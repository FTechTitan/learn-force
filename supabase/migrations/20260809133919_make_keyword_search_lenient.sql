-- El modo económico debe tolerar consultas naturales: rankea coincidencias de
-- cualquier término útil en vez de exigir que todas las palabras aparezcan.
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
  with query as (
    select websearch_to_tsquery(
      'spanish',
      regexp_replace(trim(p_query), '\s+', ' OR ', 'g')
    ) as value
  )
  select d.lesson_id, d.course_id, d.module_id, d.course_title, d.module_title,
    d.title, d.summary,
    ts_rank_cd(d.fts, query.value, 32)::real as score
  from public.course_search_documents d
  cross join query
  where d.fts @@ query.value
  order by score desc, d.title
  limit least(greatest(p_limit, 1), 25);
$$;

revoke all on function public.search_course_documents_keyword(text, integer) from public, anon, authenticated;
grant execute on function public.search_course_documents_keyword(text, integer) to service_role;
