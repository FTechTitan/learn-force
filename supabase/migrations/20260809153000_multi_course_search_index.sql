-- Generaliza el indice de busqueda para todos los cursos publicados que usan
-- clases normalizadas y para cursos historicos cargados como modulos.

create extension if not exists vector with schema extensions;

alter table public.course_search_documents
  drop constraint if exists course_search_documents_source_kind_check;

alter table public.course_search_documents
  add constraint course_search_documents_source_kind_check
  check (source_kind in ('metadata', 'content', 'transcript', 'resource'));

-- Cursos cargados antes de course_lessons: cada modulo publicado pasa a tener
-- una clase sintetica estable para exponer URL directa e indexar su teoria.
insert into public.course_lessons (
  id, course_id, module_id, source_path, title, summary, lesson_kind,
  sort_order, has_transcript, is_published
)
select
  m.id || '-lesson',
  m.course_id,
  m.id,
  'synthetic-module/' || m.id,
  m.title,
  coalesce(nullif(trim(m.intro), ''), 'Clase del modulo ' || m.title || '.'),
  'lesson',
  m.sort_order,
  false,
  true
from public.course_modules m
join public.courses c on c.id = m.course_id
where m.course_id in (
    'poderosa-maquina-pacientes',
    'whatsagenda-pro',
    'car-ecosistema-startup'
  )
  and m.is_published
  and c.is_published
on conflict (id) do update set
  course_id = excluded.course_id,
  module_id = excluded.module_id,
  source_path = excluded.source_path,
  title = excluded.title,
  summary = excluded.summary,
  lesson_kind = excluded.lesson_kind,
  sort_order = excluded.sort_order,
  has_transcript = excluded.has_transcript,
  is_published = excluded.is_published,
  updated_at = now();

insert into public.course_lesson_contents (lesson_id, body_markdown)
select
  m.id || '-lesson',
  concat_ws(E'\n\n',
    nullif(trim(m.intro), ''),
    nullif(trim(m.overview_markdown), ''),
    nullif(trim(m.theory), '')
  )
from public.course_modules m
join public.courses c on c.id = m.course_id
where m.course_id in (
    'poderosa-maquina-pacientes',
    'whatsagenda-pro',
    'car-ecosistema-startup'
  )
  and m.is_published
  and c.is_published
  and length(trim(concat_ws(E'\n\n', m.intro, m.overview_markdown, m.theory))) > 0
on conflict (lesson_id) do update set
  body_markdown = excluded.body_markdown,
  updated_at = now();

create or replace function public.rebuild_course_search_documents(p_course_ids text[])
returns table (
  course_id text,
  documents integer,
  without_embedding integer
)
language plpgsql
set search_path = ''
as $$
begin
  insert into public.course_search_documents (
    id, lesson_id, course_id, module_id, source_kind, source_id, chunk_index,
    course_title, module_title, title, summary, content
  )
  select
    l.id || ':metadata',
    l.id,
    l.course_id,
    l.module_id,
    'metadata',
    l.id,
    0,
    c.title,
    m.title,
    l.title,
    l.summary,
    concat_ws(E'\n',
      'Curso: ' || c.title,
      'Modulo: ' || m.title,
      'Clase: ' || l.title,
      nullif(l.summary, '')
    )
  from public.course_lessons l
  join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
  join public.courses c on c.id = l.course_id
  where l.course_id = any(p_course_ids)
    and l.lesson_kind = 'lesson'
    and l.is_published
    and m.is_published
    and c.is_published
    and length(trim(concat_ws(E'\n', c.title, m.title, l.title, l.summary))) > 0
  on conflict (id) do update set
    lesson_id = excluded.lesson_id,
    course_id = excluded.course_id,
    module_id = excluded.module_id,
    source_kind = excluded.source_kind,
    source_id = excluded.source_id,
    chunk_index = excluded.chunk_index,
    course_title = excluded.course_title,
    module_title = excluded.module_title,
    title = excluded.title,
    summary = excluded.summary,
    content = excluded.content,
    embedding = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding else null end,
    embedding_model = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding_model else null end,
    embedded_at = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedded_at else null end,
    updated_at = now();

  insert into public.course_search_documents (
    id, lesson_id, course_id, module_id, source_kind, source_id, chunk_index,
    course_title, module_title, title, summary, content
  )
  select
    l.id || ':content:' || chunk.n,
    l.id,
    l.course_id,
    l.module_id,
    'content',
    l.id,
    chunk.n,
    c.title,
    m.title,
    l.title,
    l.summary,
    substring(trim(body.body_markdown) from 1 + (chunk.n * 1600) for 2000)
  from public.course_lessons l
  join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
  join public.courses c on c.id = l.course_id
  join public.course_lesson_contents body on body.lesson_id = l.id
  cross join lateral generate_series(0, greatest(0, (length(trim(body.body_markdown)) - 1) / 1600)) chunk(n)
  where l.course_id = any(p_course_ids)
    and l.lesson_kind = 'lesson'
    and l.is_published
    and m.is_published
    and c.is_published
    and length(trim(body.body_markdown)) > 0
  on conflict (id) do update set
    lesson_id = excluded.lesson_id,
    course_id = excluded.course_id,
    module_id = excluded.module_id,
    source_kind = excluded.source_kind,
    source_id = excluded.source_id,
    chunk_index = excluded.chunk_index,
    course_title = excluded.course_title,
    module_title = excluded.module_title,
    title = excluded.title,
    summary = excluded.summary,
    content = excluded.content,
    embedding = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding else null end,
    embedding_model = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding_model else null end,
    embedded_at = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedded_at else null end,
    updated_at = now();

  insert into public.course_search_documents (
    id, lesson_id, course_id, module_id, source_kind, source_id, chunk_index,
    course_title, module_title, title, summary, content
  )
  select
    t.id || ':transcript:' || chunk.n,
    l.id,
    l.course_id,
    l.module_id,
    'transcript',
    t.id,
    chunk.n,
    c.title,
    m.title,
    l.title,
    l.summary,
    substring(trim(t.transcript_text) from 1 + (chunk.n * 1600) for 2000)
  from public.course_lesson_transcripts t
  join public.course_lessons l on l.id = t.lesson_id
  join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
  join public.courses c on c.id = l.course_id
  cross join lateral generate_series(0, greatest(0, (length(trim(t.transcript_text)) - 1) / 1600)) chunk(n)
  where l.course_id = any(p_course_ids)
    and l.lesson_kind = 'lesson'
    and l.is_published
    and m.is_published
    and c.is_published
    and length(trim(t.transcript_text)) > 0
  on conflict (id) do update set
    lesson_id = excluded.lesson_id,
    course_id = excluded.course_id,
    module_id = excluded.module_id,
    source_kind = excluded.source_kind,
    source_id = excluded.source_id,
    chunk_index = excluded.chunk_index,
    course_title = excluded.course_title,
    module_title = excluded.module_title,
    title = excluded.title,
    summary = excluded.summary,
    content = excluded.content,
    embedding = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding else null end,
    embedding_model = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding_model else null end,
    embedded_at = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedded_at else null end,
    updated_at = now();

  insert into public.course_search_documents (
    id, lesson_id, course_id, module_id, source_kind, source_id, chunk_index,
    course_title, module_title, title, summary, content
  )
  select
    r.id || ':resource',
    l.id,
    l.course_id,
    l.module_id,
    'resource',
    r.id,
    0,
    c.title,
    m.title,
    l.title,
    l.summary,
    concat_ws(E'\n', 'Recurso de la clase', r.title, r.kind, r.mime_type)
  from public.course_lesson_resources r
  join public.course_lessons l on l.id = r.lesson_id
  join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
  join public.courses c on c.id = l.course_id
  where l.course_id = any(p_course_ids)
    and l.lesson_kind = 'lesson'
    and r.is_published
    and l.is_published
    and m.is_published
    and c.is_published
    and length(trim(concat_ws(E'\n', r.title, r.kind, r.mime_type))) > 0
  on conflict (id) do update set
    lesson_id = excluded.lesson_id,
    course_id = excluded.course_id,
    module_id = excluded.module_id,
    source_kind = excluded.source_kind,
    source_id = excluded.source_id,
    chunk_index = excluded.chunk_index,
    course_title = excluded.course_title,
    module_title = excluded.module_title,
    title = excluded.title,
    summary = excluded.summary,
    content = excluded.content,
    embedding = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding else null end,
    embedding_model = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding_model else null end,
    embedded_at = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedded_at else null end,
    updated_at = now();

  insert into public.course_search_documents (
    id, lesson_id, course_id, module_id, source_kind, source_id, chunk_index,
    course_title, module_title, title, summary, content
  )
  select
    i.id || ':resource',
    m.id || '-lesson',
    i.course_id,
    i.module_id,
    'resource',
    i.id,
    0,
    c.title,
    m.title,
    i.title,
    coalesce(nullif(trim(m.intro), ''), ''),
    concat_ws(E'\n',
      'Actividad del modulo',
      i.title,
      nullif(i.statement_html, ''),
      nullif(i.hint, ''),
      nullif(i.explanation, ''),
      nullif(i.solution_html, ''),
      nullif(i.steps::text, '[]')
    )
  from public.course_items i
  join public.course_modules m on m.id = i.module_id and m.course_id = i.course_id
  join public.courses c on c.id = i.course_id
  join public.course_lessons l on l.id = m.id || '-lesson'
  where i.course_id = any(p_course_ids)
    and i.is_published
    and m.is_published
    and c.is_published
    and length(trim(concat_ws(E'\n',
      i.title, i.statement_html, i.hint, i.explanation, i.solution_html, i.steps::text
    ))) > 0
  on conflict (id) do update set
    lesson_id = excluded.lesson_id,
    course_id = excluded.course_id,
    module_id = excluded.module_id,
    source_kind = excluded.source_kind,
    source_id = excluded.source_id,
    chunk_index = excluded.chunk_index,
    course_title = excluded.course_title,
    module_title = excluded.module_title,
    title = excluded.title,
    summary = excluded.summary,
    content = excluded.content,
    embedding = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding else null end,
    embedding_model = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedding_model else null end,
    embedded_at = case when public.course_search_documents.content = excluded.content then public.course_search_documents.embedded_at else null end,
    updated_at = now();

  with expected as (
    select l.id || ':metadata' as id
    from public.course_lessons l
    join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
    join public.courses c on c.id = l.course_id
    where l.course_id = any(p_course_ids)
      and l.lesson_kind = 'lesson' and l.is_published and m.is_published and c.is_published
      and length(trim(concat_ws(E'\n', c.title, m.title, l.title, l.summary))) > 0
    union
    select l.id || ':content:' || chunk.n
    from public.course_lessons l
    join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
    join public.courses c on c.id = l.course_id
    join public.course_lesson_contents body on body.lesson_id = l.id
    cross join lateral generate_series(0, greatest(0, (length(trim(body.body_markdown)) - 1) / 1600)) chunk(n)
    where l.course_id = any(p_course_ids)
      and l.lesson_kind = 'lesson' and l.is_published and m.is_published and c.is_published
      and length(trim(body.body_markdown)) > 0
    union
    select t.id || ':transcript:' || chunk.n
    from public.course_lesson_transcripts t
    join public.course_lessons l on l.id = t.lesson_id
    join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
    join public.courses c on c.id = l.course_id
    cross join lateral generate_series(0, greatest(0, (length(trim(t.transcript_text)) - 1) / 1600)) chunk(n)
    where l.course_id = any(p_course_ids)
      and l.lesson_kind = 'lesson' and l.is_published and m.is_published and c.is_published
      and length(trim(t.transcript_text)) > 0
    union
    select r.id || ':resource'
    from public.course_lesson_resources r
    join public.course_lessons l on l.id = r.lesson_id
    join public.course_modules m on m.id = l.module_id and m.course_id = l.course_id
    join public.courses c on c.id = l.course_id
    where l.course_id = any(p_course_ids)
      and l.lesson_kind = 'lesson' and r.is_published and l.is_published and m.is_published and c.is_published
      and length(trim(concat_ws(E'\n', r.title, r.kind, r.mime_type))) > 0
    union
    select i.id || ':resource'
    from public.course_items i
    join public.course_modules m on m.id = i.module_id and m.course_id = i.course_id
    join public.courses c on c.id = i.course_id
    join public.course_lessons l on l.id = m.id || '-lesson'
    where i.course_id = any(p_course_ids)
      and i.is_published and m.is_published and c.is_published
      and length(trim(concat_ws(E'\n', i.title, i.statement_html, i.hint, i.explanation, i.solution_html, i.steps::text))) > 0
  )
  delete from public.course_search_documents d
  where d.course_id = any(p_course_ids)
    and not exists (select 1 from expected e where e.id = d.id);

  return query
  select
    d.course_id,
    count(*)::integer as documents,
    count(*) filter (where d.embedding is null)::integer as without_embedding
  from public.course_search_documents d
  where d.course_id = any(p_course_ids)
  group by d.course_id
  order by d.course_id;
end;
$$;

revoke all on function public.rebuild_course_search_documents(text[]) from public, anon, authenticated;
grant execute on function public.rebuild_course_search_documents(text[]) to service_role;

select * from public.rebuild_course_search_documents(array[
  'poderosa-maquina-pacientes',
  'whatsagenda-pro',
  'car-ecosistema-startup'
]);

drop function if exists public.search_course_documents_keyword(text, integer);
drop function if exists public.search_course_documents_keyword(text, integer, text[]);
drop function if exists public.search_course_documents_semantic(extensions.vector, integer, boolean);
drop function if exists public.search_course_documents_semantic(extensions.vector, integer, boolean, text[]);

create function public.search_course_documents_keyword(
  p_query text,
  p_limit integer default 10,
  p_course_ids text[] default null
)
returns table (
  document_id text, lesson_id text, course_id text, module_id text, source_kind text,
  chunk_index integer, course_title text, module_title text, title text, summary text,
  content text, score real
)
language sql stable set search_path = '' as $$
  with params as (
    select
      websearch_to_tsquery('spanish', regexp_replace(trim(p_query), '\s+', ' OR ', 'g')) as query,
      lower(p_query) ~ '(aprender|desde cero|comenzar|empezar|ruta|clases?|curso|estudiar)' as learning_intent
  ),
  candidates as materialized (
    select d.*, ts_rank_cd(d.fts, params.query, 32)::real as relevance,
      params.learning_intent
    from public.course_search_documents d cross join params
    where d.fts @@ params.query
      and (p_course_ids is null or d.course_id = any(p_course_ids))
    order by relevance desc
    limit least(greatest(p_limit * 30, 150), 700)
  ),
  scored as (
    select candidates.*,
      relevance
      + case source_kind when 'metadata' then 0.04 when 'content' then 0.02 else 0 end
      + case when learning_intent and lower(title) ~
          '(introducci[oó]n|bienvenida|empieza aqu[ií]|lo que vas a construir|empezando|estrategia)'
        then 0.10 else 0 end
      + case when learning_intent and lower(module_title) ~
          '(soporte|grabaciones|biblioteca)'
        then -0.12 else 0 end as final_score
    from candidates
  ),
  ranked as (
    select scored.*,
      row_number() over (
        partition by lesson_id
        order by final_score desc,
          case source_kind when 'metadata' then 0 when 'content' then 1 when 'transcript' then 2 else 3 end,
          chunk_index
      ) as lesson_rank
    from scored
  )
  select id, lesson_id, course_id, module_id, source_kind, chunk_index,
    course_title, module_title, title, summary, content, final_score::real
  from ranked
  where lesson_rank = 1
  order by final_score desc, title
  limit least(greatest(p_limit, 1), 50);
$$;

create function public.search_course_documents_semantic(
  p_embedding extensions.vector(512),
  p_limit integer default 10,
  p_learning_intent boolean default false,
  p_course_ids text[] default null
)
returns table (
  document_id text, lesson_id text, course_id text, module_id text, source_kind text,
  chunk_index integer, course_title text, module_title text, title text, summary text,
  content text, score real
)
language sql stable set search_path = '' as $$
  with candidates as materialized (
    select d.*,
      (1 - (d.embedding OPERATOR(extensions.<=>) p_embedding))::real as relevance
    from public.course_search_documents d
    where d.embedding is not null
      and (p_course_ids is null or d.course_id = any(p_course_ids))
    order by d.embedding OPERATOR(extensions.<=>) p_embedding
    limit least(greatest(p_limit * 30, 150), 700)
  ),
  scored as (
    select candidates.*,
      relevance
      + case source_kind when 'metadata' then 0.04 when 'content' then 0.02 else 0 end
      + case when p_learning_intent and lower(title) ~
          '(introducci[oó]n|bienvenida|empieza aqu[ií]|lo que vas a construir|empezando|estrategia)'
        then 0.10 else 0 end
      + case when p_learning_intent and lower(module_title) ~
          '(soporte|grabaciones|biblioteca)'
        then -0.12 else 0 end as final_score
    from candidates
  ),
  ranked as (
    select scored.*,
      row_number() over (
        partition by lesson_id
        order by final_score desc,
          case source_kind when 'metadata' then 0 when 'content' then 1 when 'transcript' then 2 else 3 end,
          chunk_index
      ) as lesson_rank
    from scored
  )
  select id, lesson_id, course_id, module_id, source_kind, chunk_index,
    course_title, module_title, title, summary, content, final_score::real
  from ranked
  where lesson_rank = 1
  order by final_score desc, title
  limit least(greatest(p_limit, 1), 50);
$$;

revoke all on function public.search_course_documents_keyword(text, integer, text[]) from public, anon, authenticated;
revoke all on function public.search_course_documents_semantic(extensions.vector, integer, boolean, text[]) from public, anon, authenticated;
grant execute on function public.search_course_documents_keyword(text, integer, text[]) to service_role;
grant execute on function public.search_course_documents_semantic(extensions.vector, integer, boolean, text[]) to service_role;

comment on table public.course_search_documents is
  'Fragmentos buscables multi-curso. Embeddings OpenAI text-embedding-3-small de 512 dimensiones; la API filtra por cursos accesibles antes de llamar las RPC.';
