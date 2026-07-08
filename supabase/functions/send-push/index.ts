import { createClient } from "@supabase/supabase-js";
import webpush from "web-push";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const ANON_KEY = Deno.env.get("SUPABASE_ANON_KEY")!;
const SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const VAPID_PUBLIC_KEY = Deno.env.get("VAPID_PUBLIC_KEY")!;
const VAPID_PRIVATE_KEY = Deno.env.get("VAPID_PRIVATE_KEY")!;
const VAPID_SUBJECT = Deno.env.get("VAPID_SUBJECT") || "mailto:fponce@techforce.cl";

const ALLOWED_ORIGINS = [
  "https://learn.techforce.cl",
  "https://progra-uai.pages.dev",
  "https://progra-uai.techforce.cl",
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

webpush.setVapidDetails(VAPID_SUBJECT, VAPID_PUBLIC_KEY, VAPID_PRIVATE_KEY);

Deno.serve(async (req: Request) => {
  const headers = cors(req.headers.get("origin"));
  if (req.method === "OPTIONS") return new Response("ok", { headers });
  if (req.method !== "POST") return json({ error: "Método no permitido" }, 405, headers);

  if (!VAPID_PUBLIC_KEY || !VAPID_PRIVATE_KEY) {
    return json({ error: "Faltan secretos VAPID" }, 500, headers);
  }

  const authHeader = req.headers.get("Authorization") || "";
  const userClient = createClient(SUPABASE_URL, ANON_KEY, {
    global: { headers: { Authorization: authHeader } },
  });
  const { data: userData, error: userErr } = await userClient.auth.getUser();
  const user = userData?.user;
  if (userErr || !user) return json({ error: "No autenticado" }, 401, headers);

  const admin = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false },
  });

  let body: Record<string, unknown> = {};
  try {
    body = await req.json();
  } catch {
    body = {};
  }

  const payload = JSON.stringify({
    title: String(body.title || "TechForce Learn").slice(0, 120),
    body: String(body.body || "Tienes una actualización del curso.").slice(0, 240),
    url: String(body.url || "/").slice(0, 1000),
  });

  const { data: subscriptions, error } = await admin
    .from("push_subscriptions")
    .select("id, endpoint, p256dh, auth")
    .eq("user_id", user.id);
  if (error) return json({ error: error.message }, 500, headers);

  let sent = 0;
  let removed = 0;
  const errors: string[] = [];

  for (const sub of subscriptions || []) {
    const subscription = {
      endpoint: sub.endpoint,
      keys: {
        p256dh: sub.p256dh,
        auth: sub.auth,
      },
    };

    try {
      await webpush.sendNotification(subscription, payload);
      sent += 1;
      await admin
        .from("push_subscriptions")
        .update({ last_used_at: new Date().toISOString() })
        .eq("id", sub.id);
    } catch (e) {
      const statusCode = Number((e as { statusCode?: number }).statusCode || 0);
      if (statusCode === 404 || statusCode === 410) {
        removed += 1;
        await admin.from("push_subscriptions").delete().eq("id", sub.id);
      } else {
        errors.push(e instanceof Error ? e.message : String(e));
      }
    }
  }

  return json({ sent, removed, errors }, errors.length ? 207 : 200, headers);
});
