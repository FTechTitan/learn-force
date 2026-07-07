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
  let cursos = (window.LOCAL_COURSES && window.LOCAL_COURSES.length)
    ? window.LOCAL_COURSES.slice()
    : [{
        id: "python-de-a-poco",
        titulo: "Python de a poco",
        subtitle: "Aprende programando · curso UAI",
        emoji: "🐍",
        source: "local",
        modulos: window.CURRICULUM || [],
        media: window.COURSE_MEDIA || null,
      }];
  let cursoActual = cursos[0];
  let modulos = cursoActual.modulos || [];

  // Lista plana de ejercicios en orden, con referencia a su módulo.
  let ejerciciosPlanos = [];

  function reconstruirEjerciciosPlanos() {
    modulos = cursoActual.modulos || [];
    ejerciciosPlanos = [];
    modulos.forEach((m) => {
      (m.ejercicios || []).forEach((e) => ejerciciosPlanos.push({ ...e, moduloId: m.id, moduloTitulo: m.titulo }));
    });
  }

  reconstruirEjerciciosPlanos();

  // --- Estado persistente --------------------------------------------------
  function cargarProgreso() {
    try {
      const raw = localStorage.getItem(STORAGE_KEY);
      if (!raw) return { completados: {}, codigo: {} };
      const data = JSON.parse(raw);
      return { completados: data.completados || {}, codigo: data.codigo || {} };
    } catch {
      return { completados: {}, codigo: {} };
    }
  }

  function guardarProgreso() {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(estado));
  }

  const estado = cargarProgreso();

  function elegirCursoInicial() {
    const guardado = localStorage.getItem(COURSE_STORAGE_KEY);
    cursoActual = cursos.find((c) => c.id === guardado) || cursos[0];
    reconstruirEjerciciosPlanos();
  }

  function pintarSelectorCursos() {
    if (!courseSelect) return;
    courseSelect.innerHTML = cursos
      .map((c) => `<option value="${c.id}">${c.emoji || "📚"} ${c.titulo}${c.source === "remote" ? "" : " · local"}</option>`)
      .join("");
    courseSelect.value = cursoActual.id;
  }

  function actualizarMarcaCurso() {
    const title = $("#brandTitle");
    const subtitle = $("#brandSubtitle");
    const logo = document.querySelector(".logo");
    if (title) title.textContent = cursoActual.titulo;
    if (subtitle) subtitle.textContent = cursoActual.subtitle || cursoActual.descripcion || "";
    if (logo) logo.textContent = cursoActual.emoji || "📚";
  }

  function cambiarCurso(courseId) {
    const curso = cursos.find((c) => c.id === courseId);
    if (!curso) return;
    cursoActual = curso;
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
    if (!remotos || !remotos.length) return;
    const localesSinFallbackDuplicado = cursos.filter((c) => {
      if (c.id === "estadistica-aplicada-local" && remotos.some((r) => r.id === "estadistica-aplicada")) return false;
      return !remotos.some((r) => r.id === c.id);
    });
    cursos = [...localesSinFallbackDuplicado, ...remotos];
    elegirCursoInicial();
    pintarSelectorCursos();
    actualizarMarcaCurso();
    renderSidebar();
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

  elegirCursoInicial();

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
    // Si hay un ejercicio abierto, refresca su editor con el código fusionado.
    if (ejercicioActual && indiceActual >= 0) abrirEjercicio(indiceActual);
  }

  // Un ejercicio está desbloqueado si es el primero o si el anterior ya se
  // completó. Así se avanza "de a poco".
  function estaDesbloqueado(index) {
    if (index === 0) return true;
    const anterior = ejerciciosPlanos[index - 1];
    return !!estado.completados[anterior.id];
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
        const dots = (ej.type || "code").startsWith("quiz") ? "quiz" : "●".repeat(ej.nivel || 1);

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
    return ejerciciosPlanos.some((e) => !((e.type || "code").startsWith("quiz")));
  }

  function pintarWelcome() {
    const h = welcome.querySelector("h2");
    const p = welcome.querySelector("p");
    const list = welcome.querySelector(".welcome-list");
    if (h) h.textContent = `Bienvenido/a a ${cursoActual.titulo}`;
    if (p) {
      p.innerHTML = cursoActual.descripcion || "Elige un módulo de la izquierda para empezar.";
    }
    if (list) {
      if (cursoTieneCodigo()) {
        list.innerHTML = `
          <li>📝 Lee el enunciado y escribe tu solución en el editor.</li>
          <li>▶️ Toca <b>Ejecutar</b> para probar tu código.</li>
          <li>✅ Toca <b>Comprobar</b> para validar tu respuesta.</li>
          <li>🔓 Al completar ejercicios se desbloquean los siguientes.</li>`;
      } else {
        list.innerHTML = `
          <li>✅ Responde verdadero/falso o alternativas.</li>
          <li>📌 Revisa la explicación inmediata después de comprobar.</li>
          <li>🔓 Al responder correctamente se desbloquea la siguiente pregunta.</li>
          <li>📈 Usa el progreso para repetir solo donde fallaste.</li>`;
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

    welcome.classList.add("hidden");
    mediaPanel.classList.add("hidden");
    exercise.classList.remove("hidden");

    $("#exModulo").textContent = ej.moduloTitulo;
    $("#exNivel").textContent = "Nivel " + (ej.nivel || 1);
    $("#exTitulo").textContent = ej.titulo;
    $("#exEnunciado").innerHTML = ej.enunciado;
    $("#exPista").textContent = ej.pista || "Pensá el problema paso a paso.";
    quizRespuesta = null;

    const esQuiz = (ej.type || "code").startsWith("quiz");
    $("#quizArea").classList.toggle("hidden", !esQuiz);
    document.querySelector(".editor-zone").classList.toggle("hidden", esQuiz);
    document.querySelector(".output-zone").querySelector("h3").textContent = esQuiz ? "Corrección" : "Resultado";

    if (esQuiz) {
      pintarQuiz(ej);
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
      : "Tocá «Ejecutar» o «Comprobar» para ver la salida.";

    // El botón Siguiente se habilita solo si ya está completado.
    $("#btnNext").disabled = !estado.completados[ej.id];

    renderSidebar();
    window.scrollTo({ top: 0, behavior: "smooth" });
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
      </div>`;
    area.querySelectorAll(".quiz-option").forEach((btn) => {
      btn.addEventListener("click", () => {
        quizRespuesta = btn.getAttribute("data-answer");
        area.querySelectorAll(".quiz-option").forEach((b) => b.classList.remove("selected"));
        btn.classList.add("selected");
      });
    });
  }

  // --- Guarda el código del alumno mientras escribe ------------------------
  function guardarCodigoActual() {
    if (!ejercicioActual) return;
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
    return (s || "").replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
  }

  // --- Botón Ejecutar ------------------------------------------------------
  async function onRun() {
    if (ejercicioActual && (ejercicioActual.type || "code").startsWith("quiz")) {
      setOutput("En este tipo de ejercicio no hay código que ejecutar. Elige una alternativa y toca «Comprobar».", "");
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
    if (!(ej.type || "code").startsWith("quiz")) payload.code = editor.getValue();
    pushRemoto(ej.id, payload);
    renderSidebar();
    $("#btnNext").disabled = indiceActual >= ejerciciosPlanos.length - 1;

    if (eraNuevo) {
      mostrarToast("🎉 ¡Ejercicio completado!");
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
      if (ejercicioActual) {
        const code = editor.getValue();
        estado.codigo[ejercicioActual.id] = code;
        pushCodigoDebounced(ejercicioActual.id, code);
      }
    });
    editor.on("blur", () => {
      guardarProgreso();
      if (ejercicioActual) pushRemoto(ejercicioActual.id, { code: editor.getValue() });
    });

    // Sincroniza con la nube cuando cambia la sesión (login/logout).
    if (window.AuthUI) window.AuthUI.onUsuario(sincronizarConRemoto);

    // Expone el progreso para el modo prueba (saber qué módulos están completos).
    window.ProgresoApp = {
      completados: () => ({ ...estado.completados }),
    };

    // Expone el contexto del ejercicio actual para el asistente de IA.
    window.AsistenteContexto = () => {
      if (!ejercicioActual) return {};
      const enunciado = (ejercicioActual.enunciado || "").replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim();
      const esQuiz = (ejercicioActual.type || "code").startsWith("quiz");
      return {
        id: ejercicioActual.id,
        curso: cursoActual.titulo,
        titulo: ejercicioActual.titulo,
        tipo: ejercicioActual.type || "code",
        enunciado,
        codigo: esQuiz ? "" : editor.getValue(),
      };
    };

    // Permite que el tutor por voz (ConvAI) escriba código en el editor.
    // Devuelve un mensaje de estado que el agente puede leer en voz.
    window.EscribirEnEditor = (codigo) => {
      if (!codigo || !String(codigo).trim()) return "No recibí código para escribir.";
      if (ejercicioActual && (ejercicioActual.type || "code").startsWith("quiz")) {
        return "Este ejercicio es de alternativas o verdadero/falso, no tiene editor de código.";
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
    $("#btnReset").addEventListener("click", onReset);

    iniciarHeartbeat();
    precargarPython();
  }

  // Espera a que el DOM y los scripts (CodeMirror, data) estén disponibles.
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
