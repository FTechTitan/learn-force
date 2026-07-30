// ============================================================================
//  admin — Panel de superadmin (acceso total, server-side)
//  Usa la service_role (inyectada por Supabase, jamás llega al frontend) para
//  leer todo, PERO primero verifica que quien llama sea admin
//  (app_metadata.role === "admin"). Un alumno normal recibe 403.
// ============================================================================

import { createClient } from "https://esm.sh/@supabase/supabase-js@2.45.4";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const ANON_KEY = Deno.env.get("SUPABASE_ANON_KEY")!;
const SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

const ALLOWED_ORIGINS = [
  "https://learn.techforce.cl",
  "https://progra-uai.pages.dev",
  "http://127.0.0.1:8000",
  "http://localhost:8000",
];

function cors(origin: string | null): Record<string, string> {
  const allow = origin && ALLOWED_ORIGINS.includes(origin) ? origin : ALLOWED_ORIGINS[0];
  return {
    "Access-Control-Allow-Origin": allow,
    "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
  };
}

function json(body: unknown, status: number, headers: Record<string, string>) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...headers, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req: Request) => {
  const headers = cors(req.headers.get("origin"));
  if (req.method === "OPTIONS") return new Response("ok", { headers });
  if (req.method !== "POST") return json({ error: "Método no permitido" }, 405, headers);

  // --- 1) Identifica al que llama con su propio JWT -----------------------
  const authHeader = req.headers.get("Authorization") || "";
  const userClient = createClient(SUPABASE_URL, ANON_KEY, {
    global: { headers: { Authorization: authHeader } },
  });
  const { data: userData, error: userErr } = await userClient.auth.getUser();
  const caller = userData?.user;
  if (userErr || !caller) return json({ error: "No autenticado" }, 401, headers);

  // --- 2) Verifica que sea admin (app_metadata, no user_metadata) ---------
  const rol = (caller.app_metadata as Record<string, unknown> | null)?.role;
  if (rol !== "admin") {
    return json({ error: "No autorizado: se requiere rol admin." }, 403, headers);
  }

  // --- 3) Cliente con service_role (bypassa RLS) --------------------------
  const admin = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false },
  });

  let body: Record<string, unknown> = {};
  try { body = await req.json(); } catch { /* sin body */ }
  const action = (body.action as string) || "overview";

  try {
    // ----------------------------------------------------------------------
    if (action === "overview") {
      // Todos los usuarios (paginado simple hasta 1000).
      const { data: lista, error: e1 } = await admin.auth.admin.listUsers({ page: 1, perPage: 1000 });
      if (e1) throw e1;
      const usuarios = lista.users.map((u) => ({
        id: u.id,
        email: u.email,
        creado: u.created_at,
        ultimo_login: u.last_sign_in_at,
        es_admin: (u.app_metadata as Record<string, unknown> | null)?.role === "admin",
      }));

      // Estado de acceso al catalogo por usuario.
      const { data: accesos, error: eAccesos } = await admin
        .from("course_access_requests")
        .select("user_id, email, status, requested_at, reviewed_at, reviewed_by");
      if (eAccesos && eAccesos.code !== "42P01") throw eAccesos;
      const accesoPorUsuario: Record<string, Record<string, unknown>> = {};
      (accesos || []).forEach((r) => { accesoPorUsuario[r.user_id] = r; });

      // Todo el progreso.
      const { data: prog, error: e2 } = await admin
        .from("progress")
        .select("user_id, exercise_id, completed, updated_at, time_spent_seconds");
      if (e2) throw e2;

      // Conteo de preguntas al tutor por usuario.
      const { data: preguntas } = await admin
        .from("ai_questions")
        .select("user_id, created_at");
      const preguntasPorUsuario: Record<string, number> = {};
      (preguntas || []).forEach((q) => {
        preguntasPorUsuario[q.user_id] = (preguntasPorUsuario[q.user_id] || 0) + 1;
      });

      // Resultados de pruebas: última nota, mejor nota e intentos por usuario.
      const { data: examenes } = await admin
        .from("exam_results")
        .select("user_id, nota, created_at")
        .order("created_at", { ascending: false });
      const ultimaNota: Record<string, number> = {};
      const mejorNota: Record<string, number> = {};
      const intentos: Record<string, number> = {};
      (examenes || []).forEach((e) => {
        const n = Number(e.nota);
        if (ultimaNota[e.user_id] === undefined) ultimaNota[e.user_id] = n; // primero = más reciente
        mejorNota[e.user_id] = Math.max(mejorNota[e.user_id] ?? 0, n);
        intentos[e.user_id] = (intentos[e.user_id] || 0) + 1;
      });

      // Agregados por usuario y por ejercicio.
      const completadosPorUsuario: Record<string, number> = {};
      const completadosIdsPorUsuario: Record<string, string[]> = {};
      const segundosPorUsuario: Record<string, number> = {};
      const ultimaActividad: Record<string, string> = {};
      const porEjercicio: Record<string, number> = {};
      (prog || []).forEach((r) => {
        if (r.completed) {
          completadosPorUsuario[r.user_id] = (completadosPorUsuario[r.user_id] || 0) + 1;
          (completadosIdsPorUsuario[r.user_id] ||= []).push(r.exercise_id);
          porEjercicio[r.exercise_id] = (porEjercicio[r.exercise_id] || 0) + 1;
        }
        segundosPorUsuario[r.user_id] = (segundosPorUsuario[r.user_id] || 0) + (r.time_spent_seconds || 0);
        const prev = ultimaActividad[r.user_id];
        if (!prev || (r.updated_at && r.updated_at > prev)) ultimaActividad[r.user_id] = r.updated_at;
      });

      const usuariosEnriquecidos = usuarios.map((u) => ({
        ...u,
        acceso: u.es_admin ? "admin" : String(accesoPorUsuario[u.id]?.status || "none"),
        acceso_solicitado: accesoPorUsuario[u.id]?.requested_at || null,
        acceso_revisado: accesoPorUsuario[u.id]?.reviewed_at || null,
        completados: completadosPorUsuario[u.id] || 0,
        completados_ids: completadosIdsPorUsuario[u.id] || [],
        segundos: segundosPorUsuario[u.id] || 0,
        preguntas: preguntasPorUsuario[u.id] || 0,
        nota_ultima: ultimaNota[u.id] ?? null,
        nota_mejor: mejorNota[u.id] ?? null,
        intentos_prueba: intentos[u.id] || 0,
        ultima_actividad: ultimaActividad[u.id] || null,
      }));

      // Promedio de la última nota de cada alumno que rindió.
      const notas = Object.values(ultimaNota);
      const promedioNotas = notas.length
        ? Math.round((notas.reduce((a, b) => a + b, 0) / notas.length) * 10) / 10
        : null;

      return json({
        totales: {
          alumnos: usuarios.length,
          solicitudes_pendientes: (accesos || []).filter((r) => r.status === "pending").length,
          ejercicios_completados: (prog || []).filter((r) => r.completed).length,
          preguntas: (preguntas || []).length,
          pruebas_rendidas: (examenes || []).length,
          promedio_notas: promedioNotas,
        },
        usuarios: usuariosEnriquecidos,
        por_ejercicio: porEjercicio,
      }, 200, headers);
    }

    // ----------------------------------------------------------------------
    if (action === "set_access_status") {
      const userId = body.user_id as string;
      const status = String(body.status || "");
      if (!userId) return json({ error: "Falta user_id" }, 400, headers);
      if (!["pending", "approved", "rejected"].includes(status)) {
        return json({ error: "Estado de acceso invalido" }, 400, headers);
      }
      const { data: target, error: targetErr } = await admin.auth.admin.getUserById(userId);
      if (targetErr) throw targetErr;
      const email = target.user?.email || null;
      const { error } = await admin
        .from("course_access_requests")
        .upsert({
          user_id: userId,
          email,
          status,
          requested_at: new Date().toISOString(),
          reviewed_at: status === "pending" ? null : new Date().toISOString(),
          reviewed_by: status === "pending" ? null : caller.id,
        }, { onConflict: "user_id" });
      if (error) throw error;
      return json({ ok: true }, 200, headers);
    }

    // ----------------------------------------------------------------------
    if (action === "course_catalog") {
      const { data, error } = await admin
        .from("courses")
        .select(`
          *,
          course_modules (
            *,
            course_items (*)
          )
        `)
        .order("sort_order", { ascending: true })
        .order("sort_order", { referencedTable: "course_modules", ascending: true })
        .order("sort_order", { referencedTable: "course_modules.course_items", ascending: true });
      if (error) throw error;
      return json({ courses: data || [] }, 200, headers);
    }

    // ----------------------------------------------------------------------
    if (action === "save_course") {
      const course = body.course as Record<string, unknown>;
      if (!course?.id || !course?.title) return json({ error: "Faltan id/title del curso" }, 400, headers);
      const payload = {
        id: String(course.id),
        title: String(course.title),
        subtitle: course.subtitle ? String(course.subtitle) : null,
        description: course.description ? String(course.description) : null,
        emoji: course.emoji ? String(course.emoji) : "📚",
        media: course.media || {},
        sort_order: Number(course.sort_order || 0),
        is_published: Boolean(course.is_published),
        created_by: caller.id,
      };
      const { error } = await admin.from("courses").upsert(payload, { onConflict: "id" });
      if (error) throw error;
      return json({ ok: true }, 200, headers);
    }

    // ----------------------------------------------------------------------
    if (action === "save_module") {
      const module = body.module as Record<string, unknown>;
      if (!module?.id || !module?.course_id || !module?.title) {
        return json({ error: "Faltan id/course_id/title del módulo" }, 400, headers);
      }
      const payload = {
        id: String(module.id),
        course_id: String(module.course_id),
        title: String(module.title),
        emoji: module.emoji ? String(module.emoji) : "📦",
        intro: module.intro ? String(module.intro) : null,
        theory: module.theory ? String(module.theory) : null,
        media: module.media || {},
        sort_order: Number(module.sort_order || 0),
        is_published: module.is_published !== false,
      };
      const { error } = await admin.from("course_modules").upsert(payload, { onConflict: "id" });
      if (error) throw error;
      return json({ ok: true }, 200, headers);
    }

    // ----------------------------------------------------------------------
    if (action === "save_item") {
      const item = body.item as Record<string, unknown>;
      if (!item?.id || !item?.course_id || !item?.module_id || !item?.title || !item?.statement_html) {
        return json({ error: "Faltan campos obligatorios de la pregunta" }, 400, headers);
      }
      const payload = {
        id: String(item.id),
        course_id: String(item.course_id),
        module_id: String(item.module_id),
        type: String(item.type || "quiz_single"),
        title: String(item.title),
        level: Number(item.level || 1),
        statement_html: String(item.statement_html),
        hint: item.hint ? String(item.hint) : null,
        starter: item.starter ? String(item.starter) : null,
        tests: item.tests || [],
        options: item.options || [],
        correct_answer: item.correct_answer ? String(item.correct_answer) : null,
        explanation: item.explanation ? String(item.explanation) : null,
        solution_html: item.solution_html ? String(item.solution_html) : null,
        steps: item.steps || [],
        sort_order: Number(item.sort_order || 0),
        is_published: item.is_published !== false,
      };
      const { error } = await admin.from("course_items").upsert(payload, { onConflict: "id" });
      if (error) throw error;
      return json({ ok: true }, 200, headers);
    }

    // ----------------------------------------------------------------------
    if (action === "delete_course_entity") {
      const table = String(body.table || "");
      const id = String(body.id || "");
      const allowed: Record<string, string> = {
        courses: "courses",
        modules: "course_modules",
        items: "course_items",
      };
      if (!allowed[table] || !id) return json({ error: "Tabla o id inválido" }, 400, headers);
      const { error } = await admin.from(allowed[table]).delete().eq("id", id);
      if (error) throw error;
      return json({ ok: true }, 200, headers);
    }

    // ----------------------------------------------------------------------
    if (action === "user_detail") {
      const userId = body.user_id as string;
      if (!userId) return json({ error: "Falta user_id" }, 400, headers);
      const { data, error } = await admin
        .from("progress")
        .select("exercise_id, completed, code, updated_at, time_spent_seconds")
        .eq("user_id", userId)
        .order("updated_at", { ascending: false });
      if (error) throw error;

      // Preguntas que hizo este alumno al tutor.
      const { data: preguntas } = await admin
        .from("ai_questions")
        .select("exercise_id, question, answer, created_at")
        .eq("user_id", userId)
        .order("created_at", { ascending: false })
        .limit(200);

      // Resultados de pruebas de este alumno.
      const { data: examenes } = await admin
        .from("exam_results")
        .select("exam_id, version, logro, nota, detalle, created_at")
        .eq("user_id", userId)
        .order("created_at", { ascending: false })
        .limit(50);

      return json({ progreso: data || [], preguntas: preguntas || [], examenes: examenes || [] }, 200, headers);
    }

    // ----------------------------------------------------------------------
    if (action === "reset_user") {
      const userId = body.user_id as string;
      if (!userId) return json({ error: "Falta user_id" }, 400, headers);
      const { error } = await admin.from("progress").delete().eq("user_id", userId);
      if (error) throw error;
      return json({ ok: true }, 200, headers);
    }

    // ----------------------------------------------------------------------
    if (action === "delete_user") {
      const userId = body.user_id as string;
      if (!userId) return json({ error: "Falta user_id" }, 400, headers);
      if (userId === caller.id) return json({ error: "No podés borrarte a vos mismo." }, 400, headers);
      const { error } = await admin.auth.admin.deleteUser(userId);
      if (error) throw error;
      return json({ ok: true }, 200, headers);
    }

    return json({ error: "Acción desconocida: " + action }, 400, headers);
  } catch (e) {
    console.error("admin error:", e);
    return json({ error: "Error en el panel admin: " + (e?.message || String(e)) }, 500, headers);
  }
});
