-- El título y el resumen describen mejor la intención de una clase que el
-- nombre compartido del módulo. Se ponderan para mejorar el ranking económico.
drop index if exists public.course_search_documents_fts_idx;

alter table public.course_search_documents drop column if exists fts;

alter table public.course_search_documents
  add column fts tsvector generated always as (
    setweight(to_tsvector('spanish', coalesce(title, '')), 'A') ||
    setweight(to_tsvector('spanish', coalesce(summary, '')), 'B') ||
    setweight(to_tsvector('spanish', coalesce(module_title, '')), 'C') ||
    setweight(to_tsvector('spanish', coalesce(course_title, '')), 'D')
  ) stored;

create index course_search_documents_fts_idx
  on public.course_search_documents using gin (fts);
