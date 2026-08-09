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

Los tres endpoints aceptan `{ "query": "...", "limit": 10 }` y devuelven la misma estructura. `keyword` usa solo Full Text Search; `semantic` genera un embedding; `hybrid` combina ambos rankings. El piloto inicial indexa únicamente título, resumen, curso y módulo de 28 clases de WhatsApp.

Actualizar progreso:

```bash
curl -X PUT "$BASE_URL/progress/imperio-lesson-123" \
  -H "X-API-Key: $LEARN_FORCE_AGENT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"completed":true}'
```

## Respuestas y límites

Los éxitos usan `{ "data": ... }`; los errores usan `{ "error": { "code": "...", "message": "..." } }`. El límite inicial es 120 solicitudes por minuto por usuario o clave y se informa mediante `X-RateLimit-*`.
