-- ============================================================================
--  Solicitudes de acceso a cursos.
--  Un usuario autenticado puede pedir acceso; solo un admin puede aprobarlo.
--  El catalogo publicado queda visible solo para usuarios aprobados o admins.
-- ============================================================================

create table if not exists public.course_access_requests (
  user_id     uuid primary key references auth.users (id) on delete cascade,
  email       text,
  status      text not null default 'pending'
    check (status in ('pending', 'approved', 'rejected')),
  note        text,
  requested_at timestamptz not null default now(),
  reviewed_at  timestamptz,
  reviewed_by  uuid references auth.users (id) on delete set null
);

create index if not exists course_access_requests_status_idx
  on public.course_access_requests (status, requested_at desc);

alter table public.course_access_requests enable row level security;

grant select, insert, update on public.course_access_requests to authenticated;

create or replace function public.has_course_access()
returns boolean
language sql
stable
set search_path = ''
as $$
  select
    public.is_admin()
    or exists (
      select 1
      from public.course_access_requests r
      where r.user_id = auth.uid()
        and r.status = 'approved'
    );
$$;

revoke all on function public.has_course_access() from public;
grant execute on function public.has_course_access() to authenticated;

drop policy if exists "course_access_requests_select_own_or_admin" on public.course_access_requests;
drop policy if exists "course_access_requests_insert_own" on public.course_access_requests;
drop policy if exists "course_access_requests_update_own_pending" on public.course_access_requests;
drop policy if exists "course_access_requests_admin_update" on public.course_access_requests;

create policy "course_access_requests_select_own_or_admin"
  on public.course_access_requests for select
  to authenticated
  using (user_id = auth.uid() or public.is_admin());

create policy "course_access_requests_insert_own"
  on public.course_access_requests for insert
  to authenticated
  with check (
    user_id = auth.uid()
    and status = 'pending'
    and reviewed_at is null
    and reviewed_by is null
  );

create policy "course_access_requests_update_own_pending"
  on public.course_access_requests for update
  to authenticated
  using (user_id = auth.uid() and status in ('pending', 'rejected'))
  with check (
    user_id = auth.uid()
    and status = 'pending'
    and reviewed_at is null
    and reviewed_by is null
  );

create policy "course_access_requests_admin_update"
  on public.course_access_requests for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

drop policy if exists "courses_select_published_or_admin" on public.courses;
drop policy if exists "course_modules_select_published_or_admin" on public.course_modules;
drop policy if exists "course_items_select_published_or_admin" on public.course_items;

create policy "courses_select_published_or_admin"
  on public.courses for select
  to authenticated
  using (
    public.is_admin()
    or (is_published and public.has_course_access())
  );

create policy "course_modules_select_published_or_admin"
  on public.course_modules for select
  to authenticated
  using (
    public.is_admin()
    or (
      is_published
      and public.has_course_access()
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
      and public.has_course_access()
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
