// ============================================================================
//  supabase-client.js — Cliente Supabase + auth + sincronización de progreso
//
//  La PUBLISHABLE KEY es pública por diseño: va en el frontend y está protegida
//  por Row Level Security (cada usuario solo accede a sus propias filas). NO es
//  un secreto — no confundir con la service_role/secret key, que jamás va acá.
// ============================================================================

const SUPABASE_URL = "https://bipsvhxsvfzfwzufucfg.supabase.co";
const SUPABASE_PUBLISHABLE_KEY = "sb_publishable_nsfpKRfcdisP31bYOAumeg_DimCZ5tC";
const AUTH_REDIRECT_STORAGE_KEY = "techforce-learn-post-login-url";
const CANONICAL_URL = "https://learn.techforce.cl";

// `supabase` es el global que expone el UMD de @supabase/supabase-js (CDN).
const sb = window.supabase.createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, {
  auth: { persistSession: true, autoRefreshToken: true },
});

// ---------------------------------------------------------------------------
//  Auth
// ---------------------------------------------------------------------------
const Auth = {
  cliente: sb,

  redirectUrl() {
    const url = new URL(window.location.href);
    const canonical = new URL(CANONICAL_URL);
    url.protocol = canonical.protocol;
    url.host = canonical.host;
    return url.toString();
  },

  async usuarioActual() {
    const { data } = await sb.auth.getUser();
    return data?.user || null;
  },

  async registrar(email, password) {
    const { data, error } = await sb.auth.signUp({ email, password });
    if (error) throw error;
    // Con auto-confirm activado, signUp ya deja sesión iniciada.
    return data.user;
  },

  async entrar(email, password) {
    const { data, error } = await sb.auth.signInWithPassword({ email, password });
    if (error) throw error;
    return data.user;
  },

  entrarConGoogle() {
    const redirectTo = Auth.redirectUrl();
    localStorage.setItem(AUTH_REDIRECT_STORAGE_KEY, redirectTo);
    const authUrl = new URL(`${SUPABASE_URL}/auth/v1/authorize`);
    authUrl.searchParams.set("provider", "google");
    authUrl.searchParams.set("redirect_to", redirectTo);
    window.location.href = authUrl.toString();
  },

  async salir() {
    await sb.auth.signOut();
  },

  // Notifica cambios de sesión (login / logout).
  //
  // Supabase reemite eventos (TOKEN_REFRESHED, y a veces SIGNED_IN) cada vez que
  // la pestaña vuelve a ser visible: al minimizar y restaurar Chrome, al volver
  // de otra ventana, o cuando el token se renueva solo. Propagar esos avisos
  // hacía que la app se repintara entera y el video embebido volviera a cero,
  // así que solo se avisa cuando el usuario realmente cambió.
  onCambio(callback) {
    let ultimoUserId; // undefined = todavía no se emitió nada

    sb.auth.onAuthStateChange((event, session) => {
      if (event === "SIGNED_IN" && session?.user) {
        const pending = localStorage.getItem(AUTH_REDIRECT_STORAGE_KEY);
        if (pending) {
          localStorage.removeItem(AUTH_REDIRECT_STORAGE_KEY);
          try {
            const target = new URL(pending);
            if (target.origin === CANONICAL_URL && target.href !== window.location.href) {
              window.location.replace(target.href);
              return;
            }
          } catch (_) {
            // Si algo guardado no era URL válida, se ignora.
          }
        }
      }

      const user = session?.user || null;
      const userId = user ? user.id : null;
      if (ultimoUserId !== undefined && ultimoUserId === userId) return;
      ultimoUserId = userId;
      callback(user);
    });
  },
};

// ---------------------------------------------------------------------------
//  Progreso remoto (tabla public.progress)
// ---------------------------------------------------------------------------
const ProgresoRemoto = {
  // Trae todo el progreso del usuario logueado.
  // Devuelve { completados: {id:true}, codigo: {id:"..."} }.
  async cargar() {
    const { data, error } = await sb.from("progress").select("exercise_id, completed, code");
    if (error) throw error;
    const completados = {};
    const codigo = {};
    (data || []).forEach((row) => {
      if (row.completed) completados[row.exercise_id] = true;
      if (row.code != null) codigo[row.exercise_id] = row.code;
    });
    return { completados, codigo };
  },

  // Guarda (upsert) una fila de progreso de un ejercicio.
  async guardar(userId, exerciseId, { completed, code }) {
    if (Impersonacion.activa()) return; // solo lectura mientras se mira como alumno
    const fila = { user_id: userId, exercise_id: exerciseId };
    if (completed !== undefined) fila.completed = completed;
    if (code !== undefined) fila.code = code;
    const { error } = await sb.from("progress").upsert(fila, { onConflict: "user_id,exercise_id" });
    if (error) throw error;
  },

  // Suma segundos de tiempo activo al ejercicio (vía RPC; el server usa auth.uid()).
  async sumarTiempo(exerciseId, segundos) {
    if (Impersonacion.activa()) return; // solo lectura mientras se mira como alumno
    const { error } = await sb.rpc("add_time_spent", {
      p_exercise_id: exerciseId,
      p_seconds: Math.round(segundos),
    });
    if (error) throw error;
  },
};

// ---------------------------------------------------------------------------
//  Web Push subscriptions (PWA)
// ---------------------------------------------------------------------------
const PushSubscriptions = {
  async guardar(userId, subscription) {
    const json = subscription.toJSON();
    const fila = {
      user_id: userId,
      endpoint: json.endpoint,
      p256dh: json.keys?.p256dh,
      auth: json.keys?.auth,
      user_agent: navigator.userAgent,
    };
    const { error } = await sb
      .from("push_subscriptions")
      .upsert(fila, { onConflict: "endpoint" });
    if (error) throw error;
  },

  async enviar({ title, body, url }) {
    const { data, error } = await sb.functions.invoke("send-push", {
      body: { title, body, url },
    });
    if (error) throw error;
    return data;
  },
};

// ---------------------------------------------------------------------------
//  Impersonacion: un admin mira la app con la sesion de un alumno.
//  Guarda los tokens del admin antes de cambiar de sesion para poder volver.
//  Mientras dura, la app queda en SOLO LECTURA: no se escribe progreso,
//  tiempo, pruebas ni preguntas al tutor a nombre del alumno.
// ---------------------------------------------------------------------------
const IMPERSONACION_KEY = "lf_impersonacion";

const Impersonacion = {
  estado() {
    try { return JSON.parse(localStorage.getItem(IMPERSONACION_KEY) || "null"); } catch { return null; }
  },

  activa() { return Boolean(Impersonacion.estado()); },

  // Recibe el token_hash de un magic link generado server-side por el panel admin.
  async iniciar({ email, tokenHash }) {
    const { data } = await sb.auth.getSession();
    const sesion = data?.session;
    if (!sesion) throw new Error("No hay sesion de admin activa.");
    localStorage.setItem(IMPERSONACION_KEY, JSON.stringify({
      email,
      admin_email: sesion.user?.email || "",
      access_token: sesion.access_token,
      refresh_token: sesion.refresh_token,
    }));
    const { error } = await sb.auth.verifyOtp({ token_hash: tokenHash, type: "magiclink" });
    if (error) {
      localStorage.removeItem(IMPERSONACION_KEY);
      throw error;
    }
  },

  async volver() {
    const guardado = Impersonacion.estado();
    localStorage.removeItem(IMPERSONACION_KEY);
    if (!guardado) return;
    const { error } = await sb.auth.setSession({
      access_token: guardado.access_token,
      refresh_token: guardado.refresh_token,
    });
    if (error) throw error;
  },
};

// ---------------------------------------------------------------------------
//  Solicitud de acceso al catalogo
// ---------------------------------------------------------------------------
const AccesoCursos = {
  async estado(user) {
    if (!user) return { status: "anonymous" };
    if (user.app_metadata?.role === "admin") return { status: "approved" };
    const { data, error } = await sb
      .from("course_access_requests")
      .select("status, requested_at, reviewed_at")
      .eq("user_id", user.id)
      .maybeSingle();
    if (error) throw error;
    return data || { status: "none" };
  },

  async solicitar(user) {
    if (!user) throw new Error("Inicia sesion para solicitar acceso.");
    const { error } = await sb
      .from("course_access_requests")
      .upsert({
        user_id: user.id,
        email: user.email || null,
        status: "pending",
        note: null,
        requested_at: new Date().toISOString(),
        reviewed_at: null,
        reviewed_by: null,
      }, { onConflict: "user_id" });
    if (error) throw error;
    return AccesoCursos.estado(user);
  },
};

// ---------------------------------------------------------------------------
//  Cursos remotos configurables desde Supabase
// ---------------------------------------------------------------------------
function normalizarCurso(row) {
  const modules = (row.course_modules || [])
    .filter((m) => m.is_published !== false)
    .slice()
    .sort((a, b) => (a.sort_order || 0) - (b.sort_order || 0))
    .map((m) => ({
      id: m.id,
      titulo: m.title,
      emoji: m.emoji || "📦",
      intro: m.intro || "",
      overviewMarkdown: m.overview_markdown || "",
      teoria: m.theory || "",
      media: m.media || null,
      clases: (m.course_lessons || [])
        .filter((lesson) => lesson.is_published !== false)
        .slice()
        .sort((a, b) => (a.sort_order || 0) - (b.sort_order || 0) || a.id.localeCompare(b.id))
        .map((lesson) => ({
          id: lesson.id,
          titulo: lesson.title,
          resumen: lesson.summary || "",
          lessonKind: lesson.lesson_kind || "lesson",
          videoUrl: lesson.video_url || "",
          videoProvider: lesson.video_provider || "",
          videoDuration: lesson.video_duration || "",
          videoThumbnailUrl: lesson.video_thumbnail_url || "",
          hasTranscript: lesson.has_transcript === true,
        })),
      ejercicios: (m.course_items || [])
        .filter((it) => it.is_published !== false)
        .slice()
        .sort((a, b) => (a.sort_order || 0) - (b.sort_order || 0))
        .map((it) => ({
          id: it.id,
          type: it.type,
          titulo: it.title,
          nivel: it.level || 1,
          enunciado: it.statement_html,
          pista: it.hint || "",
          starter: it.starter || "",
          tests: it.tests || [],
          options: it.options || [],
          correctAnswer: it.correct_answer,
          explanation: it.explanation || "",
          solutionHtml: it.solution_html || "",
          steps: it.steps || [],
        })),
    }));

  return {
    id: row.id,
    titulo: row.title,
    subtitle: row.subtitle || "",
    descripcion: row.description || "",
    emoji: row.emoji || "📚",
    source: "remote",
    media: row.media || null,
    modulos: modules,
  };
}

const CursosRemotos = {
  async cargarPublicados() {
    const { data, error } = await sb
      .from("courses")
      .select(`
        id,
        title,
        subtitle,
        description,
        emoji,
        media,
        is_published,
        sort_order,
        course_modules (
          id,
          title,
          emoji,
          intro,
          overview_markdown,
          theory,
          media,
          is_published,
          sort_order,
          course_lessons!course_lessons_module_course_fk (
            id,
            title,
            summary,
            lesson_kind,
            video_url,
            video_provider,
            video_duration,
            video_thumbnail_url,
            has_transcript,
            is_published,
            sort_order
          ),
          course_items!course_items_module_course_fk (
            id,
            type,
            title,
            level,
            statement_html,
            hint,
            starter,
            tests,
            options,
            correct_answer,
            explanation,
            solution_html,
            steps,
            is_published,
            sort_order
          )
        )
      `)
      .eq("is_published", true)
      .order("sort_order", { ascending: true })
      .order("sort_order", { referencedTable: "course_modules", ascending: true })
      .order("sort_order", { referencedTable: "course_modules.course_lessons", ascending: true })
      .order("sort_order", { referencedTable: "course_modules.course_items", ascending: true });
    if (error) throw error;
    return (data || []).map(normalizarCurso);
  },
};

const LeccionesRemotas = {
  async cargarDetalle(lessonId) {
    const [contentResult, transcriptsResult, resourcesResult] = await Promise.all([
      sb
        .from("course_lesson_contents")
        .select("body_markdown")
        .eq("lesson_id", lessonId)
        .maybeSingle(),
      sb
        .from("course_lesson_transcripts")
        .select("id, language, transcript_text, storage_path, sort_order")
        .eq("lesson_id", lessonId)
        .order("sort_order", { ascending: true }),
      sb
        .from("course_lesson_resources")
        .select("id, title, kind, mime_type, storage_path, file_size, sort_order")
        .eq("lesson_id", lessonId)
        .eq("is_published", true)
        .order("sort_order", { ascending: true }),
    ]);

    if (contentResult.error) throw contentResult.error;
    if (transcriptsResult.error) throw transcriptsResult.error;
    if (resourcesResult.error) throw resourcesResult.error;

    const storagePaths = [
      ...(transcriptsResult.data || []).map((item) => item.storage_path),
      ...(resourcesResult.data || []).map((item) => item.storage_path),
    ].filter(Boolean);
    const signedUrls = new Map();
    await Promise.all(storagePaths.map(async (path) => {
      const { data, error } = await sb.storage
        .from("imperio-agentico-content")
        .createSignedUrl(path, 3600);
      if (!error && data?.signedUrl) signedUrls.set(path, data.signedUrl);
    }));

    return {
      bodyMarkdown: contentResult.data?.body_markdown || "",
      transcripts: (transcriptsResult.data || []).map((item) => ({
        id: item.id,
        language: item.language,
        text: item.transcript_text || "",
        downloadUrl: signedUrls.get(item.storage_path) || "",
      })),
      resources: (resourcesResult.data || []).map((item) => ({
        id: item.id,
        title: item.title,
        kind: item.kind,
        mimeType: item.mime_type || "",
        fileSize: item.file_size || 0,
        downloadUrl: signedUrls.get(item.storage_path) || "",
      })),
    };
  },
};

// ---------------------------------------------------------------------------
//  Claves personales para agentes
// ---------------------------------------------------------------------------
const AGENT_API_URL = `${SUPABASE_URL}/functions/v1/courses-api/v1`;
const AgentApi = {
  async request(path, { method = "GET", body } = {}) {
    const { data } = await sb.auth.getSession();
    const accessToken = data?.session?.access_token;
    if (!accessToken) throw new Error("Inicia sesión para administrar tus agentes.");
    const res = await fetch(`${AGENT_API_URL}${path}`, {
      method,
      headers: {
        "Authorization": `Bearer ${accessToken}`,
        ...(body ? { "Content-Type": "application/json" } : {}),
      },
      body: body ? JSON.stringify(body) : undefined,
    });
    if (res.status === 204) return null;
    const payload = await res.json().catch(() => ({}));
    if (!res.ok) throw new Error(payload?.error?.message || `Error API (${res.status})`);
    return payload;
  },
  listarClaves() { return AgentApi.request("/api-keys"); },
  crearClave(name, expiresAt) {
    return AgentApi.request("/api-keys", { method: "POST", body: { name, ...(expiresAt ? { expires_at: expiresAt } : {}) } });
  },
  revocarClave(id) { return AgentApi.request(`/api-keys/${encodeURIComponent(id)}`, { method: "DELETE" }); },
};

window.Auth = Auth;
window.ProgresoRemoto = ProgresoRemoto;
window.PushSubscriptions = PushSubscriptions;
window.AccesoCursos = AccesoCursos;
window.Impersonacion = Impersonacion;
window.CursosRemotos = CursosRemotos;
window.LeccionesRemotas = LeccionesRemotas;
window.AgentApi = AgentApi;
