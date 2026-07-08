// ============================================================================
//  auth-ui.js — UI de autenticación (modal Google + chip de usuario)
//  Expone window.AuthUI con:
//    - onUsuario(cb)  -> se llama cada vez que cambia la sesión (user | null)
//    - abrir()        -> abre el modal de login
// ============================================================================

(function () {
  "use strict";

  const $ = (s) => document.querySelector(s);
  const suscriptores = [];

  // Referencias
  const modal = $("#authModal");
  const errorEl = $("#authError");
  const googleBtn = $("#btnGoogleLogin");

  function abrir() {
    errorEl.classList.add("hidden");
    modal.classList.remove("hidden");
    setTimeout(() => googleBtn.focus(), 50);
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

  function notificar(user) {
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

    $("#btnLogout").addEventListener("click", async () => {
      await window.Auth.salir();
      // onCambio dispara notificar(null)
    });

    googleBtn.addEventListener("click", async () => {
      errorEl.classList.add("hidden");
      googleBtn.disabled = true;
      const textoPrevio = googleBtn.querySelector("span:last-child").textContent;
      googleBtn.querySelector("span:last-child").textContent = "Redirigiendo…";
      try {
        await window.Auth.entrarConGoogle();
      } catch (err) {
        mostrarError(traducirError(err));
        googleBtn.disabled = false;
        googleBtn.querySelector("span:last-child").textContent = textoPrevio;
      }
    });

    // Sesión inicial + cambios.
    window.Auth.onCambio((user) => notificar(user));
    window.Auth.usuarioActual().then((user) => pintarSesion(user));
  }

  window.AuthUI = {
    onUsuario(cb) { suscriptores.push(cb); },
    abrir,
  };

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", wire);
  } else {
    wire();
  }
})();
