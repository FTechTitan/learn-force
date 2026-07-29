const CACHE_NAME = "techforce-learn-v6";

const APP_SHELL = [
  "/",
  "/index.html",
  "/manifest.webmanifest",
  "/css/styles.css",
  "/js/runner.js",
  "/js/supabase-client.js",
  "/js/auth-ui.js",
  "/js/app.js",
  "/js/assistant.js",
  "/js/admin.js",
  "/js/exams.js",
  "/js/exam-ui.js",
  "/js/whiteboard.js",
  "/js/voice-tools.js",
  "/assets/pwa/icon-192.png",
  "/assets/pwa/icon-512.png",
  "/assets/pwa/favicon-64.png"
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll(APP_SHELL))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys()
      .then((names) => Promise.all(names.filter((name) => name !== CACHE_NAME).map((name) => caches.delete(name))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", (event) => {
  const request = event.request;
  if (request.method !== "GET") return;

  const url = new URL(request.url);
  if (url.origin !== self.location.origin) return;

  if (request.mode === "navigate") {
    event.respondWith(
      fetch(request)
        .then((response) => {
          const copy = response.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put("/index.html", copy));
          return response;
        })
        .catch(() => caches.match("/index.html"))
    );
    return;
  }

  if (["script", "style", "worker"].includes(request.destination) || url.pathname.endsWith(".webmanifest")) {
    event.respondWith(
      fetch(request)
        .then((response) => {
          if (response.ok) {
            const copy = response.clone();
            caches.open(CACHE_NAME).then((cache) => cache.put(request, copy));
          }
          return response;
        })
        .catch(() => caches.match(request))
    );
    return;
  }

  event.respondWith(
    caches.match(request).then((cached) => {
      const network = fetch(request).then((response) => {
        if (response.ok) {
          const copy = response.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(request, copy));
        }
        return response;
      }).catch(() => cached);
      return cached || network;
    })
  );
});

self.addEventListener("message", (event) => {
  const data = event.data || {};
  if (data.type !== "SHOW_NOTIFICATION") return;

  const title = data.title || "TechForce Learn";
  const options = {
    body: data.body || "",
    icon: "/assets/pwa/icon-192.png",
    badge: "/assets/pwa/favicon-64.png",
    tag: data.tag || "techforce-learn",
    data: { url: data.url || "/" }
  };
  event.waitUntil(self.registration.showNotification(title, options));
});

self.addEventListener("push", (event) => {
  let data = {};
  try {
    data = event.data ? event.data.json() : {};
  } catch {
    data = { body: event.data ? event.data.text() : "" };
  }

  const title = data.title || "TechForce Learn";
  const options = {
    body: data.body || "",
    icon: "/assets/pwa/icon-192.png",
    badge: "/assets/pwa/favicon-64.png",
    tag: data.tag || "techforce-learn",
    data: { url: data.url || "/" }
  };

  event.waitUntil(self.registration.showNotification(title, options));
});

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  const targetUrl = event.notification.data?.url || "/";
  event.waitUntil(
    self.clients.matchAll({ type: "window", includeUncontrolled: true }).then((clients) => {
      const existing = clients.find((client) => "focus" in client);
      if (existing) {
        existing.navigate(targetUrl);
        return existing.focus();
      }
      return self.clients.openWindow(targetUrl);
    })
  );
});
