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
  let estadoAcceso = { status: "anonymous" };

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

  function hashClase(courseId, moduleId, classId) {
    return `${hashModulo(courseId, moduleId)}/clase/${encodeURIComponent(classId)}`;
  }

  function hashEjercicio(courseId, moduleId, exerciseId) {
    return `${hashModulo(courseId, moduleId)}/${encodeURIComponent(exerciseId)}`;
  }

  function leerRutaHash() {
    const parts = window.location.hash.replace(/^#\/?/, "").split("/").filter(Boolean);
    if (parts[0] !== "curso" || !parts[1]) return {};
    const moduleId = parts[2] && parts[2] !== "ejercicio" ? decodeURIComponent(parts[2]) : null;
    const classId = parts[3] === "clase" && parts[4] ? decodeURIComponent(parts[4]) : null;
    const exerciseId = classId
      ? null
      : parts[2] === "ejercicio" && parts[3]
      ? decodeURIComponent(parts[3])
      : parts[2] && parts[2] !== "ejercicio" && parts[3]
      ? decodeURIComponent(parts[3])
      : null;
    return {
      courseId: decodeURIComponent(parts[1]),
      moduleId,
      classId,
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
        swRegistration = await navigator.serviceWorker.register("/sw.js?v=20260809-module-pages-2");
        let refrescadoPorSw = false;
        navigator.serviceWorker.addEventListener("controllerchange", () => {
          if (refrescadoPorSw) return;
          refrescadoPorSw = true;
          window.location.reload();
        });
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
    document.body.classList.toggle("catalog-mode", !cursoActual);
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
    moduloExpandidoId = null;
    paginaModuloId = null;
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
    moduloExpandidoId = null;
    paginaModuloId = null;
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

  function limpiarCursosRemotos() {
    cursos = [];
    cursoActual = null;
    reconstruirEjerciciosPlanos();
    ejercicioActual = null;
    indiceActual = -1;
    mediaActual = null;
    moduloExpandidoId = null;
    paginaModuloId = null;
    quizRespuesta = null;
    localStorage.removeItem(COURSE_STORAGE_KEY);
    setHashSilencioso("");
    exercise.classList.add("hidden");
    mediaPanel.classList.add("hidden");
    welcome.classList.remove("hidden");
    actualizarMarcaCurso();
    pintarSelectorCursos();
    renderSidebar();
    pintarWelcome();
  }

  function abrirDesdeHash() {
    const ruta = leerRutaHash();
    if (!ruta.courseId) return;
    const curso = cursos.find((c) => c.id === ruta.courseId);
    if (!curso) return;
    cursoActual = curso;
    localStorage.setItem(COURSE_STORAGE_KEY, cursoActual.id);
    reconstruirEjerciciosPlanos();
    moduloExpandidoId = ruta.moduleId || null;
    paginaModuloId = ruta.moduleId || null;
    actualizarMarcaCurso();
    pintarSelectorCursos();
    renderSidebar();
    pintarWelcome();
    if (ruta.classId && ruta.moduleId) {
      abrirClaseMedia(ruta.moduleId, ruta.classId);
      return;
    }
    if (ruta.exerciseId) {
      const idx = ejerciciosPlanos.findIndex((e) =>
        e.id === ruta.exerciseId && (!ruta.moduleId || e.moduloId === ruta.moduleId)
      );
      if (idx >= 0) abrirEjercicio(idx);
    }
  }

  async function cargarCursosRemotos() {
    if (!window.CursosRemotos || !usuarioActual) return;
    try {
      estadoAcceso = window.AccesoCursos
        ? await window.AccesoCursos.estado(usuarioActual)
        : { status: "approved" };
      if (estadoAcceso.status !== "approved") {
        limpiarCursosRemotos();
        return;
      }
      const remotos = await window.CursosRemotos.cargarPublicados();
      mezclarCursosRemotos(remotos);
    } catch (e) {
      console.warn("No se pudieron cargar cursos desde Supabase:", e.message || e);
    }
  }

  async function solicitarAccesoCursos() {
    if (!usuarioActual) {
      if (window.AuthUI) window.AuthUI.abrir();
      return;
    }
    const btn = document.querySelector("[data-request-course-access]");
    if (btn) {
      btn.disabled = true;
      btn.textContent = "Solicitando...";
    }
    try {
      estadoAcceso = await window.AccesoCursos.solicitar(usuarioActual);
      limpiarCursosRemotos();
      mostrarToast("Solicitud enviada. Un admin debe aprobar tu acceso.");
    } catch (e) {
      mostrarToast(e.message || "No se pudo solicitar acceso.");
      if (btn) {
        btn.disabled = false;
        btn.textContent = "Solicitar acceso";
      }
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

  function mostrarLoginParaEjercicio() {
    if (window.AuthUI) window.AuthUI.abrir();
  }

  // Al iniciar/cerrar sesión: fusiona el progreso local con el de la nube.
  async function sincronizarConRemoto(user) {
    usuarioActual = user;
    if (!user) {
      // Logout: el progreso local queda como "invitado" en este dispositivo.
      estadoAcceso = { status: "anonymous" };
      limpiarCursosRemotos();
      return;
    }
    await cargarCursosRemotos();
    if (estadoAcceso.status !== "approved") return;
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
  let moduloExpandidoId = null;
  let paginaModuloId = null;
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
      const clasesModulo = clasesMediaModulo(modulo);
      const totalClasesModulo = clasesModulo.filter((clase) => clase.lessonKind !== "section").length;
      const expandido = moduloExpandidoId === modulo.id;

      const divMod = document.createElement("div");
      divMod.className = "modulo";

      const header = document.createElement("div");
      header.className = "modulo-header";
      if (expandido) header.classList.add("expanded");
      const totalModulo = totalClasesModulo || modulo.ejercicios.length;
      header.innerHTML = `<span class="emoji">${modulo.emoji}</span> ${modulo.titulo}
        <span class="modulo-progress">${clasesModulo.length ? `${totalClasesModulo} clases` : `${completadosModulo}/${totalModulo}`}</span>`;
      header.classList.add("clickable");
      header.addEventListener("click", () => abrirPaginaModulo(modulo.id));
      divMod.appendChild(header);

      // Contenido del módulo: teoría, recursos externos y media directa si existe.
      if (expandido && !clasesModulo.length && (modulo.teoria || modulo.intro || (modulo.media && (modulo.media.video || modulo.media.audio)))) {
        const tieneMediaDirecta = !!(modulo.media && (modulo.media.video || modulo.media.audio));
        const mItem = document.createElement("div");
        mItem.className = "ej-item media-link";
        if (mediaActual === modulo.id) mItem.classList.add("activo");
        mItem.innerHTML = `
          <span class="estado">${tieneMediaDirecta ? "📺" : "🔗"}</span>
          <span class="nombre">Clases y contenido</span>
          <span class="nivel-dots">${tieneMediaDirecta ? "media" : "links"}</span>`;
        mItem.addEventListener("click", () => abrirMediaModulo(modulo.id));
        divMod.appendChild(mItem);
      }

      if (expandido && clasesModulo.length) {
        clasesModulo.forEach((clase) => {
          if (clase.lessonKind === "section") {
            const section = document.createElement("div");
            section.className = "lesson-section-label";
            section.textContent = clase.titulo;
            divMod.appendChild(section);
            return;
          }
          const cItem = document.createElement("div");
          cItem.className = "ej-item media-link class-link";
          if (mediaActual === `${modulo.id}:${clase.id}`) cItem.classList.add("activo");
          cItem.innerHTML = `
            <span class="estado">▶️</span>
            <span class="nombre">${escaparHtml(clase.titulo)}</span>
            <span class="nivel-dots">Clase ${clase.numero}</span>`;
          cItem.addEventListener("click", () => abrirClaseMedia(modulo.id, clase.id));
          divMod.appendChild(cItem);
        });
      }

      (!clasesModulo.length ? (modulo.ejercicios || []) : []).forEach((ej) => {
        const idx = globalIndex++;
        if (!expandido) return;
        const desbloqueado = estaDesbloqueado(idx);
        const completado = !!estado.completados[ej.id];

        const item = document.createElement("div");
        item.className = "ej-item";
        if (!desbloqueado) item.classList.add("bloqueado");
        if (ejercicioActual && ej.id === ejercicioActual.id) item.classList.add("activo");

        const estadoIcon = completado ? "✅" : desbloqueado ? "⚪" : "🔒";
        const tipo = ej.type || "code";
        const dots = tipo === "guided_steps" ? "pasos" : tipo === "development" ? "desarrollo" : tipo.startsWith("quiz") ? "quiz" : "●".repeat(ej.nivel || 1);

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
    const totalClases = modulos.reduce(
      (sum, modulo) => sum + clasesMediaModulo(modulo).filter((clase) => clase.lessonKind !== "section").length,
      0
    );
    const total = totalClases || ejerciciosPlanos.length;
    const hechos = ejerciciosPlanos.filter((e) => estado.completados[e.id]).length;
    const pct = total ? Math.round((hechos / total) * 100) : 0;
    $("#progresoGlobal").style.width = pct + "%";
    $("#progresoTexto").textContent = totalClases ? `${totalClases} clases` : `${hechos} / ${total}`;
  }

  function cursoTieneCodigo() {
    if (!cursoActual) return false;
    return ejerciciosPlanos.some((e) => (e.type || "code") === "code");
  }

  function cursoTieneClasesVideo() {
    if (!cursoActual) return false;
    return modulos.some((modulo) => clasesMediaModulo(modulo).length);
  }

  function segundosDuracion(value) {
    if (!value) return 0;
    const parts = String(value).trim().split(":").map(Number);
    if (!parts.length || parts.some((part) => !Number.isFinite(part))) return 0;
    return parts.reduce((total, part) => total * 60 + part, 0);
  }

  function formatoDuracionTotal(seconds) {
    const total = Math.round(Number(seconds) || 0);
    if (!total) return "Duración no informada";
    const hours = Math.floor(total / 3600);
    const minutes = Math.ceil((total % 3600) / 60);
    return hours ? `${hours} h${minutes ? ` ${minutes} min` : ""}` : `${minutes} min`;
  }

  function duracionModulo(modulo) {
    return clasesMediaModulo(modulo).reduce((total, clase) => total + segundosDuracion(clase.videoDuration), 0);
  }

  function duracionCurso(modulosCurso) {
    const seen = new Set();
    return modulosCurso.reduce((total, modulo) => total + clasesMediaModulo(modulo).reduce((subtotal, clase) => {
      if (clase.lessonKind === "section") return subtotal;
      const key = clase.videoUrl || clase.href || clase.id;
      if (seen.has(key)) return subtotal;
      seen.add(key);
      return subtotal + segundosDuracion(clase.videoDuration);
    }, 0), 0);
  }

  function textoPlanoMarkdown(markdown, limit = 420) {
    const template = document.createElement("template");
    template.innerHTML = renderMarkdownSeguro(markdown || "");
    const text = (template.content.textContent || "").replace(/\s+/g, " ").trim();
    return text.length > limit ? `${text.slice(0, limit).trim()}…` : text;
  }

  function abrirPaginaModulo(moduleId) {
    if (!cursoActual || !modulos.some((item) => item.id === moduleId)) return;
    paginaModuloId = moduleId;
    moduloExpandidoId = moduleId;
    mediaActual = null;
    ejercicioActual = null;
    indiceActual = -1;
    setHashSilencioso(hashModulo(slugCurso(cursoActual), moduleId));
    exercise.classList.add("hidden");
    mediaPanel.classList.add("hidden");
    welcome.classList.remove("hidden");
    pintarWelcome();
    renderSidebar();
    document.querySelector(".workspace")?.scrollTo({ top: 0, behavior: "smooth" });
  }

  function pintarPaginaModulo(modulo) {
    const clases = clasesMediaModulo(modulo);
    let lessonNumber = 0;
    const contenidos = clases.length ? clases.map((clase) => {
      if (clase.lessonKind === "section") return `<div class="course-outline-section">${escaparHtml(clase.titulo)}</div>`;
      lessonNumber += 1;
      return `<button type="button" class="course-outline-lesson" data-module-id="${escaparHtml(modulo.id)}" data-lesson-id="${escaparHtml(clase.id)}">
        <span class="course-outline-number">${lessonNumber}</span>
        <span class="course-outline-copy"><strong>${escaparHtml(clase.titulo)}</strong><span>${escaparHtml(clase.resumen || "Descripción pendiente de revisión editorial.")}</span><small>${clase.videoDuration ? escaparHtml(clase.videoDuration) : "Duración no informada"}${clase.hasTranscript ? " · Transcripción disponible" : ""}</small></span>
        <span class="course-outline-open">Ver clase →</span>
      </button>`;
    }).join("") : (modulo.ejercicios || []).map((ejercicio, index) => `<button type="button" class="course-outline-lesson" data-exercise-id="${escaparHtml(ejercicio.id)}"><span class="course-outline-number">${index + 1}</span><span class="course-outline-copy"><strong>${escaparHtml(ejercicio.titulo)}</strong><span>Actividad práctica del módulo.</span></span><span class="course-outline-open">Abrir →</span></button>`).join("");
    const totalClases = clases.filter((clase) => clase.lessonKind !== "section").length;
    const descripcion = modulo.overviewMarkdown || modulo.intro || `Contenidos y actividades de ${modulo.titulo}.`;
    welcome.className = "welcome course-overview module-page";
    welcome.innerHTML = `<button type="button" class="course-back" data-module-back>← ${escaparHtml(cursoActual.titulo)}</button>
      <section class="course-hero module-hero"><div class="course-hero-icon">${modulo.emoji || "📦"}</div><div><span class="course-eyebrow">Módulo</span><h2>${escaparHtml(modulo.titulo)}</h2><div class="module-description">${renderMarkdownSeguro(descripcion)}</div></div></section>
      <div class="course-stats"><span><strong>${totalClases || (modulo.ejercicios || []).length}</strong> ${totalClases ? "clases" : "actividades"}</span><span><strong>${formatoDuracionTotal(duracionModulo(modulo))}</strong> de duración total</span></div>
      <div class="course-program-head"><div><span class="course-eyebrow">Clases</span><h3>Contenido del módulo</h3></div><p>Cada clase incluye su descripción y acceso directo.</p></div>
      <div class="course-outline-lessons">${contenidos || '<p class="course-empty-module">Contenido próximamente.</p>'}</div>`;
    welcome.querySelector("[data-module-back]").addEventListener("click", () => { paginaModuloId = null; setHashSilencioso(hashCurso(slugCurso(cursoActual))); pintarWelcome(); renderSidebar(); });
    welcome.querySelectorAll("[data-lesson-id]").forEach((button) => button.addEventListener("click", () => abrirClaseMedia(button.dataset.moduleId, button.dataset.lessonId)));
    welcome.querySelectorAll("[data-exercise-id]").forEach((button) => button.addEventListener("click", () => { const index = ejerciciosPlanos.findIndex((ejercicio) => ejercicio.id === button.dataset.exerciseId); if (index >= 0) abrirEjercicio(index); }));
  }

  function pintarWelcome() {
    if (!cursoActual) {
      const sinAcceso = usuarioActual && estadoAcceso.status !== "approved";
      const mensaje = sinAcceso
          ? estadoAcceso.status === "pending"
            ? "Tu solicitud de acceso esta pendiente de aprobacion."
            : estadoAcceso.status === "rejected"
            ? "Tu solicitud fue rechazada. Puedes volver a solicitar acceso."
            : "Tu cuenta aun no tiene acceso al catalogo."
          : cursos.length
          ? "Estos cursos vienen desde Supabase. El catálogo requiere iniciar sesión."
          : "Inicia sesión para ver los cursos disponibles.";
      const contenido = sinAcceso
          ? estadoAcceso.status === "pending"
            ? `<li class="access-card">
                <strong>Solicitud enviada</strong>
                <span>Un admin debe aprobar tu cuenta para ver los cursos.</span>
              </li>`
            : `<li class="access-card">
                <strong>Acceso requerido</strong>
                <span>Solicita acceso y un admin habilitara tu cuenta.</span>
                <button type="button" class="btn btn-primary btn-sm" data-request-course-access>Solicitar acceso</button>
              </li>`
          : cursos.length
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
          : `<li>El catálogo se muestra solo para usuarios con sesión iniciada.</li>`;
      welcome.className = "welcome";
      welcome.innerHTML = `
        <h2>Elige un curso</h2>
        <p>${mensaje}</p>
        <ul class="welcome-list">${contenido}</ul>
        <p class="loading-note" id="pyStatus">${sinAcceso ? "Solicita acceso para cargar el catálogo." : cursos.length ? "Selecciona un curso para ver su programa completo." : "Inicia sesión para cargar el catálogo."}</p>`;
      const list = welcome.querySelector(".welcome-list");
      if (list) {
        const accessBtn = list.querySelector("[data-request-course-access]");
        if (accessBtn) accessBtn.addEventListener("click", solicitarAccesoCursos);
        list.querySelectorAll("[data-course-id]").forEach((btn) => {
          btn.addEventListener("click", () => cambiarCurso(btn.getAttribute("data-course-id")));
        });
      }
      return;
    }

    if (paginaModuloId) {
      const modulo = (cursoActual.modulos || []).find((item) => item.id === paginaModuloId);
      if (modulo) {
        pintarPaginaModulo(modulo);
        return;
      }
      paginaModuloId = null;
    }

    const modulosCurso = cursoActual.modulos || [];
    const totalClases = modulosCurso.reduce((total, modulo) =>
      total + clasesMediaModulo(modulo).filter((clase) => clase.lessonKind !== "section").length, 0);
    const totalActividades = modulosCurso.reduce((total, modulo) => total + (modulo.ejercicios || []).length, 0);
    const totalTranscripciones = modulosCurso.reduce((total, modulo) =>
      total + clasesMediaModulo(modulo).filter((clase) => clase.hasTranscript).length, 0);

    const totalDuracion = duracionCurso(modulosCurso);
    const programa = modulosCurso.map((modulo) => {
      const clases = clasesMediaModulo(modulo);
      const intro = modulo.overviewMarkdown || modulo.intro || `Contenidos de ${modulo.titulo}.`;
      const count = clases.filter((clase) => clase.lessonKind !== "section").length || (modulo.ejercicios || []).length;
      return `<article class="course-module-card course-module-overview">
        <div class="course-module-summary"><span class="course-module-emoji">${modulo.emoji || "📦"}</span><div><strong>${escaparHtml(modulo.titulo)}</strong><p>${escaparHtml(textoPlanoMarkdown(intro) || `Contenidos de ${modulo.titulo}.`)}</p><small>${count} contenidos · ${formatoDuracionTotal(duracionModulo(modulo))}</small></div></div>
        <button type="button" class="btn btn-secondary" data-module-page="${escaparHtml(modulo.id)}">Ver módulo →</button>
      </article>`;
    }).join("");

    welcome.className = "welcome course-overview";
    welcome.innerHTML = `
      <button type="button" class="course-back" data-course-back>← Todos los cursos</button>
      <section class="course-hero">
        <div class="course-hero-icon">${cursoActual.emoji || "📚"}</div>
        <div>
          <span class="course-eyebrow">Programa completo</span>
          <h2>${escaparHtml(cursoActual.titulo)}</h2>
          <p>${escaparHtml(cursoActual.descripcion || cursoActual.subtitle || "Explora el programa y abre cualquier contenido para comenzar.")}</p>
        </div>
      </section>
      <div class="course-stats">
        <span><strong>${modulosCurso.length}</strong> módulos</span>
        <span><strong>${totalClases || totalActividades}</strong> ${totalClases ? "clases" : "actividades"}</span>
        <span><strong>${formatoDuracionTotal(totalDuracion)}</strong> de duración total</span>
        ${totalTranscripciones ? `<span><strong>${totalTranscripciones}</strong> transcripciones</span>` : ""}
      </div>
      <div class="course-program-head"><div><span class="course-eyebrow">Contenido</span><h3>Todo lo que verás</h3></div><p>Entra a un módulo para ver sus clases, descripciones y duración.</p></div>
      <div class="course-program">${programa}</div>`;

    welcome.querySelector("[data-course-back]").addEventListener("click", mostrarCatalogo);
    welcome.querySelectorAll("[data-module-page]").forEach((button) => button.addEventListener("click", () => abrirPaginaModulo(button.dataset.modulePage)));
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

  function urlEmbedMedia(url) {
    try {
      const u = new URL(url);
      const host = u.hostname.replace(/^www\./, "");

      if (host.includes("drive.google.com")) {
        const fileMatch = u.pathname.match(/\/file\/d\/([^/]+)/);
        if (fileMatch) {
          return {
            provider: "Drive",
            kind: "file",
            action: "Ver video",
            src: `https://drive.google.com/file/d/${fileMatch[1]}/preview`,
          };
        }

        const folderMatch = u.pathname.match(/\/drive\/folders\/([^/]+)/);
        if (folderMatch) {
          return {
            provider: "Drive",
            kind: "folder",
            action: "Ver carpeta",
            src: `https://drive.google.com/embeddedfolderview?id=${folderMatch[1]}#grid`,
          };
        }
      }

      if (host === "youtu.be" || host.endsWith("youtube.com")) {
        const id =
          host === "youtu.be"
            ? u.pathname.split("/").filter(Boolean)[0]
            : u.searchParams.get("v") ||
              (u.pathname.match(/\/(?:embed|shorts|live)\/([^/?#]+)/) || [])[1];
        if (id) {
          return {
            provider: "YouTube",
            kind: "youtube",
            action: "Ver video",
            src: `https://www.youtube.com/embed/${encodeURIComponent(id)}`,
          };
        }
      }

      if (host === "vimeo.com" || host.endsWith(".vimeo.com")) {
        const playerMatch = u.pathname.match(/\/video\/(\d+)/);
        const plainMatch = u.pathname.match(/\/(\d+)(?:\/([^/?#]+))?/);
        const videoId = playerMatch?.[1] || plainMatch?.[1];
        const hash = u.searchParams.get("h") || plainMatch?.[2];
        if (videoId) {
          const src = new URL(`https://player.vimeo.com/video/${videoId}`);
          if (hash) src.searchParams.set("h", hash);
          return {
            provider: "Vimeo",
            kind: "vimeo",
            action: "Ver video",
            src: src.toString(),
          };
        }
      }

      if (host === "loom.com" || host.endsWith(".loom.com")) {
        const loomMatch = u.pathname.match(/\/(?:share|embed)\/([a-zA-Z0-9]+)/);
        if (loomMatch) {
          return {
            provider: "Loom",
            kind: "loom",
            action: "Ver video",
            src: `https://www.loom.com/embed/${encodeURIComponent(loomMatch[1])}`,
          };
        }
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  function clasesMediaModulo(modulo) {
    if (!modulo) return [];
    if (Array.isArray(modulo.clases) && modulo.clases.length) {
      let lessonNumber = 0;
      return modulo.clases.map((clase) => {
        if (clase.lessonKind !== "section") lessonNumber += 1;
        return {
          ...clase,
          numero: clase.lessonKind === "section" ? null : lessonNumber,
          href: clase.videoUrl || "",
          embed: clase.videoUrl ? urlEmbedMedia(clase.videoUrl) : null,
          importedLesson: true,
        };
      });
    }
    if (!modulo.teoria) return [];
    const tpl = document.createElement("template");
    tpl.innerHTML = modulo.teoria;
    const links = [
      ...tpl.content.querySelectorAll(
        'a[href*="drive.google.com"], a[href*="youtube.com"], a[href*="youtu.be"], a[href*="vimeo.com"], a[href*="loom.com"]'
      ),
    ];
    return links
      .map((link, index) => {
        const embed = urlEmbedMedia(link.href);
        if (!embed || embed.kind === "folder") return null;
        return {
          id: `clase-${index + 1}`,
          numero: index + 1,
          titulo: (link.textContent || `Clase ${index + 1}`).trim(),
          href: link.href,
          embed,
        };
      })
      .filter(Boolean);
  }

  function insertarEmbedsMedia(cont) {
    const links = [
      ...cont.querySelectorAll(
        'a[href*="drive.google.com"], a[href*="youtube.com"], a[href*="youtu.be"], a[href*="vimeo.com"], a[href*="loom.com"]'
      ),
    ];
    const embeds = links
      .map((a) => ({ link: a, embed: urlEmbedMedia(a.href) }))
      .filter((it) => it.embed);
    if (!embeds.length) return;

    embeds.forEach(({ link }) => {
      const item = link.closest("li");
      if (item) item.classList.add("media-source-link");
    });
    cont.querySelectorAll("ul").forEach((list) => {
      const children = [...list.children];
      if (children.length && children.every((child) => child.classList.contains("media-source-link"))) {
        list.classList.add("media-source-list");
      }
    });

    const section = document.createElement("section");
    section.className = "drive-embeds";
    section.innerHTML = `
      <div class="drive-embeds-title">
        <h3>Clases en video</h3>
        <span>${embeds.length} ${embeds.length === 1 ? "clase" : "clases"} disponibles</span>
      </div>
      <div class="media-playlist">
        <div class="media-player-shell">
          <p>Selecciona una clase para cargar el video.</p>
        </div>
        <ol class="media-class-list"></ol>
      </div>`;

    const list = section.querySelector(".media-class-list");

    embeds.forEach(({ link, embed }, i) => {
      const title = link.textContent || `Recurso ${embed.provider} ${i + 1}`;
      const item = document.createElement("li");
      item.className = `media-class-row media-class-${embed.kind}`;
      item.innerHTML = `
        <div class="media-class-main">
          <button
            type="button"
            class="media-class-button"
            data-embed-src="${embed.src}"
            data-embed-title="${escaparHtml(title)}">
            <span class="media-class-number">Clase ${i + 1}</span>
            <span class="media-class-title">${escaparHtml(title)}</span>
            <span class="media-class-provider">${embed.provider}</span>
          </button>
          <a href="${link.href}" target="_blank" rel="noopener">Abrir</a>
        </div>`;
      list.appendChild(item);
    });

    section.addEventListener("click", (ev) => {
      const btn = ev.target.closest("[data-embed-src]");
      if (!btn) return;
      const holder = section.querySelector(".media-player-shell");
      section.querySelectorAll(".media-class-button").forEach((button) => button.classList.remove("active"));
      btn.classList.add("active");
      holder.innerHTML = `
        <div class="media-player-title">${escaparHtml(btn.getAttribute("data-embed-title") || "Clase en video")}</div>
        <iframe
          title="${escaparHtml(btn.getAttribute("data-embed-title") || "Recurso embebido")}"
          src="${btn.getAttribute("data-embed-src")}"
          loading="lazy"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture"
          allowfullscreen></iframe>`;
    });

    cont.appendChild(section);
  }

  function insertarEmbedsDrive(cont) {
    insertarEmbedsMedia(cont);
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
    const mediaTeoria = $("#mediaTeoria");
    mediaTeoria.innerHTML = teoriaHtml || "";
    insertarEmbedsDrive(mediaTeoria);
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
    if (!modulo) return;
    moduloExpandidoId = moduloId;
    if (cursoActual) setHashSilencioso(hashModulo(slugCurso(cursoActual), moduloId));
    const items = [];
    const media = modulo.media || {};
    if (media.video) items.push({ kind: "video", src: media.video, label: `Video · ${modulo.titulo}` });
    if (media.audio) items.push({ kind: "audio", src: media.audio, label: `Audio · ${modulo.titulo}` });
    mostrarPanelMedia(
      `${modulo.emoji} ${modulo.titulo}`,
      `Contenido: ${modulo.titulo}`,
      modulo.intro,
      items,
      modulo.teoria,
      modulo.id,
      media.presentacion
    );
  }

  function renderMarkdownSeguro(markdown) {
    if (!markdown) return "";
    if (!window.marked || !window.DOMPurify) return `<pre>${escaparHtml(markdown)}</pre>`;
    const html = window.marked.parse(markdown, { gfm: true, breaks: true });
    return window.DOMPurify.sanitize(html, {
      USE_PROFILES: { html: true },
      ADD_ATTR: ["target", "rel"],
    });
  }

  function etiquetaIdioma(language) {
    return {
      es: "Español",
      en: "Inglés",
      "en-orig": "Inglés original",
      und: "Transcripción",
    }[language] || language || "Transcripción";
  }

  function formatoBytes(bytes) {
    const value = Number(bytes) || 0;
    if (value < 1024) return `${value} B`;
    if (value < 1024 * 1024) return `${(value / 1024).toFixed(1)} KB`;
    return `${(value / (1024 * 1024)).toFixed(1)} MB`;
  }

  function renderVideoLeccion(clase) {
    if (!clase.videoUrl) return "";
    if (!clase.embed) {
      return `<p><a class="media-pres-link" href="${escaparHtml(clase.videoUrl)}" target="_blank" rel="noopener">Abrir video</a></p>`;
    }
    return `
      <div class="media-player-shell">
        <div class="media-player-title">${escaparHtml(clase.titulo)}</div>
        <iframe
          title="${escaparHtml(clase.titulo)}"
          src="${escaparHtml(clase.embed.src)}"
          loading="lazy"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture"
          allowfullscreen></iframe>
      </div>
      <div class="lesson-video-meta">
        ${clase.videoDuration ? `<span>${escaparHtml(clase.videoDuration)}</span>` : ""}
        <a class="media-pres-link" href="${escaparHtml(clase.videoUrl)}" target="_blank" rel="noopener">Abrir en ${escaparHtml(clase.embed.provider)}</a>
      </div>`;
  }

  function renderDetalleLeccion(container, clase, detalle) {
    const video = clase.videoUrl ? `
      <section class="lesson-flow-section lesson-video-section">
        ${renderVideoLeccion(clase)}
      </section>` : "";
    const contenido = detalle.bodyMarkdown ? `
      <section class="lesson-flow-section">
        <div class="lesson-section-heading"><span>Apuntes de la clase</span></div>
        <article class="lesson-markdown">${renderMarkdownSeguro(detalle.bodyMarkdown)}</article>
      </section>` : "";
    const recursos = detalle.resources.length ? `
      <section class="lesson-flow-section lesson-resources-section">
        <div class="lesson-section-heading"><span>Recursos para esta clase</span><small>${detalle.resources.length} ${detalle.resources.length === 1 ? "archivo" : "archivos"}</small></div>
        <div class="lesson-resource-list">${detalle.resources.map((resource) => `
          <article class="lesson-resource-card">
            <div>
              <span class="class-resource-kind">${escaparHtml(resource.kind)}</span>
              <strong>${escaparHtml(resource.title)}</strong>
              <small>${escaparHtml(resource.mimeType)} · ${formatoBytes(resource.fileSize)}</small>
            </div>
            ${resource.downloadUrl ? `<a class="media-pres-link" href="${escaparHtml(resource.downloadUrl)}" download>Descargar</a>` : `<span class="resource-unavailable">No disponible</span>`}
          </article>`).join("")}</div>
      </section>` : "";
    const transcripciones = detalle.transcripts.length ? `
      <section class="lesson-flow-section lesson-transcripts-section">
        <details class="lesson-transcript-group">
          <summary><span>Ver transcripción completa</span><small>${detalle.transcripts.length} ${detalle.transcripts.length === 1 ? "versión" : "versiones"}</small></summary>
          <div class="lesson-transcript-group-body">
            ${detalle.transcripts.map((track) => `
              <details class="lesson-transcript">
                <summary>${escaparHtml(etiquetaIdioma(track.language))}</summary>
                <div class="lesson-transcript-actions">
                  ${track.downloadUrl ? `<a class="media-pres-link" href="${escaparHtml(track.downloadUrl)}" download>Descargar SRT original</a>` : ""}
                </div>
                <div class="lesson-transcript-text">${escaparHtml(track.text).replace(/\n\n/g, "</p><p>").replace(/^/, "<p>").replace(/$/, "</p>")}</div>
              </details>`).join("")}
          </div>
        </details>
      </section>` : "";

    if (!video && !contenido && !recursos && !transcripciones) {
      container.innerHTML = `<p class="lesson-empty">Esta lección no tiene contenido publicado.</p>`;
      return;
    }
    container.innerHTML = `<div class="lesson-flow">${video}${contenido}${recursos}${transcripciones}</div>`;
  }

  async function abrirClaseMedia(moduloId, classId) {
    const modulo = modulos.find((m) => m.id === moduloId);
    if (!modulo) return;
    const clase = clasesMediaModulo(modulo).find((c) => c.id === classId);
    if (!clase) return;

    document.body.classList.remove("exercise-focus");
    ejercicioActual = null;
    indiceActual = -1;
    moduloExpandidoId = moduloId;
    mediaActual = `${moduloId}:${classId}`;
    if (cursoActual) setHashSilencioso(hashClase(slugCurso(cursoActual), moduloId, classId));

    welcome.classList.add("hidden");
    exercise.classList.add("hidden");
    mediaPanel.classList.remove("hidden");

    $("#btnBackToModule").textContent = `← ${modulo.titulo}`;
    $("#mediaBadge").textContent = `${modulo.emoji} Clase ${clase.numero}`;
    $("#mediaTitulo").textContent = clase.titulo;
    $("#mediaSub").innerHTML = modulo.overviewMarkdown
      ? renderMarkdownSeguro(modulo.overviewMarkdown)
      : (modulo.intro || "");
    $("#mediaPlayers").innerHTML = "";
    const teoria = $("#mediaTeoria");
    if (clase.importedLesson) {
      teoria.innerHTML = `<div class="lesson-loading">Cargando contenido de la lección…</div>`;
      try {
        const detalle = await window.LeccionesRemotas.cargarDetalle(clase.id);
        if (mediaActual !== `${moduloId}:${classId}`) return;
        renderDetalleLeccion(teoria, clase, detalle);
      } catch (error) {
        console.error("No se pudo cargar la lección:", error);
        if (mediaActual === `${moduloId}:${classId}`) {
          teoria.innerHTML = `<p class="lesson-error">No se pudo cargar el contenido. Recarga la página e inténtalo nuevamente.</p>`;
        }
      }
    } else if (clase.embed) {
      teoria.innerHTML = `<section class="drive-embeds class-video-view">${renderVideoLeccion({ ...clase, videoUrl: clase.href })}</section>`;
    }

    renderSidebar();
    window.scrollTo({ top: 0, behavior: "smooth" });
  }

  // --- Abre un ejercicio en el workspace -----------------------------------
  function abrirEjercicio(index) {
    const ej = ejerciciosPlanos[index];
    if (!estaDesbloqueado(index)) return;

    ejercicioActual = ej;
    indiceActual = index;
    mediaActual = null;
    moduloExpandidoId = ej.moduloId;
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
    const esDesarrollo = tipo === "development";
    const bloqueadoPorLogin = !usuarioActual;
    $("#exerciseLoginGate").classList.toggle("hidden", !bloqueadoPorLogin);
    $("#quizArea").classList.toggle("hidden", bloqueadoPorLogin || !(esQuiz || esGuiado || esDesarrollo));
    $("#exerciseNextRow").classList.toggle("hidden", bloqueadoPorLogin || !(esQuiz || esGuiado || esDesarrollo));
    document.querySelector(".editor-zone").classList.toggle("hidden", bloqueadoPorLogin || tipo !== "code");
    document.querySelector(".output-zone").classList.toggle("hidden", bloqueadoPorLogin);
    document.querySelector(".output-zone").querySelector("h3").textContent = (esQuiz || esGuiado || esDesarrollo) ? "Avance" : "Resultado";

    if (bloqueadoPorLogin) {
      $("#quizArea").innerHTML = "";
      outputEl.className = "output";
      outputEl.textContent = "";
      renderSidebar();
      window.scrollTo({ top: 0, behavior: "smooth" });
      return;
    }

    if (esQuiz) {
      pintarQuiz(ej);
    } else if (esGuiado) {
      pintarPasosGuiados(ej);
    } else if (esDesarrollo) {
      pintarDesarrollo(ej);
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
      : esDesarrollo
      ? "Escribe tu respuesta y guárdala cuando esté lista."
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
    paginaModuloId = moduloExpandidoId || null;
    if (cursoActual) setHashSilencioso(paginaModuloId
      ? hashModulo(slugCurso(cursoActual), paginaModuloId)
      : hashCurso(slugCurso(cursoActual)));
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

  function pintarDesarrollo(ej) {
    const area = $("#quizArea");
    if (!estado.pasos[ej.id]) estado.pasos[ej.id] = { answer: "" };
    const respuesta = estado.pasos[ej.id].answer || "";
    area.innerHTML = `
      <label class="guided-input-label">
        <span>Tu respuesta</span>
        <textarea class="guided-input" id="developmentAnswer" rows="8" placeholder="Escribe tu desarrollo, propuesta o plan de acción...">${escaparHtml(respuesta)}</textarea>
      </label>
      ${ej.solutionHtml ? `<details class="guided-hint"><summary>Guía de respuesta</summary><div>${ej.solutionHtml}</div></details>` : ""}
      <button type="button" class="btn btn-primary btn-sm" id="btnDevelopmentSave">Guardar y marcar completado</button>`;
    $("#developmentAnswer").addEventListener("input", (ev) => {
      estado.pasos[ej.id].answer = ev.target.value;
      guardarProgreso();
    });
    $("#btnDevelopmentSave").addEventListener("click", comprobarDesarrollo);
  }

  function comprobarDesarrollo() {
    if (!requerirLoginParaValidar()) return;
    const input = $("#developmentAnswer");
    const respuesta = input ? input.value.trim() : "";
    if (!respuesta) {
      setOutput('<span class="fail-line">Escribe una respuesta antes de marcar la actividad como completada.</span>', "fail");
      return;
    }
    if (!estado.pasos[ejercicioActual.id]) estado.pasos[ejercicioActual.id] = {};
    estado.pasos[ejercicioActual.id].answer = respuesta;
    guardarProgreso();
    setOutput('<span class="ok-line">Respuesta guardada.</span>', "ok");
    marcarCompletado(ejercicioActual);
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
    if (ejercicioActual && (ejercicioActual.type || "code") === "development") {
      comprobarDesarrollo();
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
    if (window.Auth) {
      window.Auth.usuarioActual()
        .then((user) => sincronizarConRemoto(user))
        .catch((e) => console.warn("No se pudo leer la sesión inicial:", e.message || e));
    }

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
    $("#btnBackToModule").addEventListener("click", volverAlCurso);
    $("#btnShareExercise").addEventListener("click", compartirEjercicioWsp);
    $("#btnExerciseLogin").addEventListener("click", mostrarLoginParaEjercicio);

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
