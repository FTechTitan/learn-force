// ============================================================================
//  auth-ui.js — UI de autenticación (correo, Google y chip de usuario)
//  Expone window.AuthUI con:
//    - onUsuario(cb)  -> se llama cada vez que cambia la sesión (user | null)
//    - abrir()        -> abre el modal de login
// ============================================================================

(function () {
  "use strict";

  const $ = (s) => document.querySelector(s);
  const suscriptores = [];
  let usuarioActual = null;
  let sesionInicialResuelta = false;

  // Referencias
  const modal = $("#authModal");
  const errorEl = $("#authError");
  const googleBtn = $("#btnGoogleLogin");
  const form = $("#authForm");
  const emailInput = $("#authEmail");
  const passwordInput = $("#authPassword");
  const emailBtn = $("#btnEmailAuth");
  const agentModal = $("#agentKeysModal");
  const agentError = $("#agentKeysError");
  const agentList = $("#agentKeyList");
  const agentForm = $("#agentKeyForm");
  let modoRegistro = false;

  function configurarModo(registro) {
    modoRegistro = registro;
    $("#authTitulo").textContent = registro ? "Crear cuenta" : "Iniciar sesión";
    $("#authSubtitulo").textContent = registro
      ? "Crea una cuenta con correo y contraseña para guardar tu avance."
      : "Usa tu correo o tu cuenta Google para guardar tu avance.";
    emailBtn.textContent = registro ? "Crear cuenta" : "Entrar";
    $("#authToggleText").textContent = registro ? "¿Ya tienes cuenta?" : "¿No tienes cuenta?";
    $("#authToggle").textContent = registro ? "Iniciar sesión" : "Crear una";
    passwordInput.autocomplete = registro ? "new-password" : "current-password";
    errorEl.classList.add("hidden");
  }

  function abrir() {
    configurarModo(false);
    errorEl.classList.add("hidden");
    modal.classList.remove("hidden");
    setTimeout(() => emailInput.focus(), 50);
  }
  function cerrar() {
    modal.classList.add("hidden");
  }

  function mostrarError(msg) {
    errorEl.textContent = msg;
    errorEl.classList.remove("hidden");
  }

  // Traduce errores comunes de Supabase a español claro.
  function traducirError(e) {
    const m = (e && e.message) || String(e);
    if (/rate limit/i.test(m)) return "Demasiados intentos. Esperá un momento.";
    if (/invalid login credentials/i.test(m)) return "El correo o la contraseña no son correctos.";
    if (/email not confirmed/i.test(m)) return "Confirma tu correo antes de iniciar sesión.";
    if (/user already registered/i.test(m)) return "Ya existe una cuenta con ese correo.";
    if (/password should be at least/i.test(m)) return "La contraseña debe tener al menos 6 caracteres.";
    if (/redirect_uri_mismatch/i.test(m)) return "La configuración de Google está rechazando el callback. Probá de nuevo en un momento.";
    return m;
  }

  // Actualiza el chip de usuario en la topbar.
  function pintarSesion(user) {
    const chip = $("#userChip");
    const btnLogin = $("#btnLogin");
    if (user) {
      $("#userEmail").textContent = user.email || "Mi cuenta";
      chip.classList.remove("hidden");
      btnLogin.classList.add("hidden");
    } else {
      chip.classList.add("hidden");
      btnLogin.classList.remove("hidden");
    }
  }

  function fechaCorta(value) {
    if (!value) return "Sin expiración";
    return new Intl.DateTimeFormat("es-CL", { dateStyle: "medium" }).format(new Date(value));
  }

  function escapar(value) {
    const div = document.createElement("div");
    div.textContent = String(value ?? "");
    return div.innerHTML;
  }

  async function cargarClavesAgente() {
    agentError.classList.add("hidden");
    agentList.innerHTML = '<span class="agent-key-empty">Cargando…</span>';
    try {
      const payload = await window.AgentApi.listarClaves();
      const keys = (payload.data || []).filter((key) => !key.revoked_at);
      agentList.innerHTML = keys.length ? keys.map((key) => `
        <article class="agent-key-row">
          <div><strong>${escapar(key.name)}</strong><code>${escapar(key.key_prefix)}…</code><small>${fechaCorta(key.expires_at)}${key.last_used_at ? ` · usada ${fechaCorta(key.last_used_at)}` : ""}</small></div>
          <button type="button" class="btn-mini danger" data-revoke-agent-key="${escapar(key.id)}">Revocar</button>
        </article>`).join("") : '<span class="agent-key-empty">Todavía no tienes claves activas.</span>';
      agentList.querySelectorAll("[data-revoke-agent-key]").forEach((button) => {
        button.addEventListener("click", async () => {
          button.disabled = true;
          try {
            await window.AgentApi.revocarClave(button.dataset.revokeAgentKey);
            await cargarClavesAgente();
          } catch (err) {
            agentError.textContent = traducirError(err);
            agentError.classList.remove("hidden");
            button.disabled = false;
          }
        });
      });
    } catch (err) {
      agentList.innerHTML = "";
      agentError.textContent = traducirError(err);
      agentError.classList.remove("hidden");
    }
  }

  function abrirClavesAgente() {
    $("#agentKeySecret").classList.add("hidden");
    agentModal.classList.remove("hidden");
    cargarClavesAgente();
  }

  function cerrarClavesAgente() {
    $("#agentKeyValue").textContent = "";
    $("#agentKeySecret").classList.add("hidden");
    agentModal.classList.add("hidden");
  }

  function notificar(user) {
    usuarioActual = user || null;
    sesionInicialResuelta = true;
    pintarSesion(user);
    suscriptores.forEach((cb) => {
      try { cb(user); } catch (e) { console.error(e); }
    });
  }

  // --- Eventos -------------------------------------------------------------
  function wire() {
    $("#btnLogin").addEventListener("click", abrir);
    $("#authClose").addEventListener("click", cerrar);
    modal.addEventListener("click", (e) => { if (e.target === modal) cerrar(); });

    $("#authToggle").addEventListener("click", (e) => {
      e.preventDefault();
      configurarModo(!modoRegistro);
    });

    form.addEventListener("submit", async (e) => {
      e.preventDefault();
      errorEl.classList.add("hidden");
      emailBtn.disabled = true;
      emailBtn.textContent = modoRegistro ? "Creando…" : "Entrando…";
      try {
        const email = emailInput.value.trim();
        const password = passwordInput.value;
        const user = modoRegistro
          ? await window.Auth.registrar(email, password)
          : await window.Auth.entrar(email, password);
        if (modoRegistro && !user) {
          mostrarError("Revisa tu correo para confirmar la cuenta antes de entrar.");
          return;
        }
        cerrar();
        form.reset();
      } catch (err) {
        mostrarError(traducirError(err));
      } finally {
        emailBtn.disabled = false;
        emailBtn.textContent = modoRegistro ? "Crear cuenta" : "Entrar";
      }
    });

    $("#btnLogout").addEventListener("click", async () => {
      await window.Auth.salir();
      // onCambio dispara notificar(null)
    });

    $("#btnAgentKeys").addEventListener("click", abrirClavesAgente);
    $("#agentKeysClose").addEventListener("click", cerrarClavesAgente);
    agentModal.addEventListener("click", (e) => { if (e.target === agentModal) cerrarClavesAgente(); });
    $("#copyAgentKey").addEventListener("click", async () => {
      await navigator.clipboard.writeText($("#agentKeyValue").textContent);
      $("#copyAgentKey").textContent = "Copiada";
      setTimeout(() => { $("#copyAgentKey").textContent = "Copiar clave"; }, 1600);
    });
    agentForm.addEventListener("submit", async (e) => {
      e.preventDefault();
      agentError.classList.add("hidden");
      const button = $("#createAgentKey");
      button.disabled = true;
      button.textContent = "Creando…";
      try {
        const name = $("#agentKeyName").value.trim();
        const expiry = $("#agentKeyExpiry").value;
        const expiresAt = expiry ? new Date(`${expiry}T23:59:59`).toISOString() : null;
        const payload = await window.AgentApi.crearClave(name, expiresAt);
        $("#agentKeyValue").textContent = payload.data.key;
        $("#agentKeySecret").classList.remove("hidden");
        agentForm.reset();
        await cargarClavesAgente();
      } catch (err) {
        agentError.textContent = traducirError(err);
        agentError.classList.remove("hidden");
      } finally {
        button.disabled = false;
        button.textContent = "Crear clave";
      }
    });

    googleBtn.addEventListener("click", () => {
      errorEl.classList.add("hidden");
      googleBtn.disabled = true;
      googleBtn.querySelector("span:last-child").textContent = "Redirigiendo…";
      try {
        window.Auth.entrarConGoogle();
      } catch (err) {
        mostrarError(traducirError(err));
        googleBtn.disabled = false;
        googleBtn.querySelector("span:last-child").textContent = "Continuar con Google";
      }
    });

    // Sesión inicial + cambios.
    window.Auth.onCambio((user) => notificar(user));
    window.Auth.usuarioActual().then((user) => notificar(user));
  }

  window.AuthUI = {
    onUsuario(cb) {
      suscriptores.push(cb);
      if (sesionInicialResuelta) {
        try { cb(usuarioActual); } catch (e) { console.error(e); }
      }
    },
    abrir,
  };

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", wire);
  } else {
    wire();
  }
})();
