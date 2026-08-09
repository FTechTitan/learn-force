#!/bin/sh
set -eu
query=${1:-}; mode=${2:-hybrid}; limit=${3:-10}; course_ids=${4:-}
[ -n "$query" ] || { echo 'Uso: search.sh "consulta" [hybrid|keyword|semantic] [limite] [course_ids_coma]' >&2; exit 2; }
case "$mode" in hybrid|keyword|semantic) ;; *) echo 'Modo invalido.' >&2; exit 2;; esac
env_file=${LEARN_FORCE_ENV_FILE:-"$HOME/.config/learnforce/.env"}; key=${LEARN_FORCE_API_KEY:-}
if [ -z "$key" ] && [ -f "$env_file" ]; then key=$(sed -n 's/^LEARN_FORCE_API_KEY=//p' "$env_file" | head -n 1 | tr -d '\r"' | sed "s/^'//;s/'$//"); fi
[ -n "$key" ] || { echo "LEARN_FORCE_API_KEY no esta definida en $env_file" >&2; exit 1; }
payload=$(LF_QUERY="$query" LF_LIMIT="$limit" LF_COURSE_IDS="$course_ids" osascript -l JavaScript -e 'ObjC.import("Foundation"); const env=$.NSProcessInfo.processInfo.environment; const body={query: ObjC.unwrap(env.objectForKey("LF_QUERY")), limit: Number(ObjC.unwrap(env.objectForKey("LF_LIMIT")))}; const raw=ObjC.unwrap(env.objectForKey("LF_COURSE_IDS")); if (raw) body.course_ids=raw.split(",").map(x => x.trim()).filter(Boolean); JSON.stringify(body)' 2>/dev/null)
curl --fail --silent --show-error -H "X-API-Key: $key" -H 'Content-Type: application/json' -d "$payload" "https://bipsvhxsvfzfwzufucfg.supabase.co/functions/v1/courses-api/v1/search/$mode"
