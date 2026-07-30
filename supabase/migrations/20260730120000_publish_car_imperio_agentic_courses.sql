-- ============================================================================
--  Publica los cursos privados importados desde vaults Skool locales.
--  Las migraciones previas ya sembraron cursos, modulos, actividades y embeds.
--  Esta migracion solo los deja visibles para usuarios autenticados.
-- ============================================================================

begin;

update public.courses
set
  title = case id
    when 'car-ecosistema-startup' then 'CAR'
    when 'imperio-agentico' then 'Imperio Agentic'
    else title
  end,
  subtitle = case id
    when 'car-ecosistema-startup' then 'Cagala, Aprende, Repite'
    when 'imperio-agentico' then 'Curso de agentes, automatizaciones y vibe-coding'
    else subtitle
  end,
  sort_order = case id
    when 'car-ecosistema-startup' then 50
    when 'imperio-agentico' then 60
    else sort_order
  end,
  is_published = true
where id in (
  'car-ecosistema-startup',
  'imperio-agentico'
);

update public.course_modules
set is_published = true
where course_id in (
  'car-ecosistema-startup',
  'imperio-agentico'
);

update public.course_items
set is_published = true
where course_id in (
  'car-ecosistema-startup',
  'imperio-agentico'
);

commit;
