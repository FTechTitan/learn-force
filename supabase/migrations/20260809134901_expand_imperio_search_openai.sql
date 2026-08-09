-- Indice completo de Imperio Agentico para recuperacion por agentes.
-- OpenAI solo genera embeddings; pgvector ejecuta las consultas.
drop function if exists public.search_course_documents_keyword(text, integer);
drop function if exists public.search_course_documents_semantic(extensions.vector, integer);
drop table if exists public.course_search_documents;

create table public.course_search_documents (
  id text primary key,
  lesson_id text not null references public.course_lessons (id) on delete cascade,
  course_id text not null references public.courses (id) on delete cascade,
  module_id text not null,
  source_kind text not null check (source_kind in ('metadata', 'content', 'transcript', 'resource')),
  source_id text,
  chunk_index integer not null default 0,
  course_title text not null,
  module_title text not null,
  title text not null,
  summary text not null default '',
  content text not null,
  fts tsvector generated always as (
    setweight(to_tsvector('spanish', coalesce(title, '')), 'A') ||
    setweight(to_tsvector('spanish', coalesce(summary, '')), 'B') ||
    setweight(to_tsvector('spanish', coalesce(content, '')), 'B') ||
    setweight(to_tsvector('spanish', coalesce(module_title, '')), 'C') ||
    setweight(to_tsvector('spanish', coalesce(course_title, '')), 'D')
  ) stored,
  embedding extensions.vector(512),
  embedding_model text,
  embedded_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint course_search_documents_module_fk
    foreign key (module_id, course_id) references public.course_modules (id, course_id) on delete cascade
);

create index course_search_documents_fts_idx
  on public.course_search_documents using gin (fts);
create index course_search_documents_lesson_idx
  on public.course_search_documents (lesson_id, source_kind, chunk_index);
create index course_search_documents_embedding_idx
  on public.course_search_documents using hnsw (embedding extensions.vector_cosine_ops)
  where embedding is not null;

alter table public.course_search_documents enable row level security;
revoke all on public.course_search_documents from anon, authenticated;

-- Un documento corto por clase: tambien cubre clases sin transcripcion.
insert into public.course_search_documents (
  id, lesson_id, course_id, module_id, source_kind, chunk_index,
  course_title, module_title, title, summary, content
)
select
  l.id || ':metadata', l.id, l.course_id, l.module_id, 'metadata', 0,
  c.title, m.title, l.title, l.summary,
  concat_ws(E'\n', c.title, m.title, l.title, l.summary)
from public.course_lessons l
join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
join public.courses c on c.id = l.course_id
where l.course_id = 'imperio-agentico'
  and l.lesson_kind = 'lesson' and l.is_published and m.is_published and c.is_published;

-- Fragmentos de ~2.000 caracteres con 400 caracteres de solapamiento.
insert into public.course_search_documents (
  id, lesson_id, course_id, module_id, source_kind, source_id, chunk_index,
  course_title, module_title, title, summary, content
)
select
  l.id || ':content:' || chunk.n, l.id, l.course_id, l.module_id, 'content', l.id, chunk.n,
  c.title, m.title, l.title, l.summary,
  substring(trim(body.body_markdown) from 1 + (chunk.n * 1600) for 2000)
from public.course_lessons l
join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
join public.courses c on c.id = l.course_id
join public.course_lesson_contents body on body.lesson_id = l.id
cross join lateral generate_series(0, greatest(0, (length(trim(body.body_markdown)) - 1) / 1600)) chunk(n)
where l.course_id = 'imperio-agentico' and l.lesson_kind = 'lesson'
  and l.is_published and m.is_published and c.is_published
  and length(trim(body.body_markdown)) > 0;

insert into public.course_search_documents (
  id, lesson_id, course_id, module_id, source_kind, source_id, chunk_index,
  course_title, module_title, title, summary, content
)
select
  t.id || ':transcript:' || chunk.n, l.id, l.course_id, l.module_id, 'transcript', t.id, chunk.n,
  c.title, m.title, l.title, l.summary,
  substring(trim(t.transcript_text) from 1 + (chunk.n * 1600) for 2000)
from public.course_lesson_transcripts t
join public.course_lessons l on l.id = t.lesson_id
join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
join public.courses c on c.id = l.course_id
cross join lateral generate_series(0, greatest(0, (length(trim(t.transcript_text)) - 1) / 1600)) chunk(n)
where l.course_id = 'imperio-agentico' and l.lesson_kind = 'lesson'
  and l.is_published and m.is_published and c.is_published
  and length(trim(t.transcript_text)) > 0;

insert into public.course_search_documents (
  id, lesson_id, course_id, module_id, source_kind, source_id, chunk_index,
  course_title, module_title, title, summary, content
)
select
  r.id || ':resource', l.id, l.course_id, l.module_id, 'resource', r.id, 0,
  c.title, m.title, l.title, l.summary,
  concat_ws(E'\n', 'Recurso de la clase', r.title, r.kind, r.mime_type)
from public.course_lesson_resources r
join public.course_lessons l on l.id = r.lesson_id
join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
join public.courses c on c.id = l.course_id
where l.course_id = 'imperio-agentico' and l.lesson_kind = 'lesson'
  and r.is_published and l.is_published and m.is_published and c.is_published;

create function public.search_course_documents_keyword(p_query text, p_limit integer default 10)
returns table (
  document_id text, lesson_id text, course_id text, module_id text, source_kind text,
  chunk_index integer, course_title text, module_title text, title text, summary text,
  content text, score real
)
language sql stable set search_path = '' as $$
  with query as (
    select websearch_to_tsquery('spanish', regexp_replace(trim(p_query), '\s+', ' OR ', 'g')) value
  )
  select d.id, d.lesson_id, d.course_id, d.module_id, d.source_kind, d.chunk_index,
    d.course_title, d.module_title, d.title, d.summary, d.content,
    ts_rank_cd(d.fts, query.value, 32)::real
  from public.course_search_documents d cross join query
  where d.fts @@ query.value
  order by ts_rank_cd(d.fts, query.value, 32) desc, d.title, d.chunk_index
  limit least(greatest(p_limit, 1), 50);
$$;

create function public.search_course_documents_semantic(
  p_embedding extensions.vector(512), p_limit integer default 10
)
returns table (
  document_id text, lesson_id text, course_id text, module_id text, source_kind text,
  chunk_index integer, course_title text, module_title text, title text, summary text,
  content text, score real
)
language sql stable set search_path = '' as $$
  select d.id, d.lesson_id, d.course_id, d.module_id, d.source_kind, d.chunk_index,
    d.course_title, d.module_title, d.title, d.summary, d.content,
    (1 - (d.embedding OPERATOR(extensions.<=>) p_embedding))::real
  from public.course_search_documents d
  where d.embedding is not null
  order by d.embedding OPERATOR(extensions.<=>) p_embedding
  limit least(greatest(p_limit, 1), 50);
$$;

revoke all on function public.search_course_documents_keyword(text, integer) from public, anon, authenticated;
revoke all on function public.search_course_documents_semantic(extensions.vector, integer) from public, anon, authenticated;
grant execute on function public.search_course_documents_keyword(text, integer) to service_role;
grant execute on function public.search_course_documents_semantic(extensions.vector, integer) to service_role;

comment on table public.course_search_documents is
  'Fragmentos buscables de Imperio Agentico. Embeddings OpenAI text-embedding-3-small de 512 dimensiones.';
