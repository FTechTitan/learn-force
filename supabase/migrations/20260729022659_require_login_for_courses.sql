-- ============================================================================
--  Requiere login para leer el catalogo de cursos.
--  Antes el contenido publicado era legible por anon. Desde esta migracion,
--  solo usuarios authenticated pueden leer courses/course_modules/course_items.
-- ============================================================================

revoke select on public.courses from anon;
revoke select on public.course_modules from anon;
revoke select on public.course_items from anon;

grant select on public.courses to authenticated;
grant select on public.course_modules to authenticated;
grant select on public.course_items to authenticated;

revoke execute on function public.is_admin() from anon;
grant execute on function public.is_admin() to authenticated;

drop policy if exists "courses_select_published_or_admin" on public.courses;
drop policy if exists "course_modules_select_published_or_admin" on public.course_modules;
drop policy if exists "course_items_select_published_or_admin" on public.course_items;

create policy "courses_select_published_or_admin"
  on public.courses for select
  to authenticated
  using (is_published or public.is_admin());

create policy "course_modules_select_published_or_admin"
  on public.course_modules for select
  to authenticated
  using (
    (is_published and exists (
      select 1 from public.courses c
      where c.id = course_modules.course_id and c.is_published
    ))
    or public.is_admin()
  );

create policy "course_items_select_published_or_admin"
  on public.course_items for select
  to authenticated
  using (
    (is_published and exists (
      select 1 from public.course_modules m
      join public.courses c on c.id = m.course_id
      where m.id = course_items.module_id
        and m.course_id = course_items.course_id
        and m.is_published
        and c.is_published
    ))
    or public.is_admin()
  );
