-- Lecciones completas importadas desde el vault privado de Imperio Agentico.
-- Los metadatos se cargan con el catalogo; cuerpo, transcripcion y recursos se
-- consultan de forma diferida al abrir una leccion.

alter table public.course_modules
  add column if not exists overview_markdown text;

create table if not exists public.course_lessons (
  id                  text primary key,
  course_id           text not null references public.courses (id) on delete cascade,
  module_id           text not null,
  source_path         text not null,
  title               text not null,
  lesson_kind         text not null default 'lesson' check (lesson_kind in ('lesson', 'section')),
  sort_order          integer not null default 0,
  video_url           text,
  video_provider      text check (video_provider in ('youtube', 'loom')),
  video_duration      text,
  video_thumbnail_url text,
  has_transcript      boolean not null default false,
  is_published        boolean not null default true,
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now(),
  unique (course_id, source_path),
  constraint course_lessons_module_course_fk
    foreign key (module_id, course_id)
    references public.course_modules (id, course_id)
    on delete cascade
);

create table if not exists public.course_lesson_contents (
  lesson_id               text primary key references public.course_lessons (id) on delete cascade,
  body_markdown           text not null default '',
  created_at              timestamptz not null default now(),
  updated_at              timestamptz not null default now()
);

create table if not exists public.course_lesson_transcripts (
  id           text primary key,
  lesson_id    text not null references public.course_lessons (id) on delete cascade,
  language     text not null,
  transcript_text text not null,
  storage_path text not null,
  sort_order   integer not null default 0,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now(),
  unique (lesson_id, language)
);

create table if not exists public.course_lesson_resources (
  id           text primary key,
  lesson_id    text not null references public.course_lessons (id) on delete cascade,
  title        text not null,
  kind         text not null check (kind in ('template', 'document', 'image', 'archive', 'resource')),
  mime_type    text,
  storage_path text not null,
  file_size    bigint not null default 0 check (file_size >= 0),
  sort_order   integer not null default 0,
  is_published boolean not null default true,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

create index if not exists course_lessons_module_sort_idx
  on public.course_lessons (module_id, is_published, sort_order, id);

create index if not exists course_lesson_resources_lesson_sort_idx
  on public.course_lesson_resources (lesson_id, is_published, sort_order, id);

create index if not exists course_lesson_transcripts_lesson_sort_idx
  on public.course_lesson_transcripts (lesson_id, sort_order, id);

alter table public.course_lessons enable row level security;
alter table public.course_lesson_contents enable row level security;
alter table public.course_lesson_transcripts enable row level security;
alter table public.course_lesson_resources enable row level security;

grant select on public.course_lessons to authenticated;
grant select on public.course_lesson_contents to authenticated;
grant select on public.course_lesson_transcripts to authenticated;
grant select on public.course_lesson_resources to authenticated;

grant insert, update, delete on public.course_lessons to authenticated;
grant insert, update, delete on public.course_lesson_contents to authenticated;
grant insert, update, delete on public.course_lesson_transcripts to authenticated;
grant insert, update, delete on public.course_lesson_resources to authenticated;

create or replace function public.can_read_course_lesson(target_lesson_id text)
returns boolean
language sql
stable
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
      and public.has_course_access()
  );
$$;

revoke all on function public.can_read_course_lesson(text) from public;
grant execute on function public.can_read_course_lesson(text) to authenticated;

create policy "course_lessons_select_approved"
  on public.course_lessons for select to authenticated
  using (
    public.is_admin()
    or (
      is_published
      and public.has_course_access()
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

create policy "course_lesson_contents_select_approved"
  on public.course_lesson_contents for select to authenticated
  using (public.is_admin() or public.can_read_course_lesson(lesson_id));

create policy "course_lesson_transcripts_select_approved"
  on public.course_lesson_transcripts for select to authenticated
  using (public.is_admin() or public.can_read_course_lesson(lesson_id));

create policy "course_lesson_resources_select_approved"
  on public.course_lesson_resources for select to authenticated
  using (
    public.is_admin()
    or (is_published and public.can_read_course_lesson(lesson_id))
  );

create policy "course_lessons_admin_manage"
  on public.course_lessons for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

create policy "course_lesson_contents_admin_manage"
  on public.course_lesson_contents for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

create policy "course_lesson_transcripts_admin_manage"
  on public.course_lesson_transcripts for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

create policy "course_lesson_resources_admin_manage"
  on public.course_lesson_resources for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

insert into storage.buckets (id, name, public, file_size_limit)
values ('imperio-agentico-content', 'imperio-agentico-content', false, 52428800)
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit;

create policy "imperio_storage_select_approved"
  on storage.objects for select to authenticated
  using (
    bucket_id = 'imperio-agentico-content'
    and public.has_course_access()
  );
