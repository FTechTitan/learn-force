#!/bin/sh
set -eu
config="$HOME/.config/learnforce"; env_file="$config/.env"; mkdir -p "$config"
if [ "${1:-}" = "--clipboard-only" ]; then
  command -v pbpaste >/dev/null 2>&1 || { echo 'pbpaste no esta disponible.' >&2; exit 1; }
  key=$(pbpaste | tr -d '\r\n')
else
  printf 'Pega tu API key de LearnForce: ' >&2; stty -echo; IFS= read -r key; stty echo; printf '\n' >&2
fi
case "$key" in lf_agent_????????????????*) ;; *) echo 'La API key no tiene un formato valido.' >&2; exit 1;; esac
status=$(curl --silent --output /dev/null --write-out '%{http_code}' -H "X-API-Key: $key" 'https://bipsvhxsvfzfwzufucfg.supabase.co/functions/v1/courses-api/v1/me')
[ "$status" = 200 ] || { echo 'La API rechazo la key. No se guardo.' >&2; exit 1; }
umask 077; printf 'LEARN_FORCE_API_KEY=%s\n' "$key" > "$env_file"; unset key
printf '{"status":"ok","api_verified":true,"env_file":"%s"}\n' "$env_file"
