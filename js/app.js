// ============================================================================
//  app.js — Lógica de la interfaz
//  Construye la barra lateral, gestiona el progreso (localStorage), conecta el
//  editor (CodeMirror) con el runner (Pyodide) y maneja el desbloqueo de
//  ejercicios de menos a más.
// ============================================================================

(function () {
  "use strict";

  const STORAGE_KEY = "progra-uai-progreso-v1";
  const COURSE_STORAGE_KEY = "progra-uai-curso-activo-v1";
  const CANONICAL_ORIGIN = "https://learn.techforce.cl";
  const VAPID_PUBLIC_KEY = "BNCz7TMy0I4UmeS2JVnqrCzxqryUvP41NKb8aMUbkVXoZVnqS0M51vs2l59SheD03lRCy1IPYI_SW5gPSC8wqQ8";
  let cursos = [];
  let cursoActual = null;
  let modulos = [];
  let swRegistration = null;

  // Lista plana de ejercicios en orden, con referencia a su módulo.
  let ejerciciosPlanos = [];

  function reconstruirEjerciciosPlanos() {
    modulos = cursoActual ? (cursoActual.modulos || []) : [];
    ejerciciosPlanos = [];
    modulos.forEach((m) => {
      (m.ejercicios || []).forEach((e) => ejerciciosPlanos.push({ ...e, moduloId: m.id, moduloTitulo: m.titulo }));
    });
  }

  reconstruirEjerciciosPlanos();

  function slugCurso(curso) {
    return curso.id;
  }

  function hashCurso(courseId) {
    return `#curso/${encodeURIComponent(courseId)}`;
  }

  function hashModulo(courseId, moduleId) {
    return `${hashCurso(courseId)}/${encodeURIComponent(moduleId)}`;
  }

  function hashEjercicio(courseId, moduleId, exerciseId) {
    return `${hashModulo(courseId, moduleId)}/${encodeURIComponent(exerciseId)}`;
  }

  function leerRutaHash() {
    const parts = window.location.hash.replace(/^#\/?/, "").split("/").filter(Boolean);
    if (parts[0] !== "curso" || !parts[1]) return {};
    const moduleId = parts[2] && parts[2] !== "ejercicio" ? decodeURIComponent(parts[2]) : null;
    const exerciseId = parts[2] === "ejercicio" && parts[3]
      ? decodeURIComponent(parts[3])
      : parts[2] && parts[2] !== "ejercicio" && parts[3]
      ? decodeURIComponent(parts[3])
      : null;
    return {
      courseId: decodeURIComponent(parts[1]),
      moduleId,
      exerciseId,
    };
  }

  function setHashSilencioso(hash) {
    if (window.location.hash === hash) return;
    history.replaceState(null, "", hash || window.location.pathname + window.location.search);
  }

  async function registrarPwa() {
    const notifyBtn = $("#btnNotifications");

    if ("serviceWorker" in navigator) {
      try {
        swRegistration = await navigator.serviceWorker.register("/sw.js");
      } catch (e) {
        console.warn("No se pudo registrar el service worker", e);
      }
    }

    if (!notifyBtn || !("Notification" in window) || !("serviceWorker" in navigator) || !("PushManager" in window)) return;
    notifyBtn.classList.remove("hidden");
    actualizarBotonNotificaciones();
    notifyBtn.addEventListener("click", activarNotificaciones);
    if ("Notification" in window && Notification.permission === "granted") {
      guardarPushSubscription().catch((e) => console.warn("No se pudo guardar push subscription:", e.message || e));
    }
  }

  function actualizarBotonNotificaciones() {
    const notifyBtn = $("#btnNotifications");
    if (!notifyBtn || !("Notification" in window)) return;
    const activas = Notification.permission === "granted";
    notifyBtn.classList.toggle("enabled", activas);
    notifyBtn.textContent = activas ? "Notificaciones activas" : "Activar notificaciones";
    notifyBtn.disabled = Notification.permission === "denied";
    if (Notification.permission === "denied") notifyBtn.textContent = "Notificaciones bloqueadas";
  }

  async function activarNotificaciones() {
    if (!("Notification" in window)) return;
    if (!usuarioActual) {
      if (window.AuthUI) window.AuthUI.abrir();
      mostrarToast("Inicia sesión para activar notificaciones.");
      return;
    }
    const permiso = Notification.permission === "default"
      ? await Notification.requestPermission()
      : Notification.permission;
    actualizarBotonNotificaciones();
    if (permiso === "granted") {
      await guardarPushSubscription();
      await enviarPush("TechForce Learn", "Listo. Te avisaré incluso si la app está cerrada.", window.location.href);
    }
  }

  function vapidKeyToUint8Array(base64Url) {
    const padding = "=".repeat((4 - base64Url.length % 4) % 4);
    const base64 = (base64Url + padding).replace(/-/g, "+").replace(/_/g, "/");
    const raw = atob(base64);
    return Uint8Array.from([...raw].map((char) => char.charCodeAt(0)));
  }

  async function guardarPushSubscription() {
    if (!usuarioActual || !window.PushSubscriptions || Notification.permission !== "granted") return;
    const registration = swRegistration || await navigator.serviceWorker.ready;
    let subscription = await registration.pushManager.getSubscription();
    if (!subscription) {
      subscription = await registration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: vapidKeyToUint8Array(VAPID_PUBLIC_KEY),
      });
    }
    await window.PushSubscriptions.guardar(usuarioActual.id, subscription);
  }

  async function enviarPush(title, body, url) {
    if (!usuarioActual || !window.PushSubscriptions || Notification.permission !== "granted") return;
    try {
      await guardarPushSubscription();
      await window.PushSubscriptions.enviar({ title, body, url });
    } catch (e) {
      console.warn("No se pudo enviar push:", e.message || e);
    }
  }

  // --- Estado persistente --------------------------------------------------
  function cargarProgreso() {
    try {
      const raw = localStorage.getItem(STORAGE_KEY);
      if (!raw) return { completados: {}, codigo: {}, pasos: {} };
      const data = JSON.parse(raw);
      return { completados: data.completados || {}, codigo: data.codigo || {}, pasos: data.pasos || {} };
    } catch {
      return { completados: {}, codigo: {}, pasos: {} };
    }
  }

  function guardarProgreso() {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(estado));
  }

  const estado = cargarProgreso();

  function pintarSelectorCursos() {
    if (!courseSelect) return;
    const opciones = cursos
      .map((c) => `<option value="${c.id}">${c.emoji || "📚"} ${c.titulo}</option>`)
      .join("");
    courseSelect.innerHTML = `<option value="">Selecciona un curso</option>${opciones}`;
    courseSelect.value = cursoActual ? cursoActual.id : "";
  }

  function actualizarMarcaCurso() {
    const title = $("#brandTitle");
    const subtitle = $("#brandSubtitle");
    const logo = document.querySelector(".logo");
    if (title) title.textContent = cursoActual ? cursoActual.titulo : "Cursos";
    if (subtitle) {
      subtitle.textContent = cursoActual
        ? (cursoActual.subtitle || cursoActual.descripcion || "")
        : "Selecciona un curso para comenzar";
    }
    if (logo) logo.textContent = cursoActual ? (cursoActual.emoji || "📚") : "📚";
  }

  function mostrarCatalogo() {
    document.body.classList.remove("exercise-focus");
    setHashSilencioso("");
    cursoActual = null;
    localStorage.removeItem(COURSE_STORAGE_KEY);
    reconstruirEjerciciosPlanos();
    ejercicioActual = null;
    indiceActual = -1;
    mediaActual = null;
    quizRespuesta = null;
    exercise.classList.add("hidden");
    mediaPanel.classList.add("hidden");
    welcome.classList.remove("hidden");
    actualizarMarcaCurso();
    pintarSelectorCursos();
    renderSidebar();
    pintarWelcome();
  }

  function cambiarCurso(courseId) {
    if (!courseId) {
      mostrarCatalogo();
      return;
    }
    const curso = cursos.find((c) => c.id === courseId);
    if (!curso) return;
    document.body.classList.remove("exercise-focus");
    cursoActual = curso;
    setHashSilencioso(hashCurso(slugCurso(cursoActual)));
    localStorage.setItem(COURSE_STORAGE_KEY, cursoActual.id);
    reconstruirEjerciciosPlanos();
    ejercicioActual = null;
    indiceActual = -1;
    mediaActual = null;
    quizRespuesta = null;
    exercise.classList.add("hidden");
    mediaPanel.classList.add("hidden");
    welcome.classList.remove("hidden");
    actualizarMarcaCurso();
    pintarSelectorCursos();
    renderSidebar();
    pintarWelcome();
    if (!pyListo) precargarPython();
  }

  function mezclarCursosRemotos(remotos) {
    document.body.classList.remove("exercise-focus");
    cursos = remotos || [];
    cursoActual = null;
    reconstruirEjerciciosPlanos();
    pintarSelectorCursos();
    actualizarMarcaCurso();
    renderSidebar();
    pintarWelcome();
    abrirDesdeHash();
  }

  function abrirDesdeHash() {
    const ruta = leerRutaHash();
    if (!ruta.courseId) return;
    const curso = cursos.find((c) => c.id === ruta.courseId);
    if (!curso) return;
    cursoActual = curso;
    localStorage.setItem(COURSE_STORAGE_KEY, cursoActual.id);
    reconstruirEjerciciosPlanos();
    actualizarMarcaCurso();
    pintarSelectorCursos();
    renderSidebar();
    pintarWelcome();
    if (ruta.exerciseId) {
      const idx = ejerciciosPlanos.findIndex((e) =>
        e.id === ruta.exerciseId && (!ruta.moduleId || e.moduloId === ruta.moduleId)
      );
      if (idx >= 0) abrirEjercicio(idx);
    }
  }

  async function cargarCursosRemotos() {
    if (!window.CursosRemotos) return;
    try {
      const remotos = await window.CursosRemotos.cargarPublicados();
      mezclarCursosRemotos(remotos);
    } catch (e) {
      console.warn("No se pudieron cargar cursos desde Supabase:", e.message || e);
    }
  }

  // Usuario logueado (null = invitado, progreso solo local).
  let usuarioActual = null;
  // Debounce por ejercicio para no spamear la DB al tipear código.
  const debouncersCodigo = {};

  // Empuja una fila de progreso a Supabase si hay sesión (silencioso si no).
  function pushRemoto(exerciseId, payload) {
    if (!usuarioActual) return;
    window.ProgresoRemoto
      .guardar(usuarioActual.id, exerciseId, payload)
      .catch((e) => console.warn("No se pudo guardar en la nube:", e.message || e));
  }

  // Guarda el código de un ejercicio en la nube, con debounce de 1.2s.
  function pushCodigoDebounced(exerciseId, code) {
    if (!usuarioActual) return;
    clearTimeout(debouncersCodigo[exerciseId]);
    debouncersCodigo[exerciseId] = setTimeout(() => {
      pushRemoto(exerciseId, { code });
    }, 1200);
  }

  function requerirLoginParaValidar() {
    if (usuarioActual) return true;
    setOutput("Inicia sesión para comprobar y guardar tu progreso.", "fail");
    if (window.AuthUI) window.AuthUI.abrir();
    return false;
  }

  // Al iniciar/cerrar sesión: fusiona el progreso local con el de la nube.
  async function sincronizarConRemoto(user) {
    usuarioActual = user;
    if (!user) {
      // Logout: el progreso local queda como "invitado" en este dispositivo.
      renderSidebar();
      return;
    }
    let remoto;
    try {
      remoto = await window.ProgresoRemoto.cargar();
    } catch (e) {
      console.warn("No se pudo cargar progreso de la nube:", e.message || e);
      return;
    }

    // Detecta progreso local que aún no está en la nube (para migrarlo).
    const subirCompletados = Object.keys(estado.completados).filter(
      (id) => estado.completados[id] && !remoto.completados[id]
    );
    const subirCodigo = Object.keys(estado.codigo).filter(
      (id) => estado.codigo[id] != null && remoto.codigo[id] === undefined
    );

    // Fusiona: la nube gana donde tiene datos; lo local-only se conserva.
    estado.completados = { ...estado.completados, ...remoto.completados };
    estado.codigo = { ...estado.codigo, ...remoto.codigo };
    guardarProgreso();

    // Sube lo que estaba solo en local (progreso de invitado).
    const idsASubir = new Set([...subirCompletados, ...subirCodigo]);
    idsASubir.forEach((id) => {
      pushRemoto(id, { completed: !!estado.completados[id], code: estado.codigo[id] });
    });

    renderSidebar();
    if ("Notification" in window && Notification.permission === "granted") {
      guardarPushSubscription().catch((e) => console.warn("No se pudo guardar push subscription:", e.message || e));
    }
    // Si hay un ejercicio abierto, refresca su editor con el código fusionado.
    if (ejercicioActual && indiceActual >= 0) abrirEjercicio(indiceActual);
  }

  // Todos los ejercicios quedan disponibles desde el inicio. El progreso sigue
  // marcando completados, pero no bloquea navegación dentro del curso.
  function estaDesbloqueado(index) {
    return index >= 0 && index < ejerciciosPlanos.length;
  }

  // --- Referencias al DOM --------------------------------------------------
  const $ = (sel) => document.querySelector(sel);
  const sidebar = $("#sidebar");
  const welcome = $("#welcome");
  const exercise = $("#exercise");
  const outputEl = $("#output");
  const pyStatus = $("#pyStatus");
  const mediaPanel = $("#media");
  const courseSelect = $("#courseSelect");

  let editor = null;       // instancia de CodeMirror
  let ejercicioActual = null;
  let indiceActual = -1;
  let mediaActual = null;  // id de la clase de media abierta ("curso" o moduloId)
  let quizRespuesta = null;

  // --- Inicializa el editor CodeMirror -------------------------------------
  function initEditor() {
    editor = CodeMirror.fromTextArea(document.getElementById("editor"), {
      mode: "python",
      theme: "material-darker",
      lineNumbers: true,
      indentUnit: 4,
      tabSize: 4,
      indentWithTabs: false,
      autoCloseBrackets: true,
      lineWrapping: true,
      extraKeys: {
        Tab: (cm) => cm.replaceSelection("    ", "end"),
      },
    });
  }

  // --- Construye la barra lateral ------------------------------------------
  function renderSidebar() {
    sidebar.innerHTML = "";
    if (!cursoActual) {
      const header = document.createElement("div");
      header.className = "modulo-header";
      header.innerHTML = `<span class="emoji">📚</span> Cursos`;
      sidebar.appendChild(header);
      cursos.forEach((curso) => {
        const item = document.createElement("div");
        item.className = "ej-item course-link";
        item.innerHTML = `
          <span class="estado">${curso.emoji || "📚"}</span>
          <span class="nombre">${curso.titulo}</span>
          <span class="nivel-dots">${(curso.modulos || []).length} módulos</span>`;
        item.addEventListener("click", () => cambiarCurso(curso.id));
        sidebar.appendChild(item);
      });
      actualizarProgresoGlobal();
      return;
    }

    let globalIndex = 0;

    // Clase del curso en audio (podcast general). Siempre accesible: es material
    // de estudio, no se bloquea por progreso como los ejercicios.
    if (cursoActual.media && cursoActual.media.audio) {
      const cm = cursoActual.media;
      const cmItem = document.createElement("div");
      cmItem.className = "ej-item media-link";
      if (mediaActual === "curso") cmItem.classList.add("activo");
      cmItem.innerHTML = `
        <span class="estado">🎧</span>
        <span class="nombre">${cm.titulo}</span>
        <span class="nivel-dots">audio</span>`;
      cmItem.addEventListener("click", abrirMediaCurso);
      sidebar.appendChild(cmItem);
    }

    modulos.forEach((modulo) => {
      const completadosModulo = modulo.ejercicios.filter((e) => estado.completados[e.id]).length;

      const divMod = document.createElement("div");
      divMod.className = "modulo";

      const header = document.createElement("div");
      header.className = "modulo-header";
      header.innerHTML = `<span class="emoji">${modulo.emoji}</span> ${modulo.titulo}
        <span class="modulo-progress">${completadosModulo}/${modulo.ejercicios.length}</span>`;
      header.classList.add("clickable");
      header.addEventListener("click", () => {
        if (cursoActual) setHashSilencioso(hashModulo(slugCurso(cursoActual), modulo.id));
      });
      divMod.appendChild(header);

      // Clase en video/audio del módulo (si tiene). Libre, no se bloquea.
      if (modulo.media && (modulo.media.video || modulo.media.audio)) {
        const esVideo = !!modulo.media.video;
        const mItem = document.createElement("div");
        mItem.className = "ej-item media-link";
        if (mediaActual === modulo.id) mItem.classList.add("activo");
        mItem.innerHTML = `
          <span class="estado">${esVideo ? "📺" : "🎧"}</span>
          <span class="nombre">Clase en ${esVideo ? "video" : "audio"}</span>
          <span class="nivel-dots">${esVideo ? "video" : "audio"}</span>`;
        mItem.addEventListener("click", () => abrirMediaModulo(modulo.id));
        divMod.appendChild(mItem);
      }

      (modulo.ejercicios || []).forEach((ej) => {
        const idx = globalIndex++;
        const desbloqueado = estaDesbloqueado(idx);
        const completado = !!estado.completados[ej.id];

        const item = document.createElement("div");
        item.className = "ej-item";
        if (!desbloqueado) item.classList.add("bloqueado");
        if (ejercicioActual && ej.id === ejercicioActual.id) item.classList.add("activo");

        const estadoIcon = completado ? "✅" : desbloqueado ? "⚪" : "🔒";
        const tipo = ej.type || "code";
        const dots = tipo === "guided_steps" ? "pasos" : tipo.startsWith("quiz") ? "quiz" : "●".repeat(ej.nivel || 1);

        item.innerHTML = `
          <span class="estado">${estadoIcon}</span>
          <span class="nombre">${ej.titulo}</span>
          <span class="nivel-dots">${dots}</span>`;

        if (desbloqueado) {
          item.addEventListener("click", () => abrirEjercicio(idx));
        }
        divMod.appendChild(item);
      });

      sidebar.appendChild(divMod);
    });

    actualizarProgresoGlobal();
  }

  function actualizarProgresoGlobal() {
    const total = ejerciciosPlanos.length;
    const hechos = ejerciciosPlanos.filter((e) => estado.completados[e.id]).length;
    const pct = total ? Math.round((hechos / total) * 100) : 0;
    $("#progresoGlobal").style.width = pct + "%";
    $("#progresoTexto").textContent = `${hechos} / ${total}`;
  }

  function cursoTieneCodigo() {
    if (!cursoActual) return false;
    return ejerciciosPlanos.some((e) => (e.type || "code") === "code");
  }

  function pintarWelcome() {
    const h = welcome.querySelector("h2");
    const p = welcome.querySelector("p");
    const list = welcome.querySelector(".welcome-list");
    if (!cursoActual) {
      if (h) h.textContent = "Elige un curso";
      if (p) {
        p.innerHTML = cursos.length
          ? "Estos cursos vienen desde Supabase. Puedes revisar el contenido sin cuenta; para comprobar respuestas se pide login."
          : "Cargando cursos desde Supabase…";
      }
      if (list) {
        list.innerHTML = cursos.length
          ? cursos.map((curso) => `
              <li class="course-card">
                <button type="button" class="course-card-btn" data-course-id="${escaparHtml(curso.id)}">
                  <span class="course-card-emoji">${curso.emoji || "📚"}</span>
                  <span class="course-card-main">
                    <span class="course-card-title">${escaparHtml(curso.titulo)}</span>
                    <span class="course-card-sub">${escaparHtml(curso.subtitle || curso.descripcion || "")}</span>
                  </span>
                  <span class="course-card-count">${(curso.modulos || []).length} módulos</span>
                </button>
              </li>
            `).join("")
          : `<li>Cargando catálogo…</li>`;
        list.querySelectorAll("[data-course-id]").forEach((btn) => {
          btn.addEventListener("click", () => cambiarCurso(btn.getAttribute("data-course-id")));
        });
      }
      if (pyStatus) {
        pyStatus.textContent = cursos.length
          ? "Selecciona un curso para ver módulos y ejercicios."
          : "Conectando con Supabase…";
        pyStatus.style.background = "var(--bg-card)";
      }
      return;
    }

    if (h) h.textContent = `Bienvenido/a a ${cursoActual.titulo}`;
    if (p) {
      p.innerHTML = cursoActual.descripcion || "Elige un módulo de la izquierda para empezar.";
    }
    if (list) {
      if (cursoTieneCodigo()) {
        list.innerHTML = `
          <li>📝 Lee el enunciado y escribe tu solución en el editor.</li>
          <li>▶️ Toca <b>Ejecutar</b> para probar tu código.</li>
          <li>✅ Inicia sesión para <b>Comprobar</b> y guardar progreso.</li>
          <li>📚 Puedes abrir cualquier ejercicio del curso.</li>`;
      } else {
        list.innerHTML = `
          <li>✅ Responde verdadero/falso, alternativas o ejercicios paso a paso.</li>
          <li>🔑 Inicia sesión para comprobar y guardar tu avance.</li>
          <li>📌 Revisa la explicación inmediata después de comprobar.</li>
          <li>📚 Puedes abrir cualquier pregunta del curso.</li>`;
      }
    }
    if (pyStatus) {
      pyStatus.textContent = cursoTieneCodigo()
        ? "Cargando Python en el navegador…"
        : "Curso listo. Elige la primera pregunta para empezar.";
      pyStatus.style.background = cursoTieneCodigo() ? "var(--green-soft)" : "var(--bg-card)";
    }
  }

  // --- Clases en audio/video -----------------------------------------------
  // Construye los reproductores dentro de `cont`. Cada item es
  // { kind: "video"|"audio", src, label }. Si el archivo no existe todavía
  // (aún generándose / no subido), el <video|audio> dispara "error" y se
  // muestra un aviso de "próximamente" en su lugar, sin romper la página.
  function pintarReproductores(cont, items) {
    cont.innerHTML = items
      .map(
        (it, i) => `
      <div class="media-card" data-i="${i}">
        <div class="media-card-label">${it.kind === "video" ? "📺" : "🎧"} ${it.label}</div>
        <div class="media-slot">
          ${
            it.kind === "video"
              ? `<video class="media-el" controls preload="metadata" playsinline></video>`
              : `<audio class="media-el" controls preload="metadata"></audio>`
          }
          <div class="media-pending hidden">
            🎬 <b>Próximamente.</b> Esta clase se está generando.
            Volvé a entrar en un rato.
          </div>
        </div>
        <a class="media-dl" href="${it.src}" download>⬇ Descargar</a>
      </div>`
      )
      .join("");

    cont.querySelectorAll(".media-card").forEach((card, i) => {
      const el = card.querySelector(".media-el");
      const pend = card.querySelector(".media-pending");
      const dl = card.querySelector(".media-dl");
      el.addEventListener("error", () => {
        el.classList.add("hidden");
        dl.classList.add("hidden");
        pend.classList.remove("hidden");
      });
      el.src = items[i].src; // setear src después del listener para captar el error
    });
  }

  // Muestra el panel de media y oculta welcome/ejercicio.
  function mostrarPanelMedia(badge, titulo, subHtml, items, teoriaHtml, claveActiva, presUrl) {
    document.body.classList.remove("exercise-focus");
    ejercicioActual = null;
    indiceActual = -1;
    mediaActual = claveActiva;

    welcome.classList.add("hidden");
    exercise.classList.add("hidden");
    mediaPanel.classList.remove("hidden");

    $("#mediaBadge").textContent = badge;
    $("#mediaTitulo").textContent = titulo;
    $("#mediaSub").innerHTML = subHtml || "";
    if (presUrl) {
      $("#mediaSub").insertAdjacentHTML(
        "beforeend",
        ` <a class="media-pres-link" href="${presUrl}" target="_blank" rel="noopener">📊 Ver presentación</a>`
      );
    }
    $("#mediaTeoria").innerHTML = teoriaHtml || "";
    pintarReproductores($("#mediaPlayers"), items);

    renderSidebar();
    window.scrollTo({ top: 0, behavior: "smooth" });
  }

  function abrirMediaCurso() {
    const cm = cursoActual.media;
    if (!cm) return;
    const items = [];
    if (cm.audio) items.push({ kind: "audio", src: cm.audio, label: "Podcast del curso" });
    if (cm.video) items.push({ kind: "video", src: cm.video, label: "Video del curso" });
    mostrarPanelMedia("🎧 Clase del curso", cm.titulo, cm.sub, items, "", "curso");
  }

  function abrirMediaModulo(moduloId) {
    const modulo = modulos.find((m) => m.id === moduloId);
    if (!modulo || !modulo.media) return;
    if (cursoActual) setHashSilencioso(hashModulo(slugCurso(cursoActual), moduloId));
    const items = [];
    if (modulo.media.video) items.push({ kind: "video", src: modulo.media.video, label: `Video · ${modulo.titulo}` });
    if (modulo.media.audio) items.push({ kind: "audio", src: modulo.media.audio, label: `Audio · ${modulo.titulo}` });
    mostrarPanelMedia(
      `${modulo.emoji} ${modulo.titulo}`,
      `Clase: ${modulo.titulo}`,
      modulo.intro,
      items,
      modulo.teoria,
      modulo.id,
      modulo.media.presentacion
    );
  }

  // --- Abre un ejercicio en el workspace -----------------------------------
  function abrirEjercicio(index) {
    const ej = ejerciciosPlanos[index];
    if (!estaDesbloqueado(index)) return;

    ejercicioActual = ej;
    indiceActual = index;
    mediaActual = null;
    document.body.classList.add("exercise-focus");
    if (cursoActual) setHashSilencioso(hashEjercicio(slugCurso(cursoActual), ej.moduloId, ej.id));

    welcome.classList.add("hidden");
    mediaPanel.classList.add("hidden");
    exercise.classList.remove("hidden");

    $("#exModulo").textContent = ej.moduloTitulo;
    $("#exNivel").textContent = "Nivel " + (ej.nivel || 1);
    $("#exTitulo").textContent = ej.titulo;
    $("#exEnunciado").innerHTML = `
      <span class="statement-label">Instrucciones:</span>
      <div class="statement-body">${ej.enunciado || ""}</div>`;
    $("#exPista").textContent = ej.pista || "Pensá el problema paso a paso.";
    quizRespuesta = null;

    const tipo = ej.type || "code";
    const esQuiz = tipo.startsWith("quiz");
    const esGuiado = tipo === "guided_steps";
    $("#quizArea").classList.toggle("hidden", !(esQuiz || esGuiado));
    $("#exerciseNextRow").classList.toggle("hidden", !(esQuiz || esGuiado));
    document.querySelector(".editor-zone").classList.toggle("hidden", esQuiz || esGuiado);
    document.querySelector(".output-zone").querySelector("h3").textContent = (esQuiz || esGuiado) ? "Corrección" : "Resultado";

    if (esQuiz) {
      pintarQuiz(ej);
    } else if (esGuiado) {
      pintarPasosGuiados(ej);
    } else {
      // Restaura el código guardado del alumno o el starter del ejercicio.
      const guardado = estado.codigo[ej.id];
      editor.setValue(guardado != null ? guardado : ej.starter || "");
      // Recalcula el ancho del gutter (números de línea) para que no tape el código.
      setTimeout(() => editor.refresh(), 0);
    }

    $("#stdin").value = "";
    outputEl.className = "output";
    outputEl.textContent = esQuiz
      ? "Elige una respuesta y toca «Comprobar»."
      : esGuiado
      ? "Completa el paso activo para avanzar."
      : "Tocá «Ejecutar» o «Comprobar» para ver la salida.";

    $("#btnNext").disabled = indiceActual >= ejerciciosPlanos.length - 1;
    $("#btnNextInline").disabled = indiceActual >= ejerciciosPlanos.length - 1;

    renderSidebar();
    window.scrollTo({ top: 0, behavior: "smooth" });
  }

  function volverAlCurso() {
    document.body.classList.remove("exercise-focus");
    ejercicioActual = null;
    indiceActual = -1;
    mediaActual = null;
    quizRespuesta = null;
    if (cursoActual) setHashSilencioso(hashCurso(slugCurso(cursoActual)));
    exercise.classList.add("hidden");
    mediaPanel.classList.add("hidden");
    welcome.classList.remove("hidden");
    pintarWelcome();
    renderSidebar();
    window.scrollTo({ top: 0, behavior: "smooth" });
  }

  function urlEjercicioActual() {
    if (!cursoActual || !ejercicioActual) return window.location.href;
    const hash = hashEjercicio(slugCurso(cursoActual), ejercicioActual.moduloId, ejercicioActual.id);
    return `${CANONICAL_ORIGIN}/${hash}`;
  }

  function compartirEjercicioWsp() {
    if (!cursoActual || !ejercicioActual) return;
    const url = urlEjercicioActual();
    const texto = `Mira este ejercicio de ${cursoActual.titulo}: ${ejercicioActual.titulo}\n${url}`;
    window.open(`https://wa.me/?text=${encodeURIComponent(texto)}`, "_blank", "noopener");
  }

  function pintarQuiz(ej) {
    const area = $("#quizArea");
    const opciones = (ej.options && ej.options.length)
      ? ej.options
      : [{ id: "true", label: "Verdadero" }, { id: "false", label: "Falso" }];
    area.innerHTML = `
      <div class="quiz-options">
        ${opciones.map((op) => `
          <button type="button" class="quiz-option" data-answer="${escaparHtml(op.id)}">
            <span class="quiz-option-key">${escaparHtml(op.id)}</span>
            <span>${escaparHtml(op.label)}</span>
          </button>
        `).join("")}
      </div>
      <button type="button" class="btn btn-primary btn-sm quiz-check" id="btnQuizCheck">Comprobar respuesta</button>`;
    area.querySelectorAll(".quiz-option").forEach((btn) => {
      btn.addEventListener("click", () => {
        quizRespuesta = btn.getAttribute("data-answer");
        area.querySelectorAll(".quiz-option").forEach((b) => b.classList.remove("selected"));
        btn.classList.add("selected");
      });
    });
    $("#btnQuizCheck").addEventListener("click", comprobarQuiz);
  }

  function estadoPasos(ej) {
    if (!estado.pasos[ej.id]) estado.pasos[ej.id] = { current: 0, correct: {}, answers: {}, feedback: {} };
    const st = estado.pasos[ej.id];
    st.current = Number(st.current || 0);
    st.correct ||= {};
    st.answers ||= {};
    st.feedback ||= {};
    return st;
  }

  function pintarPasosGuiados(ej) {
    const area = $("#quizArea");
    const pasos = Array.isArray(ej.steps) ? ej.steps : [];
    const st = estadoPasos(ej);
    if (!pasos.length) {
      area.innerHTML = '<p class="dim">Este ejercicio no tiene pasos configurados.</p>';
      return;
    }

    area.innerHTML = `<div class="guided-steps">
      ${pasos.map((paso, i) => pintarPasoGuiado(ej, paso, i, st)).join("")}
    </div>`;

    area.querySelectorAll("[data-step-check]").forEach((btn) => {
      btn.addEventListener("click", () => comprobarPasoGuiado(Number(btn.getAttribute("data-step-check"))));
    });
  }

  function pintarPasoGuiado(ej, paso, i, st) {
    const correcto = !!st.correct[i];
    const bloqueado = i > st.current && !correcto;
    const activo = i === st.current && !correcto;
    const cls = ["guided-step"];
    if (correcto) cls.push("correct");
    if (bloqueado) cls.push("locked");
    if (activo) cls.push("active");
    const feedback = st.feedback[i] || "";
    return `
      <section class="${cls.join(" ")}" data-step="${i}">
        <div class="guided-head">
          <span class="guided-index">${correcto ? "✓" : i + 1}</span>
          <div>
            <span class="guided-step-kicker">Paso ${i + 1}:</span>
            <h3>${escaparHtml(paso.title || "Resolver esta parte")}</h3>
            ${bloqueado ? '<p class="guided-status">Completa el paso anterior para desbloquear.</p>' : ""}
          </div>
        </div>
        ${bloqueado ? "" : pintarControlPaso(paso, i, st.answers[i])}
        ${bloqueado || !paso.hint ? "" : `<details class="guided-hint"><summary>Pista</summary><p>${escaparHtml(paso.hint)}</p></details>`}
        ${feedback ? `<div class="guided-feedback">${feedback}</div>` : ""}
      </section>`;
  }

  function pintarControlPaso(paso, i, valorPrevio) {
    if (paso.kind === "info") {
      return `
        <div class="guided-content">${paso.content_html || ""}</div>
        <button type="button" class="btn btn-primary btn-sm" data-step-check="${i}">Continuar</button>`;
    }
    if (paso.kind === "single") {
      const opciones = paso.options || [];
      return `
        <p class="guided-prompt">${escaparHtml(paso.prompt || "")}</p>
        <div class="guided-options">
          ${opciones.map((op) => `
            <label class="guided-choice">
              <input type="radio" name="guided-${i}" value="${escaparHtml(op.id)}" ${String(valorPrevio || "") === String(op.id) ? "checked" : ""}>
              <span>${escaparHtml(op.label)}</span>
            </label>
          `).join("")}
        </div>
        <button type="button" class="btn btn-primary btn-sm" data-step-check="${i}">Comprobar paso</button>`;
    }
    if (paso.kind === "boolean") {
      return `
        <p class="guided-prompt">${escaparHtml(paso.prompt || "")}</p>
        <div class="guided-options">
          <label class="guided-choice"><input type="radio" name="guided-${i}" value="true" ${valorPrevio === true || valorPrevio === "true" ? "checked" : ""}> <span>Verdadero</span></label>
          <label class="guided-choice"><input type="radio" name="guided-${i}" value="false" ${valorPrevio === false || valorPrevio === "false" ? "checked" : ""}> <span>Falso</span></label>
        </div>
        <button type="button" class="btn btn-primary btn-sm" data-step-check="${i}">Comprobar paso</button>`;
    }
    const multiline = paso.kind === "short_text" || paso.kind === "formula";
    const valor = valorPrevio == null ? "" : String(valorPrevio);
    return `
      <label class="guided-input-label">
        <span>${escaparHtml(paso.prompt || "Ingresa tu respuesta.")}</span>
        ${multiline
          ? `<textarea class="guided-input" data-step-input="${i}" rows="3">${escaparHtml(valor)}</textarea>`
          : `<input class="guided-input" data-step-input="${i}" type="text" value="${escaparHtml(valor)}">`}
      </label>
      <button type="button" class="btn btn-primary btn-sm" data-step-check="${i}">Comprobar paso</button>`;
  }

  function comprobarPasoGuiado(i) {
    if (!requerirLoginParaValidar()) return;
    const ej = ejercicioActual;
    const paso = (ej.steps || [])[i];
    if (!paso) return;
    const st = estadoPasos(ej);
    const respuesta = leerRespuestaPaso(paso, i);
    const res = validarPaso(paso, respuesta);
    st.answers[i] = respuesta;
    st.feedback[i] = res.ok
      ? `<span class="ok-line">Correcto.</span>${paso.explanation ? `<p>${escaparHtml(paso.explanation)}</p>` : ""}`
      : `<span class="fail-line">No todavía.</span><p>${escaparHtml(res.message || paso.hint || "Revisa el paso e intenta de nuevo.")}</p>`;

    if (res.ok) {
      st.correct[i] = true;
      while (st.correct[st.current] && st.current < (ej.steps || []).length - 1) st.current += 1;
      const completo = (ej.steps || []).every((_p, idx) => st.correct[idx]);
      if (completo) {
        st.current = (ej.steps || []).length;
        guardarProgreso();
        pintarPasosGuiados(ej);
        setOutput('<span class="ok-line">Ejercicio paso a paso completado.</span>', "ok");
        marcarCompletado(ej);
        return;
      }
      setOutput('<span class="ok-line">Paso correcto. Sigue con el siguiente.</span>', "ok");
    } else {
      setOutput('<span class="fail-line">Revisa este paso antes de avanzar.</span>', "fail");
    }
    guardarProgreso();
    pintarPasosGuiados(ej);
  }

  function leerRespuestaPaso(paso, i) {
    const area = $("#quizArea");
    if (paso.kind === "single" || paso.kind === "boolean") {
      const marcado = area.querySelector(`input[name="guided-${i}"]:checked`);
      if (!marcado) return "";
      return paso.kind === "boolean" ? marcado.value === "true" : marcado.value;
    }
    const input = area.querySelector(`[data-step-input="${i}"]`);
    return input ? input.value.trim() : "";
  }

  function validarPaso(paso, respuesta) {
    if (paso.kind === "info") return { ok: true };
    if (paso.kind === "single") {
      return { ok: String(respuesta) === String(paso.answer), message: "Elige otra alternativa." };
    }
    if (paso.kind === "boolean") {
      if (respuesta === "") return { ok: false, message: "Selecciona verdadero o falso." };
      return { ok: Boolean(respuesta) === Boolean(paso.answer), message: "Vuelve a evaluar la afirmación." };
    }
    if (paso.kind === "numeric") {
      const valor = parseNumeroFlexible(respuesta);
      const esperado = Number(paso.answer);
      const tol = Number(paso.tolerance ?? 0);
      if (!Number.isFinite(valor)) return { ok: false, message: "Ingresa un número válido." };
      const directo = Math.abs(valor - esperado) <= tol;
      const porcentaje = paso.allow_percent && Math.abs(valor / 100 - esperado) <= tol;
      return { ok: directo || porcentaje, message: "El valor no calza con la tolerancia esperada." };
    }
    if (paso.kind === "short_text") {
      const texto = normalizarTexto(respuesta);
      const keys = paso.accepted_keywords || [];
      const ok = keys.every((k) => texto.includes(normalizarTexto(k)));
      return { ok, message: paso.sample_answer ? `Una respuesta esperada sería: ${paso.sample_answer}` : "Faltan ideas clave en la respuesta." };
    }
    if (paso.kind === "formula") {
      const r = normalizarFormula(respuesta);
      const aceptadas = paso.accepted || [];
      const ok = aceptadas.some((f) => normalizarFormula(f) === r);
      return { ok, message: "La fórmula no coincide con una forma esperada." };
    }
    return { ok: false, message: "Tipo de paso no soportado." };
  }

  // --- Guarda el código del alumno mientras escribe ------------------------
  function guardarCodigoActual() {
    if (!ejercicioActual || (ejercicioActual.type || "code") !== "code") return;
    estado.codigo[ejercicioActual.id] = editor.getValue();
    guardarProgreso();
  }

  // --- Pyodide listo? ------------------------------------------------------
  let pyListo = false;
  async function asegurarPython() {
    if (pyListo) return;
    setOutput('<span class="dim"><span class="spinner"></span>Cargando Python (primera vez, ~5s)…</span>', "");
    await window.PyRunner.load();
    pyListo = true;
  }

  function setOutput(html, cls) {
    outputEl.className = "output" + (cls ? " " + cls : "");
    outputEl.innerHTML = html;
  }

  function escaparHtml(s) {
    return String(s || "").replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
  }

  function normalizarTexto(s) {
    return String(s || "")
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .replace(/\s+/g, " ")
      .trim();
  }

  function normalizarFormula(s) {
    return normalizarTexto(s)
      .replace(/×|·/g, "*")
      .replace(/\s+/g, "")
      .replace(/\*/g, "");
  }

  function parseNumeroFlexible(s) {
    const limpio = String(s || "").replace("%", "").replace(",", ".").trim();
    return Number(limpio);
  }

  // --- Botón Ejecutar ------------------------------------------------------
  async function onRun() {
    if (ejercicioActual && (ejercicioActual.type || "code") !== "code") {
      setOutput("En este tipo de ejercicio no hay código que ejecutar. Resuelve la actividad en el panel.", "");
      return;
    }
    guardarCodigoActual();
    await asegurarPython();
    const codigo = editor.getValue();
    const entrada = $("#stdin").value;
    try {
      const { output, error } = await window.PyRunner.run(codigo, entrada);
      if (error) {
        setOutput('<span class="err-line">' + escaparHtml(error) + "</span>", "fail");
      } else {
        setOutput(
          output.trim() === ""
            ? '<span class="dim">(tu programa no imprimió nada)</span>'
            : escaparHtml(output),
          ""
        );
      }
    } catch (e) {
      setOutput('<span class="err-line">Error inesperado: ' + escaparHtml(String(e)) + "</span>", "fail");
    }
  }

  // --- Botón Comprobar -----------------------------------------------------
  async function onCheck() {
    if (ejercicioActual && (ejercicioActual.type || "code").startsWith("quiz")) {
      comprobarQuiz();
      return;
    }
    if (ejercicioActual && (ejercicioActual.type || "code") === "guided_steps") {
      setOutput("Completa el paso activo usando el botón «Comprobar paso».", "");
      return;
    }
    if (!requerirLoginParaValidar()) return;
    guardarCodigoActual();
    await asegurarPython();
    const codigo = editor.getValue();
    setOutput('<span class="dim"><span class="spinner"></span>Corriendo casos de prueba…</span>', "");

    const ej = ejercicioActual;
    let res;
    try {
      res = await window.PyRunner.check(codigo, ej.tests);
    } catch (e) {
      setOutput('<span class="err-line">Error al correr: ' + escaparHtml(String(e)) + "</span>", "fail");
      return;
    }

    // Construye el reporte por caso.
    let html = "";
    res.resultados.forEach((r, i) => {
      const icono = r.pasa ? "✅" : "❌";
      const cls = r.pasa ? "ok-line" : "fail-line";
      const entrada = r.stdin.length ? r.stdin.join(", ") : "(sin entrada)";
      html += `<span class="${cls}">${icono} Caso ${i + 1}</span>  `;
      html += `<span class="dim">entrada: ${escaparHtml(entrada)}</span>\n`;
      if (!r.pasa) {
        if (r.error) {
          html += '   <span class="err-line">' + escaparHtml(r.error.split("\n").slice(-2).join(" ").trim()) + "</span>\n";
        } else {
          html += '   <span class="dim">' + escaparHtml(r.detalle) + "</span>\n";
          const salida = r.output.trim() || "(nada)";
          html += '   <span class="dim">tu salida: ' + escaparHtml(salida.replace(/\n/g, " ⏎ ")) + "</span>\n";
        }
      }
    });

    html += `\n<b>${res.pasados} de ${res.total} casos correctos.</b>`;

    if (res.exito) {
      setOutput(html, "ok");
      marcarCompletado(ej);
    } else {
      setOutput(html, "fail");
    }
  }

  function comprobarQuiz() {
    if (!requerirLoginParaValidar()) return;
    const ej = ejercicioActual;
    if (!quizRespuesta) {
      setOutput('<span class="fail-line">Elige una respuesta antes de comprobar.</span>', "fail");
      return;
    }
    const correcta = String(ej.correctAnswer) === String(quizRespuesta);
    const explicacion = ej.explanation || ej.solutionHtml || "";
    if (correcta) {
      setOutput(
        `<span class="ok-line">✅ Correcto.</span>\n${escaparHtml(explicacion)}`,
        "ok"
      );
      marcarCompletado(ej);
      return;
    }
    setOutput(
      `<span class="fail-line">❌ No todavía.</span>\n${escaparHtml(explicacion || "Revisa la pista y vuelve a intentarlo.")}`,
      "fail"
    );
  }

  // --- Marca completado y desbloquea el siguiente --------------------------
  function marcarCompletado(ej) {
    const eraNuevo = !estado.completados[ej.id];
    estado.completados[ej.id] = true;
    guardarProgreso();
    const payload = { completed: true };
    if ((ej.type || "code") === "code") payload.code = editor.getValue();
    pushRemoto(ej.id, payload);
    renderSidebar();
    $("#btnNext").disabled = indiceActual >= ejerciciosPlanos.length - 1;
    $("#btnNextInline").disabled = indiceActual >= ejerciciosPlanos.length - 1;

    if (eraNuevo) {
      mostrarToast("🎉 ¡Ejercicio completado!");
      enviarPush(
        "Ejercicio completado",
        `Avanzaste en ${cursoActual?.titulo || "tu curso"}.`,
        urlEjercicioActual()
      );
    }
  }

  function mostrarToast(texto) {
    const t = document.createElement("div");
    t.className = "toast";
    t.textContent = texto;
    document.body.appendChild(t);
    setTimeout(() => t.remove(), 2200);
  }

  // --- Botón Siguiente -----------------------------------------------------
  function onNext() {
    const sig = indiceActual + 1;
    if (sig < ejerciciosPlanos.length && estaDesbloqueado(sig)) {
      abrirEjercicio(sig);
    }
  }

  // --- Botón Reiniciar código ----------------------------------------------
  function onReset() {
    if (!ejercicioActual) return;
    if ((ejercicioActual.type || "code") !== "code") return;
    if (confirm("¿Volver al código inicial? Se perderá lo que escribiste en este ejercicio.")) {
      editor.setValue(ejercicioActual.starter || "");
      guardarCodigoActual();
    }
  }

  // --- Heartbeat de tiempo dedicado ----------------------------------------
  // Cuenta segundos de actividad REAL en el ejercicio abierto (pestaña visible
  // + interacción reciente) y los acumula en la nube vía RPC. El panel admin lo
  // usa para mostrar cuántas horas le dedicó cada alumno. Solo cuenta logueado.
  const HEARTBEAT_TICK_S = 15;   // cada cuántos segundos suma un "tick"
  const HEARTBEAT_IDLE_S = 120;  // sin interacción => se considera inactivo (no cuenta)
  const HEARTBEAT_FLUSH_S = 60;  // segundos acumulados antes de mandar a la nube
  const tiempoPendiente = {};    // exercise_id -> segundos sin enviar
  let ultimaInteraccion = Date.now();

  function marcarInteraccion() { ultimaInteraccion = Date.now(); }

  function flushTiempo() {
    if (!usuarioActual) {
      Object.keys(tiempoPendiente).forEach((k) => delete tiempoPendiente[k]);
      return;
    }
    Object.keys(tiempoPendiente).forEach((id) => {
      const secs = tiempoPendiente[id];
      delete tiempoPendiente[id];
      if (secs > 0) {
        window.ProgresoRemoto.sumarTiempo(id, secs)
          .catch((e) => console.warn("No se pudo guardar tiempo:", e.message || e));
      }
    });
  }

  function iniciarHeartbeat() {
    ["keydown", "mousedown", "mousemove", "touchstart", "wheel"].forEach((ev) =>
      document.addEventListener(ev, marcarInteraccion, { passive: true }));

    setInterval(() => {
      if (!usuarioActual || !ejercicioActual) return;
      if (document.visibilityState !== "visible") return;
      if (Date.now() - ultimaInteraccion > HEARTBEAT_IDLE_S * 1000) return;
      const id = ejercicioActual.id;
      tiempoPendiente[id] = (tiempoPendiente[id] || 0) + HEARTBEAT_TICK_S;
      const totalPend = Object.values(tiempoPendiente).reduce((a, b) => a + b, 0);
      if (totalPend >= HEARTBEAT_FLUSH_S) flushTiempo();
    }, HEARTBEAT_TICK_S * 1000);

    // Manda lo pendiente al ocultar la pestaña o cerrar (best-effort).
    document.addEventListener("visibilitychange", () => {
      if (document.visibilityState === "hidden") flushTiempo();
    });
    window.addEventListener("beforeunload", flushTiempo);
  }

  // --- Carga inicial de Pyodide en segundo plano ---------------------------
  async function precargarPython() {
    if (!cursoActual) {
      if (pyStatus) {
        pyStatus.innerHTML = "Selecciona un curso para empezar.";
        pyStatus.style.background = "var(--bg-card)";
      }
      return;
    }
    if (!cursoTieneCodigo()) {
      pyStatus.innerHTML = "✅ Curso listo. Elegí una pregunta para empezar.";
      pyStatus.style.background = "var(--bg-card)";
      return;
    }
    try {
      await window.PyRunner.load();
      pyListo = true;
      pyStatus.innerHTML = "✅ Python listo. ¡Elegí un ejercicio para empezar!";
      pyStatus.style.background = "var(--green-soft)";
    } catch (e) {
      pyStatus.innerHTML = "⚠️ No se pudo cargar Python. Revisá tu conexión y recargá.";
      pyStatus.style.background = "var(--red-soft)";
    }
  }

  // --- Arranque ------------------------------------------------------------
  function init() {
    initEditor();
    actualizarMarcaCurso();
    pintarSelectorCursos();
    pintarWelcome();
    renderSidebar();
    cargarCursosRemotos();

    if (courseSelect) {
      courseSelect.addEventListener("change", () => cambiarCurso(courseSelect.value));
    }

    editor.on("change", () => {
      // Guardado liviano del código mientras escribe (local + nube con debounce).
      if (ejercicioActual && (ejercicioActual.type || "code") === "code") {
        const code = editor.getValue();
        estado.codigo[ejercicioActual.id] = code;
        pushCodigoDebounced(ejercicioActual.id, code);
      }
    });
    editor.on("blur", () => {
      guardarProgreso();
      if (ejercicioActual && (ejercicioActual.type || "code") === "code") {
        pushRemoto(ejercicioActual.id, { code: editor.getValue() });
      }
    });

    // Sincroniza con la nube cuando cambia la sesión (login/logout).
    if (window.AuthUI) window.AuthUI.onUsuario(sincronizarConRemoto);

    // Expone el progreso para el modo prueba (saber qué módulos están completos).
    window.ProgresoApp = {
      completados: () => ({ ...estado.completados }),
      cursos: () => cursos.slice(),
      cursoActual: () => cursoActual,
      modulosActuales: () => modulos.slice(),
    };

    // Expone el contexto del ejercicio actual para el asistente de IA.
    window.AsistenteContexto = () => {
      if (!ejercicioActual) return {};
      const enunciado = (ejercicioActual.enunciado || "").replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
      const esCodigo = (ejercicioActual.type || "code") === "code";
      return {
        id: ejercicioActual.id,
        curso: cursoActual ? cursoActual.titulo : "",
        titulo: ejercicioActual.titulo,
        tipo: ejercicioActual.type || "code",
        enunciado,
        codigo: esCodigo ? editor.getValue() : "",
      };
    };

    // Permite que el tutor por voz (ConvAI) escriba código en el editor.
    // Devuelve un mensaje de estado que el agente puede leer en voz.
    window.EscribirEnEditor = (codigo) => {
      if (!codigo || !String(codigo).trim()) return "No recibí código para escribir.";
      if (ejercicioActual && (ejercicioActual.type || "code") !== "code") {
        return "Este ejercicio no tiene editor de código.";
      }
      if (!editor || exercise.classList.contains("hidden")) {
        return "El alumno no tiene ningún ejercicio abierto. Pedile que abra un ejercicio primero.";
      }
      editor.setValue(String(codigo));
      setTimeout(() => editor.refresh(), 0);
      if (ejercicioActual) {
        estado.codigo[ejercicioActual.id] = String(codigo);
        guardarProgreso();
        pushCodigoDebounced(ejercicioActual.id, String(codigo));
      }
      // Pequeño resalte para que el alumno note el cambio.
      try {
        const wrap = editor.getWrapperElement();
        wrap.style.transition = "box-shadow .3s";
        wrap.style.boxShadow = "0 0 0 2px var(--py-yellow)";
        setTimeout(() => { wrap.style.boxShadow = ""; }, 1200);
      } catch (_) {}
      return "Listo, escribí el código en el editor del alumno.";
    };

    $("#btnRun").addEventListener("click", onRun);
    $("#btnCheck").addEventListener("click", onCheck);
    $("#btnNext").addEventListener("click", onNext);
    $("#btnNextInline").addEventListener("click", onNext);
    $("#btnReset").addEventListener("click", onReset);
    $("#btnBackToCourse").addEventListener("click", volverAlCurso);
    $("#btnShareExercise").addEventListener("click", compartirEjercicioWsp);

    iniciarHeartbeat();
    registrarPwa();
    precargarPython();
  }

  // Espera a que el DOM y los scripts (CodeMirror, data) estén disponibles.
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
