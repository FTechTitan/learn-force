// ============================================================================
//  assistant.js — Chat con el tutor de IA (Edge Function ask-ai)
//  Requiere sesión iniciada. Manda la pregunta + contexto del ejercicio actual
//  y muestra la respuesta renderizando markdown básico.
// ============================================================================

(function () {
  "use strict";

  const $ = (s) => document.querySelector(s);
  const fab = $("#aiFab");
  const panel = $("#aiPanel");
  const mensajes = $("#aiMessages");
  const form = $("#aiForm");
  const textarea = $("#aiText");
  const sendBtn = $("#aiSend");
  const micBtn = $("#aiMic");
  const titleEl = $("#aiTitle");

  const historial = []; // [{role, content}] para dar continuidad a la charla
  let enviando = false;

  // --- Grabación de audio --------------------------------------------------
  const GRABACION_MAX_MS = 60000; // tope de 60s por audio
  let mediaRecorder = null;
  let chunks = [];
  let grabando = false;
  let autoStopTimer = null;

  function abrir() {
    actualizarTitulo();
    panel.classList.remove("hidden");
    fab.classList.add("hidden");
    setTimeout(() => textarea.focus(), 50);
  }
  function cerrar() {
    panel.classList.add("hidden");
    fab.classList.remove("hidden");
  }

  function actualizarTitulo() {
    if (!titleEl) return;
    const curso = window.ProgresoApp?.cursoActual?.();
    titleEl.textContent = curso?.titulo ? `🤖 Tutor: ${curso.titulo}` : "🤖 Tutor del curso";
  }

  // --- Markdown mínimo y seguro -------------------------------------------
  function escapar(s) {
    return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
  }
  function renderMarkdown(texto) {
    // 1) Bloques de código ```...```
    const bloques = [];
    let t = texto.replace(/```(\w*)\n?([\s\S]*?)```/g, (_m, _lang, code) => {
      bloques.push(`<pre><code>${escapar(code.replace(/\n$/, ""))}</code></pre>`);
      return `BLOQUE${bloques.length - 1}`;
    });
    // 2) Escapar el resto
    t = escapar(t);
    // 3) Inline: `code`, **bold**
    t = t.replace(/`([^`]+)`/g, "<code>$1</code>");
    t = t.replace(/\*\*([^*]+)\*\*/g, "<b>$1</b>");
    // 4) Párrafos y saltos de línea
    t = t.split(/\n{2,}/).map((p) => `<p>${p.replace(/\n/g, "<br>")}</p>`).join("");
    // 5) Reinsertar bloques de código
    t = t.replace(/BLOQUE(\d+)/g, (_m, i) => bloques[Number(i)]);
    return t;
  }

  function agregarMensaje(tipo, html) {
    const div = document.createElement("div");
    div.className = "ai-msg " + tipo;
    div.innerHTML = html;
    mensajes.appendChild(div);
    mensajes.scrollTop = mensajes.scrollHeight;
    return div;
  }

  function mostrarEscribiendo() {
    return agregarMensaje("bot", '<span class="ai-typing"><span></span><span></span><span></span></span>');
  }

  // --- Envío --------------------------------------------------------------
  async function enviar(pregunta) {
    if (enviando || !pregunta.trim()) return;

    // Requiere sesión iniciada (la función rechaza anónimos).
    const user = await window.Auth.usuarioActual();
    if (!user) {
      agregarMensaje("error", "Para usar el asistente necesitás <b>iniciar sesión</b>. Abrí “Entrar con Google” arriba a la derecha. 🙂");
      if (window.AuthUI) window.AuthUI.abrir();
      return;
    }

    enviando = true;
    sendBtn.disabled = true;
    agregarMensaje("user", escapar(pregunta).replace(/\n/g, "<br>"));
    historial.push({ role: "user", content: pregunta });
    const typing = mostrarEscribiendo();

    const contexto = (window.AsistenteContexto && window.AsistenteContexto()) || {};

    try {
      const { data, error } = await window.Auth.cliente.functions.invoke("ask-ai", {
        body: { question: pregunta, context: contexto, history: historial.slice(0, -1) },
      });

      typing.remove();

      if (error) {
        // Intenta extraer el mensaje amistoso del cuerpo de la respuesta.
        let msg = "El asistente tuvo un problema. Probá de nuevo.";
        try {
          const ctx = await error.context?.json?.();
          if (ctx?.error) msg = ctx.error;
        } catch (_) {}
        agregarMensaje("error", escapar(msg));
        return;
      }

      const respuesta = data?.answer || "(sin respuesta)";
      agregarMensaje("bot", renderMarkdown(respuesta));
      historial.push({ role: "assistant", content: respuesta });
    } catch (e) {
      typing.remove();
      agregarMensaje("error", "No me pude conectar. Revisá tu internet y probá de nuevo.");
    } finally {
      enviando = false;
      sendBtn.disabled = false;
    }
  }

  // --- Grabar / transcribir audio -----------------------------------------
  function tipoSoportado() {
    if (typeof MediaRecorder === "undefined") return null;
    if (MediaRecorder.isTypeSupported && MediaRecorder.isTypeSupported("audio/webm")) return "audio/webm";
    if (MediaRecorder.isTypeSupported && MediaRecorder.isTypeSupported("audio/mp4")) return "audio/mp4";
    return ""; // dejar que el navegador elija el default
  }

  function pintarGrabando(activo) {
    grabando = activo;
    micBtn.textContent = activo ? "⏹" : "🎤";
    micBtn.classList.toggle("grabando", activo);
    micBtn.title = activo ? "Detener y enviar" : "Grabar un audio";
  }

  async function toggleGrabacion() {
    if (grabando) { detenerGrabacion(); return; }
    if (enviando) return;

    // Requiere sesión (la función transcribe rechaza anónimos).
    const user = await window.Auth.usuarioActual();
    if (!user) {
      agregarMensaje("error", "Para mandar audios necesitás <b>iniciar sesión</b>. 🙂");
      if (window.AuthUI) window.AuthUI.abrir();
      return;
    }

    const mime = tipoSoportado();
    if (mime === null || !navigator.mediaDevices?.getUserMedia) {
      agregarMensaje("error", "Tu navegador no permite grabar audio. Probá con Chrome o escribí tu pregunta. 🙂");
      return;
    }

    let stream;
    try {
      stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    } catch (_) {
      agregarMensaje("error", "No pude acceder al micrófono. Revisá los permisos del navegador. 🎤");
      return;
    }

    chunks = [];
    mediaRecorder = new MediaRecorder(stream, mime ? { mimeType: mime } : undefined);
    mediaRecorder.addEventListener("dataavailable", (e) => { if (e.data.size) chunks.push(e.data); });
    mediaRecorder.addEventListener("stop", () => {
      stream.getTracks().forEach((t) => t.stop());
      const tipo = mediaRecorder.mimeType || mime || "audio/webm";
      const blob = new Blob(chunks, { type: tipo });
      transcribirYEnviar(blob, tipo);
    });
    mediaRecorder.start();
    pintarGrabando(true);
    autoStopTimer = setTimeout(detenerGrabacion, GRABACION_MAX_MS);
  }

  function detenerGrabacion() {
    clearTimeout(autoStopTimer);
    if (mediaRecorder && mediaRecorder.state !== "inactive") mediaRecorder.stop();
    pintarGrabando(false);
  }

  async function transcribirYEnviar(blob, tipo) {
    if (!blob.size) return;
    enviando = true;
    sendBtn.disabled = true;
    micBtn.disabled = true;
    const typing = agregarMensaje("user", '🎤 <span class="ai-typing"><span></span><span></span><span></span></span> <span style="opacity:.7">transcribiendo audio…</span>');
    try {
      const ext = tipo.includes("mp4") ? "mp4" : "webm";
      const fd = new FormData();
      fd.append("file", blob, "audio." + ext);
      const { data, error } = await window.Auth.cliente.functions.invoke("transcribe", { body: fd });
      typing.remove();
      if (error) {
        let msg = "No se pudo transcribir el audio. Probá de nuevo.";
        try { const c = await error.context?.json?.(); if (c?.error) msg = c.error; } catch (_) {}
        agregarMensaje("error", escapar(msg));
        return;
      }
      const texto = (data?.text || "").trim();
      if (!texto) {
        agregarMensaje("error", "No te entendí en el audio 🙉. Probá de nuevo, más cerca del micrófono.");
        return;
      }
      // Libera los flags y manda el texto transcripto como pregunta normal.
      enviando = false;
      sendBtn.disabled = false;
      micBtn.disabled = false;
      enviar(texto);
    } catch (_) {
      typing.remove();
      agregarMensaje("error", "No me pude conectar para transcribir. Revisá tu internet.");
    } finally {
      enviando = false;
      sendBtn.disabled = false;
      micBtn.disabled = false;
    }
  }

  // Hace arrastrable un panel tomándolo de un "handle" (su header).
  function hacerArrastrable(el, handle) {
    let sx, sy, ox, oy, drag = false;
    handle.style.cursor = "move";
    handle.addEventListener("mousedown", (e) => {
      if (e.target.closest("button")) return;
      drag = true;
      const r = el.getBoundingClientRect();
      sx = e.clientX; sy = e.clientY; ox = r.left; oy = r.top;
      el.style.right = "auto"; el.style.bottom = "auto";
      el.style.left = ox + "px"; el.style.top = oy + "px";
      e.preventDefault();
    });
    window.addEventListener("mousemove", (e) => {
      if (!drag) return;
      let nx = ox + (e.clientX - sx), ny = oy + (e.clientY - sy);
      nx = Math.max(0, Math.min(window.innerWidth - 60, nx));
      ny = Math.max(0, Math.min(window.innerHeight - 40, ny));
      el.style.left = nx + "px"; el.style.top = ny + "px";
    });
    window.addEventListener("mouseup", () => { drag = false; });
  }

  // --- Eventos ------------------------------------------------------------
  function wire() {
    fab.addEventListener("click", abrir);
    $("#aiClose").addEventListener("click", cerrar);
    if (micBtn) micBtn.addEventListener("click", toggleGrabacion);
    actualizarTitulo();

    // Minimizar: colapsa el cuerpo y deja solo la barra de título.
    const minBtn = $("#aiMin");
    if (minBtn) minBtn.addEventListener("click", () => {
      panel.classList.toggle("min");
      minBtn.textContent = panel.classList.contains("min") ? "▢" : "—";
      minBtn.title = panel.classList.contains("min") ? "Restaurar" : "Minimizar";
    });

    // Mover: arrastrar el panel por su header.
    const header = panel.querySelector(".ai-header");
    if (header) hacerArrastrable(panel, header);

    // Auto-resize del textarea.
    textarea.addEventListener("input", () => {
      textarea.style.height = "auto";
      textarea.style.height = Math.min(textarea.scrollHeight, 120) + "px";
    });
    // Enter envía, Shift+Enter hace salto de línea.
    textarea.addEventListener("keydown", (e) => {
      if (e.key === "Enter" && !e.shiftKey) {
        e.preventDefault();
        form.requestSubmit();
      }
    });

    form.addEventListener("submit", (e) => {
      e.preventDefault();
      const txt = textarea.value.trim();
      if (!txt) return;
      textarea.value = "";
      textarea.style.height = "auto";
      enviar(txt);
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", wire);
  } else {
    wire();
  }
})();
