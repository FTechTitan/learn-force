-- ============================================================================
--  Rehace CAR e Imperio Agentic como cursos curados y navegables.
--  Reemplaza el import bruto desde indices Obsidian por modulos pedagogicos,
--  enlaces web reproducibles y actividades accionables.
-- ============================================================================

begin;
alter table public.courses
  add column if not exists media jsonb not null default '{}'::jsonb;
alter table public.course_modules
  add column if not exists media jsonb not null default '{}'::jsonb;
delete from public.course_items
where course_id in ('car-ecosistema-startup', 'imperio-agentico');
delete from public.course_modules
where course_id in ('car-ecosistema-startup', 'imperio-agentico');
insert into public.courses
  (id, title, subtitle, description, emoji, sort_order, is_published, media)
values
  (
    'car-ecosistema-startup',
    'CAR',
    'Cagala, Aprende, Repite',
    'Ruta practica para founders: valida un problema, segmenta el mercado, entiende tus numeros, arma tu narrativa de capital, vende con IA y automatiza operaciones sin convertir el curso en un indice bruto.',
    '🚀',
    50,
    true,
    '{"curation":"pedagogical_rebuild","source":"CAR Skool export","audience":"founders_latam","local_paths_removed":true}'::jsonb
  ),
  (
    'imperio-agentico',
    'Imperio Agentic',
    'Agentes, automatizaciones y vibe-coding',
    'Ruta operativa para construir sistemas agenticos: mentalidad, n8n, Make, Claude Code, OpenClaw, automatizaciones con valor comercial y entrega vendible.',
    '🏛️',
    60,
    true,
    '{"curation":"pedagogical_rebuild","source":"Imperio Agentic Skool export","audience":"builders_automation_agencies","local_paths_removed":true}'::jsonb
  )
on conflict (id) do update set
  title = excluded.title,
  subtitle = excluded.subtitle,
  description = excluded.description,
  emoji = excluded.emoji,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published,
  media = excluded.media,
  updated_at = now();
insert into public.course_modules
  (id, course_id, title, emoji, intro, theory, sort_order, is_published, media)
values
  (
    'car-01-validacion-sin-excusas',
    'car-ecosistema-startup',
    'Validacion sin excusas',
    '🔎',
    'Convierte una idea difusa en evidencia: problema, entrevista, smoke test, disposicion a pago y decision build/pivot/kill.',
    $car_01$
<section>
  <h3>Objetivo del modulo</h3>
  <p>Antes de construir, el alumno debe probar que existe un dolor relevante, un segmento alcanzable y una senal de compra. La meta no es tener razon; es reducir incertidumbre con conversaciones, experimentos y evidencia.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li>Encuentra el problema y separa opinion de evidencia.</li>
    <li><a href="https://youtu.be/PBjF0zQDl1g" target="_blank" rel="noopener">Workshop: encontrar problemas con n8n y Reddit</a>.</li>
    <li>Smoke tests: landing, waitlist, outreach y oferta falsa-controlada.</li>
    <li>Entrevistas anti-sesgo y test de disposicion a pago.</li>
    <li>Preventa y decision build/pivot/kill.</li>
  </ol>
  <h3>Recursos utiles</h3>
  <ul>
    <li><a href="https://youtube.com/live/P6vA5PzOZ0E" target="_blank" rel="noopener">Tutorial complementario: landing gratis con GitHub Pages</a>.</li>
    <li><a href="https://docs.google.com/spreadsheets/d/1FZ3PQXSJMi8HiKcGk4tfRjma_FVuXaX9PWClB5vNGpk/edit?usp=sharing" target="_blank" rel="noopener">Sheet de tracking para smoke test</a>.</li>
    <li><a href="https://docs.google.com/spreadsheets/d/1TgkUUdcfMQ_7nAhL7LSoXf_mOqqc-hCG0rHzsGf8JPY/edit?usp=sharing" target="_blank" rel="noopener">Sheet de entrevistas anti-sesgo</a>.</li>
    <li><a href="https://docs.google.com/spreadsheets/d/1aOB8QXO_GnHq4Zuv4BOdFZiVvHdhMfiyPJZoYKpT5v0/edit?usp=sharing" target="_blank" rel="noopener">Sheet de preventa</a>.</li>
    <li><a href="https://docs.google.com/spreadsheets/d/1x5Ws-CfIUFQlQZ93pvd53PMPRXtakHgs8RJgF9BSfpA/edit?usp=sharing" target="_blank" rel="noopener">Sheet build/pivot/kill</a>.</li>
  </ul>
  <h3>Cierre esperado</h3>
  <p>Terminas con una hipotesis priorizada, una lista de evidencias, un experimento de 48 horas y un criterio concreto para seguir o matar la idea.</p>
</section>
$car_01$,
    10,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'car-02-segmentacion-icp',
    'car-ecosistema-startup',
    'Segmentacion, ICP y buyer personas',
    '🎯',
    'Define a quien venderle primero, cuanto mercado hay y que mensaje merece cada segmento.',
    $car_02$
<section>
  <h3>Objetivo del modulo</h3>
  <p>El alumno deja de hablarle a todo el mercado y elige un segmento donde tenga urgencia, acceso y una propuesta diferenciada. La teoria combina TAM/SAM/SOM, ICP, buyer persona, posicionamiento y metricas de ajuste.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://youtu.be/uD38qRe5Vt8" target="_blank" rel="noopener">Segmentacion de mercado para startups</a>.</li>
    <li><a href="https://youtu.be/hvym80n2uzA" target="_blank" rel="noopener">Definicion de segmentacion</a> y <a href="https://youtu.be/0NUWbBm6E_I" target="_blank" rel="noopener">tipos principales</a>.</li>
    <li><a href="https://youtu.be/RuaPCBCgF84" target="_blank" rel="noopener">TAM</a>, <a href="https://youtu.be/_1BxuOvHmDc" target="_blank" rel="noopener">SAM</a>, <a href="https://www.youtube.com/watch?v=YOUb6HDvXNE" target="_blank" rel="noopener">SOM</a> y <a href="https://www.youtube.com/watch?v=7zRAUTOHvUI" target="_blank" rel="noopener">calculo aplicado</a>.</li>
    <li><a href="https://www.youtube.com/watch?v=JKhtqe5Fjx0" target="_blank" rel="noopener">Diferencia entre ICP y buyer persona</a>, <a href="https://youtu.be/oD9ToA9ketw" target="_blank" rel="noopener">creacion de ICP</a> y <a href="https://www.youtube.com/watch?v=tN1AnadKCAk" target="_blank" rel="noopener">buyer personas detalladas</a>.</li>
    <li><a href="https://youtu.be/thHZeG6cfAg" target="_blank" rel="noopener">Seleccion de segmentos</a>, <a href="https://youtu.be/OMVhNw-xONc" target="_blank" rel="noopener">posicionamiento</a> y <a href="https://www.youtube.com/watch?v=M1S2Ku5WWmQ" target="_blank" rel="noopener">KPIs</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con un ICP operativo, segmentos descartados con razon, promesa por segmento y metricas para validar si el mercado elegido responde.</p>
</section>
$car_02$,
    20,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'car-03-finanzas-base',
    'car-ecosistema-startup',
    'Finanzas aplicadas para decidir',
    '📊',
    'Lee tus numeros sin perderte: margen bruto, costos, unidad de negocio, equilibrio economico y break-even.',
    $car_03$
<section>
  <h3>Objetivo del modulo</h3>
  <p>Transforma las finanzas en una herramienta de decision diaria. El foco esta en entender que vendes, cuanto cuesta entregar, donde se va el margen y cuando el negocio deja de depender de intuicion.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://youtu.be/qaNmTD13nZ4" target="_blank" rel="noopener">Bienvenida y mapa del curso</a>.</li>
    <li>Logica financiera: ingresos, costos, margen, caja y decisiones.</li>
    <li><a href="https://youtu.be/cmFE0ZxK348" target="_blank" rel="noopener">Margenes brutos</a> y <a href="https://youtu.be/e1Lv2qA7GH0" target="_blank" rel="noopener">estructura de costos</a>.</li>
    <li><a href="https://youtu.be/5Ad2C6cRQG8" target="_blank" rel="noopener">Analisis de unidad de negocio</a> y <a href="https://youtu.be/lRB1-K33UYs" target="_blank" rel="noopener">aplicaciones practicas</a>.</li>
    <li><a href="https://youtu.be/-lZuXJx9v24" target="_blank" rel="noopener">Equilibrio economico</a> y <a href="https://youtu.be/IIJ6Qlsjwz4" target="_blank" rel="noopener">break-even financiero</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con un cuadro simple de ingresos, costos variables, costos fijos, margen bruto, punto de equilibrio y decision recomendada.</p>
</section>
$car_03$,
    30,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'car-04-unit-economics-crecimiento',
    'car-ecosistema-startup',
    'Unit economics y crecimiento',
    '📈',
    'Conecta CAC, LTV, payback y ritmo de crecimiento para saber cuando escalar.',
    $car_04$
<section>
  <h3>Objetivo del modulo</h3>
  <p>El alumno deja de medir crecimiento bruto y empieza a medir crecimiento sano. La pregunta central es si cada cliente nuevo mejora o deteriora el negocio.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://youtu.be/2NKh_ybQ8LY" target="_blank" rel="noopener">Introduccion a unit economics</a>.</li>
    <li>Metricas clave: cliente, cohorte, ingreso, costo directo y margen.</li>
    <li><a href="https://vimeo.com/1088008948/5844509ade?fl=pl&amp;fe=sh" target="_blank" rel="noopener">CAC</a> y <a href="https://vimeo.com/1088009004/7c8b65cdca?fl=pl&amp;fe=sh" target="_blank" rel="noopener">LTV</a>.</li>
    <li><a href="https://vimeo.com/1088009120/7689873eb3?fl=pl&amp;fe=sh" target="_blank" rel="noopener">Payback</a> y recuperacion de inversion comercial.</li>
    <li><a href="https://vimeo.com/1088009067/8c9cf7d96f?fl=pl&amp;fe=sh" target="_blank" rel="noopener">Formula del crecimiento rentable</a> y <a href="https://vimeo.com/1088009162/f388ddf307?fl=pl&amp;fe=sh" target="_blank" rel="noopener">cuando escalar</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con una ficha de economia por cliente y una recomendacion: optimizar adquisicion, subir retencion, ajustar precio o escalar.</p>
</section>
$car_04$,
    40,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'car-05-capital-fundraising',
    'car-ecosistema-startup',
    'Capital y fundraising LATAM',
    '💸',
    'Prepara una ronda con estrategia: etapa, actores, documentos, narrativa, acercamiento y terminos.',
    $car_05$
<section>
  <h3>Objetivo del modulo</h3>
  <p>Levantar capital no es mandar un deck a todos. El alumno define si realmente necesita capital, que tipo de inversionista corresponde, que evidencia tiene y como defender su valoracion.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://youtu.be/KpFni9NeI_U" target="_blank" rel="noopener">Preparacion para levantar capital</a>, <a href="https://youtu.be/Tx6FKOBVhZM" target="_blank" rel="noopener">viaje de una startup</a> y <a href="https://youtu.be/os69knwGYOU" target="_blank" rel="noopener">ecosistema emprendedor</a>.</li>
    <li><a href="https://youtu.be/KaMV_rJ9ThM" target="_blank" rel="noopener">Bootstrapping vs capital externo</a>, <a href="https://youtu.be/C7JEJXUOGCU" target="_blank" rel="noopener">tipos de inversionistas</a> y <a href="https://youtu.be/ExLAI8vbmO4" target="_blank" rel="noopener">rondas</a>.</li>
    <li><a href="https://youtu.be/WuN096RoNTI" target="_blank" rel="noopener">Estructura para atraer capital</a>, <a href="https://youtu.be/T8iLOxHYEKA" target="_blank" rel="noopener">documentos clave</a> y <a href="https://youtu.be/mt8FvYBFe9M" target="_blank" rel="noopener">storytelling</a>.</li>
    <li><a href="https://youtu.be/SbNlu84APWQ" target="_blank" rel="noopener">Encontrar inversionistas</a>, <a href="https://youtu.be/lnbzW21n5-g" target="_blank" rel="noopener">proceso de acercamiento</a> y <a href="https://youtu.be/Rvr3CkOAYos" target="_blank" rel="noopener">errores comunes</a>.</li>
    <li><a href="https://youtu.be/8N9wBIwD7Vk" target="_blank" rel="noopener">Defender valoracion</a>, <a href="https://youtu.be/pCk_b49KXUY" target="_blank" rel="noopener">condiciones de inversion</a> y <a href="https://youtu.be/x8MhBjz9r0k" target="_blank" rel="noopener">cierre efectivo</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con readiness de fundraising, lista de inversionistas priorizada, deck narrativo y plan de acercamiento.</p>
</section>
$car_05$,
    50,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'car-06-ventas-ia',
    'car-ecosistema-startup',
    'Ventas con IA y prospeccion',
    '💬',
    'Construye una maquina comercial liviana: canales, mensajes, follow-up, enriquecimiento y limites legales.',
    $car_06$
<section>
  <h3>Objetivo del modulo</h3>
  <p>El alumno disena un flujo comercial que no depende de inspiracion diaria. Parte por elegir el canal correcto, construir listas sanas, escribir mensajes que no parezcan plantilla y decidir que automatizar.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li>Donde esta tu cliente y que canal merece prioridad.</li>
    <li>Reglas de LinkedIn, Sales Navigator y operadores de busqueda.</li>
    <li>Prompt comercial: propuesta, tono, objeciones y follow-up.</li>
    <li>Prospeccion en Instagram y Google sin quemar reputacion.</li>
    <li>Enriquecimiento, calificacion, multicanal y limite legal de automatizacion.</li>
  </ol>
  <h3>Recursos utiles</h3>
  <ul>
    <li><a href="https://claude.ai" target="_blank" rel="noopener">Claude.ai para redactar y revisar mensajes</a>.</li>
    <li><a href="https://www.linkedin.com/search/results/people/" target="_blank" rel="noopener">Busqueda de personas en LinkedIn</a>.</li>
    <li><a href="https://docs.google.com/spreadsheets/d/1zZQkoeRkDfVA5jVGDEQ9VeruW2ZVMoQUMPITTsjBYvQ/edit?usp=sharing" target="_blank" rel="noopener">Sheet de seguimiento comercial</a>.</li>
  </ul>
  <h3>Cierre esperado</h3>
  <p>Terminas con un ICP de venta, 50 prospectos priorizados, secuencia de mensajes y reglas de automatizacion responsable.</p>
</section>
$car_06$,
    60,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'car-07-automatizacion-operativa',
    'car-ecosistema-startup',
    'Automatizacion operativa con n8n',
    '⚙️',
    'Pasa de tareas repetidas a flujos revisables: contenido, leads, agenda, bots y alertas.',
    $car_07$
<section>
  <h3>Objetivo del modulo</h3>
  <p>El alumno identifica procesos repetibles y arma automatizaciones pequenas, con aprobacion humana cuando corresponde. No se trata de automatizar todo, sino lo que recupera tiempo o reduce errores.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li>Que es n8n, cuando automatizar y errores que frenan un flujo.</li>
    <li>Bot de Telegram para decisiones, FAQ, recordatorios y notas de voz.</li>
    <li>Captura de leads, agenda de citas y outreach en lote.</li>
    <li><a href="https://youtu.be/7U9EIoyoC5A" target="_blank" rel="noopener">Workshop: generacion de contenido</a>.</li>
    <li><a href="https://youtu.be/d-X5t6IzzKk" target="_blank" rel="noopener">Workshop: automatizar conversion</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con un mapa de automatizaciones por impacto, un primer flujo de bajo riesgo y una lista de controles humanos.</p>
</section>
$car_07$,
    70,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'imperio-01-mentalidad-agentica',
    'imperio-agentico',
    'Mentalidad agentica y oportunidad',
    '🧠',
    'Entiende que automatizar no es apretar botones: es detectar procesos, disenar sistemas y vender resultados.',
    $imp_01$
<section>
  <h3>Objetivo del modulo</h3>
  <p>El alumno aprende a pensar en sistemas: entradas, reglas, herramientas, memoria, salidas y supervision. La meta es elegir casos de uso con valor real antes de abrir n8n, Make o Claude Code.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://youtu.be/4mFlEyYTNx8" target="_blank" rel="noopener">Introduccion a la mentalidad IA</a>.</li>
    <li><a href="https://youtu.be/TlXA6pK-wro" target="_blank" rel="noopener">Generalista vs especialista</a>.</li>
    <li><a href="https://youtu.be/9oBWmLT5TeQ" target="_blank" rel="noopener">GPTs como agentes especialistas</a>.</li>
    <li><a href="https://youtu.be/WSOxMTqXXdk" target="_blank" rel="noopener">Pensar en prompts</a> y <a href="https://youtu.be/CWWEsUT1PHE" target="_blank" rel="noopener">automatizar procesos especialistas</a>.</li>
    <li><a href="https://youtu.be/-_Il0lauJQs" target="_blank" rel="noopener">Deep Research aplicado</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con tres oportunidades de automatizacion priorizadas por dolor, frecuencia, datos disponibles y riesgo.</p>
</section>
$imp_01$,
    10,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'imperio-02-n8n-desde-cero',
    'imperio-agentico',
    'n8n desde cero',
    '🧩',
    'Domina los nodos que mas se repiten y arma flujos entendibles antes de construir agentes complejos.',
    $imp_02$
<section>
  <h3>Objetivo del modulo</h3>
  <p>El alumno construye criterio operativo en n8n: triggers, datos, ramas, loops, webhooks, llamadas HTTP, merges y AI Agent. La ruta privilegia patrones reutilizables.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://www.loom.com/share/76c055a5fd0b40f58db5fa4807ec9b78" target="_blank" rel="noopener">Que es automatizar</a>, <a href="https://www.loom.com/share/b98bb24da5554a739572dbdfcbcbeaec" target="_blank" rel="noopener">logica y ejemplos</a>, <a href="https://www.loom.com/share/9b2102ce6a544e119e168ccdbbdf1df8" target="_blank" rel="noopener">tour por n8n</a>.</li>
    <li><a href="https://www.loom.com/share/e57f71a58ac641e19c490012da134938" target="_blank" rel="noopener">Instalacion</a>, <a href="https://www.loom.com/share/639654e781e445009619988bcc97ccfb" target="_blank" rel="noopener">Google x n8n</a> y <a href="https://www.loom.com/share/af697f4d2c9848068b62b3ad5898c04c" target="_blank" rel="noopener">primera automatizacion con IA</a>.</li>
    <li>Schedule, event triggers, sub-workflows, split out, aggregate, edit fields, if y switch.</li>
    <li><a href="https://www.loom.com/share/5e9e1bbca68c42c5880feedbbd728d72" target="_blank" rel="noopener">Code</a>, <a href="https://www.loom.com/share/703cf76fd3874d4aa223d7c5445666ad" target="_blank" rel="noopener">HTTP Request</a>, <a href="https://www.loom.com/share/9284535b97564370a1bac6bad1d1d2ba" target="_blank" rel="noopener">Webhook</a>.</li>
    <li><a href="https://www.loom.com/share/8a0fe4397aa542168bc7d3c5cc71ab21" target="_blank" rel="noopener">AI Agent</a>, merge e information extractor.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con una automatizacion pequena documentada, probada por pasos y lista para evolucionar a caso real.</p>
</section>
$imp_02$,
    20,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'imperio-03-make-sistemas',
    'imperio-agentico',
    'Make y sistemas no-code',
    '🔁',
    'Construye automatizaciones comerciales y de contenido con Make sin perder control del proceso.',
    $imp_03$
<section>
  <h3>Objetivo del modulo</h3>
  <p>Make sirve para prototipar y entregar soluciones rapido. Este modulo agrupa casos concretos: contenido, scraping, leads, WhatsApp, facturacion y publicacion multicanal.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://www.youtube.com/watch?v=Mn0hVWuG4uU" target="_blank" rel="noopener">Intro a Make para principiantes</a> y <a href="https://youtu.be/UVxh6GVqVyM" target="_blank" rel="noopener">conectar cualquier IA</a>.</li>
    <li><a href="https://youtu.be/PcXe9oej_z4" target="_blank" rel="noopener">UGC automatico con Sora</a>, <a href="https://youtu.be/K3Jg1J6uGXY" target="_blank" rel="noopener">contenido en RRSS</a> y <a href="https://youtu.be/fQmUR-jIzZ0" target="_blank" rel="noopener">blog WordPress</a>.</li>
    <li><a href="https://youtu.be/U7yrtOu_omU" target="_blank" rel="noopener">Resenas de Amazon con Apify</a>, <a href="https://www.youtube.com/watch?v=7dK71uG40Og" target="_blank" rel="noopener">ads de competidores</a> y <a href="https://youtu.be/zSPvxqSc3kc" target="_blank" rel="noopener">grupos de Facebook</a>.</li>
    <li><a href="https://www.youtube.com/watch?v=6I780zheHzU" target="_blank" rel="noopener">Calificacion automatica de leads</a>, <a href="https://www.youtube.com/watch?v=XYQX-A3sh9c" target="_blank" rel="noopener">propuestas personalizadas</a> y <a href="https://www.youtube.com/watch?v=dbETsmaJ_QQ" target="_blank" rel="noopener">correos masivos personalizados</a>.</li>
    <li><a href="https://www.youtube.com/watch?v=c_VVCadaOx0" target="_blank" rel="noopener">Facturacion automatica</a>, <a href="https://youtu.be/t9hgwrzyZg8" target="_blank" rel="noopener">tareas desde ChatGPT</a> y <a href="https://youtu.be/Fqkpuw-DCRM" target="_blank" rel="noopener">primer agente en Make</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con un caso Make elegido, datos de entrada, herramientas conectadas, prueba manual y checklist de fallas probables.</p>
</section>
$imp_03$,
    30,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'imperio-04-n8n-aplicado',
    'imperio-agentico',
    'n8n aplicado a negocio',
    '🤖',
    'Pasa de nodos a productos: LinkedIn, WhatsApp, facturacion, scraping, imagenes y despliegue.',
    $imp_04$
<section>
  <h3>Objetivo del modulo</h3>
  <p>Este modulo toma n8n como plataforma de productos: automatizaciones que un cliente entiende y podria pagar. Se ordena por caso de uso y no por inventario.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://youtu.be/ePy0_ZYwFik" target="_blank" rel="noopener">Cold email en n8n</a>, <a href="https://youtu.be/721W4daXwLU" target="_blank" rel="noopener">agente de contenido en LinkedIn</a> y <a href="https://www.loom.com/share/219866bc26964cb689e61f60c64f56a2" target="_blank" rel="noopener">configuracion del agente LinkedIn</a>.</li>
    <li><a href="https://youtu.be/UVAqelGsSOk" target="_blank" rel="noopener">Sistema de facturacion automatica</a> con <a href="https://docs.google.com/spreadsheets/d/1oblK8r_MUF3GKpFibFIcB4uAa_vwiReNVb8fIF5OymE/edit?usp=sharing" target="_blank" rel="noopener">plantilla Sheets</a>.</li>
    <li><a href="https://www.loom.com/share/0759eadf82c94ff9b10a98806fba1299" target="_blank" rel="noopener">Agente de WhatsApp que agenda y recuerda</a>.</li>
    <li><a href="https://youtu.be/EFcGuhY8XWk" target="_blank" rel="noopener">Instalacion n8n en VPS</a>, <a href="https://www.loom.com/share/65017562294c4506af96f8bee37bf121" target="_blank" rel="noopener">Evolution API</a> y <a href="https://www.loom.com/share/f571b6bfdb8e409b842a47d4caebef0d" target="_blank" rel="noopener">Chatwoot</a>.</li>
    <li><a href="https://youtu.be/wxvI7N7IFQE" target="_blank" rel="noopener">Comerciales cinematicos</a>, <a href="https://www.loom.com/share/4c72649db64e4f73988d67800e2b8968" target="_blank" rel="noopener">generador de imagenes</a> y <a href="https://www.loom.com/share/25f9a42af2304f50b0b2720fe21a4c64" target="_blank" rel="noopener">scraping de videos con transcript</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con una propuesta de automatizacion vendible: problema, demo, stack, alcance, riesgos y precio base.</p>
</section>
$imp_04$,
    40,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'imperio-05-claude-code',
    'imperio-agentico',
    'Claude Code como motor de entrega',
    '⌨️',
    'Usa Claude Code para construir, automatizar navegador, conservar contexto y acelerar entregas reales.',
    $imp_05$
<section>
  <h3>Objetivo del modulo</h3>
  <p>Claude Code no es solo una herramienta de programacion. En esta ruta se usa para planificar, construir, operar navegador con Playwright, trabajar con memoria y crear capacidades reutilizables.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://www.youtube.com/watch?v=73eFWU-edO4&amp;t=30s" target="_blank" rel="noopener">Curso completo Claude Code</a> y sesiones bien estructuradas.</li>
    <li><a href="https://www.youtube.com/watch?v=dghyElh4EFw" target="_blank" rel="noopener">Playwright para automatizar navegador</a> y <a href="https://youtu.be/p5YgvC6yzCs" target="_blank" rel="noopener">Obsidian como memoria</a>.</li>
    <li><a href="https://www.youtube.com/watch?v=9JvIRYLwetU&amp;t=242s" target="_blank" rel="noopener">Claude Skills</a>, <a href="https://youtu.be/_aD00IQTgdY" target="_blank" rel="noopener">motor agentico</a> y <a href="https://www.youtube.com/watch?v=v9PreCpgVkU" target="_blank" rel="noopener">Graphify</a>.</li>
    <li><a href="https://youtu.be/8hqFUQNFPew?si=uRO8Z2iQWmCXmBi8" target="_blank" rel="noopener">GoHighLevel + Claude Code</a> y <a href="https://www.youtube.com/watch?v=mfk82SbXgGo&amp;t=93s" target="_blank" rel="noopener">Meta Ads Manager</a>.</li>
    <li><a href="https://www.youtube.com/watch?v=Au-igeiNF2c" target="_blank" rel="noopener">Control remoto</a> y <a href="https://www.youtube.com/watch?v=dJYauJwcalA" target="_blank" rel="noopener">framework SMART</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con un protocolo de trabajo en Claude Code: contexto, plan, validacion, artefactos y memoria para no partir de cero cada vez.</p>
</section>
$imp_05$,
    50,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'imperio-06-openclaw-hermes',
    'imperio-agentico',
    'OpenClaw, Hermes y agentes persistentes',
    '🦞',
    'Instala y protege un agente persistente con memoria, herramientas, Telegram, Tailscale y casos reales.',
    $imp_06$
<section>
  <h3>Objetivo del modulo</h3>
  <p>El alumno pasa de usar IA por chat a operar un agente con identidad, herramientas, memoria y acceso controlado. El foco es seguridad, persistencia y primer caso de uso real.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li><a href="https://youtu.be/FQZGoSwdS_0" target="_blank" rel="noopener">Hermes 2026: curso completo de agente IA</a>.</li>
    <li><a href="https://youtu.be/gYXRFI9i9IU" target="_blank" rel="noopener">Que es OpenClaw</a> y <a href="https://www.youtube.com/watch?v=KPg5s5SZfck&amp;t=6s" target="_blank" rel="noopener">opinion despues de uso real</a>.</li>
    <li><a href="https://www.loom.com/share/426a6b039fec4b8a8331885dd4ec0a7f" target="_blank" rel="noopener">Instalacion en VPS</a>, <a href="https://www.youtube.com/watch?v=i5piRc39NPU&amp;t=327s" target="_blank" rel="noopener">Mac Mini</a> y <a href="https://www.youtube.com/watch?v=k0RmZG87XTU" target="_blank" rel="noopener">Ollama local</a>.</li>
    <li><a href="https://www.loom.com/share/7f64fa4debe444898693eb3dc886bd8b" target="_blank" rel="noopener">Tailscale y tunel privado</a>, <a href="https://youtu.be/rPAKq2oQVBs" target="_blank" rel="noopener">proteccion de OpenClaw</a> y <a href="https://www.loom.com/share/7cd649403fc2458299c18aab073be308" target="_blank" rel="noopener">Telegram</a>.</li>
    <li><a href="https://www.youtube.com/watch?v=M8kOnNLL-3E" target="_blank" rel="noopener">Framework SOUL</a>, <a href="https://www.youtube.com/watch?v=8kNv3rjQaVA" target="_blank" rel="noopener">caso real 1</a> y <a href="https://www.youtube.com/watch?v=Q7r--i9lLck" target="_blank" rel="noopener">caso real 2</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con una arquitectura documentada de tu agente: entorno, acceso, identidad, memoria, herramientas, backups y primer caso de uso.</p>
</section>
$imp_06$,
    60,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  ),
  (
    'imperio-07-vender-automatizaciones',
    'imperio-agentico',
    'Vender automatizaciones de alto valor',
    '💼',
    'Convierte sistemas agenticos en ofertas entendibles, con alcance, precio, demo, propuesta y gestion.',
    $imp_07$
<section>
  <h3>Objetivo del modulo</h3>
  <p>La capacidad tecnica no sirve si no se traduce a resultado de negocio. Este modulo ordena oferta, pricing, venta consultiva, propuesta, contrato, planificacion y entrega.</p>
  <h3>Ruta de clases</h3>
  <ol>
    <li>Por que vender IA y automatizaciones: dolor, urgencia y presupuesto.</li>
    <li>Automatizaciones de alto valor y lista de casos vendibles.</li>
    <li><a href="https://youtu.be/AHUqyWOU3zs" target="_blank" rel="noopener">Modelos de negocio y pricing</a>.</li>
    <li><a href="https://youtu.be/CHk4ALAH4TI" target="_blank" rel="noopener">Presentar propuestas irresistibles</a> y gestion del cliente.</li>
    <li><a href="https://youtu.be/SeRgxNPM390" target="_blank" rel="noopener">Planificar proyectos de automatizacion</a> y <a href="https://www.youtube.com/watch?v=mFIQVViF0PU" target="_blank" rel="noopener">gestionar desarrollos</a>.</li>
  </ol>
  <h3>Cierre esperado</h3>
  <p>Terminas con una oferta empaquetada: problema, entregable, alcance, precio, timeline, demo y condiciones de soporte.</p>
</section>
$imp_07$,
    70,
    true,
    '{"lessons":5,"activities":2}'::jsonb
  )
on conflict (id) do update set
  course_id = excluded.course_id,
  title = excluded.title,
  emoji = excluded.emoji,
  intro = excluded.intro,
  theory = excluded.theory,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published,
  media = excluded.media,
  updated_at = now();
insert into public.course_items
  (id, course_id, module_id, type, title, level, statement_html, hint, tests, options, solution_html, sort_order, is_published)
values
  ('car-01-validacion-hipotesis', 'car-ecosistema-startup', 'car-01-validacion-sin-excusas', 'development', 'Mapa de hipotesis y evidencia', 2, '<p>Escribe tu idea en formato problema-segmento-promesa. Luego lista 5 supuestos criticos y que evidencia concreta aceptarias para validar o invalidar cada uno.</p>', 'Los supuestos mas peligrosos suelen ser dolor, urgencia, canal y pago.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: tabla con supuesto, riesgo, experimento, evidencia minima y decision posible.</p>', 10, true),
  ('car-01-validacion-sprint-48h', 'car-ecosistema-startup', 'car-01-validacion-sin-excusas', 'development', 'Sprint de validacion 48h', 3, '<p>Disena un experimento que puedas ejecutar en 48 horas: audiencia, mensaje, canal, CTA, metrica principal y umbral para seguir o pivotar.</p>', 'Evita experimentos que solo midan likes; busca conversacion, respuesta o compromiso.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: plan de 48 horas con metrica, umbral y siguiente decision.</p>', 20, true),
  ('car-02-segmentacion-icp', 'car-ecosistema-startup', 'car-02-segmentacion-icp', 'development', 'ICP operativo', 2, '<p>Define tu ICP inicial con industria, tamano, cargo comprador, evento gatillante, dolor caro, alternativa actual y objecion esperada.</p>', 'Un buen ICP permite decir no a segmentos atractivos pero dispersos.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: ficha ICP y tres segmentos descartados con motivo.</p>', 10, true),
  ('car-02-segmentacion-tam-sam-som', 'car-ecosistema-startup', 'car-02-segmentacion-icp', 'development', 'TAM/SAM/SOM util', 3, '<p>Estima TAM, SAM y SOM con supuestos explicitos. Luego traduce esos numeros a una meta comercial de 90 dias.</p>', 'No busques precision falsa; busca orden de magnitud y decision.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: estimacion razonada y meta de ventas conectada al segmento.</p>', 20, true),
  ('car-03-finanzas-break-even', 'car-ecosistema-startup', 'car-03-finanzas-base', 'development', 'Break-even del negocio', 3, '<p>Calcula ingresos, costos variables, margen bruto, costos fijos y punto de equilibrio mensual para tu oferta principal.</p>', 'Si tienes varias ofertas, parte por la que mas quieres vender este trimestre.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: break-even mensual y decision sobre precio, costo o volumen.</p>', 10, true),
  ('car-03-finanzas-decision', 'car-ecosistema-startup', 'car-03-finanzas-base', 'development', 'Decision financiera semanal', 2, '<p>Elige una decision actual del negocio y responde con numeros: que cambia en margen, caja, costo fijo o capacidad si la ejecutas.</p>', 'La decision debe ser real: contratar, subir precio, invertir, pausar o automatizar.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: recomendacion con supuesto financiero y riesgo principal.</p>', 20, true),
  ('car-04-unit-economics-ficha', 'car-ecosistema-startup', 'car-04-unit-economics-crecimiento', 'development', 'Ficha de unit economics', 3, '<p>Arma una ficha por cliente: CAC, ingreso promedio, margen bruto, retencion esperada, LTV, payback y principal palanca de mejora.</p>', 'Si aun no tienes datos, usa rangos y marca que dato debes medir primero.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: ficha por cliente y una recomendacion de optimizacion.</p>', 10, true),
  ('car-04-unit-economics-escalar', 'car-ecosistema-startup', 'car-04-unit-economics-crecimiento', 'development', 'Semaforo de escalamiento', 3, '<p>Evalua si estas listo para escalar: canal, CAC, LTV, payback, capacidad operativa, churn y soporte. Marca rojo, amarillo o verde por criterio.</p>', 'Escalar con payback confuso normalmente solo acelera problemas.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: semaforo y decision de escalar, optimizar o pausar.</p>', 20, true),
  ('car-05-capital-readiness', 'car-ecosistema-startup', 'car-05-capital-fundraising', 'development', 'Readiness de ronda', 3, '<p>Evalua si debes levantar capital ahora: traccion, mercado, equipo, runway, uso de fondos, narrativa y alternativas a diluirte.</p>', 'Incluye una razon honesta para no levantar todavia si aplica.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: diagnostico de readiness y decision de levantar, preparar o postergar.</p>', 10, true),
  ('car-05-capital-inversionistas', 'car-ecosistema-startup', 'car-05-capital-fundraising', 'development', 'Lista priorizada de inversionistas', 3, '<p>Construye una lista de 15 inversionistas o fondos. Para cada uno anota tesis, etapa, ticket, conexion posible y primer mensaje.</p>', 'Prioriza fit de tesis sobre fama.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: pipeline de inversionistas con prioridad y siguiente accion.</p>', 20, true),
  ('car-06-ventas-secuencia', 'car-ecosistema-startup', 'car-06-ventas-ia', 'development', 'Secuencia outbound con IA', 2, '<p>Crea una secuencia de 4 mensajes: conexion, primer valor, follow-up y cierre suave. Debe sonar humano y especifico para tu ICP.</p>', 'Escribe primero el criterio de personalizacion antes del copy.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: secuencia lista para probar con 20 prospectos.</p>', 10, true),
  ('car-06-ventas-lista', 'car-ecosistema-startup', 'car-06-ventas-ia', 'development', 'Lista comercial limpia', 2, '<p>Define campos minimos para una lista de prospectos: empresa, cargo, senal de dolor, canal, fuente, estado y proximo paso.</p>', 'Una lista usable es mejor que una base gigante sin contexto.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: estructura de CRM simple y criterios de calificacion.</p>', 20, true),
  ('car-07-automatizacion-mapa', 'car-ecosistema-startup', 'car-07-automatizacion-operativa', 'development', 'Mapa de automatizaciones', 2, '<p>Lista 10 tareas repetitivas y puntua frecuencia, tiempo, error, riesgo y facilidad. Elige una para automatizar primero.</p>', 'No partas por la mas entretenida; parte por la que libera tiempo sin alto riesgo.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: matriz priorizada y primera automatizacion seleccionada.</p>', 10, true),
  ('car-07-automatizacion-diseno', 'car-ecosistema-startup', 'car-07-automatizacion-operativa', 'development', 'Diseno de flujo con control humano', 3, '<p>Disena el flujo elegido: trigger, datos de entrada, pasos, aprobacion humana, salida, errores posibles y metrica de exito.</p>', 'Incluye siempre como se detiene o revisa el flujo si algo sale mal.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: diagrama textual del flujo y checklist de control.</p>', 20, true),
  ('imperio-01-oportunidades', 'imperio-agentico', 'imperio-01-mentalidad-agentica', 'development', 'Radar de oportunidades agenticas', 2, '<p>Identifica 10 procesos que podrian beneficiarse de IA. Puntua dolor, frecuencia, valor economico, datos disponibles y riesgo.</p>', 'Un proceso frecuente y aburrido suele ser mejor candidato que uno raro y glamoroso.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: ranking de oportunidades y caso elegido.</p>', 10, true),
  ('imperio-01-sistema', 'imperio-agentico', 'imperio-01-mentalidad-agentica', 'development', 'Anatomia del sistema', 2, '<p>Para el caso elegido define entrada, decision, herramientas, memoria, salida, aprobacion humana y fallback.</p>', 'Si no puedes dibujarlo sin herramienta, aun no esta listo para automatizar.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: ficha de arquitectura del caso.</p>', 20, true),
  ('imperio-02-n8n-flujo-base', 'imperio-agentico', 'imperio-02-n8n-desde-cero', 'development', 'Primer flujo n8n documentado', 2, '<p>Disena un flujo n8n con trigger, transformacion, rama condicional y salida. Documenta que hace cada nodo y como lo probarias.</p>', 'Incluye datos de prueba antes de pensar en produccion.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: flujo explicado nodo por nodo y plan de pruebas.</p>', 10, true),
  ('imperio-02-n8n-patron', 'imperio-agentico', 'imperio-02-n8n-desde-cero', 'development', 'Patron reutilizable', 3, '<p>Convierte tu flujo en patron reutilizable: que variables cambian, que partes son fijas, que errores esperas y como lo monitoreas.</p>', 'Un patron bueno sirve para el segundo cliente con pocos cambios.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: plantilla de patron reutilizable.</p>', 20, true),
  ('imperio-03-make-caso', 'imperio-agentico', 'imperio-03-make-sistemas', 'development', 'Caso Make de alto impacto', 2, '<p>Elige un caso Make y define datos de entrada, apps, IA usada, aprobaciones, salida y valor para el negocio.</p>', 'Evita automatizaciones sin usuario claro.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: especificacion del caso y primer demo.</p>', 10, true),
  ('imperio-03-make-checklist', 'imperio-agentico', 'imperio-03-make-sistemas', 'development', 'Checklist de entrega Make', 3, '<p>Prepara checklist de entrega: credenciales, escenarios, manejo de errores, limites de API, logs, traspaso y soporte.</p>', 'El cliente paga por un sistema operable, no por un escenario bonito.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: checklist operativo para entregar Make.</p>', 20, true),
  ('imperio-04-n8n-producto', 'imperio-agentico', 'imperio-04-n8n-aplicado', 'development', 'Producto n8n vendible', 3, '<p>Convierte una automatizacion n8n en producto: problema, usuario, demo, integraciones, dependencias, setup y precio inicial.</p>', 'Un producto vendible se explica en lenguaje de negocio.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: ficha de producto n8n.</p>', 10, true),
  ('imperio-04-n8n-riesgos', 'imperio-agentico', 'imperio-04-n8n-aplicado', 'development', 'Riesgos de produccion', 3, '<p>Lista riesgos tecnicos y comerciales: credenciales, datos personales, caidas, errores de IA, cambios de API y soporte. Define mitigacion.</p>', 'Marca que riesgos requieren aprobacion humana o contrato.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: matriz de riesgos y mitigaciones.</p>', 20, true),
  ('imperio-05-claude-protocolo', 'imperio-agentico', 'imperio-05-claude-code', 'development', 'Protocolo Claude Code', 2, '<p>Disena tu protocolo de trabajo: contexto inicial, plan, branch, validacion, artefactos, memoria y cierre.</p>', 'El objetivo es repetir calidad, no depender de una sesion inspirada.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: protocolo reusable para proyectos.</p>', 10, true),
  ('imperio-05-claude-skill', 'imperio-agentico', 'imperio-05-claude-code', 'development', 'Capacidad reutilizable', 3, '<p>Elige una tarea recurrente y describe como la convertirias en skill/procedimiento: trigger, pasos, inputs, validacion y salida.</p>', 'No automatices memoria mala; define primero el procedimiento correcto.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: especificacion de skill o procedimiento.</p>', 20, true),
  ('imperio-06-openclaw-arquitectura', 'imperio-agentico', 'imperio-06-openclaw-hermes', 'development', 'Arquitectura OpenClaw segura', 3, '<p>Define tu arquitectura: host, acceso, tunel, autenticacion, Telegram, memoria, herramientas, backups y monitoreo.</p>', 'La seguridad es parte del producto, no un extra posterior.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: diagrama textual y checklist de seguridad.</p>', 10, true),
  ('imperio-06-openclaw-caso', 'imperio-agentico', 'imperio-06-openclaw-hermes', 'development', 'Primer caso persistente', 3, '<p>Elige un caso para tu agente persistente y define que hara cada dia, que datos necesita, cuando pide ayuda y como reporta resultados.</p>', 'Prefiere un caso repetible con salida verificable.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: caso operativo con cadencia y evidencias.</p>', 20, true),
  ('imperio-07-venta-oferta', 'imperio-agentico', 'imperio-07-vender-automatizaciones', 'development', 'Oferta empaquetada', 3, '<p>Empaqueta una automatizacion como oferta: dolor, resultado, alcance, demo, precio, timeline, exclusiones y soporte.</p>', 'Las exclusiones evitan proyectos infinitos.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: oferta de una pagina lista para conversar con prospectos.</p>', 10, true),
  ('imperio-07-venta-propuesta', 'imperio-agentico', 'imperio-07-vender-automatizaciones', 'development', 'Propuesta y plan de entrega', 3, '<p>Arma propuesta para un cliente hipotetico: diagnostico, solucion, fases, entregables, responsabilidades, precio y criterios de aceptacion.</p>', 'Incluye criterios de aceptacion medibles.', '[]'::jsonb, '[]'::jsonb, '<p>Entrega esperada: propuesta resumida y plan de entrega.</p>', 20, true)
on conflict (id) do update set
  course_id = excluded.course_id,
  module_id = excluded.module_id,
  type = excluded.type,
  title = excluded.title,
  level = excluded.level,
  statement_html = excluded.statement_html,
  hint = excluded.hint,
  tests = excluded.tests,
  options = excluded.options,
  solution_html = excluded.solution_html,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published,
  updated_at = now();
commit;
