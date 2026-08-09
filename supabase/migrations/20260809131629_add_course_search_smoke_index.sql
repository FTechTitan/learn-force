-- Piloto de búsqueda: 28 clases de los módulos de WhatsApp, sin transcripciones.
create extension if not exists vector with schema extensions;

create table if not exists public.course_search_documents (
  lesson_id text primary key references public.course_lessons (id) on delete cascade,
  course_id text not null references public.courses (id) on delete cascade,
  module_id text not null,
  course_title text not null,
  module_title text not null,
  title text not null,
  summary text not null default '',
  search_text text not null,
  fts tsvector generated always as (to_tsvector('spanish', search_text)) stored,
  embedding extensions.vector(384),
  embedded_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint course_search_documents_module_fk
    foreign key (module_id, course_id) references public.course_modules (id, course_id) on delete cascade
);

create index if not exists course_search_documents_fts_idx
  on public.course_search_documents using gin (fts);

alter table public.course_search_documents enable row level security;
revoke all on public.course_search_documents from anon, authenticated;

insert into public.course_search_documents (
  lesson_id, course_id, module_id, course_title, module_title, title, summary, search_text
)
select
  l.id,
  l.course_id,
  l.module_id,
  c.title,
  m.title,
  l.title,
  l.summary,
  concat_ws(E'\n', c.title, m.title, l.title, l.summary)
from public.course_lessons l
join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
join public.courses c on c.id = l.course_id
where l.course_id = 'imperio-agentico'
  and l.module_id in ('imperio-agentes-de-whatsapp', 'imperio-dashboard-agentes-de-whatsapp')
  and l.lesson_kind = 'lesson'
  and l.is_published
  and m.is_published
  and c.is_published
on conflict (lesson_id) do update set
  course_title = excluded.course_title,
  module_title = excluded.module_title,
  title = excluded.title,
  summary = excluded.summary,
  search_text = excluded.search_text,
  embedding = case
    when public.course_search_documents.search_text = excluded.search_text then public.course_search_documents.embedding
    else null
  end,
  embedded_at = case
    when public.course_search_documents.search_text = excluded.search_text then public.course_search_documents.embedded_at
    else null
  end,
  updated_at = now();

create or replace function public.search_course_documents_keyword(
  p_query text,
  p_limit integer default 10
)
returns table (
  lesson_id text, course_id text, module_id text, course_title text, module_title text,
  title text, summary text, score real
)
language sql
stable
set search_path = ''
as $$
  select d.lesson_id, d.course_id, d.module_id, d.course_title, d.module_title,
    d.title, d.summary,
    ts_rank_cd(d.fts, websearch_to_tsquery('spanish', p_query), 32)::real as score
  from public.course_search_documents d
  where d.fts @@ websearch_to_tsquery('spanish', p_query)
  order by score desc, d.title
  limit least(greatest(p_limit, 1), 25);
$$;

create or replace function public.search_course_documents_semantic(
  p_embedding extensions.vector(384),
  p_limit integer default 10
)
returns table (
  lesson_id text, course_id text, module_id text, course_title text, module_title text,
  title text, summary text, score real
)
language sql
stable
set search_path = ''
as $$
  select d.lesson_id, d.course_id, d.module_id, d.course_title, d.module_title,
    d.title, d.summary,
    (-(d.embedding OPERATOR(extensions.<#>) p_embedding))::real as score
  from public.course_search_documents d
  where d.embedding is not null
  order by d.embedding OPERATOR(extensions.<#>) p_embedding
  limit least(greatest(p_limit, 1), 25);
$$;

revoke all on function public.search_course_documents_keyword(text, integer) from public, anon, authenticated;
revoke all on function public.search_course_documents_semantic(extensions.vector, integer) from public, anon, authenticated;
grant execute on function public.search_course_documents_keyword(text, integer) to service_role;
grant execute on function public.search_course_documents_semantic(extensions.vector, integer) to service_role;

comment on table public.course_search_documents is
  'Índice piloto de búsqueda para agentes. Contexto limitado a metadatos de 28 clases de WhatsApp.';
