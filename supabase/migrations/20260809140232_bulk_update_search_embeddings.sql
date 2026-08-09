create function public.update_course_search_embeddings(
  p_updates jsonb,
  p_model text
)
returns integer
language plpgsql
set search_path = ''
as $$
declare
  updated_count integer;
begin
  update public.course_search_documents d
  set embedding = (u.embedding::text)::extensions.vector(512),
      embedding_model = p_model,
      embedded_at = now(),
      updated_at = now()
  from jsonb_to_recordset(p_updates) as u(id text, embedding jsonb)
  where d.id = u.id;

  get diagnostics updated_count = row_count;
  return updated_count;
end;
$$;

revoke all on function public.update_course_search_embeddings(jsonb, text)
  from public, anon, authenticated;
grant execute on function public.update_course_search_embeddings(jsonb, text)
  to service_role;
