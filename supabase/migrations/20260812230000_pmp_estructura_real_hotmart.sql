-- ============================================================================
--  La Poderosa Máquina de Pacientes: estructura real del autor.
--
--  La migración anterior (20260812210000) tomó los nombres de la nota de
--  Obsidian, que era un inventario de respaldo, no el índice del curso. Quedaron
--  8 módulos con numeración inventada: el neuromarketing figuraba como Módulo 1
--  cuando en el original es el 4, las sesiones prácticas estaban al principio en
--  vez del final, y Canva, IA y FanPage estaban fusionados en un solo módulo.
--
--  Esta migración usa la fuente real: el classroom del autor en Hotmart Club
--  (producto 3294505, "Donny Sánchez Academia Digital Marketing"), leído el
--  2026-08-12. Son 11 módulos y 64 clases, y los 64 videos de la base encajan
--  exactamente en esa estructura, sin sobrantes ni faltantes.
--
--  Ninguna clase cambia de id: se mueven de módulo, así que progreso, grants y
--  URLs directas de clase siguen funcionando.
-- ============================================================================

-- ---------------------------------------------------------------------------
--  1) Módulos nuevos que la importación no separó
-- ---------------------------------------------------------------------------
insert into public.course_modules (id, course_id, title, emoji, intro, sort_order, is_published)
values
  ('pmp-empieza-aqui', 'poderosa-maquina-pacientes',
   'Empieza aquí', '🚩',
   'La vista general del proceso de atracción de pacientes, antes de entrar a las herramientas.',
   5, true),

  ('pmp-inteligencia-artificial', 'poderosa-maquina-pacientes',
   'Módulo 7 · Inteligencia Artificial', '🤖',
   'Dar instrucciones a la IA, prompts para el sector salud y edición de textos con Fancy Text.',
   70, true),

  ('pmp-bono-canva', 'poderosa-maquina-pacientes',
   'BONO · Diseños publicitarios con Canva', '🎨',
   'Las herramientas de Canva, la práctica de un anuncio de impacto y una sesión en vivo combinando Canva con IA.',
   90, true),

  ('pmp-bono-fanpage', 'poderosa-maquina-pacientes',
   'BONO · Tu primera FanPage', '📄',
   'De la diferencia entre perfil y FanPage hasta publicar con el botón de WhatsApp conectado.',
   100, true)
on conflict (id) do update set
  title = excluded.title, emoji = excluded.emoji, intro = excluded.intro,
  sort_order = excluded.sort_order, is_published = excluded.is_published;

-- ---------------------------------------------------------------------------
--  2) Módulos existentes: nombres, orden e intros según el original
-- ---------------------------------------------------------------------------
update public.course_modules set title = t.title, intro = t.intro, sort_order = t.sort_order
from (values
  ('pmp-whatsapp-trafico', 10,
   'Módulo 1 · WhatsApp Business para prospectar pacientes',
   'Migrar e instalar WhatsApp Business, configurar el perfil de empresa, respuestas automáticas, catálogos y etiquetas, y armar el embudo con tráfico frío, tibio y caliente.'),

  ('pmp-estados-calendario', 20,
   'Módulo 2 · Estados de WhatsApp para atraer pacientes',
   'La fórmula corta para atraer un paciente nuevo usando solo estados, y el calendario para sostenerla.'),

  ('pmp-mensajes-impacto', 30,
   'Módulo 3 · Mensajes de alto impacto',
   'La estructura problema-agitación-solución y los guiones para cada momento: interés, conversación, objeciones, urgencia, seguimiento, cierre y confianza.'),

  ('pmp-neuromarketing-persuasion', 40,
   'Módulo 4 · La magia del neuromarketing',
   'Cómo decide la mente del paciente: psicología del consumidor, motivos de consulta, propuesta de valor, landing page y conexión emocional.'),

  ('pmp-cierre-gatillos', 50,
   'Módulo 5 · Cierre de ventas y agendamiento',
   'Gatillos mentales aplicados al cierre: autoridad, confianza, urgencia, objeciones y la secuencia final para agendar.'),

  ('pmp-facebook-ads', 60,
   'Módulo 6 · Facebook Ads',
   'Campañas desde cero: configuración inicial, conjuntos de anuncios, creativos y copy, segmentación, revisión y medición.'),

  ('pmp-introduccion-sesiones', 80,
   'Módulo 8 · Sesiones prácticas',
   'Las seis sesiones grabadas en vivo donde se aplica todo lo anterior de punta a punta.')
) as t(id, sort_order, title, intro)
where public.course_modules.id = t.id
  and public.course_modules.course_id = 'poderosa-maquina-pacientes';

-- ---------------------------------------------------------------------------
--  3) Clases a su módulo real. Los ids no cambian, solo el module_id.
-- ---------------------------------------------------------------------------

-- "Bienvenida" abre el curso; las seis sesiones son el Módulo 8.
update public.course_lessons set module_id = 'pmp-empieza-aqui'
where course_id = 'poderosa-maquina-pacientes'
  and id = 'catalog-lesson-dd65cabe913fb7a047f';

-- El módulo fusionado se reparte en cuatro destinos.
update public.course_lessons set module_id = 'pmp-whatsapp-trafico'
where course_id = 'poderosa-maquina-pacientes'
  and id = 'catalog-lesson-34c5d5d908c048550d8';  -- Como encontrar clientes en grupos de Facebook

update public.course_lessons set module_id = 'pmp-inteligencia-artificial'
where course_id = 'poderosa-maquina-pacientes'
  and id in (
    'catalog-lesson-acc1ac2eb63ddb06cd2',  -- Dando instrucciones a la IA
    'catalog-lesson-60f4e4c173e33819268',  -- Prompts para el sector salud
    'catalog-lesson-ead4715abdcd2149ffc'   -- Editando textos con Fancy Text
  );

update public.course_lessons set module_id = 'pmp-bono-canva'
where course_id = 'poderosa-maquina-pacientes'
  and id in (
    'catalog-lesson-3cd35c4a5dfb24a3c91',  -- Canva para crear contenido
    'catalog-lesson-3b137d0ae47710abcd9',  -- Práctica de anuncio en Canva
    'catalog-lesson-6ee94c1096cbf31941f'   -- Sesión en vivo: Canva con IA
  );

update public.course_lessons set module_id = 'pmp-bono-fanpage'
where course_id = 'poderosa-maquina-pacientes'
  and id in (
    'catalog-lesson-7ade64e78afb357e9ab',  -- Diferencia entre perfil y FanPage
    'catalog-lesson-477ce19f126d7a00923',  -- Creando la FanPage
    'catalog-lesson-9abd76c566173a80cc7',  -- Conectando el botón de WhatsApp
    'catalog-lesson-13f60d0c211a045956a'   -- Publicando con el botón
  );

-- ---------------------------------------------------------------------------
--  4) El módulo fusionado queda vacío: se elimina.
--     El delete falla si quedó alguna clase, que es la señal correcta.
-- ---------------------------------------------------------------------------
delete from public.course_modules
where id = 'pmp-canva-ia-fanpage'
  and not exists (
    select 1 from public.course_lessons l where l.module_id = 'pmp-canva-ia-fanpage'
  );

-- ---------------------------------------------------------------------------
--  5) Descripción del curso, ahora con el público real que declara el autor
-- ---------------------------------------------------------------------------
update public.courses set
  description = 'Curso de Donny Sánchez para odontólogos, terapeutas, médicos y profesionales de la estética '
                || 'que quieren llenar su agenda: WhatsApp Business y embudos, estados, mensajes de alto impacto, '
                || 'neuromarketing, cierre y agendamiento, Facebook Ads e inteligencia artificial, más dos bonos '
                || 'de Canva y FanPage. 64 clases en video repartidas en 11 módulos, unas 20 horas en total.'
where id = 'poderosa-maquina-pacientes';

-- El indice de busqueda guarda copia de titulos y modulos: hay que reconstruirlo.
select * from public.rebuild_course_search_documents(array['poderosa-maquina-pacientes']);
