// ============================================================================
//  VideoProgress — recuerda en qué segundo quedó cada clase.
//
//  Por qué existe: cualquier repintado del panel vuelve a crear el <iframe> o
//  el <video>, y el reproductor arranca de cero. Acá se guarda la posición en
//  localStorage y se restaura al montar el reproductor.
//
//  Soporta:
//    - <video> / <audio> propios   -> currentTime
//    - Vimeo (player.vimeo.com)    -> #t= al montar + SDK player.js para leer
//    - YouTube (youtube.com/embed) -> start= al montar + IFrame API para leer
//  Drive y Loom no exponen API de tiempo: se siguen viendo, pero sin memoria.
// ============================================================================

(function () {
  "use strict";

  const STORAGE_KEY = "techforce-learn-video-pos-v1";
  const MAX_ENTRADAS = 300;
  const INTERVALO_GUARDADO_MS = 4000;  // no escribir en cada timeupdate
  const MINIMO_PARA_RECORDAR_S = 10;   // menos que esto no vale la pena recordar
  const MARGEN_FINAL_S = 15;           // si ya casi terminó, arranca de cero

  // --- Almacenamiento ------------------------------------------------------
  function leerMapa() {
    try {
      const raw = localStorage.getItem(STORAGE_KEY);
      const data = raw ? JSON.parse(raw) : null;
      return data && typeof data === "object" ? data : {};
    } catch (_) {
      return {};
    }
  }

  function escribirMapa(mapa) {
    try {
      const claves = Object.keys(mapa);
      const podado = claves.length <= MAX_ENTRADAS
        ? mapa
        : claves
            .sort((a, b) => (mapa[b].t || 0) - (mapa[a].t || 0))
            .slice(0, MAX_ENTRADAS)
            .reduce((acc, clave) => ({ ...acc, [clave]: mapa[clave] }), {});
      localStorage.setItem(STORAGE_KEY, JSON.stringify(podado));
    } catch (e) {
      console.warn("No se pudo guardar la posición del video:", e.message || e);
    }
  }

  function olvidar(clave, mapa) {
    if (!mapa[clave]) return;
    const copia = { ...mapa };
    delete copia[clave];
    escribirMapa(copia);
  }

  function guardar(clave, segundos, duracion) {
    if (!clave) return;
    const s = Number(segundos);
    if (!Number.isFinite(s) || s < 0) return;
    const d = Number.isFinite(Number(duracion)) ? Number(duracion) : 0;
    const mapa = leerMapa();

    // Recién empezado o prácticamente terminado: no hay nada que recordar.
    if (s < MINIMO_PARA_RECORDAR_S || (d && s > d - MARGEN_FINAL_S)) {
      olvidar(clave, mapa);
      return;
    }
    escribirMapa({ ...mapa, [clave]: { s: Math.floor(s), d: Math.floor(d), t: Date.now() } });
  }

  function posicionGuardada(clave) {
    if (!clave) return 0;
    const item = leerMapa()[clave];
    if (!item || !Number.isFinite(item.s)) return 0;
    if (item.s < MINIMO_PARA_RECORDAR_S) return 0;
    if (item.d && item.s > item.d - MARGEN_FINAL_S) return 0;
    return item.s;
  }

  function crearPersistidor(clave) {
    let ultimoGuardado = 0;
    return function persistir(segundos, duracion, forzar) {
      const ahora = Date.now();
      if (!forzar && ahora - ultimoGuardado < INTERVALO_GUARDADO_MS) return;
      ultimoGuardado = ahora;
      guardar(clave, segundos, duracion);
    };
  }

  // --- Flush al ocultar la pestaña o cerrar --------------------------------
  const pendientes = [];

  function registrarFlush(el, fn) {
    pendientes.push({ el, fn });
  }

  function flushTodo() {
    for (let i = pendientes.length - 1; i >= 0; i--) {
      const { el, fn } = pendientes[i];
      if (el && !el.isConnected) {
        pendientes.splice(i, 1);
        continue;
      }
      try { fn(); } catch (_) { /* un reproductor muerto no debe romper el resto */ }
    }
  }

  document.addEventListener("visibilitychange", () => {
    if (document.visibilityState === "hidden") flushTodo();
  });
  window.addEventListener("pagehide", flushTodo);

  // --- Carga perezosa de SDKs externos -------------------------------------
  const scriptsCargados = {};

  function cargarScript(src) {
    if (scriptsCargados[src]) return scriptsCargados[src];
    scriptsCargados[src] = new Promise((resolve, reject) => {
      const tag = document.createElement("script");
      tag.src = src;
      tag.async = true;
      tag.onload = () => resolve();
      tag.onerror = () => reject(new Error(`No se pudo cargar ${src}`));
      document.head.appendChild(tag);
    });
    return scriptsCargados[src];
  }

  // --- <video> / <audio> propios -------------------------------------------
  function seguirMediaEl(el, clave) {
    const persistir = crearPersistidor(clave);

    const restaurar = () => {
      const inicio = posicionGuardada(clave);
      if (!inicio) return;
      if (el.duration && inicio >= el.duration - MARGEN_FINAL_S) return;
      try { el.currentTime = inicio; } catch (_) { /* algunos formatos no permiten seek temprano */ }
    };

    if (el.readyState >= 1) restaurar();
    else el.addEventListener("loadedmetadata", restaurar, { once: true });

    el.addEventListener("timeupdate", () => persistir(el.currentTime, el.duration));
    ["pause", "ended"].forEach((evento) =>
      el.addEventListener(evento, () => persistir(el.currentTime, el.duration, true)));
    registrarFlush(el, () => persistir(el.currentTime, el.duration, true));
  }

  // --- Vimeo ---------------------------------------------------------------
  function cargarVimeoSdk() {
    if (window.Vimeo && window.Vimeo.Player) return Promise.resolve();
    return cargarScript("https://player.vimeo.com/api/player.js");
  }

  function seguirVimeo(iframe, clave) {
    // El salto inicial ya viene en el src (#t=), acá solo se lee la posición.
    cargarVimeoSdk()
      .then(() => {
        if (!window.Vimeo || !window.Vimeo.Player) return;
        const player = new window.Vimeo.Player(iframe);
        const persistir = crearPersistidor(clave);
        let ultimo = { seconds: 0, duration: 0 };

        player.on("timeupdate", (data) => {
          ultimo = data;
          persistir(data.seconds, data.duration);
        });
        player.on("pause", () => persistir(ultimo.seconds, ultimo.duration, true));
        player.on("ended", () => persistir(ultimo.duration || 0, ultimo.duration, true));
        registrarFlush(iframe, () => persistir(ultimo.seconds, ultimo.duration, true));
      })
      .catch((e) => console.warn("No se pudo seguir el video de Vimeo:", e.message || e));
  }

  // --- YouTube -------------------------------------------------------------
  let promesaYoutube = null;

  function cargarYoutubeApi() {
    if (window.YT && window.YT.Player) return Promise.resolve();
    if (!promesaYoutube) {
      promesaYoutube = new Promise((resolve, reject) => {
        const anterior = window.onYouTubeIframeAPIReady;
        window.onYouTubeIframeAPIReady = () => {
          if (typeof anterior === "function") anterior();
          resolve();
        };
        cargarScript("https://www.youtube.com/iframe_api").catch(reject);
      });
    }
    return promesaYoutube;
  }

  function seguirYoutube(iframe, clave) {
    if (!iframe.id) iframe.id = `yt-player-${Math.random().toString(36).slice(2, 10)}`;
    cargarYoutubeApi()
      .then(() => {
        const persistir = crearPersistidor(clave);
        let temporizador = null;

        const leer = (forzar) => {
          if (typeof player.getCurrentTime !== "function") return;
          persistir(player.getCurrentTime(), player.getDuration(), forzar);
        };

        const player = new window.YT.Player(iframe.id, {
          events: {
            onStateChange: (ev) => {
              clearInterval(temporizador);
              temporizador = null;
              if (ev.data === window.YT.PlayerState.PLAYING) {
                // El intervalo ya hace de throttle, por eso guarda forzado.
                temporizador = setInterval(() => leer(true), INTERVALO_GUARDADO_MS);
                return;
              }
              leer(true);
            },
          },
        });

        registrarFlush(iframe, () => leer(true));
      })
      .catch((e) => console.warn("No se pudo seguir el video de YouTube:", e.message || e));
  }

  // --- API pública ---------------------------------------------------------

  // Devuelve el src del embed listo para montar: con el salto al último punto
  // visto y, en YouTube, con la API habilitada para poder leer el avance.
  function prepararSrc(embed, clave) {
    if (!embed || !embed.src) return "";
    let url;
    try {
      url = new URL(embed.src);
    } catch (_) {
      return embed.src;
    }
    const inicio = posicionGuardada(clave);

    if (embed.kind === "youtube") {
      url.searchParams.set("enablejsapi", "1");
      url.searchParams.set("origin", window.location.origin);
      if (inicio) url.searchParams.set("start", String(inicio));
    } else if (embed.kind === "vimeo" && inicio) {
      url.hash = `t=${inicio}s`;
    }
    return url.toString();
  }

  // Conecta el seguimiento a todo reproductor con data-video-key dentro de raiz.
  function attach(raiz) {
    const root = raiz || document;
    root.querySelectorAll("[data-video-key]").forEach((el) => {
      if (el.dataset.videoTracked === "1") return;
      el.dataset.videoTracked = "1";

      const clave = el.getAttribute("data-video-key");
      if (!clave) return;

      if (el.tagName === "VIDEO" || el.tagName === "AUDIO") {
        seguirMediaEl(el, clave);
        return;
      }
      if (el.tagName !== "IFRAME") return;

      const kind = el.getAttribute("data-video-kind");
      if (kind === "vimeo") seguirVimeo(el, clave);
      else if (kind === "youtube") seguirYoutube(el, clave);
    });
  }

  window.VideoProgress = {
    attach,
    prepararSrc,
    posicionGuardada,
    guardar,
    flush: flushTodo,
  };
})();
