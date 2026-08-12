-- ============================================================================
--  Acceso segmentado por curso.
--
--  Antes: `has_course_access()` era global — un alumno aprobado veia TODO el
--  catalogo publicado. Ahora el permiso es por curso:
--
--    courses.access_mode = 'open'        -> visible para cualquier usuario logueado
--    courses.access_mode = 'restricted'  -> visible solo con fila en course_grants
--
--  Los cursos restringidos sin grant quedan ocultos a nivel de fila por RLS:
--  no aparecen en el catalogo, ni en la API de agentes, ni en la busqueda, asi
--  que el alumno ni siquiera sabe que existen.
--
--  `course_access_requests` se mantiene como la solicitud de entrada a la
--  plataforma (bandeja del admin); ya no otorga acceso al contenido por si sola.
-- ============================================================================

-- ---------------------------------------------------------------------------
--  1) Modo de acceso por curso
-- ---------------------------------------------------------------------------
alter table public.courses
  add column if not exists access_mode text not null default 'restricted';

alter table public.courses
  drop constraint if exists courses_access_mode_check;

alter table public.courses
  add constraint courses_access_mode_check
  check (access_mode in ('open', 'restricted'));

comment on column public.courses.access_mode is
  'open = visible para cualquier usuario autenticado; restricted = solo con grant en course_grants.';

-- ---------------------------------------------------------------------------
--  2) Grants explicitos alumno <-> curso
-- ---------------------------------------------------------------------------
create table if not exists public.course_grants (
  user_id    uuid not null references auth.users (id) on delete cascade,
  course_id  text not null references public.courses (id) on delete cascade,
  granted_at timestamptz not null default now(),
  granted_by uuid references auth.users (id) on delete set null,
  note       text,
  primary key (user_id, course_id)
);

create index if not exists course_grants_course_idx
  on public.course_grants (course_id, granted_at desc);

alter table public.course_grants enable row level security;

grant select, insert, update, delete on public.course_grants to authenticated;

drop policy if exists "course_grants_select_own_or_admin" on public.course_grants;
drop policy if exists "course_grants_admin_manage" on public.course_grants;

-- El alumno puede ver sus propios grants; solo un admin puede crearlos o borrarlos.
create policy "course_grants_select_own_or_admin"
  on public.course_grants for select
  to authenticated
  using (user_id = auth.uid() or public.is_admin());

create policy "course_grants_admin_manage"
  on public.course_grants for all
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

-- ---------------------------------------------------------------------------
--  3) Backfill: preserva exactamente lo que hoy ve cada alumno aprobado
-- ---------------------------------------------------------------------------
insert into public.course_grants (user_id, course_id, note)
select r.user_id, c.id, 'backfill: acceso global aprobado antes de la segmentacion'
from public.course_access_requests r
cross join public.courses c
where r.status = 'approved'
  and c.is_published
on conflict (user_id, course_id) do nothing;

-- ---------------------------------------------------------------------------
--  4) Nueva funcion de permiso, ahora por curso
-- ---------------------------------------------------------------------------
-- security definer: la funcion se usa DENTRO de la policy de public.courses y lee
-- esa misma tabla. Sin definer, Postgres aborta con "infinite recursion detected
-- in policy for relation courses".
create or replace function public.has_course_access(p_course_id text)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select
    public.is_admin()
    or exists (
      select 1
      from public.courses c
      where c.id = p_course_id
        and c.access_mode = 'open'
    )
    or exists (
      select 1
      from public.course_grants g
      where g.course_id = p_course_id
        and g.user_id = auth.uid()
    );
$$;

revoke all on function public.has_course_access(text) from public;
grant execute on function public.has_course_access(text) to authenticated;

-- ---------------------------------------------------------------------------
--  5) Policies del catalogo
-- ---------------------------------------------------------------------------
drop policy if exists "courses_select_published_or_admin" on public.courses;
drop policy if exists "course_modules_select_published_or_admin" on public.course_modules;
drop policy if exists "course_items_select_published_or_admin" on public.course_items;

create policy "courses_select_published_or_admin"
  on public.courses for select
  to authenticated
  using (
    public.is_admin()
    or (is_published and public.has_course_access(id))
  );

create policy "course_modules_select_published_or_admin"
  on public.course_modules for select
  to authenticated
  using (
    public.is_admin()
    or (
      is_published
      and public.has_course_access(course_modules.course_id)
      and exists (
        select 1 from public.courses c
        where c.id = course_modules.course_id
          and c.is_published
      )
    )
  );

create policy "course_items_select_published_or_admin"
  on public.course_items for select
  to authenticated
  using (
    public.is_admin()
    or (
      is_published
      and public.has_course_access(course_items.course_id)
      and exists (
        select 1
        from public.course_modules m
        join public.courses c on c.id = m.course_id
        where m.id = course_items.module_id
          and m.course_id = course_items.course_id
          and m.is_published
          and c.is_published
      )
    )
  );

-- ---------------------------------------------------------------------------
--  6) Policies de clases, contenidos, transcripciones y recursos
-- ---------------------------------------------------------------------------
-- security definer: resuelve el permiso completo por si misma (publicado + acceso
-- al curso), asi no depende de las policies de las tablas que consulta.
create or replace function public.can_read_course_lesson(target_lesson_id text)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.course_lessons l
    join public.course_modules m
      on m.id = l.module_id and m.course_id = l.course_id
    join public.courses c on c.id = l.course_id
    where l.id = target_lesson_id
      and l.is_published
      and m.is_published
      and c.is_published
      and public.has_course_access(l.course_id)
  );
$$;

revoke all on function public.can_read_course_lesson(text) from public;
grant execute on function public.can_read_course_lesson(text) to authenticated;

drop policy if exists "course_lessons_select_approved" on public.course_lessons;

create policy "course_lessons_select_approved"
  on public.course_lessons for select to authenticated
  using (
    public.is_admin()
    or (
      is_published
      and public.has_course_access(course_lessons.course_id)
      and exists (
        select 1
        from public.course_modules m
        join public.courses c on c.id = m.course_id
        where m.id = course_lessons.module_id
          and m.course_id = course_lessons.course_id
          and m.is_published
          and c.is_published
      )
    )
  );

-- Las policies de contents/transcripts/resources ya delegan en
-- can_read_course_lesson(), que acaba de quedar segmentada por curso.

-- ---------------------------------------------------------------------------
--  7) Storage privado: firma solo archivos de cursos accesibles
--     Los storage_path son hashes de contenido, no llevan prefijo de curso, asi
--     que el permiso se resuelve por la clase que referencia cada archivo.
-- ---------------------------------------------------------------------------
create index if not exists course_lesson_resources_storage_path_idx
  on public.course_lesson_resources (storage_path);

create index if not exists course_lesson_transcripts_storage_path_idx
  on public.course_lesson_transcripts (storage_path);

create or replace function public.can_read_course_object(target_path text)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select
    exists (
      select 1
      from public.course_lesson_resources r
      where r.storage_path = target_path
        and r.is_published
        and public.can_read_course_lesson(r.lesson_id)
    )
    or exists (
      select 1
      from public.course_lesson_transcripts t
      where t.storage_path = target_path
        and public.can_read_course_lesson(t.lesson_id)
    );
$$;

revoke all on function public.can_read_course_object(text) from public;
grant execute on function public.can_read_course_object(text) to authenticated;

drop policy if exists "imperio_storage_select_approved" on storage.objects;

create policy "imperio_storage_select_approved"
  on storage.objects for select to authenticated
  using (
    bucket_id = 'imperio-agentico-content'
    and (public.is_admin() or public.can_read_course_object(name))
  );

-- ---------------------------------------------------------------------------
--  8) Fuera la version global: ya nadie debe poder pedir "acceso a todo"
-- ---------------------------------------------------------------------------
drop function if exists public.has_course_access();
