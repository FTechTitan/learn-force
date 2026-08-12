// ============================================================================
//  admin.js — Menú de superadmin (frontend)
//  Solo se muestra si el usuario logueado tiene rol "admin" (verificado contra
//  el servidor). Toda la data viene de la Edge Function `admin`, que re-verifica
//  el rol server-side. El frontend nunca toca la service_role.
// ============================================================================

(function () {
  "use strict";

  const sb = window.Auth.cliente;
  let esAdmin = false;
  let titulosEjercicios = {}; // id -> título legible
  let modulosInfo = [];       // [{ id, titulo, emoji, ids:[...] }]
  let totalEjercicios = 0;    // total de ejercicios del curso
  let cursosCatalogo = [];    // [{ id, title, emoji, is_published, access_mode }]
  let ultimoOverview = {};    // última respuesta de la acción "overview"

  // Mapa id->título y estructura de módulos desde el curso remoto activo.
  function indexarTitulos() {
    modulosInfo = [];
    totalEjercicios = 0;
    const mods = (window.ProgresoApp && window.ProgresoApp.modulosActuales()) || [];
    mods.forEach((m) => {
      const ids = (m.ejercicios || []).map((e) => {
        titulosEjercicios[e.id] = e.titulo;
        return e.id;
      });
      totalEjercicios += ids.length;
      modulosInfo.push({ id: m.id, titulo: m.titulo, emoji: m.emoji || "📦", ids });
    });
  }

  // Cuántos módulos tiene 100% completo este alumno (todos sus ejercicios).
  function modulosCompletos(completadosIds) {
    const hechos = new Set(completadosIds || []);
    let n = 0;
    modulosInfo.forEach((m) => {
      if (m.ids.length && m.ids.every((id) => hechos.has(id))) n++;
    });
    return n;
  }

  // Formatea segundos como "Xh Ym" / "Ym" / "—".
  function fmtDuracion(seg) {
    seg = Math.round(Number(seg) || 0);
    if (seg <= 0) return '<span style="color:var(--text-dim)">—</span>';
    const h = Math.floor(seg / 3600);
    const m = Math.round((seg % 3600) / 60);
    if (h > 0) return `${h}h ${m}m`;
    if (m > 0) return `${m}m`;
    return `${seg}s`;
  }

  // Barra de % de avance (completados / total del curso).
  function avanceCell(u) {
    const hechos = (u.completados_ids || []).length || u.completados || 0;
    const pct = totalEjercicios ? Math.round((hechos / totalEjercicios) * 100) : 0;
    const color = pct >= 100 ? "var(--green)" : pct >= 50 ? "var(--accent, #4a9)" : "var(--text)";
    return `<div class="avance-cell">
      <span class="avance-track"><span class="avance-fill" style="width:${pct}%;background:${color}"></span></span>
      <span class="avance-num">${pct}% <span style="color:var(--text-dim)">(${hechos}/${totalEjercicios})</span></span>
    </div>`;
  }

  // Llama a la Edge Function admin.
  async function llamar(action, extra) {
    const { data, error } = await sb.functions.invoke("admin", {
      body: { action, ...(extra || {}) },
    });
    if (error) {
      let msg = "Error en el panel admin.";
      try { const c = await error.context?.json?.(); if (c?.error) msg = c.error; } catch (_) {}
      throw new Error(msg);
    }
    return data;
  }

  // --- Detección de rol (consulta fresca al servidor) ----------------------
  async function chequearAdmin() {
    try {
      const { data } = await sb.auth.getUser();
      const rol = data?.user?.app_metadata?.role;
      esAdmin = rol === "admin";
    } catch {
      esAdmin = false;
    }
    pintarBoton();
  }

  function pintarBoton() {
    let btn = document.getElementById("btnAdmin");
    if (esAdmin && !btn) {
      btn = document.createElement("button");
      btn.id = "btnAdmin";
      btn.className = "btn-admin";
      btn.textContent = "🛠 Admin";
      btn.addEventListener("click", abrirPanel);
      const area = document.getElementById("authArea");
      area.parentNode.insertBefore(btn, area);
    } else if (!esAdmin && btn) {
      btn.remove();
    }
  }

  // --- Render del panel ----------------------------------------------------
  function fmtFecha(iso) {
    if (!iso) return "—";
    return iso.slice(0, 10);
  }

  // Celda de nota: muestra la última, con color según aprobado, y mejor/intentos.
  function notaCell(u) {
    if (u.nota_ultima == null) return '<span class="dim" style="color:var(--text-dim)">—</span>';
    const n = Number(u.nota_ultima);
    const color = n >= 4 ? "var(--green)" : "var(--red)";
    const extra = u.intentos_prueba > 1 ? ` <span class="dim" style="color:var(--text-dim);font-size:11px">(mejor ${Number(u.nota_mejor).toFixed(1)}, ${u.intentos_prueba} int.)</span>` : "";
    return `<b style="color:${color}">${n.toFixed(1)}</b>${extra}`;
  }

  function accesoCell(u) {
    const estado = u.acceso || "none";
    const labels = {
      admin: "admin",
      approved: "aprobado",
      pending: "pendiente",
      rejected: "rechazado",
      none: "sin solicitud",
    };
    const cls = estado === "approved" || estado === "admin"
      ? "ok"
      : estado === "pending"
      ? "pending"
      : estado === "rejected"
      ? "danger"
      : "";
    return `<span class="tag-access ${cls}">${labels[estado] || estado}</span>`;
  }

  // Celda "Agente": si puede usar "Conecta a tu agente" y sus API keys.
  function agenteCell(u) {
    if (u.es_admin) return '<span class="tag-access ok">siempre</span>';
    return `<button class="btn-row" data-agente="${u.id}" data-enabled="${u.agente ? "1" : "0"}">
      <span class="tag-access ${u.agente ? "ok" : ""}">${u.agente ? "habilitado" : "no"}</span>
    </button>`;
  }

  // Cursos restringidos: los que exigen grant explícito para siquiera aparecer.
  function cursosRestringidos() {
    return cursosCatalogo.filter((c) => c.access_mode !== "open");
  }

  // Celda "Cursos": cuántos cursos restringidos tiene habilitados este alumno.
  function cursosCell(u) {
    if (u.es_admin) return '<span class="tag-access ok">todos</span>';
    const restringidos = cursosRestringidos();
    const habilitados = (u.cursos || []).filter((id) => restringidos.some((c) => c.id === id));
    const cls = habilitados.length ? "ok" : "";
    return `<button class="btn-row grants-cell" data-cursos="${u.id}" data-email="${escapar(u.email || "")}" title="Elegir a qué cursos accede">
      <span class="tag-access ${cls}">${habilitados.length}/${restringidos.length}</span> Editar
    </button>`;
  }

  // --- Alta de alumno en un paso -------------------------------------------
  function abrirModalNuevoAlumno() {
    const filas = cursosRestringidos().map((c) => `
      <label class="grant-row">
        <input type="checkbox" value="${escapar(c.id)}">
        <span>${escapar(c.emoji || "📚")} ${escapar(c.title)}</span>
        <span class="grant-meta">${c.is_published ? "" : "borrador · "}${escapar(c.id)}</span>
      </label>`).join("");

    const ov = document.createElement("div");
    ov.className = "grants-overlay";
    ov.innerHTML = `
      <div class="grants-modal">
        <h3>Nuevo alumno</h3>
        <p class="grant-note">Crea la cuenta y le habilita los cursos marcados. El alumno entra en learn.techforce.cl con <b>Continuar con Google</b> usando ese mismo email — sin contraseña y sin aprobar nada.</p>
        <label class="grant-field">
          <span>Email</span>
          <input type="email" data-nuevo-email placeholder="alumno@mail.com" autocomplete="off">
        </label>
        <div class="grants-list">${filas || '<p class="admin-loading">No hay cursos restringidos.</p>'}</div>
        <div class="grants-actions">
          <button class="btn-row" data-nuevo-all>Todos los cursos</button>
          <span style="flex:1"></span>
          <button class="btn-row" data-nuevo-cancel>Cancelar</button>
          <button class="btn btn-primary btn-sm" data-nuevo-save>Crear alumno</button>
        </div>
      </div>`;
    document.body.appendChild(ov);

    const checks = () => [...ov.querySelectorAll(".grants-list input[type=checkbox]")];
    const cerrar = () => ov.remove();
    ov.querySelector("[data-nuevo-all]").addEventListener("click", () => checks().forEach((c) => { c.checked = true; }));
    ov.querySelector("[data-nuevo-cancel]").addEventListener("click", cerrar);
    ov.addEventListener("click", (ev) => { if (ev.target === ov) cerrar(); });
    ov.querySelector("[data-nuevo-email]").focus();

    ov.querySelector("[data-nuevo-save]").addEventListener("click", async () => {
      const email = ov.querySelector("[data-nuevo-email]").value.trim();
      if (!email) { alert("Falta el email."); return; }
      const boton = ov.querySelector("[data-nuevo-save]");
      boton.disabled = true;
      boton.textContent = "Creando…";
      try {
        await llamar("create_student", {
          email,
          course_ids: checks().filter((c) => c.checked).map((c) => c.value),
        });
        cerrar();
        cargarOverview();
      } catch (e) {
        alert(e.message);
        boton.disabled = false;
        boton.textContent = "Crear alumno";
      }
    });
  }

  // --- Modal de cursos habilitados por alumno ------------------------------
  function abrirModalCursos(userId, email) {
    const usuario = (ultimoOverview.usuarios || []).find((u) => u.id === userId);
    const habilitados = new Set(usuario?.cursos || []);
    const abiertos = cursosCatalogo.filter((c) => c.access_mode === "open");

    const filas = cursosRestringidos().map((c) => `
      <label class="grant-row">
        <input type="checkbox" value="${escapar(c.id)}" ${habilitados.has(c.id) ? "checked" : ""}>
        <span>${escapar(c.emoji || "📚")} ${escapar(c.title)}</span>
        <span class="grant-meta">${c.is_published ? "" : "borrador · "}${escapar(c.id)}</span>
      </label>`).join("");

    const nota = abiertos.length
      ? `<p class="grant-note">Además ve ${abiertos.length} curso(s) abierto(s) a cualquier usuario con sesión: ${
          abiertos.map((c) => escapar(c.title)).join(", ")}.</p>`
      : "";

    const ov = document.createElement("div");
    ov.className = "grants-overlay";
    ov.innerHTML = `
      <div class="grants-modal">
        <h3>Cursos habilitados</h3>
        <p class="grant-note">${escapar(email || "alumno")} solo verá los cursos marcados. El resto no aparece en su catálogo.</p>
        <div class="grants-list">${filas || '<p class="admin-loading">No hay cursos restringidos.</p>'}</div>
        ${nota}
        <div class="grants-actions">
          <button class="btn-row" data-grants-none>Ninguno</button>
          <button class="btn-row" data-grants-all>Todos</button>
          <span style="flex:1"></span>
          <button class="btn-row" data-grants-cancel>Cancelar</button>
          <button class="btn btn-primary btn-sm" data-grants-save>Guardar</button>
        </div>
      </div>`;
    document.body.appendChild(ov);

    const checks = () => [...ov.querySelectorAll(".grants-list input[type=checkbox]")];
    ov.querySelector("[data-grants-all]").addEventListener("click", () => checks().forEach((c) => { c.checked = true; }));
    ov.querySelector("[data-grants-none]").addEventListener("click", () => checks().forEach((c) => { c.checked = false; }));
    ov.querySelector("[data-grants-cancel]").addEventListener("click", () => ov.remove());
    ov.addEventListener("click", (ev) => { if (ev.target === ov) ov.remove(); });
    ov.querySelector("[data-grants-save]").addEventListener("click", async () => {
      const boton = ov.querySelector("[data-grants-save]");
      boton.disabled = true;
      boton.textContent = "Guardando…";
      try {
        await llamar("set_course_grants", {
          user_id: userId,
          course_ids: checks().filter((c) => c.checked).map((c) => c.value),
        });
        ov.remove();
        cargarOverview();
      } catch (e) {
        alert(e.message);
        boton.disabled = false;
        boton.textContent = "Guardar";
      }
    });
  }

  function abrirPanel() {
    let ov = document.getElementById("adminOverlay");
    if (!ov) {
      ov = document.createElement("div");
      ov.id = "adminOverlay";
      ov.className = "admin-overlay";
      ov.innerHTML = `
        <div class="admin-top">
          <h2>🛠 Panel de superadmin</h2>
          <div>
            <button class="btn-row" id="adminRefresh">↻ Actualizar</button>
            <button class="btn-row" id="adminCourses">Cursos</button>
            <button class="btn btn-ghost btn-sm" id="adminCerrar">✕ Cerrar</button>
          </div>
        </div>
        <div class="admin-body" id="adminBody">
          <div class="admin-loading">Cargando…</div>
        </div>`;
      document.body.appendChild(ov);
      document.getElementById("adminCerrar").addEventListener("click", () => ov.remove());
      document.getElementById("adminRefresh").addEventListener("click", cargarOverview);
      document.getElementById("adminCourses").addEventListener("click", cargarCursosAdmin);
    }
    cargarOverview();
  }

  async function cargarCursosAdmin() {
    const body = document.getElementById("adminBody");
    body.innerHTML = '<div class="admin-loading">Cargando cursos…</div>';
    let data;
    try {
      data = await llamar("course_catalog");
    } catch (e) {
      body.innerHTML = `<div class="admin-loading">⚠️ ${e.message}<br><br>Si acabas de agregar esta feature, primero aplica la migración de cursos configurables.</div>`;
      return;
    }

    const courses = data.courses || [];
    const alumnosPorCurso = data.alumnos_por_curso || {};
    cursosCatalogo = courses.map((c) => ({
      id: c.id, title: c.title, emoji: c.emoji, is_published: c.is_published, access_mode: c.access_mode,
    }));
    const rows = courses.map((c) => {
      const mods = c.course_modules || [];
      const items = mods.flatMap((m) => m.course_items || []);
      const abierto = c.access_mode === "open";
      return `<tr>
        <td>${escapar(c.emoji || "📚")} ${escapar(c.title)}<br><span style="color:var(--text-dim);font-size:12px">${escapar(c.id)}</span></td>
        <td>${mods.length}</td>
        <td>${items.length}</td>
        <td>${c.is_published ? "Publicado" : "Borrador"}</td>
        <td>
          <select class="grant-mode" data-access-mode="${escapar(c.id)}">
            <option value="restricted" ${abierto ? "" : "selected"}>Restringido</option>
            <option value="open" ${abierto ? "selected" : ""}>Abierto</option>
          </select>
          <div style="color:var(--text-dim);font-size:12px;margin-top:3px">
            ${abierto ? "Todos los usuarios con sesión" : `${alumnosPorCurso[c.id] || 0} alumno(s) habilitado(s)`}
          </div>
        </td>
        <td class="acciones"><button class="btn-row danger" data-del-course="${escapar(c.id)}">Borrar</button></td>
      </tr>`;
    }).join("");

    body.innerHTML = `
      <div class="admin-section-title">Cursos configurables</div>
      <p style="color:var(--text-dim);font-size:13px;margin:0 0 10px">
        <b>Restringido</b>: solo lo ven los alumnos habilitados uno por uno; para el resto el curso no existe.
        <b>Abierto</b>: visible para cualquier usuario con sesión iniciada.
      </p>
      <table class="admin-table">
        <thead><tr><th>Curso</th><th>Módulos</th><th>Preguntas</th><th>Estado</th><th>Acceso</th><th>Acciones</th></tr></thead>
        <tbody>${rows || '<tr><td colspan="6" class="admin-loading">Sin cursos en Supabase.</td></tr>'}</tbody>
      </table>

      <div class="admin-detail">
        <h3 style="margin-top:0">Guardar curso</h3>
        <textarea id="courseJson" class="admin-json"></textarea>
        <button class="btn btn-primary btn-sm" id="saveCourseJson">Guardar curso</button>
      </div>

      <div class="admin-detail">
        <h3 style="margin-top:0">Guardar módulo</h3>
        <textarea id="moduleJson" class="admin-json"></textarea>
        <button class="btn btn-primary btn-sm" id="saveModuleJson">Guardar módulo</button>
      </div>

      <div class="admin-detail">
        <h3 style="margin-top:0">Guardar pregunta</h3>
        <textarea id="itemJson" class="admin-json"></textarea>
        <button class="btn btn-primary btn-sm" id="saveItemJson">Guardar pregunta</button>
      </div>`;

    document.getElementById("courseJson").value = JSON.stringify({
      id: "nuevo-curso",
      title: "Nuevo curso",
      subtitle: "Subtítulo",
      description: "Descripción del curso",
      emoji: "📚",
      sort_order: 30,
      is_published: false,
      access_mode: "restricted",
    }, null, 2);
    document.getElementById("moduleJson").value = JSON.stringify({
      id: "nuevo-modulo",
      course_id: "nuevo-curso",
      title: "Nuevo módulo",
      emoji: "📦",
      intro: "Introducción corta",
      theory: "<p>Teoría en HTML.</p>",
      sort_order: 10,
      is_published: true,
    }, null, 2);
    document.getElementById("itemJson").value = JSON.stringify({
      id: "pregunta-01",
      course_id: "nuevo-curso",
      module_id: "nuevo-modulo",
      type: "guided_steps",
      title: "Pregunta paso a paso",
      level: 1,
      statement_html: "<p>Enunciado de la pregunta.</p>",
      hint: "Pista corta",
      steps: [
        {
          kind: "numeric",
          title: "Primer calculo",
          prompt: "Ingresa el resultado.",
          answer: 0.5,
          tolerance: 0.01,
          hint: "Puedes usar coma o punto decimal.",
          explanation: "Explicación del paso.",
        },
      ],
      sort_order: 10,
      is_published: true,
    }, null, 2);

    document.getElementById("saveCourseJson").addEventListener("click", () => guardarEntidadJson("save_course", "course", "courseJson"));
    document.getElementById("saveModuleJson").addEventListener("click", () => guardarEntidadJson("save_module", "module", "moduleJson"));
    document.getElementById("saveItemJson").addEventListener("click", () => guardarEntidadJson("save_item", "item", "itemJson"));
    body.querySelectorAll("[data-del-course]").forEach((b) =>
      b.addEventListener("click", () => borrarEntidadCurso("courses", b.getAttribute("data-del-course"))));
    body.querySelectorAll("[data-access-mode]").forEach((select) =>
      select.addEventListener("change", () => cambiarModoAcceso(select.getAttribute("data-access-mode"), select.value)));
  }

  async function cambiarModoAcceso(courseId, accessMode) {
    const aviso = accessMode === "open"
      ? `El curso ${courseId} pasará a ser visible para CUALQUIER usuario con sesión. ¿Continuar?`
      : `El curso ${courseId} quedará restringido: solo lo verán los alumnos habilitados. ¿Continuar?`;
    if (!confirm(aviso)) {
      cargarCursosAdmin();
      return;
    }
    try {
      await llamar("set_course_access_mode", { course_id: courseId, access_mode: accessMode });
      cargarCursosAdmin();
    } catch (e) {
      alert(e.message);
      cargarCursosAdmin();
    }
  }

  async function guardarEntidadJson(action, key, textareaId) {
    let payload;
    try {
      payload = JSON.parse(document.getElementById(textareaId).value);
    } catch {
      alert("JSON inválido.");
      return;
    }
    try {
      await llamar(action, { [key]: payload });
      alert("Guardado.");
      cargarCursosAdmin();
    } catch (e) {
      alert(e.message);
    }
  }

  async function borrarEntidadCurso(table, id) {
    if (!confirm(`¿Borrar ${id}?`)) return;
    try {
      await llamar("delete_course_entity", { table, id });
      cargarCursosAdmin();
    } catch (e) {
      alert(e.message);
    }
  }

  async function cargarOverview() {
    const body = document.getElementById("adminBody");
    body.innerHTML = '<div class="admin-loading">Cargando datos…</div>';
    let data;
    try {
      data = await llamar("overview");
    } catch (e) {
      body.innerHTML = `<div class="admin-loading">⚠️ ${e.message}</div>`;
      return;
    }

    ultimoOverview = data;
    cursosCatalogo = data.cursos || [];
    const t = data.totales || {};
    const usuarios = data.usuarios || [];
    const porEj = data.por_ejercicio || {};
    const maxEj = Math.max(1, ...Object.values(porEj));

    // Barras por ejercicio (ordenadas por cantidad desc).
    const barras = Object.entries(porEj)
      .sort((a, b) => b[1] - a[1])
      .map(([id, n]) => `
        <div class="ex-bar-row">
          <span>${titulosEjercicios[id] || id}</span>
          <span class="ex-bar-track"><span class="ex-bar-fill" style="width:${(n / maxEj) * 100}%"></span></span>
          <span>${n}</span>
        </div>`).join("") || '<p class="admin-loading">Nadie completó ejercicios todavía.</p>';

    // Filas de usuarios (ordenadas por % de avance desc).
    const filas = usuarios
      .sort((a, b) => ((b.completados_ids || []).length || b.completados || 0) - ((a.completados_ids || []).length || a.completados || 0))
      .map((u) => `
        <tr>
          <td>${u.email || "—"} ${u.es_admin ? '<span class="tag-admin">admin</span>' : ""}</td>
          <td>${accesoCell(u)}</td>
          <td>${cursosCell(u)}</td>
          <td>${agenteCell(u)}</td>
          <td>${avanceCell(u)}</td>
          <td>${modulosCompletos(u.completados_ids)}/${modulosInfo.length}</td>
          <td>${fmtDuracion(u.segundos)}</td>
          <td>${u.preguntas || 0}</td>
          <td>${notaCell(u)}</td>
          <td>${fmtFecha(u.ultima_actividad)}</td>
          <td class="acciones">
            ${u.es_admin ? "" : `
              <button class="btn-row" data-access="approved" data-user="${u.id}">Aprobar</button>
              <button class="btn-row" data-access="rejected" data-user="${u.id}">Rechazar</button>
              <button class="btn-row danger" data-access="pending" data-user="${u.id}">Revocar</button>
            `}
            ${u.es_admin ? "" : `<button class="btn-row" data-comover="${u.id}" data-email="${escapar(u.email || "")}">Ver como</button>`}
            <button class="btn-row" data-ver="${u.id}">Ver</button>
            <button class="btn-row danger" data-reset="${u.id}" data-email="${u.email}">Reset</button>
            <button class="btn-row danger" data-del="${u.id}" data-email="${u.email}">Borrar</button>
          </td>
        </tr>`).join("");

    // Avance promedio del curso entre los alumnos (no admins).
    const alumnosReales = usuarios.filter((u) => !u.es_admin);
    const avancePromedio = alumnosReales.length && totalEjercicios
      ? Math.round(
          (alumnosReales.reduce((a, u) => a + ((u.completados_ids || []).length || u.completados || 0), 0) /
            (alumnosReales.length * totalEjercicios)) * 100
        )
      : 0;
    const segundosTotales = usuarios.reduce((a, u) => a + (u.segundos || 0), 0);

    body.innerHTML = `
      <div class="admin-cards">
        <div class="admin-card"><div class="num">${t.alumnos ?? 0}</div><div class="lbl">Alumnos registrados</div></div>
        <div class="admin-card"><div class="num">${t.solicitudes_pendientes ?? 0}</div><div class="lbl">Solicitudes pendientes</div></div>
        <div class="admin-card"><div class="num">${avancePromedio}%</div><div class="lbl">Avance promedio del curso 📈</div></div>
        <div class="admin-card"><div class="num">${fmtDuracion(segundosTotales)}</div><div class="lbl">Tiempo total dedicado ⏱</div></div>
        <div class="admin-card"><div class="num">${t.preguntas ?? 0}</div><div class="lbl">Preguntas al tutor 🤖</div></div>
        <div class="admin-card"><div class="num">${t.promedio_notas != null ? t.promedio_notas.toFixed(1) : "—"}</div><div class="lbl">Nota predicha promedio 📝</div></div>
      </div>

      <div class="admin-section-title">Completados por ejercicio</div>
      <div class="ex-bars">${barras}</div>

      <div class="admin-section-title admin-title-row">
        <span>Alumnos</span>
        <button class="btn btn-primary btn-sm" id="btnNuevoAlumno">+ Nuevo alumno</button>
      </div>
      <table class="admin-table">
        <thead><tr><th>Email</th><th>Acceso</th><th>Cursos</th><th>Agente 🤖</th><th>Avance</th><th>Módulos</th><th>Tiempo ⏱</th><th>Preguntas 🤖</th><th>Nota predicha 📝</th><th>Última actividad</th><th>Acciones</th></tr></thead>
        <tbody>${filas || '<tr><td colspan="11" class="admin-loading">Sin alumnos.</td></tr>'}</tbody>
      </table>

      <div id="adminDetalle"></div>`;

    // Listeners de las acciones.
    body.querySelectorAll("[data-ver]").forEach((b) =>
      b.addEventListener("click", () => verDetalle(b.getAttribute("data-ver"))));
    body.querySelectorAll("[data-reset]").forEach((b) =>
      b.addEventListener("click", () => resetUsuario(b.getAttribute("data-reset"), b.getAttribute("data-email"))));
    body.querySelectorAll("[data-del]").forEach((b) =>
      b.addEventListener("click", () => borrarUsuario(b.getAttribute("data-del"), b.getAttribute("data-email"))));
    body.querySelectorAll("[data-access]").forEach((b) =>
      b.addEventListener("click", () => cambiarAcceso(b.getAttribute("data-user"), b.getAttribute("data-access"))));
    body.querySelectorAll("[data-cursos]").forEach((b) =>
      b.addEventListener("click", () => abrirModalCursos(b.getAttribute("data-cursos"), b.getAttribute("data-email"))));
    document.getElementById("btnNuevoAlumno").addEventListener("click", abrirModalNuevoAlumno);
    body.querySelectorAll("[data-comover]").forEach((b) =>
      b.addEventListener("click", () => verComoAlumno(b.getAttribute("data-comover"), b.getAttribute("data-email"))));
    body.querySelectorAll("[data-agente]").forEach((b) =>
      b.addEventListener("click", () => cambiarAccesoAgente(b.getAttribute("data-agente"), b.getAttribute("data-enabled") !== "1")));
  }

  async function cambiarAccesoAgente(userId, habilitar) {
    const aviso = habilitar
      ? "¿Habilitar 'Conecta a tu agente' para este alumno? Va a poder crear claves de API y consultar el contenido de sus cursos desde un agente."
      : "¿Deshabilitar 'Conecta a tu agente'? Las claves que ya tenga dejan de funcionar en el acto.";
    if (!confirm(aviso)) return;
    try {
      await llamar("set_agent_access", { user_id: userId, enabled: habilitar });
      cargarOverview();
    } catch (e) { alert(e.message); }
  }

  // --- Ver la app como un alumno -------------------------------------------
  async function verComoAlumno(userId, email) {
    if (!confirm(`Vas a ver la app como ${email}.\n\nQueda en solo lectura: no se guarda progreso, tiempo, pruebas ni preguntas al tutor a su nombre. Volvés con la barra de abajo.`)) return;
    try {
      const alta = await llamar("impersonate", { user_id: userId });
      await window.Impersonacion.iniciar({ email: alta.email, tokenHash: alta.token_hash });
      location.href = location.pathname; // recarga limpia, sin hash de otro curso
    } catch (e) {
      alert(e.message || "No se pudo iniciar la vista como alumno.");
    }
  }

  // Barra fija mientras dura la impersonación. Se pinta siempre que haya estado
  // guardado, aunque la sesión activa ya no sea admin.
  function pintarBarraImpersonacion() {
    const estado = window.Impersonacion && window.Impersonacion.estado();
    const previa = document.getElementById("impersonationBar");
    if (!estado) { if (previa) previa.remove(); return; }
    if (previa) return;

    const barra = document.createElement("div");
    barra.id = "impersonationBar";
    barra.className = "impersonation-bar";
    barra.innerHTML = `
      <span class="imp-dot"></span>
      <span>Viendo como <b>${escapar(estado.email)}</b> · solo lectura</span>
      <button class="btn-row" id="impersonationBack">Volver a superadmin</button>`;
    document.body.appendChild(barra);
    document.getElementById("impersonationBack").addEventListener("click", async (ev) => {
      ev.target.disabled = true;
      ev.target.textContent = "Volviendo…";
      try {
        await window.Impersonacion.volver();
        location.href = location.pathname;
      } catch (e) {
        alert("No se pudo restaurar tu sesión: " + (e.message || e) + "\nIniciá sesión de nuevo como admin.");
        ev.target.disabled = false;
        ev.target.textContent = "Volver a superadmin";
      }
    });
  }

  function escapar(s) {
    return (s || "").replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
  }

  async function verDetalle(userId) {
    const cont = document.getElementById("adminDetalle");
    cont.innerHTML = '<div class="admin-detail admin-loading">Cargando detalle…</div>';
    let data;
    try {
      data = await llamar("user_detail", { user_id: userId });
    } catch (e) {
      cont.innerHTML = `<div class="admin-detail admin-loading">⚠️ ${e.message}</div>`;
      return;
    }
    const prog = data.progreso || [];
    const preguntas = data.preguntas || [];
    const examenes = data.examenes || [];

    // Mapas auxiliares: tiempo y completado por ejercicio.
    const tiempoPorEj = {};
    const completadoPorEj = {};
    prog.forEach((r) => {
      tiempoPorEj[r.exercise_id] = r.time_spent_seconds || 0;
      completadoPorEj[r.exercise_id] = !!r.completed;
    });
    const completadosIds = prog.filter((r) => r.completed).map((r) => r.exercise_id);
    const tiempoTotal = prog.reduce((a, r) => a + (r.time_spent_seconds || 0), 0);
    const pctAvance = totalEjercicios ? Math.round((completadosIds.length / totalEjercicios) * 100) : 0;

    // Resumen arriba del todo.
    const resumenHtml = `
      <div class="admin-cards" style="margin-bottom:14px">
        <div class="admin-card"><div class="num">${pctAvance}%</div><div class="lbl">Avance (${completadosIds.length}/${totalEjercicios})</div></div>
        <div class="admin-card"><div class="num">${modulosCompletos(completadosIds)}/${modulosInfo.length}</div><div class="lbl">Módulos completos</div></div>
        <div class="admin-card"><div class="num">${fmtDuracion(tiempoTotal)}</div><div class="lbl">Tiempo dedicado ⏱</div></div>
      </div>`;

    // Desglose por módulo: hechos/total y tiempo del módulo.
    const modulosHtml = modulosInfo.map((m) => {
      const hechos = m.ids.filter((id) => completadoPorEj[id]).length;
      const seg = m.ids.reduce((a, id) => a + (tiempoPorEj[id] || 0), 0);
      const pct = m.ids.length ? Math.round((hechos / m.ids.length) * 100) : 0;
      const color = pct >= 100 ? "var(--green)" : pct >= 50 ? "var(--accent, #4a9)" : "var(--text)";
      return `<div class="ex-bar-row">
        <span>${m.emoji} ${m.titulo}</span>
        <span class="ex-bar-track"><span class="ex-bar-fill" style="width:${pct}%;background:${color}"></span></span>
        <span>${hechos}/${m.ids.length} · ${fmtDuracion(seg)}</span>
      </div>`;
    }).join("");

    const items = prog.map((r) => `
      <details class="detail-ex">
        <summary>${r.completed ? "✅" : "⏳"} ${titulosEjercicios[r.exercise_id] || r.exercise_id}
          <span class="dim" style="margin-left:auto;color:var(--text-dim)">⏱ ${fmtDuracion(r.time_spent_seconds)} · ${fmtFecha(r.updated_at)}</span></summary>
        <pre>${escapar(r.code) || "(sin código)"}</pre>
      </details>`).join("") || '<p class="admin-loading">Este alumno todavía no tiene progreso.</p>';

    const preguntasHtml = preguntas.map((q) => `
      <details class="detail-ex">
        <summary>❓ ${escapar(q.question).slice(0, 90)}${q.question.length > 90 ? "…" : ""}
          <span class="dim" style="margin-left:auto;color:var(--text-dim)">${q.exercise_id ? (titulosEjercicios[q.exercise_id] || q.exercise_id) + " · " : ""}${fmtFecha(q.created_at)}</span></summary>
        <pre style="white-space:pre-wrap"><b>Pregunta:</b> ${escapar(q.question)}\n\n<b>Respuesta del tutor:</b> ${escapar(q.answer) || "—"}</pre>
      </details>`).join("") || '<p class="admin-loading">Este alumno no le hizo preguntas al tutor.</p>';

    const examenesHtml = examenes.map((e) => {
      const n = Number(e.nota);
      const color = n >= 4 ? "var(--green)" : "var(--red)";
      const det = (e.detalle || []).map((d) =>
        `${d.tema}: ${d.ganados}/${d.puntos} (${d.casos})`).join(" · ");
      return `<details class="detail-ex">
        <summary>📝 ${e.exam_id} v${e.version} — <b style="color:${color}">nota ${n.toFixed(1)}</b>
          <span class="dim" style="margin-left:auto;color:var(--text-dim)">logro ${Number(e.logro).toFixed(0)}% · ${fmtFecha(e.created_at)}</span></summary>
        <pre style="white-space:pre-wrap">${escapar(det) || "(sin detalle)"}</pre>
      </details>`;
    }).join("") || '<p class="admin-loading">Todavía no rindió ninguna prueba.</p>';

    cont.innerHTML = `<div class="admin-detail">
      ${resumenHtml}
      <div class="admin-section-title" style="margin-top:0">Avance por módulo</div>
      <div class="ex-bars">${modulosHtml}</div>
      <div class="admin-section-title">Pruebas rendidas 📝 (${examenes.length})</div>
      ${examenesHtml}
      <div class="admin-section-title">Progreso y código</div>
      ${items}
      <div class="admin-section-title">Preguntas al tutor 🤖 (${preguntas.length})</div>
      ${preguntasHtml}
    </div>`;
    cont.scrollIntoView({ behavior: "smooth", block: "start" });
  }

  async function resetUsuario(userId, email) {
    if (!confirm(`¿Borrar TODO el progreso de ${email}? El usuario sigue existiendo pero empieza de cero.`)) return;
    try {
      await llamar("reset_user", { user_id: userId });
      cargarOverview();
    } catch (e) { alert(e.message); }
  }

  async function borrarUsuario(userId, email) {
    if (!confirm(`¿Eliminar la cuenta de ${email} por completo? Esta acción no se puede deshacer.`)) return;
    try {
      await llamar("delete_user", { user_id: userId });
      cargarOverview();
    } catch (e) { alert(e.message); }
  }

  async function cambiarAcceso(userId, status) {
    const texto = status === "approved" ? "aprobar" : status === "rejected" ? "rechazar" : "revocar";
    if (!confirm(`¿${texto} el acceso de este usuario?`)) return;
    try {
      await llamar("set_access_status", { user_id: userId, status });
      cargarOverview();
    } catch (e) { alert(e.message); }
  }

  // --- Init ----------------------------------------------------------------
  function init() {
    indexarTitulos();
    pintarBarraImpersonacion();
    chequearAdmin();
    if (window.AuthUI) window.AuthUI.onUsuario(() => chequearAdmin());
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
