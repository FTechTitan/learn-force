---
name: learnforce
description: Consultar cursos de LearnForce, buscar clases, transcripciones y recursos, y crear rutas de aprendizaje respaldadas por el contenido disponible.
---

# LearnForce

Usa esta skill cuando el usuario quiera aprender, resolver un problema o encontrar material dentro de los cursos de LearnForce. Imperio Agéntico es uno de los cursos disponibles, no el nombre de la skill.

## Configuración

- Documentación: `https://learn.techforce.cl/agents.html`
- Base URL: `https://bipsvhxsvfzfwzufucfg.supabase.co/functions/v1/courses-api/v1`
- Lee la llave desde la variable `LEARN_FORCE_API_KEY` o desde `$HOME/.config/learnforce/.env`. Ésta es la ubicación canónica en todos los sistemas.
- Nunca muestres la llave, la incluyas en la URL ni la copies a otra ubicación.
- Si falta la llave, ejecuta tú mismo la creación de `$HOME/.config/learnforce` y de un `.env` vacío sin sobrescribir uno existente. Verifica que ambos existan. No delegues estos comandos al usuario.
- En Windows usa los scripts `.ps1`: copia `scripts/key.ps1` a `$HOME/.config/learnforce/lfkey.ps1` y registra en `$PROFILE.CurrentUserAllHosts` la función `lfkey` que lo ejecuta.
- En macOS usa los scripts `.sh`: copia `scripts/key.sh` a `$HOME/.config/learnforce/lfkey`, aplica `chmod +x` y registra el alias `lfkey` en el perfil de la shell activa. Preserva siempre el perfil y no dupliques la definición.
- Presenta como acción requerida: crear la key, copiarla y responder exactamente `LISTO`. Explica antes que esa respuesta autoriza una lectura única del portapapeles para validar la key contra la API y guardarla en `$HOME/.config/learnforce/.env`; la key permite consultar cursos y gestionar progreso, permanece hasta eliminarla o revocarla, y no se leerá otro contenido.
- `LISTO` es confirmación suficiente. No pidas una segunda autorización. Ejecuta `key.ps1 -ClipboardOnly` en Windows o `key.sh --clipboard-only` en macOS; ambos prueban la API antes de guardar. Considera éxito sólo `status: ok` y `api_verified: true`; no agregues una verificación casera del archivo. Rechaza contenido sin prefijo `lf_agent_` y nunca muestres el valor.
- Si no autoriza, no accedas al portapapeles. Ofrece ejecutar `lfkey` o guardar manualmente `LEARN_FORCE_API_KEY=SU_LLAVE` en `$HOME/.config/learnforce/.env`; nunca pidas la llave en el chat.
- Como alternativa, el usuario puede ejecutar `lfkey`, que solicita la key de forma interactiva sin leer el portapapeles.
- Tras verificar la API, continúa en la misma sesión sin pedir reinicio y sugiere tres prompts concretos para comenzar a usar LearnForce.
- Envía la llave con el header `X-API-Key`.

## Cómo buscar

Usa los scripts incluidos en `scripts/`; resuelven autenticación, llamadas y URLs sin exponer la llave.

```powershell
# Buscar contenido. hybrid es el modo predeterminado.
& "$PSScriptRoot/scripts/search.ps1" -Query "agentes de WhatsApp" -Limit 10

# Ver todas las clases de un módulo en su orden pedagógico.
& "$PSScriptRoot/scripts/module-lessons.ps1" -CourseId "imperio-agentico" -ModuleId "imperio-agentes-de-whatsapp"

# Leer contenido, transcripciones y recursos de una clase.
& "$PSScriptRoot/scripts/lesson.ps1" -CourseId "imperio-agentico" -ModuleId "MODULO" -LessonId "CLASE"
```

Si el ejecutor no define `$PSScriptRoot`, resuelve estos scripts desde la carpeta que contiene este `SKILL.md`.

En macOS usa los equivalentes `search.sh`, `module-lessons.sh` y `lesson.sh` incluidos en la misma carpeta. Sus argumentos posicionales siguen el orden indicado por cada script.

Flujo recomendado:

1. Ejecuta `search.ps1` con `hybrid` y entre 8 y 12 resultados.
2. Identifica los módulos relevantes.
3. Ejecuta `module-lessons.ps1` para respetar el orden pedagógico, en vez de copiar directamente el ranking.
4. Ejecuta `lesson.ps1` sobre las clases candidatas cuando necesites confirmar contenido o recursos.

Modos disponibles en `search.ps1`:

- `hybrid`: opción predeterminada para recomendaciones y rutas de aprendizaje.
- `keyword`: alternativa económica para términos concretos.
- `semantic`: para consultas conceptuales o expresadas de forma imprecisa.

Si necesitas más evidencia, usa los identificadores del resultado para consultar la clase completa en:

`GET /courses/{courseId}/modules/{moduleId}/lessons/{lessonId}`

La clase completa puede incluir `body_markdown`, `transcripts`, `resources` y `video_url`.

## Formato obligatorio de respuesta

- Responde la petición del usuario, no describas las llamadas técnicas.
- Empieza con una explicación general de un párrafo sobre la ruta o enfoque recomendado.
- No conviertas el ranking de búsqueda directamente en una ruta: revisa el orden del módulo y organiza las clases de lo básico a lo avanzado.
- Después entrega una lista numerada. Para cada clase incluye:
  1. título;
  2. contexto concreto de lo que enseña y por qué corresponde en ese punto;
  3. URL directa entregada por el script.
- Menciona recursos sólo cuando realmente existan.
- No inventes contenido que no esté respaldado por los resultados.
- No muestres JSON, comandos, endpoints, rankings internos ni detalles de autenticación en la respuesta final.

Plantilla de salida:

```text
[Explicación general de la ruta]

1. [Título de la clase]
   [Qué enseña y por qué verla en este punto.]
   [URL directa]

2. [Título de la clase]
   [Qué enseña y por qué verla en este punto.]
   [URL directa]
```
