# Hotmart + Vimeo: cómo recuperar los subtítulos de un curso

Guía reutilizable para cualquier curso de LearnForce importado desde Hotmart. Escrita después de
hacerlo completo sobre `poderosa-maquina-pacientes` el 2026-08-12; incluye lo que funcionó, lo que no,
y con qué evidencia, para no repetir callejones sin salida.

**Lo primero, para calibrar expectativas:** en el caso trabajado, de 64 clases solo **13** tenían
subtítulos. No es un problema de método — Vimeo no los generó para el resto. Verificalo temprano
(paso 3) antes de invertir tiempo.

---

## El problema de fondo

Los cursos que entraron a LearnForce desde una carpeta de Drive quedaron sin transcripciones:
`course_lesson_transcripts` vacía y un `body_markdown` de relleno (~300 caracteres con el título
repetido). El manifiesto del importador incluso lo audita:

```json
"transcript_source_audit": { "status": "not_found_in_original_source" }
```

Esa conclusión es correcta **para Drive**, que es una copia. El origen real es **Hotmart, con los
videos servidos por Vimeo**, y ahí a veces sí hay subtítulos autogenerados en español
(`es-x-autogen`, formato `.vtt`). Se reconoce el origen por el nombre del archivo, que conserva el
patrón de `yt-dlp` con el ID de Vimeo:

```
Bienvenida [861268366].mp4
```

---

## Procedimiento

### 1. Grabar el HAR

La API de Hotmart Club exige un `access_token` y **dura poco**: un HAR de dos semanas antes devolvió
401. Hay que grabar uno nuevo cada vez.

1. Chrome → DevTools (F12) → pestaña **Network** → activar **Preserve log**.
2. Navegar a una clase del curso y esperar a que **cargue el reproductor**. Esto importa: el token
   viaja en el header `Authorization` de las llamadas a la API, y si no se abre ninguna clase el HAR
   no lo trae.
3. Click derecho sobre la lista de requests → **Save all as HAR with content**.

> El HAR trae JWT, datos personales y URLs firmadas. **No subirlo a GitHub, Drive ni tickets.**
> `tmp/` está en el `.gitignore` de este repo; guardarlo ahí o fuera del repositorio.

### 2. Mapear las clases a sus URLs de Vimeo

```bash
python scripts/hotmart_subtitulos.py mapear \
  --har ~/Downloads/hotmart.com.har \
  --product-id 3294505 \
  --slug alumnos-la-poderosa-maquina-atraer-pacientes \
  --out tmp/pmp-vimeo-urls.json
```

El `product-id` y el `slug` salen de la URL del curso en Hotmart Club:
`hotmart.com/es/club/<slug>/products/<product-id>`.

El script valida el token contra `/v2/product/basic`, recorre `/v1/navigation` y consulta
`/v2/web/lessons/<hash>` por cada clase, con pausa de 1,5 s. Nunca imprime el token.

### 3. Medir cuántas tienen subtítulo *antes* de bajar nada

```bash
python -c "
import json
d = json.load(open('tmp/pmp-vimeo-urls.json', encoding='utf-8'))
print('clases:', len(d), '| descargables:', sum(1 for r in d if r['descargable']))
"
yt-dlp --list-subs "<una vimeo_url del JSON>"
```

Si `--list-subs` responde `has no subtitles`, ese video no tiene captions y no hay forma de
extraerlos: hay que generarlos con ASR. Probá tres o cuatro para estimar la cobertura real.

### 4. Descargar los `.vtt`

```bash
python scripts/hotmart_subtitulos.py bajar \
  --mapa tmp/pmp-vimeo-urls.json \
  --out-dir tmp/pmp-subtitulos
```

> Usar **`--write-subs`**, no `--write-auto-subs`: Vimeo los reporta como subtítulos disponibles, no
> como auto-subs, y con el flag equivocado no baja nada aunque el listado los muestre. El script ya
> lo hace bien; queda anotado porque es el error que costó una sesión entera en julio.

Ojo con el reporte: `yt-dlp` sale con código 0 aunque el video no tenga subtítulos, así que
"50 ok, 0 fallos" no significa 50 archivos. Contá los `.vtt` en disco.

### 5. Importar a Supabase

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

Después del import, dos pasos fáciles de olvidar:

1. `update public.course_lessons set has_transcript = true where …` — el frontend usa ese flag para
   mostrar la pestaña de transcripción.
2. `select * from public.rebuild_course_search_documents(array['<curso>']);` — sin esto las
   transcripciones no aparecen en la búsqueda.

El acceso a los archivos del bucket se resuelve por curso: ver
[CONFIG.md](../CONFIG.md#-acceso-segmentado-por-curso).

---

## La API de Hotmart Club

Base: `https://api-club-course-consumption-gateway-ga.cb.hotmart.com`

| Endpoint | Devuelve |
|---|---|
| `GET /v2/product/basic` | datos del producto; sirve para validar el token |
| `GET /v1/navigation` | módulos y, dentro de cada uno, las `pages` con su `hash` |
| `GET /v2/web/lessons/<hash>` | el detalle de la clase, con el HTML que contiene el embed |

Headers obligatorios: `slug`, `x-product-id`, `origin`/`referer` de hotmart.com y
`Authorization: Bearer <access_token>`. Sin token, 401.

`/v1/navigation` es además la **fuente canónica de la estructura del curso**: nombres reales de
módulos y orden. Sirve para corregir importaciones que quedaron con nombres inventados — así se
reestructuró PMP de 8 módulos mal numerados a los 11 reales.

---

## Las dos formas del embed

Cada clase trae el video como un iframe dentro de su HTML, y aparece de dos maneras:

```
con hash:  player.vimeo.com/video/<id>?h=<hash>              -> descargable
sin hash:  player.vimeo.com/video/<id>?badge=0&app_id=58479  -> 401 siempre
```

**No se puede anticipar por el `type` de la clase**: en PMP las 64 son `CONTENT` y aun así 50 traen
hash y 14 no. Hay que mirar el HTML de cada una, que es lo que hace el script.

Los videos sin hash son *unlisted con hash obligatorio*: no alcanza con el dominio. El script igual
guarda su `vimeo_id`, porque es el que llevan los mp4 locales en el nombre (`Título [<id>].mp4`) y
por ahí se mapea la clase a su archivo para transcribir.

---

## Callejones sin salida (verificados, no repetir)

| Intento | Resultado |
|---|---|
| `yt-dlp` sobre `vimeo.com/<id>` | 401 — la URL pelada nunca funciona |
| `player.vimeo.com/video/<id>` con `--referer` y `Origin` de hotmart | 401 |
| `GET /config?app_id=…` por curl con dos referers distintos | **403** — el recurso existe pero rechaza el origen; confirma que el hash es obligatorio |
| `fetch` al config desde la página de Hotmart | CORS impide leer la respuesta |
| Capturar la request del iframe con la extensión de Chrome | no ve subframes |
| Minar el HAR buscando hashes | solo trae los de las clases efectivamente abiertas |
| `--cookies-from-browser chrome` en Windows | `Failed to decrypt with DPAPI` (yt-dlp #10927): Chrome 127+ usa App-Bound Encryption. Antes falla con `Could not copy Chrome cookie database` (#7271) si Chrome está abierto — y en Windows sigue corriendo en segundo plano aunque cierres las ventanas. **Con el `?h=` no se necesitan cookies.** |
| Buscar pistas de subtítulos en los mp4 locales | `video_probe` muestra solo h264 + aac, sin pista de texto |
| API oficial `api.vimeo.com/videos/<id>/texttracks` | solo responde al dueño del video, que es el autor del curso |

**La única vía que queda para los embeds sin hash**: grabar un HAR con *Preserve log* mientras se
**reproduce** cada una de esas clases. DevTools sí captura subframes, así que la request del iframe
al config queda registrada. Evaluá si vale la pena: con una tasa de captions del 26%, abrir 14 clases
a mano rinde unos 3 o 4 archivos.

---

## Estado por curso

| Curso | Clases | Subtítulos |
|---|---|---|
| `poderosa-maquina-pacientes` | 64 | **13 descargados** en `tmp/pmp-subtitulos/`. Cubren completos el Módulo 7 (3/3), el Módulo 8 (6/6) y el BONO FanPage (4/4) — que son las clases más largas, así que en volumen de texto pesan mucho más que su proporción. 37 accesibles sin captions, 14 con embed sin hash. **Sin importar a Supabase todavía.** |
| `whatsagenda-pro` | 18 | **18/18 descargados** el 2026-07-29 → `~/Downloads/whatsagenda-pro-vimeo/subtitles` en `ftt-2b-rocket`. **Sin importar a Supabase todavía.** |

El trabajo original se hizo en el repo **`hotmart-har`** (`~/github/hotmart-har` en `ftt-2b-rocket`,
no está en GitHub): ahí viven `guia-hotmart-api.md` y `procedimiento-realizado-hotmart.md`. Los `.md`
y `.json` de ese repo guardan `vimeo_id` pero **no** los `?h=`: se sanitizaron a propósito por higiene
de secretos, así que no sirven para descargar.

---

## Cuando no hay subtítulos: ASR

Los mp4 están en `tmp/course-import/<curso>/videos/` (8,2 GB y 20,6 h en el caso de PMP), así que no
hay que bajar nada. Opciones, en orden de conveniencia:

- **Granolazo**: `scripts/learnforce-granolazo-transcribe.py` está hecho exactamente para esto y corre
  en el worker host, no en el PC de trabajo. Es la vía por defecto.
- **OpenAI** vía la skill `transcribe-audio` en modo rápido: ~US$0,006 por minuto.
- **faster-whisper local**: gratis, pero ≈1x tiempo real en CPU. No correrlo en el equipo de trabajo
  sin confirmación explícita.

El puente entre una clase y su archivo es el `vimeo_id` del JSON del paso 2, que aparece entre
corchetes en el nombre del mp4.
