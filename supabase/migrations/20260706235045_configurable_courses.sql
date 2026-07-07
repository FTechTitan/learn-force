-- ============================================================================
--  Cursos configurables desde Supabase
--  Permite publicar cursos, módulos y preguntas/ejercicios sin redeployar la app.
--  Lectura pública solo para contenido publicado. Escritura solo para usuarios
--  con app_metadata.role = 'admin' (verificado por RLS usando auth.jwt()).
-- ============================================================================

create table if not exists public.courses (
  id           text primary key,
  title        text not null,
  subtitle     text,
  description  text,
  emoji        text not null default '📚',
  sort_order   integer not null default 0,
  is_published boolean not null default false,
  created_by   uuid references auth.users (id) on delete set null,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

create table if not exists public.course_modules (
  id           text primary key,
  course_id    text not null references public.courses (id) on delete cascade,
  title        text not null,
  emoji        text not null default '📦',
  intro        text,
  theory       text,
  sort_order   integer not null default 0,
  is_published boolean not null default true,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now(),
  unique (id, course_id)
);

create table if not exists public.course_items (
  id              text primary key,
  course_id       text not null references public.courses (id) on delete cascade,
  module_id       text not null references public.course_modules (id) on delete cascade,
  type            text not null check (type in ('code', 'quiz_single', 'quiz_boolean', 'development')),
  title           text not null,
  level           integer not null default 1 check (level between 1 and 5),
  statement_html  text not null,
  hint            text,
  starter         text,
  tests           jsonb not null default '[]'::jsonb,
  options         jsonb not null default '[]'::jsonb,
  correct_answer  text,
  explanation     text,
  solution_html   text,
  sort_order      integer not null default 0,
  is_published    boolean not null default true,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  constraint course_items_module_course_fk
    foreign key (module_id, course_id)
    references public.course_modules (id, course_id)
    on delete cascade
);

create index if not exists courses_published_sort_idx
  on public.courses (is_published, sort_order, id);

create index if not exists course_modules_course_sort_idx
  on public.course_modules (course_id, is_published, sort_order, id);

create index if not exists course_items_module_sort_idx
  on public.course_items (module_id, is_published, sort_order, id);

alter table public.courses enable row level security;
alter table public.course_modules enable row level security;
alter table public.course_items enable row level security;

grant select on public.courses to anon, authenticated;
grant select on public.course_modules to anon, authenticated;
grant select on public.course_items to anon, authenticated;

grant insert, update, delete on public.courses to authenticated;
grant insert, update, delete on public.course_modules to authenticated;
grant insert, update, delete on public.course_items to authenticated;

create or replace function public.is_admin()
returns boolean
language sql
stable
set search_path = ''
as $$
  select coalesce((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin', false);
$$;

revoke all on function public.is_admin() from public;
grant execute on function public.is_admin() to anon, authenticated;

-- Lectura: cualquiera puede leer contenido publicado.
create policy "courses_select_published_or_admin"
  on public.courses for select
  to anon, authenticated
  using (is_published or public.is_admin());

create policy "course_modules_select_published_or_admin"
  on public.course_modules for select
  to anon, authenticated
  using (
    (is_published and exists (
      select 1 from public.courses c
      where c.id = course_modules.course_id and c.is_published
    ))
    or public.is_admin()
  );

create policy "course_items_select_published_or_admin"
  on public.course_items for select
  to anon, authenticated
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

-- Escritura: solo admin.
create policy "courses_admin_insert"
  on public.courses for insert
  to authenticated
  with check (public.is_admin());

create policy "courses_admin_update"
  on public.courses for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

create policy "courses_admin_delete"
  on public.courses for delete
  to authenticated
  using (public.is_admin());

create policy "course_modules_admin_insert"
  on public.course_modules for insert
  to authenticated
  with check (public.is_admin());

create policy "course_modules_admin_update"
  on public.course_modules for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

create policy "course_modules_admin_delete"
  on public.course_modules for delete
  to authenticated
  using (public.is_admin());

create policy "course_items_admin_insert"
  on public.course_items for insert
  to authenticated
  with check (public.is_admin());

create policy "course_items_admin_update"
  on public.course_items for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

create policy "course_items_admin_delete"
  on public.course_items for delete
  to authenticated
  using (public.is_admin());

create trigger courses_touch_updated_at
  before update on public.courses
  for each row execute function public.touch_updated_at();

create trigger course_modules_touch_updated_at
  before update on public.course_modules
  for each row execute function public.touch_updated_at();

create trigger course_items_touch_updated_at
  before update on public.course_items
  for each row execute function public.touch_updated_at();

-- Seed inicial: Estadística Aplicada, Certamen 2.
insert into public.courses (id, title, subtitle, description, emoji, sort_order, is_published)
values (
  'estadistica-aplicada',
  'Estadística Aplicada',
  'Probabilidad · Certamen 2',
  'Práctica de verdadero/falso y alternativas para conteo, condicional, independencia, probabilidad total y Bayes.',
  '📊',
  20,
  true
)
on conflict (id) do update set
  title = excluded.title,
  subtitle = excluded.subtitle,
  description = excluded.description,
  emoji = excluded.emoji,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

insert into public.course_modules (id, course_id, title, emoji, intro, theory, sort_order, is_published)
values
  (
    'estadistica-vf',
    'estadistica-aplicada',
    'Verdadero o falso',
    '✅',
    'Preguntas cortas para detectar errores conceptuales frecuentes.',
    '<p>En probabilidad, no confundas eventos mutuamente excluyentes con eventos independientes. Para independencia usa <code>P(A∩B)=P(A)P(B)</code> o <code>P(A|B)=P(A)</code>.</p>',
    10,
    true
  ),
  (
    'estadistica-alternativas',
    'estadistica-aplicada',
    'Alternativas',
    '📝',
    'Ejercicios rápidos con una alternativa correcta y explicación inmediata.',
    '<p>Antes de calcular, decide si importa el orden. Si importa, usa permutaciones; si no importa, usa combinaciones.</p>',
    20,
    true
  )
on conflict (id) do update set
  title = excluded.title,
  emoji = excluded.emoji,
  intro = excluded.intro,
  theory = excluded.theory,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

insert into public.course_items
  (id, course_id, module_id, type, title, level, statement_html, hint, options, correct_answer, explanation, sort_order, is_published)
values
  (
    'est-vf-01',
    'estadistica-aplicada',
    'estadistica-vf',
    'quiz_boolean',
    'Excluyentes e independientes',
    1,
    '<p>Si dos sucesos A y B son mutuamente excluyentes y ambos tienen probabilidad positiva, entonces A y B son independientes.</p>',
    'Compara P(A∩B) con P(A)P(B).',
    '[{"id":"true","label":"Verdadero"},{"id":"false","label":"Falso"}]'::jsonb,
    'false',
    'Falso. Si son mutuamente excluyentes, P(A∩B)=0. Si ambos tienen probabilidad positiva, P(A)P(B)>0, por lo que no se cumple independencia.',
    10,
    true
  ),
  (
    'est-vf-02',
    'estadistica-aplicada',
    'estadistica-vf',
    'quiz_boolean',
    'Regla de unión',
    1,
    '<p>Si A y B son mutuamente excluyentes, entonces <code>P(A∪B)=P(A)+P(B)</code>.</p>',
    'Recuerda la fórmula general de la unión.',
    '[{"id":"true","label":"Verdadero"},{"id":"false","label":"Falso"}]'::jsonb,
    'true',
    'Verdadero. La regla general resta P(A∩B), y en eventos excluyentes esa intersección vale 0.',
    20,
    true
  ),
  (
    'est-vf-03',
    'estadistica-aplicada',
    'estadistica-vf',
    'quiz_boolean',
    'Condicional e independencia',
    2,
    '<p>Si <code>P(A|B)=P(A)</code>, con <code>P(B)>0</code>, entonces A y B son independientes.</p>',
    'Despeja desde P(A|B)=P(A∩B)/P(B).',
    '[{"id":"true","label":"Verdadero"},{"id":"false","label":"Falso"}]'::jsonb,
    'true',
    'Verdadero. Al multiplicar por P(B), queda P(A∩B)=P(A)P(B), que es la condición de independencia.',
    30,
    true
  ),
  (
    'est-vf-04',
    'estadistica-aplicada',
    'estadistica-vf',
    'quiz_boolean',
    'Comités',
    1,
    '<p>Para formar un comité de 4 personas desde 10, sin cargos ni orden, se usa <code>P(10,4)</code>.</p>',
    'La palabra comité normalmente no distingue orden.',
    '[{"id":"true","label":"Verdadero"},{"id":"false","label":"Falso"}]'::jsonb,
    'false',
    'Falso. Si no hay cargos ni orden, corresponde C(10,4), no P(10,4).',
    40,
    true
  ),
  (
    'est-alt-01',
    'estadistica-aplicada',
    'estadistica-alternativas',
    'quiz_single',
    'Códigos de producto',
    2,
    '<p>Una empresa codifica productos con 2 letras distintas tomadas de A,B,C,D,E y luego 2 dígitos que pueden repetirse. ¿Cuántos códigos hay?</p>',
    'Principio multiplicativo: opciones para cada posición.',
    '[{"id":"a","label":"250"},{"id":"b","label":"500"},{"id":"c","label":"2000"},{"id":"d","label":"2500"}]'::jsonb,
    'c',
    'Hay 5 opciones para la primera letra, 4 para la segunda, 10 para cada dígito: 5·4·10·10=2000.',
    10,
    true
  ),
  (
    'est-alt-02',
    'estadistica-aplicada',
    'estadistica-alternativas',
    'quiz_single',
    'Equipo sin cargos',
    2,
    '<p>De 12 trabajadores se forma un equipo de 5 sin cargos. ¿Cuántas formas hay?</p>',
    'Si no hay cargos, no importa el orden.',
    '[{"id":"a","label":"60"},{"id":"b","label":"792"},{"id":"c","label":"95040"},{"id":"d","label":"248832"}]'::jsonb,
    'b',
    'Corresponde C(12,5)=792.',
    20,
    true
  ),
  (
    'est-alt-03',
    'estadistica-aplicada',
    'estadistica-alternativas',
    'quiz_single',
    'Unión con intersección',
    2,
    '<p>Si <code>P(A)=0,6</code>, <code>P(B)=0,5</code> y <code>P(A∪B)=0,8</code>, entonces <code>P(A∩B)</code> es:</p>',
    'Despeja desde P(A∪B)=P(A)+P(B)-P(A∩B).',
    '[{"id":"a","label":"0,1"},{"id":"b","label":"0,2"},{"id":"c","label":"0,3"},{"id":"d","label":"1,1"}]'::jsonb,
    'c',
    'P(A∩B)=0,6+0,5-0,8=0,3.',
    30,
    true
  ),
  (
    'est-alt-04',
    'estadistica-aplicada',
    'estadistica-alternativas',
    'quiz_single',
    'Probabilidad total',
    3,
    '<p>Una máquina M1 produce el 70% y M2 el 30%. Defectos: 2% en M1 y 5% en M2. ¿Cuál es <code>P(defectuosa)</code>?</p>',
    'Pondera cada porcentaje de defecto por su proporción de producción.',
    '[{"id":"a","label":"0,029"},{"id":"b","label":"0,035"},{"id":"c","label":"0,070"},{"id":"d","label":"0,050"}]'::jsonb,
    'a',
    'P(D)=0,70·0,02 + 0,30·0,05 = 0,014+0,015=0,029.',
    40,
    true
  )
on conflict (id) do update set
  title = excluded.title,
  level = excluded.level,
  statement_html = excluded.statement_html,
  hint = excluded.hint,
  options = excluded.options,
  correct_answer = excluded.correct_answer,
  explanation = excluded.explanation,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;
