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
- Después indica al usuario que cree la llave en `https://learn.techforce.cl/agents.html`; no le pidas que la pegue en el chat. El único comando que debe ejecutar el usuario es: `$key = Read-Host "Pega tu API key de LearnForce"; Set-Content -LiteralPath ([IO.Path]::Combine($HOME, '.config', 'learnforce', '.env')) -Value "LEARN_FORCE_API_KEY=$key"; Remove-Variable key`.
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
