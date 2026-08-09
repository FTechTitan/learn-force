import { createClient } from "@supabase/supabase-js";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const ANON_KEY = Deno.env.get("SUPABASE_ANON_KEY")!;
const SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const admin = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false },
});

const API_ROOT = "/courses-api/v1";
const RATE_LIMIT = 120;
const RATE_WINDOW_MS = 60_000;
const ALLOWED_ORIGINS = new Set([
  "https://learn.techforce.cl",
  "https://learn-force.pages.dev",
  "http://127.0.0.1:8000",
  "http://localhost:8000",
]);

type AuthContext = {
  userId: string;
  email: string | null;
  isAdmin: boolean;
  method: "jwt" | "api_key";
  keyId?: string;
};

function cors(req: Request): Record<string, string> {
  const origin = req.headers.get("origin");
  return {
    "Access-Control-Allow-Origin": origin && ALLOWED_ORIGINS.has(origin) ? origin : "https://learn.techforce.cl",
    "Access-Control-Allow-Headers": "authorization, x-api-key, apikey, content-type",
    "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
    "Vary": "Origin",
  };
}

function response(req: Request, body: unknown, status = 200, extra: Record<string, string> = {}) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...cors(req), "Content-Type": "application/json; charset=utf-8", ...extra },
  });
}

function error(req: Request, status: number, code: string, message: string) {
  return response(req, { error: { code, message } }, status);
}

async function sha256(value: string): Promise<string> {
  const bytes = new TextEncoder().encode(value);
  const digest = await crypto.subtle.digest("SHA-256", bytes);
  return [...new Uint8Array(digest)].map((byte) => byte.toString(16).padStart(2, "0")).join("");
}

function randomSecret(): string {
  const bytes = crypto.getRandomValues(new Uint8Array(32));
  const encoded = btoa(String.fromCharCode(...bytes))
    .replaceAll("+", "-").replaceAll("/", "_").replaceAll("=", "");
  return `lf_agent_${encoded}`;
}

async function authenticate(req: Request): Promise<AuthContext | null> {
  const personalKey = req.headers.get("x-api-key")?.trim();
  if (personalKey) {
    if (!personalKey.startsWith("lf_agent_")) return null;
    const hash = await sha256(personalKey);
    const { data, error: keyError } = await admin
      .from("agent_api_keys")
      .select("id, user_id, expires_at, revoked_at")
      .eq("key_hash", hash)
      .maybeSingle();
    if (keyError || !data || data.revoked_at || (data.expires_at && new Date(data.expires_at) <= new Date())) return null;
    const { data: userData, error: userError } = await admin.auth.admin.getUserById(data.user_id);
    if (userError || !userData.user) return null;
    await admin.from("agent_api_keys").update({ last_used_at: new Date().toISOString() }).eq("id", data.id);
    return {
      userId: userData.user.id,
      email: userData.user.email || null,
      isAdmin: userData.user.app_metadata?.role === "admin",
      method: "api_key",
      keyId: data.id,
    };
  }

  const authorization = req.headers.get("authorization") || "";
  if (!authorization.toLowerCase().startsWith("bearer ")) return null;
  const userClient = createClient(SUPABASE_URL, ANON_KEY, {
    global: { headers: { Authorization: authorization } },
    auth: { autoRefreshToken: false, persistSession: false },
  });
  const { data, error: userError } = await userClient.auth.getUser();
  if (userError || !data.user) return null;
  return {
    userId: data.user.id,
    email: data.user.email || null,
    isAdmin: data.user.app_metadata?.role === "admin",
    method: "jwt",
  };
}

async function consumeRateLimit(auth: AuthContext) {
  const windowStarted = new Date(Math.floor(Date.now() / RATE_WINDOW_MS) * RATE_WINDOW_MS).toISOString();
  const subject = auth.keyId ? `key:${auth.keyId}` : `user:${auth.userId}`;
  const { data } = await admin.from("agent_api_rate_limits")
    .select("request_count").eq("subject", subject).eq("window_started_at", windowStarted).maybeSingle();
  const count = Number(data?.request_count || 0) + 1;
  await admin.from("agent_api_rate_limits").upsert({ subject, window_started_at: windowStarted, request_count: count });
  return { allowed: count <= RATE_LIMIT, remaining: Math.max(0, RATE_LIMIT - count), reset: Math.floor((new Date(windowStarted).getTime() + RATE_WINDOW_MS) / 1000) };
}

async function hasCatalogAccess(auth: AuthContext): Promise<boolean> {
  if (auth.isAdmin) return true;
  const { data } = await admin.from("course_access_requests")
    .select("status").eq("user_id", auth.userId).eq("status", "approved").maybeSingle();
  return Boolean(data);
}

function pathParts(req: Request): string[] {
  const pathname = new URL(req.url).pathname;
  const marker = pathname.indexOf(API_ROOT);
  if (marker < 0) return [];
  return pathname.slice(marker + API_ROOT.length).split("/").filter(Boolean).map(decodeURIComponent);
}

async function parseBody(req: Request): Promise<Record<string, unknown> | null> {
  try { return await req.json(); } catch { return null; }
}

async function ensureCourse(courseId: string) {
  return admin.from("courses")
    .select("id, title, subtitle, description, emoji, media, sort_order")
    .eq("id", courseId).eq("is_published", true).maybeSingle();
}

async function ensureModule(courseId: string, moduleId: string) {
  return admin.from("course_modules")
    .select("id, course_id, title, emoji, intro, overview_markdown, theory, media, sort_order")
    .eq("id", moduleId).eq("course_id", courseId).eq("is_published", true).maybeSingle();
}

async function signedDownload(path: string | null) {
  if (!path) return null;
  const { data } = await admin.storage.from("imperio-agentico-content").createSignedUrl(path, 3600);
  return data?.signedUrl || null;
}

type SearchRow = {
  lesson_id: string;
  course_id: string;
  module_id: string;
  course_title: string;
  module_title: string;
  title: string;
  summary: string;
  score: number;
};

function searchLimit(value: unknown): number {
  const parsed = Number(value || 10);
  return Number.isFinite(parsed) ? Math.min(25, Math.max(1, Math.trunc(parsed))) : 10;
}

function searchResult(row: SearchRow, score = row.score) {
  return {
    lesson_id: row.lesson_id,
    course_id: row.course_id,
    module_id: row.module_id,
    course: row.course_title,
    module: row.module_title,
    title: row.title,
    summary: row.summary,
    score: Math.round(Number(score || 0) * 10_000) / 10_000,
    next_action: {
      method: "GET",
      path: `/courses/${row.course_id}/modules/${row.module_id}/lessons/${row.lesson_id}`,
    },
    web_url: `https://learn.techforce.cl/#curso/${row.course_id}/${row.module_id}/clase/${row.lesson_id}`,
  };
}

async function queryEmbedding(text: string): Promise<number[]> {
  const aiGlobal = (globalThis as unknown as {
    Supabase: { ai: { Session: new (model: string) => { run: (input: string, options: Record<string, boolean>) => Promise<ArrayLike<number>> } } };
  }).Supabase;
  if (!aiGlobal?.ai?.Session) throw new Error("Supabase AI no está disponible en este runtime.");
  const model = new aiGlobal.ai.Session("gte-small");
  const output = await model.run(text, { mean_pool: true, normalize: true });
  return Array.from(output);
}

async function keywordSearch(query: string, limit: number): Promise<SearchRow[]> {
  const { data, error: queryError } = await admin.rpc("search_course_documents_keyword", {
    p_query: query,
    p_limit: limit,
  });
  if (queryError) throw queryError;
  return (data || []) as SearchRow[];
}

async function semanticSearch(embedding: number[], limit: number): Promise<SearchRow[]> {
  const { data, error: queryError } = await admin.rpc("search_course_documents_semantic", {
    p_embedding: embedding,
    p_limit: limit,
  });
  if (queryError) throw queryError;
  return (data || []) as SearchRow[];
}

async function indexedDocumentCount(): Promise<number> {
  const { count } = await admin.from("course_search_documents")
    .select("lesson_id", { count: "exact", head: true }).not("embedding", "is", null);
  return count || 0;
}

async function searchRoute(req: Request, auth: AuthContext, mode: "keyword" | "semantic" | "hybrid") {
  const startedAt = performance.now();
  const body = await parseBody(req);
  const query = String(body?.query || "").trim();
  const limit = searchLimit(body?.limit);
  if (query.length < 2 || query.length > 500) {
    return error(req, 422, "validation_error", "query debe tener entre 2 y 500 caracteres.");
  }

  if (mode === "keyword") {
    const rows = await keywordSearch(query, limit);
    return response(req, {
      data: rows.map((row) => searchResult(row)),
      meta: { mode, query, total: rows.length, semantic_used: false, duration_ms: Math.round(performance.now() - startedAt) },
    });
  }

  const embedding = await queryEmbedding(query);
  if (mode === "semantic") {
    const rows = await semanticSearch(embedding, limit);
    return response(req, {
      data: rows.map((row) => searchResult(row)),
      meta: { mode, query, total: rows.length, semantic_used: true, indexed_documents: await indexedDocumentCount(), duration_ms: Math.round(performance.now() - startedAt) },
    });
  }

  const [keywordRows, semanticRows] = await Promise.all([
    keywordSearch(query, Math.min(25, limit * 3)),
    semanticSearch(embedding, Math.min(25, limit * 3)),
  ]);
  const maxKeyword = Math.max(...keywordRows.map((row) => Number(row.score || 0)), 0.0001);
  const merged = new Map<string, SearchRow & { keyword_score: number; semantic_score: number }>();
  keywordRows.forEach((row) => merged.set(row.lesson_id, { ...row, keyword_score: Number(row.score || 0) / maxKeyword, semantic_score: 0 }));
  semanticRows.forEach((row) => {
    const current = merged.get(row.lesson_id);
    if (current) current.semantic_score = Math.max(0, Number(row.score || 0));
    else merged.set(row.lesson_id, { ...row, keyword_score: 0, semantic_score: Math.max(0, Number(row.score || 0)) });
  });
  const rows = [...merged.values()]
    .map((row) => ({ ...row, combined_score: row.keyword_score * 0.45 + row.semantic_score * 0.55 }))
    .sort((a, b) => b.combined_score - a.combined_score)
    .slice(0, limit);
  return response(req, {
    data: rows.map((row) => ({ ...searchResult(row, row.combined_score), keyword_score: Math.round(row.keyword_score * 10_000) / 10_000, semantic_score: Math.round(row.semantic_score * 10_000) / 10_000 })),
    meta: { mode, query, total: rows.length, semantic_used: true, indexed_documents: await indexedDocumentCount(), duration_ms: Math.round(performance.now() - startedAt) },
  });
}

async function indexSmokeBatch(req: Request, auth: AuthContext) {
  if (!auth.isAdmin || auth.method !== "jwt") return error(req, 403, "admin_required", "Solo un administrador puede generar el índice piloto.");
  const body = await parseBody(req);
  const limit = Math.min(8, Math.max(1, Number(body?.limit || 8)));
  const { data: documents, error: selectError } = await admin.from("course_search_documents")
    .select("lesson_id, search_text").is("embedding", null).order("lesson_id").limit(limit);
  if (selectError) throw selectError;
  const indexed: string[] = [];
  const failed: string[] = [];
  for (const document of documents || []) {
    try {
      const embedding = await queryEmbedding(document.search_text);
      const { error: updateError } = await admin.from("course_search_documents")
        .update({ embedding, embedded_at: new Date().toISOString(), updated_at: new Date().toISOString() })
        .eq("lesson_id", document.lesson_id);
      if (updateError) throw updateError;
      indexed.push(document.lesson_id);
    } catch (caught) {
      console.error("index-smoke", document.lesson_id, caught instanceof Error ? caught.message : caught);
      failed.push(document.lesson_id);
    }
  }
  const { count: remaining } = await admin.from("course_search_documents")
    .select("lesson_id", { count: "exact", head: true }).is("embedding", null);
  return response(req, { data: { indexed: indexed.length, failed: failed.length, remaining: remaining || 0 }, meta: { smoke: true, max_batch: 8 } });
}

async function route(req: Request, auth: AuthContext, parts: string[]) {
  if (req.method === "GET" && parts.length === 1 && parts[0] === "me") {
    return response(req, { data: { id: auth.userId, email: auth.email, auth_method: auth.method } });
  }

  if (parts[0] === "api-keys") {
    if (auth.method !== "jwt") return error(req, 403, "jwt_required", "Administra tus claves usando una sesión de usuario.");
    if (req.method === "GET" && parts.length === 1) {
      const { data, error: queryError } = await admin.from("agent_api_keys")
        .select("id, name, key_prefix, last_used_at, expires_at, revoked_at, created_at")
        .eq("user_id", auth.userId).order("created_at", { ascending: false });
      if (queryError) throw queryError;
      return response(req, { data });
    }
    if (req.method === "POST" && parts.length === 1) {
      const body = await parseBody(req);
      const name = String(body?.name || "").trim();
      const expiresAt = body?.expires_at ? String(body.expires_at) : null;
      if (!name || name.length > 80) return error(req, 422, "validation_error", "name debe tener entre 1 y 80 caracteres.");
      if (expiresAt && (Number.isNaN(Date.parse(expiresAt)) || new Date(expiresAt) <= new Date())) {
        return error(req, 422, "validation_error", "expires_at debe ser una fecha futura ISO 8601.");
      }
      const secret = randomSecret();
      const keyHash = await sha256(secret);
      const { data, error: insertError } = await admin.from("agent_api_keys").insert({
        user_id: auth.userId, name, key_prefix: secret.slice(0, 17), key_hash: keyHash, expires_at: expiresAt,
      }).select("id, name, key_prefix, expires_at, created_at").single();
      if (insertError) throw insertError;
      return response(req, { data: { ...data, key: secret }, meta: { warning: "Guarda esta clave ahora; no volverá a mostrarse." } }, 201, {
        "Location": `${API_ROOT}/api-keys/${data.id}`,
      });
    }
    if (req.method === "DELETE" && parts.length === 2) {
      const { data, error: revokeError } = await admin.from("agent_api_keys")
        .update({ revoked_at: new Date().toISOString() })
        .eq("id", parts[1]).eq("user_id", auth.userId).is("revoked_at", null).select("id").maybeSingle();
      if (revokeError) throw revokeError;
      if (!data) return error(req, 404, "not_found", "Clave no encontrada o ya revocada.");
      return new Response(null, { status: 204, headers: cors(req) });
    }
    return error(req, 405, "method_not_allowed", "Método no permitido para esta ruta.");
  }

  if (!(await hasCatalogAccess(auth))) return error(req, 403, "course_access_required", "El usuario no tiene acceso aprobado al catálogo.");

  if (req.method === "POST" && parts.length === 2 && parts[0] === "search" && parts[1] === "index-smoke") {
    return indexSmokeBatch(req, auth);
  }

  if (req.method === "POST" && parts.length === 2 && parts[0] === "search" && ["keyword", "semantic", "hybrid"].includes(parts[1])) {
    return searchRoute(req, auth, parts[1] as "keyword" | "semantic" | "hybrid");
  }

  if (req.method === "GET" && parts.length === 1 && parts[0] === "courses") {
    const { data, error: queryError } = await admin.from("courses")
      .select("id, title, subtitle, description, emoji, media, sort_order")
      .eq("is_published", true).order("sort_order");
    if (queryError) throw queryError;
    return response(req, { data, meta: { total: data.length } });
  }

  if (parts[0] === "courses" && parts[1]) {
    const courseId = parts[1];
    const { data: course, error: courseError } = await ensureCourse(courseId);
    if (courseError) throw courseError;
    if (!course) return error(req, 404, "not_found", "Curso no encontrado.");

    if (req.method === "GET" && parts.length === 2) return response(req, { data: course });

    if (req.method === "GET" && parts.length === 3 && parts[2] === "modules") {
      const { data, error: queryError } = await admin.from("course_modules")
        .select("id, course_id, title, emoji, intro, overview_markdown, sort_order")
        .eq("course_id", courseId).eq("is_published", true).order("sort_order");
      if (queryError) throw queryError;
      return response(req, { data, meta: { total: data.length } });
    }

    if (parts[2] === "modules" && parts[3]) {
      const moduleId = parts[3];
      const { data: module, error: moduleError } = await ensureModule(courseId, moduleId);
      if (moduleError) throw moduleError;
      if (!module) return error(req, 404, "not_found", "Módulo no encontrado.");
      if (req.method === "GET" && parts.length === 4) return response(req, { data: module });
      if (req.method === "GET" && parts.length === 5 && parts[4] === "lessons") {
        const { data, error: queryError } = await admin.from("course_lessons")
          .select("id, course_id, module_id, title, summary, lesson_kind, video_url, video_provider, video_duration, video_thumbnail_url, has_transcript, sort_order")
          .eq("course_id", courseId).eq("module_id", moduleId).eq("is_published", true).order("sort_order").order("id");
        if (queryError) throw queryError;
        return response(req, { data, meta: { total: data.length } });
      }
      if (req.method === "GET" && parts.length === 6 && parts[4] === "lessons") {
        const lessonId = parts[5];
        const { data: lesson, error: lessonError } = await admin.from("course_lessons")
          .select("id, course_id, module_id, title, summary, lesson_kind, video_url, video_provider, video_duration, video_thumbnail_url, has_transcript, sort_order")
          .eq("id", lessonId).eq("course_id", courseId).eq("module_id", moduleId).eq("is_published", true).maybeSingle();
        if (lessonError) throw lessonError;
        if (!lesson) return error(req, 404, "not_found", "Clase no encontrada.");
        const [contentResult, transcriptResult, resourceResult] = await Promise.all([
          admin.from("course_lesson_contents").select("body_markdown").eq("lesson_id", lessonId).maybeSingle(),
          admin.from("course_lesson_transcripts").select("id, language, transcript_text, storage_path, sort_order").eq("lesson_id", lessonId).order("sort_order"),
          admin.from("course_lesson_resources").select("id, title, kind, mime_type, storage_path, file_size, sort_order").eq("lesson_id", lessonId).eq("is_published", true).order("sort_order"),
        ]);
        if (contentResult.error) throw contentResult.error;
        if (transcriptResult.error) throw transcriptResult.error;
        if (resourceResult.error) throw resourceResult.error;
        const transcripts = await Promise.all((transcriptResult.data || []).map(async (item) => ({
          id: item.id, language: item.language, text: item.transcript_text, download_url: await signedDownload(item.storage_path),
        })));
        const resources = await Promise.all((resourceResult.data || []).map(async (item) => ({
          id: item.id, title: item.title, kind: item.kind, mime_type: item.mime_type, file_size: item.file_size,
          download_url: await signedDownload(item.storage_path),
        })));
        return response(req, { data: { ...lesson, body_markdown: contentResult.data?.body_markdown || "", transcripts, resources } });
      }
    }
  }

  if (parts[0] === "progress") {
    if (req.method === "GET" && parts.length === 1) {
      const { data, error: queryError } = await admin.from("progress")
        .select("exercise_id, completed, code, updated_at, time_spent_seconds")
        .eq("user_id", auth.userId).order("updated_at", { ascending: false });
      if (queryError) throw queryError;
      return response(req, { data, meta: { total: data.length } });
    }
    if (req.method === "PUT" && parts.length === 2) {
      const body = await parseBody(req);
      if (!body || (typeof body.completed !== "boolean" && typeof body.code !== "string")) {
        return error(req, 422, "validation_error", "Envía completed (boolean) y/o code (string).");
      }
      const payload: Record<string, unknown> = { user_id: auth.userId, exercise_id: parts[1] };
      if (typeof body.completed === "boolean") payload.completed = body.completed;
      if (typeof body.code === "string") payload.code = body.code.slice(0, 100_000);
      const { data, error: updateError } = await admin.from("progress").upsert(payload, { onConflict: "user_id,exercise_id" })
        .select("exercise_id, completed, code, updated_at, time_spent_seconds").single();
      if (updateError) throw updateError;
      return response(req, { data });
    }
  }

  return error(req, 404, "not_found", "Ruta no encontrada.");
}

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") return new Response(null, { status: 204, headers: cors(req) });
  const auth = await authenticate(req);
  if (!auth) return error(req, 401, "unauthorized", "Usa Authorization: Bearer <JWT> o X-API-Key: <clave personal>.");
  const rate = await consumeRateLimit(auth);
  const rateHeaders = {
    "X-RateLimit-Limit": String(RATE_LIMIT),
    "X-RateLimit-Remaining": String(rate.remaining),
    "X-RateLimit-Reset": String(rate.reset),
  };
  if (!rate.allowed) return response(req, { error: { code: "rate_limit_exceeded", message: "Límite de solicitudes excedido." } }, 429, { ...rateHeaders, "Retry-After": "60" });
  try {
    const routed = await route(req, auth, pathParts(req));
    Object.entries(rateHeaders).forEach(([key, value]) => routed.headers.set(key, value));
    return routed;
  } catch (caught) {
    console.error("courses-api", caught instanceof Error ? caught.message : caught);
    return error(req, 500, "internal_error", "No fue posible procesar la solicitud.");
  }
});
