# API REST de cursos para agentes

Base URL:

```text
https://bipsvhxsvfzfwzufucfg.supabase.co/functions/v1/courses-api/v1
```

La API devuelve únicamente contenido publicado y exige que el usuario tenga acceso aprobado al catálogo. Los recursos y SRT privados se entregan mediante enlaces firmados válidos durante una hora.

## Autenticación

Durante una sesión web, usa el access token de Supabase:

```http
Authorization: Bearer <access_token>
```

Para un agente persistente, crea una clave personal usando primero un JWT de usuario:

```bash
curl -X POST "$BASE_URL/api-keys" \
  -H "Authorization: Bearer $SUPABASE_USER_JWT" \
  -H "Content-Type: application/json" \
  -d '{"name":"Mi agente","expires_at":"2026-12-31T23:59:59Z"}'
```

La propiedad `data.key` aparece una sola vez. Guárdala como secreto del agente y úsala así:

```http
X-API-Key: lf_agent_...
```

Nunca incluyas la clave en una URL. Para listar o revocar claves se requiere nuevamente el JWT del usuario:

```text
GET    /api-keys
DELETE /api-keys/{key_id}
```

## Endpoints

```text
GET /me
GET /courses
GET /courses/{course_id}
GET /courses/{course_id}/modules
GET /courses/{course_id}/modules/{module_id}
GET /courses/{course_id}/modules/{module_id}/lessons
GET /courses/{course_id}/modules/{module_id}/lessons/{lesson_id}
GET /progress
PUT /progress/{item_id}
POST /search/keyword
POST /search/semantic
POST /search/hybrid
```

La consulta de una clase devuelve en una sola respuesta `body_markdown`, `transcripts` y `resources`, además de sus metadatos y video.

### Búsqueda

Los tres endpoints aceptan `{ "query": "...", "limit": 10 }` y devuelven la misma estructura. `keyword` usa solo Full Text Search; `semantic` genera un embedding con `text-embedding-3-small`; `hybrid` combina ambos rankings.

Tambien aceptan `course_ids` opcional para limitar la busqueda. Sin `course_ids`, la API busca en todos los cursos accesibles del usuario. Con un curso, busca exclusivamente dentro de ese curso. Con varios cursos, cruza el conocimiento y devuelve un ranking conjunto. Los IDs inexistentes o no accesibles se ignoran sin revelar informacion privada.

```json
{
  "query": "como captar pacientes usando WhatsApp",
  "limit": 10,
  "course_ids": ["poderosa-maquina-pacientes", "whatsagenda-pro"]
}
```

El indice cubre los cursos publicados accesibles: titulos, resumenes, contenido, transcripciones fragmentadas cuando existen y nombres de recursos. Cada resultado informa `source_kind`, `chunk_index` y `excerpt`, para que el agente pueda citar la evidencia encontrada. `next_action.path` permite solicitar despues la clase completa, que integra video, transcripciones y recursos.

Los vectores se generan con OpenAI y se almacenan y consultan en Supabase mediante pgvector. Learn Force no genera la respuesta final: esa responsabilidad corresponde al agente consumidor.

El indice multi-curso cubre Imperio Agentico, La Poderosa Maquina de Pacientes, WhatsAgenda Pro y CAR: titulos, resumenes, contenido, transcripciones fragmentadas cuando existen y recursos con contexto textual. Cada resultado informa `course_id`, `module_id`, `lesson_id`, `source_kind`, `chunk_index`, `excerpt` y `web_url`.

### Prompts para copiar y pegar

```text
Dime cuáles son las 5 clases más importantes para aprender [tema]. Ordénalas y explícame brevemente por qué debería ver cada una.
```

```text
Dime cómo me recomiendas hacer [objetivo] de acuerdo con el curso Imperio Agéntico. Dame los pasos y las clases que debería consultar.
```

```text
Quiero aprender [tema] desde cero. Créame una ruta de aprendizaje usando las clases de Imperio Agéntico, desde la más básica hasta la más avanzada.
```

```text
Tengo este problema: [describe el problema]. Busca en Imperio Agéntico las clases y recursos que me pueden ayudar y recomiéndame qué hacer primero.
```

```text
Busca solo en La Poderosa Maquina de Pacientes como captar pacientes.
```

```text
Compara lo que ensenan WhatsAgenda Pro y La Poderosa Maquina de Pacientes sobre WhatsApp.
```

```text
Usando todos mis cursos, recomiendame una ruta para captar, responder y agendar pacientes.
```

```text
Busca en CAR e Imperio Agentico como validar y automatizar un nuevo servicio.
```

Actualizar progreso:

```bash
curl -X PUT "$BASE_URL/progress/imperio-lesson-123" \
  -H "X-API-Key: $LEARN_FORCE_AGENT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"completed":true}'
```

## Respuestas y límites

Los éxitos usan `{ "data": ... }`; los errores usan `{ "error": { "code": "...", "message": "..." } }`. El límite inicial es 120 solicitudes por minuto por usuario o clave y se informa mediante `X-RateLimit-*`.
