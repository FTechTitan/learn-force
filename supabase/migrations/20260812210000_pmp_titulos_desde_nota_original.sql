-- ============================================================================
--  La Poderosa Máquina de Pacientes: recupera lo que el importador dejó afuera.
--
--  El importador armó el curso desde una carpeta de Drive con 64 mp4 y generó
--  relleno: los módulos quedaron con el slug como título ("pmp-facebook-ads") y
--  con intros del tipo "Clases originales de pmp-facebook-ads.".
--
--  Los nombres reales de los módulos estaban en la nota de Obsidian que originó
--  la importación, sin usarse:
--    personal-private/PERSONAL/Cursos/La Poderosa Maquina de Pacientes.md
--  De ahí salen los títulos y el autor. Las intros se derivan de los títulos de
--  las clases que ya están en la base: describen lo que agrupa cada módulo, sin
--  inventar contenido (el curso no tiene transcripciones ni texto de origen).
--
--  Datos verificados: 8 módulos, 64 clases, ~20,6 h de video, autor Donny Sánchez.
-- ============================================================================

update public.courses set
  title = 'La Poderosa Máquina de Pacientes',
  subtitle = 'Neuroventas, WhatsApp Business y Facebook Ads para captar y agendar pacientes',
  description = 'Curso de Donny Sánchez para captar y agendar pacientes con marketing digital: '
                || 'neuromarketing y persuasión, WhatsApp Business y tráfico, mensajes de alto impacto, '
                || 'cierre con gatillos mentales, Facebook Ads y diseño de contenido con Canva e IA. '
                || '64 clases en video repartidas en 8 módulos, unas 20 horas en total.'
where id = 'poderosa-maquina-pacientes';

update public.course_modules set title = t.title, intro = t.intro
from (values
  ('pmp-introduccion-sesiones',
   'Introducción y sesiones en vivo',
   'Bienvenida y las seis sesiones grabadas del entrenamiento: redes, palabras poderosas, embudo, códigos reptiles, publicaciones y Facebook Ads.'),

  ('pmp-neuromarketing-persuasion',
   'Módulo 1 · Neuromarketing y persuasión',
   'Por qué decide el cerebro del paciente: psicología del consumidor, motivos de consulta, propuesta de valor y landing page.'),

  ('pmp-whatsapp-trafico',
   'Módulo 2 · WhatsApp Business y tráfico',
   'Instalar y configurar WhatsApp Business de punta a punta: perfil de empresa, llamada a la acción y publicaciones hacia Facebook.'),

  ('pmp-estados-calendario',
   'Módulo 3 · Estados y calendario',
   'Estados de WhatsApp, publicaciones que activan el deseo y un calendario para sostener la constancia.'),

  ('pmp-mensajes-impacto',
   'Módulo 4 · Mensajes de alto impacto',
   'Estructura de mensajes y guiones para cada momento: interés, conversación, objeciones, urgencia, seguimiento, cierre y confianza.'),

  ('pmp-cierre-gatillos',
   'Módulo 5 · Cierre y gatillos mentales',
   'Gatillos mentales aplicados al cierre: autoridad, confianza, urgencia, objeciones y la secuencia final.'),

  ('pmp-facebook-ads',
   'Módulo 6 · Facebook Ads',
   'Campañas desde cero: configuración, conjuntos de anuncios, creativos y copy, segmentación, revisión y medición inicial.'),

  ('pmp-canva-ia-fanpage',
   'Canva, IA y FanPage',
   'Contenido y presencia: Canva para crear piezas, prompts de IA para el sector salud y una FanPage con botón de WhatsApp.')
) as t(id, title, intro)
where public.course_modules.id = t.id
  and public.course_modules.course_id = 'poderosa-maquina-pacientes';

-- El indice de busqueda guarda copia de los titulos: hay que reconstruirlo.
select * from public.rebuild_course_search_documents(array['poderosa-maquina-pacientes']);
