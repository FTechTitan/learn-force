-- Devuelve una sola evidencia por clase y favorece una ruta pedagogica
-- cuando la consulta expresa intencion de aprender.
drop function if exists public.search_course_documents_keyword(text, integer);
drop function if exists public.search_course_documents_semantic(extensions.vector, integer);
drop function if exists public.search_course_documents_semantic(extensions.vector, integer, boolean);

create function public.search_course_documents_keyword(p_query text, p_limit integer default 10)
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
    order by relevance desc
    limit least(greatest(p_limit * 20, 100), 500)
  ),
  scored as (
    select candidates.*,
      relevance
      + case source_kind when 'metadata' then 0.04 when 'content' then 0.02 else 0 end
      + case
          when lower(module_title) like '%agentes de whatsapp%' then 0.10
          when lower(module_title) like '%dashboard agentes de whatsapp%' then 0.06
          else 0
        end
      + case when learning_intent and lower(title) ~
          '(introducci[oó]n|bienvenida|empieza aqu[ií]|lo que vas a construir)'
        then 0.12 else 0 end
      + case when learning_intent and lower(module_title) ~
          '(soporte|grabaciones|biblioteca)'
        then -0.18 else 0 end as final_score
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
  p_embedding extensions.vector(512), p_limit integer default 10,
  p_learning_intent boolean default false
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
    order by d.embedding OPERATOR(extensions.<=>) p_embedding
    limit least(greatest(p_limit * 20, 100), 500)
  ),
  scored as (
    select candidates.*,
      relevance
      + case source_kind when 'metadata' then 0.04 when 'content' then 0.02 else 0 end
      + case
          when lower(module_title) like '%agentes de whatsapp%' then 0.10
          when lower(module_title) like '%dashboard agentes de whatsapp%' then 0.06
          else 0
        end
      + case when p_learning_intent and lower(title) ~
          '(introducci[oó]n|bienvenida|empieza aqu[ií]|lo que vas a construir)'
        then 0.12 else 0 end
      + case when p_learning_intent and lower(module_title) ~
          '(soporte|grabaciones|biblioteca)'
        then -0.18 else 0 end as final_score
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

revoke all on function public.search_course_documents_keyword(text, integer) from public, anon, authenticated;
revoke all on function public.search_course_documents_semantic(extensions.vector, integer, boolean) from public, anon, authenticated;
grant execute on function public.search_course_documents_keyword(text, integer) to service_role;
grant execute on function public.search_course_documents_semantic(extensions.vector, integer, boolean) to service_role;
