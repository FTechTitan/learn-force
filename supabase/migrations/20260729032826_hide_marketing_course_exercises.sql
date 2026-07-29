begin;

update public.course_items
set is_published = false
where course_id in (
  'poderosa-maquina-pacientes',
  'whatsagenda-pro'
);

commit;
