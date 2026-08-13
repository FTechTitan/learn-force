# Recuperar subtítulos de los cursos importados desde Hotmart

Los cursos que entraron a LearnForce desde una carpeta de Drive (`poderosa-maquina-pacientes`,
`whatsagenda-pro`) quedaron **sin transcripciones**: `course_lesson_transcripts` está vacía para
ellos y el `body_markdown` de cada clase es relleno del importador (~300 caracteres con el título
repetido). Eso deja la app sin material para resúmenes por clase ni para la búsqueda semántica.

**La buena noticia: no hay que transcribir nada.** Los videos originales están en Vimeo y tienen
subtítulos autogenerados en español (`es-x-autogen`, formato `.vtt`).

---

## Por qué el importador concluyó que no había transcripciones

El manifiesto (`tmp/course-import/<curso>/manifest.json`) trae esta auditoría:

```json
"transcript_source_audit": {
  "status": "not_found_in_original_source",
  "checked": ["Drive folder …: 64 files, all video/mp4, no transcript-like files"]
}
```

La conclusión es correcta **para Drive**, pero Drive es una copia. El origen real es
**Hotmart, con los videos servidos por Vimeo**. Se nota en el nombre de archivo, que conserva el
patrón de `yt-dlp` con el ID de Vimeo:

```
Bienvenida [861268366].mp4
```

y en la nota de Obsidian que originó la importación, que documenta la ruta local
`~/Downloads/hotmart-vimeo`.

---

## El detalle que hace toda la diferencia: el `?h=`

Los videos son privados. Con la URL pelada, Vimeo responde **401**:

```bash
yt-dlp --list-subs "https://vimeo.com/861268366"
# ERROR: HTTP Error 401: Unauthorized
```

Con el **hash de embed** que usa Hotmart, funciona sin cookies ni sesión:

```bash
yt-dlp --list-subs "https://player.vimeo.com/video/907868643?h=c40fb03022"
# [info] Available subtitles for 907868643:
# Language     Formats
# es-x-autogen vtt, vtt, vtt
```

Ese hash está en el **HTML renderizado** de la página de la clase en Hotmart Club. No está en el
HTML servido (la app es un SPA y lo resuelve en el cliente), así que hay que leerlo del DOM ya
montado:

```js
// en la consola, sobre https://hotmart.com/es/club/<slug>/products/<id>/content/<contenido>
document.documentElement.innerHTML.match(/player\.vimeo\.com\/video\/\d+\?h=[a-z0-9]+/i)[0]
```

---

## Descargar los subtítulos

Con la URL completa, solo subtítulos y sin bajar video:

```bash
yt-dlp --write-subs --sub-langs "es.*" --skip-download \
  -o "%(title)s [%(id)s].%(ext)s" \
  -P ./subtitles \
  "https://player.vimeo.com/video/<ID>?h=<HASH>"
```

> Usar **`--write-subs`**, no `--write-auto-subs`: Vimeo reporta estos como subtítulos disponibles,
> no como auto-subs, y con el flag equivocado no baja nada aunque el listado los muestre.

Resultado: `<titulo> [<id>].es-x-autogen.vtt`, que empieza con `WEBVTT`.

---

## Importar a Supabase

Destino: `public.course_lesson_transcripts`.

| Columna | Valor |
|---|---|
| `id` | estable y derivable, p. ej. `<lesson_id>-es` |
| `lesson_id` | FK a `course_lessons.id` (los ids son `catalog-lesson-<sha1 de 24>`, **39 caracteres**) |
| `language` | `es` |
| `transcript_text` | el `.vtt` convertido a texto plano, sin timestamps |
| `storage_path` | ruta del `.vtt` en el bucket privado `imperio-agentico-content` |
| `sort_order` | `0` |

Hay `unique (lesson_id, language)`, así que el insert va con
`on conflict (lesson_id, language) do update`.

Después del import, dos pasos que es fácil olvidar:

1. `update public.course_lessons set has_transcript = true where …` — el frontend usa ese flag para
   mostrar la pestaña de transcripción.
2. `select * from public.rebuild_course_search_documents(array['<curso>']);` — la búsqueda indexa el
   texto de las transcripciones; sin esto no aparecen en los resultados.

El acceso a los archivos del bucket se resuelve por curso: ver
[CONFIG.md](../CONFIG.md#-acceso-segmentado-por-curso).

---

## Estado y antecedentes

| Curso | Videos | Subtítulos |
|---|---|---|
| `whatsagenda-pro` | 18 | **18/18 descargados** el 2026-07-29 → `~/Downloads/whatsagenda-pro-vimeo/subtitles` en `ftt-2b-rocket`. Nunca se importaron a Supabase. |
| `poderosa-maquina-pacientes` | 64 | Confirmado que existen; **pendientes de descargar**. Los 64 mp4 están en `tmp/course-import/poderosa-maquina-pacientes/videos/` (8,2 GB). |

El trabajo original se hizo en el repo **`hotmart-har`** (`~/github/hotmart-har` en `ftt-2b-rocket`,
no está en GitHub). El nombre viene del método: se capturó un HAR de la sesión de Hotmart para
obtener los links completos, que quedaron en un JSON tipo
`/tmp/hotmart-lessons-details-<productId>`.

Producto en Hotmart de PMP: `3294505`, escuela `alumnos-la-poderosa-maquina-atraer-pacientes`.

---

## La API de Hotmart Club

El hash no hay que sacarlo clase por clase del DOM: la API lo entrega. Base:

```
https://api-club-course-consumption-gateway-ga.cb.hotmart.com
```

| Endpoint | Devuelve |
|---|---|
| `GET /v2/product/basic` | datos del producto (sirve para validar el token) |
| `GET /v1/navigation` | módulos y, dentro de cada uno, las `pages` con su `hash` |
| `GET /v2/web/lessons/<hash>` | el detalle de la clase, **con la URL del player y su `?h=`** |

Headers obligatorios: `slug`, `x-product-id`, `origin`/`referer` de hotmart.com y
`Authorization: Bearer <access_token>`. Sin token, 401.

El `access_token` se saca de un **HAR de una sesión autenticada**. Dura poco: el HAR del
2026-07-28 ya devuelve 401, así que hay que grabar uno nuevo cada vez.

### Cómo grabar el HAR

1. Chrome → DevTools (F12) → pestaña **Network** → activar **Preserve log**.
2. Navegar a una clase del curso y esperar a que **cargue el reproductor**. Esto importa: el token
   viaja en el header `Authorization` de las llamadas a la API, y si no se carga ninguna clase no
   queda ninguna.
3. Click derecho sobre la lista de requests → **Save all as HAR with content**.

> El HAR trae JWT, datos personales y URLs firmadas. **No subirlo a GitHub, Drive ni tickets.**
> `tmp/` está ignorado en este repo; guardarlo ahí o fuera del repositorio.

### Script

`scripts/hotmart_subtitulos.py` automatiza todo y nunca imprime el token:

```bash
# HAR -> JSON con las URLs de Vimeo con hash
python scripts/hotmart_subtitulos.py mapear \
  --har ~/Downloads/hotmart.com.har \
  --product-id 3294505 \
  --slug alumnos-la-poderosa-maquina-atraer-pacientes \
  --out tmp/pmp-vimeo-urls.json

# JSON -> archivos .vtt (solo subtitulos, sin bajar video)
python scripts/hotmart_subtitulos.py bajar \
  --mapa tmp/pmp-vimeo-urls.json \
  --out-dir tmp/pmp-subtitulos
```

Respeta una pausa de 1,5 s entre llamadas, como pide la guía original del método.

## Lo que falta

Un HAR fresco. Con eso, el resto es mecánico: correr las dos etapas del script, convertir los VTT a
texto, importar a `course_lesson_transcripts`, marcar `has_transcript` y reconstruir el índice.

---

## Gotchas encontrados

- **`--cookies-from-browser chrome` no sirve en Windows.** Chrome 127+ usa App-Bound Encryption y
  falla con `Failed to decrypt with DPAPI` (yt-dlp #10927). Antes de eso falla con
  `Could not copy Chrome cookie database` (#7271) si Chrome está abierto, y en Windows queda
  corriendo en segundo plano aunque cierres todas las ventanas. **No hace falta pelear con esto**:
  con el `?h=` no se necesitan cookies.
- **El referer no reemplaza al hash.** `--referer https://hotmart.com/` sobre `player.vimeo.com`
  sigue dando 401.
- **Hotmart ya no expone un iframe de Vimeo en el árbol de accesibilidad**; el hash hay que sacarlo
  del HTML, no buscando un `<iframe>`.
- **Hotmart dice "57 contenidos" pero el curso tiene 64 clases.** El contador de la plataforma no
  cuenta lo mismo; el árbol real de módulos sí da 64.
