-- Bucket de Storage para transcripciones/recursos importados del vault
-- "Emprende Go" (comunidad Skool), siguiendo el mismo patron que
-- imperio-agentico-content (ver 20260809014000_add_imperio_lessons.sql y
-- 20260812150000_segmented_course_access.sql). Los videos NO se re-alojan
-- aqui: quedan como video_url apuntando al Drive ya archivado, embebido por
-- el front (js/app.js urlEmbedMedia) via drive.google.com/file/d/<id>/preview.

insert into storage.buckets (id, name, public, file_size_limit)
values ('emprendego-content', 'emprendego-content', false, 52428800)
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit;

drop policy if exists "emprendego_storage_select_approved" on storage.objects;

create policy "emprendego_storage_select_approved"
  on storage.objects for select to authenticated
  using (
    bucket_id = 'emprendego-content'
    and (public.is_admin() or public.can_read_course_object(name))
  );
