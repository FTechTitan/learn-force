-- Claves personales para agentes. El secreto nunca se persiste: solo SHA-256.
create table if not exists public.agent_api_keys (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  name text not null check (char_length(name) between 1 and 80),
  key_prefix text not null,
  key_hash text not null unique,
  last_used_at timestamptz,
  expires_at timestamptz,
  revoked_at timestamptz,
  created_at timestamptz not null default now()
);

create index if not exists agent_api_keys_user_created_idx
  on public.agent_api_keys (user_id, created_at desc);

alter table public.agent_api_keys enable row level security;
revoke all on public.agent_api_keys from anon, authenticated;

-- Ventanas simples de rate limiting. Solo la Edge Function accede con service role.
create table if not exists public.agent_api_rate_limits (
  subject text not null,
  window_started_at timestamptz not null,
  request_count integer not null default 0 check (request_count >= 0),
  primary key (subject, window_started_at)
);

alter table public.agent_api_rate_limits enable row level security;
revoke all on public.agent_api_rate_limits from anon, authenticated;

comment on table public.agent_api_keys is
  'Claves personales revocables para consumir courses-api; solo se almacena su hash SHA-256.';
