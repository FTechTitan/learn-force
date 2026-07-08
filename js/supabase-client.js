// ============================================================================
//  supabase-client.js — Cliente Supabase + auth + sincronización de progreso
//
//  La PUBLISHABLE KEY es pública por diseño: va en el frontend y está protegida
//  por Row Level Security (cada usuario solo accede a sus propias filas). NO es
//  un secreto — no confundir con la service_role/secret key, que jamás va acá.
// ============================================================================

const SUPABASE_URL = "https://bipsvhxsvfzfwzufucfg.supabase.co";
const SUPABASE_PUBLISHABLE_KEY = "sb_publishable_nsfpKRfcdisP31bYOAumeg_DimCZ5tC";

// `supabase` es el global que expone el UMD de @supabase/supabase-js (CDN).
const sb = window.supabase.createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, {
  auth: { persistSession: true, autoRefreshToken: true },
});

// ---------------------------------------------------------------------------
//  Auth
// ---------------------------------------------------------------------------
const Auth = {
  cliente: sb,
  redirectUrl: "https://learn.techforce.cl",

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

  async entrarConGoogle() {
    const { data, error } = await sb.auth.signInWithOAuth({
      provider: "google",
      options: {
        redirectTo: Auth.redirectUrl,
        skipBrowserRedirect: true,
      },
    });
    if (error) throw error;
    if (data?.url) window.location.assign(data.url);
    else throw new Error("Google no devolvió una URL de inicio de sesión.");
    return data;
  },

  async salir() {
    await sb.auth.signOut();
  },

  // Notifica cambios de sesión (login / logout / refresh).
  onCambio(callback) {
    sb.auth.onAuthStateChange((_event, session) => callback(session?.user || null));
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
    const fila = { user_id: userId, exercise_id: exerciseId };
    if (completed !== undefined) fila.completed = completed;
    if (code !== undefined) fila.code = code;
    const { error } = await sb.from("progress").upsert(fila, { onConflict: "user_id,exercise_id" });
    if (error) throw error;
  },

  // Suma segundos de tiempo activo al ejercicio (vía RPC; el server usa auth.uid()).
  async sumarTiempo(exerciseId, segundos) {
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
//  Cursos remotos configurables desde Supabase
// ---------------------------------------------------------------------------
function normalizarCurso(row) {
  const modules = (row.course_modules || [])
    .slice()
    .sort((a, b) => (a.sort_order || 0) - (b.sort_order || 0))
    .map((m) => ({
      id: m.id,
      titulo: m.title,
      emoji: m.emoji || "📦",
      intro: m.intro || "",
      teoria: m.theory || "",
      media: m.media || null,
      ejercicios: (m.course_items || [])
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
        sort_order,
        course_modules (
          id,
          title,
          emoji,
          intro,
          theory,
          media,
          sort_order,
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
            sort_order
          )
        )
      `)
      .order("sort_order", { ascending: true })
      .order("sort_order", { referencedTable: "course_modules", ascending: true })
      .order("sort_order", { referencedTable: "course_modules.course_items", ascending: true });
    if (error) throw error;
    return (data || []).map(normalizarCurso);
  },
};

window.Auth = Auth;
window.ProgresoRemoto = ProgresoRemoto;
window.PushSubscriptions = PushSubscriptions;
window.CursosRemotos = CursosRemotos;
