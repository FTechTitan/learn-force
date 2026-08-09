alter table public.course_lessons
  add column if not exists summary text not null default '';

with lesson_sources as (
  select lesson.id,
    coalesce(nullif(trim(content.body_markdown), ''), nullif(trim(transcript.transcript_text), ''), '') as source_text
  from public.course_lessons lesson
  left join public.course_lesson_contents content on content.lesson_id = lesson.id
  left join lateral (
    select t.transcript_text from public.course_lesson_transcripts t
    where t.lesson_id = lesson.id order by t.sort_order, t.id limit 1
  ) transcript on true
), cleaned as (
  select id, trim(regexp_replace(
    regexp_replace(regexp_replace(source_text, E'(?m)^#{1,6}\\s*', '', 'g'), E'!?\\[([^]]+)\\]\\([^)]+\\)', E'\\1', 'g'),
    E'[`*_>|~-]+|\\s+', ' ', 'g'
  )) as plain_text
  from lesson_sources
)
update public.course_lessons lesson
set summary = case
  when cleaned.plain_text <> '' then left(cleaned.plain_text, 360) || case when length(cleaned.plain_text) > 360 then '…' else '' end
  else 'Aprende los conceptos, herramientas y pasos prácticos de “' || lesson.title || '”.'
end
from cleaned
where cleaned.id = lesson.id and lesson.lesson_kind = 'lesson';
