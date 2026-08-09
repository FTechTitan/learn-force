#!/bin/sh
set -eu
[ "$#" -eq 2 ] || { echo 'Uso: module-lessons.sh COURSE_ID MODULE_ID' >&2; exit 2; }
course=$1; module=$2; env_file=${LEARN_FORCE_ENV_FILE:-"$HOME/.config/learnforce/.env"}; key=${LEARN_FORCE_API_KEY:-}
[ -n "$key" ] || key=$(sed -n 's/^LEARN_FORCE_API_KEY=//p' "$env_file" 2>/dev/null | head -n 1 | tr -d '\r"' | sed "s/^'//;s/'$//")
[ -n "$key" ] || { echo "LEARN_FORCE_API_KEY no esta definida en $env_file" >&2; exit 1; }
curl --fail --silent --show-error -H "X-API-Key: $key" "https://bipsvhxsvfzfwzufucfg.supabase.co/functions/v1/courses-api/v1/courses/$course/modules/$module/lessons"
