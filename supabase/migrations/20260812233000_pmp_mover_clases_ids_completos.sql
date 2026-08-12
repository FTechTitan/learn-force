-- ============================================================================
--  Corrige 20260812230000: los movimientos de clase no se aplicaron.
--
--  Aquella migración usó ids truncados a 34 caracteres (error al copiarlos de un
--  listado abreviado), así que ningún `update ... set module_id` matcheó: los
--  módulos nuevos quedaron vacíos y el módulo fusionado siguió con sus 11 clases.
--  Los ids reales tienen 39 caracteres: catalog-lesson- + sha1 de 24.
--
--  Esta migración repite los movimientos con los ids completos y verifica el
--  resultado antes de borrar el módulo fusionado.
-- ============================================================================

update public.course_lessons set module_id = 'pmp-empieza-aqui'
where course_id = 'poderosa-maquina-pacientes'
  and id = 'catalog-lesson-dd65cabe913fb7a047f083e2';  -- Bienvenida

update public.course_lessons set module_id = 'pmp-whatsapp-trafico'
where course_id = 'poderosa-maquina-pacientes'
  and id = 'catalog-lesson-34c5d5d908c048550d8f7371';  -- Clientes en grupos de Facebook

update public.course_lessons set module_id = 'pmp-inteligencia-artificial'
where course_id = 'poderosa-maquina-pacientes'
  and id in (
    'catalog-lesson-acc1ac2eb63ddb06cd2ea075',  -- Dando instrucciones a la IA
    'catalog-lesson-60f4e4c173e33819268cdbc5',  -- Prompts para el sector salud
    'catalog-lesson-ead4715abdcd2149ffc46361'   -- Editando textos con Fancy Text
  );

update public.course_lessons set module_id = 'pmp-bono-canva'
where course_id = 'poderosa-maquina-pacientes'
  and id in (
    'catalog-lesson-3cd35c4a5dfb24a3c9186b50',  -- Canva para crear contenido
    'catalog-lesson-3b137d0ae47710abcd9614ea',  -- Práctica de anuncio en Canva
    'catalog-lesson-6ee94c1096cbf31941f10b95'   -- Sesión en vivo: Canva con IA
  );

update public.course_lessons set module_id = 'pmp-bono-fanpage'
where course_id = 'poderosa-maquina-pacientes'
  and id in (
    'catalog-lesson-7ade64e78afb357e9abd6d30',  -- Diferencia entre perfil y FanPage
    'catalog-lesson-477ce19f126d7a00923ef373',  -- Creando la FanPage
    'catalog-lesson-9abd76c566173a80cc7a21ec',  -- Conectando el botón de WhatsApp
    'catalog-lesson-13f60d0c211a045956ae124c'   -- Publicando con el botón
  );

-- Falla ruidosamente si el reparto no dejó la estructura esperada.
do $$
declare
  sobrantes integer;
  reparto text;
begin
  select count(*) into sobrantes
  from public.course_lessons where module_id = 'pmp-canva-ia-fanpage';
  if sobrantes > 0 then
    raise exception 'pmp-canva-ia-fanpage todavia tiene % clases sin reasignar', sobrantes;
  end if;

  select string_agg(m.id || '=' || c.n, ', ' order by m.sort_order) into reparto
  from public.course_modules m
  join lateral (
    select count(*) as n from public.course_lessons l where l.module_id = m.id
  ) c on true
  where m.course_id = 'poderosa-maquina-pacientes'
    and c.n = 0
    and m.id <> 'pmp-canva-ia-fanpage';  -- este debe quedar vacio: se borra abajo
  if reparto is not null then
    raise exception 'quedaron modulos vacios: %', reparto;
  end if;
end $$;

delete from public.course_modules where id = 'pmp-canva-ia-fanpage';

select * from public.rebuild_course_search_documents(array['poderosa-maquina-pacientes']);
