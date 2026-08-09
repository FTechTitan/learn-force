(function () {
  "use strict";

  const $ = (selector) => document.querySelector(selector);
  const sessionLabel = $("#agentsSession");
  const app = $("#agentsApp");
  const authGate = $("#agentsAuthGate");
  const errorEl = $("#agentKeysError");
  const listEl = $("#agentKeyList");
  const keyTools = $("#agentKeyTools");

  function selectWorkflowTab(tabName) {
    document.querySelectorAll("[data-agent-tab]").forEach((button) => {
      const active = button.dataset.agentTab === tabName;
      button.classList.toggle("active", active);
      button.setAttribute("aria-selected", String(active));
    });
    document.querySelectorAll("[data-agent-panel]").forEach((panel) => {
      panel.hidden = panel.dataset.agentPanel !== tabName;
    });
    keyTools.classList.toggle("hidden", tabName !== "key");
  }

  function selectOperatingSystem(osName) {
    document.querySelectorAll("[data-agent-os]").forEach((button) => {
      const active = button.dataset.agentOs === osName;
      button.classList.toggle("active", active);
      button.setAttribute("aria-selected", String(active));
    });
    document.querySelectorAll("[data-agent-os-panel]").forEach((panel) => {
      panel.hidden = panel.dataset.agentOsPanel !== osName;
    });
  }

  function escapeHtml(value) {
    const div = document.createElement("div");
    div.textContent = String(value ?? "");
    return div.innerHTML;
  }

  function shortDate(value) {
    if (!value) return "Sin expiración";
    return new Intl.DateTimeFormat("es-CL", { dateStyle: "medium" }).format(new Date(value));
  }

  function showError(error) {
    errorEl.textContent = error?.message || String(error);
    errorEl.classList.remove("hidden");
  }

  async function copyText(text, button) {
    await navigator.clipboard.writeText(text);
    const previous = button.textContent;
    button.textContent = "Copiado ✓";
    setTimeout(() => { button.textContent = previous; }, 1500);
  }

  async function loadKeys() {
    errorEl.classList.add("hidden");
    listEl.innerHTML = '<span class="agent-key-empty">Cargando…</span>';
    try {
      const payload = await window.AgentApi.listarClaves();
      const keys = (payload.data || []).filter((key) => !key.revoked_at);
      listEl.innerHTML = keys.length ? keys.map((key) => `
        <article class="agent-key-row">
          <div><strong>${escapeHtml(key.name)}</strong><code>${escapeHtml(key.key_prefix)}…</code><small>${shortDate(key.expires_at)}${key.last_used_at ? ` · usada ${shortDate(key.last_used_at)}` : ""}</small></div>
          <button type="button" class="agent-revoke" data-revoke-key="${escapeHtml(key.id)}">Revocar</button>
        </article>`).join("") : '<span class="agent-key-empty">No tienes llaves activas.</span>';
      listEl.querySelectorAll("[data-revoke-key]").forEach((button) => {
        button.addEventListener("click", async () => {
          button.disabled = true;
          try {
            await window.AgentApi.revocarClave(button.dataset.revokeKey);
            await loadKeys();
          } catch (error) {
            showError(error);
            button.disabled = false;
          }
        });
      });
    } catch (error) {
      listEl.innerHTML = "";
      showError(error);
    }
  }

  async function initialize() {
    const user = await window.Auth.usuarioActual();
    if (!user) {
      sessionLabel.textContent = "Sin sesión";
      authGate.classList.remove("hidden");
      return;
    }
    sessionLabel.textContent = user.email || "Sesión activa";
    app.classList.remove("hidden");
    await loadKeys();
  }

  $("#agentKeyForm").addEventListener("submit", async (event) => {
    event.preventDefault();
    errorEl.classList.add("hidden");
    const button = $("#createAgentKey");
    button.disabled = true;
    button.textContent = "Creando…";
    try {
      const name = $("#agentKeyName").value.trim();
      const days = Number($("#agentKeyExpiry").value || 0);
      const expiresAt = days ? new Date(Date.now() + days * 86400000).toISOString() : null;
      const payload = await window.AgentApi.crearClave(name, expiresAt);
      $("#agentKeyValue").textContent = payload.data.key;
      $("#agentKeySecret").classList.remove("hidden");
      $("#agentKeyForm").reset();
      await loadKeys();
    } catch (error) {
      showError(error);
    } finally {
      button.disabled = false;
      button.textContent = "Crear llave segura";
    }
  });

  $("#copyAgentKey").addEventListener("click", (event) => copyText($("#agentKeyValue").textContent, event.currentTarget));
  $("#refreshAgentKeys").addEventListener("click", loadKeys);
  document.querySelectorAll("[data-agent-tab]").forEach((button) => {
    button.addEventListener("click", () => selectWorkflowTab(button.dataset.agentTab));
  });
  document.querySelectorAll("[data-agent-os]").forEach((button) => {
    button.addEventListener("click", () => selectOperatingSystem(button.dataset.agentOs));
  });
  document.querySelectorAll("[data-copy-target]").forEach((button) => {
    button.addEventListener("click", () => copyText($(`#${button.dataset.copyTarget}`).textContent.trim(), button));
  });

  initialize().catch((error) => {
    sessionLabel.textContent = "No se pudo verificar la sesión";
    authGate.classList.remove("hidden");
    console.error(error);
  });
})();
