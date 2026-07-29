-- ============================================================================
--  Cursos personales de marketing y WhatsApp Business.
--  Fuente: notas Obsidian personales de Francisco en PERSONAL/Cursos.
--  Los videos Drive quedan como recursos externos; no se usan como media.video
--  porque las URL webViewLink no son URLs directas reproducibles por <video>.
-- ============================================================================

insert into public.courses
  (id, title, subtitle, description, emoji, sort_order, is_published, media)
values
  (
    'poderosa-maquina-pacientes',
    'La Poderosa Maquina de Pacientes',
    'Marketing conversacional para captar y agendar pacientes',
    'Curso de neuromarketing, WhatsApp Business, mensajes persuasivos, contenidos, Facebook Ads, Canva, IA y FanPage para transformar conversaciones en agendas.',
    '🧲',
    30,
    true,
    '{}'::jsonb
  ),
  (
    'whatsagenda-pro',
    'WhatsAgenda Pro',
    'WhatsApp Business y FanPage para agenda de consulta',
    'Curso practico para configurar WhatsApp Business, FanPage, perfil de consulta, catalogo, etiquetas, respuestas rapidas y mensajes PAS apoyados con ChatGPT.',
    '💬',
    40,
    true,
    '{}'::jsonb
  )
on conflict (id) do update set
  title = excluded.title,
  subtitle = excluded.subtitle,
  description = excluded.description,
  emoji = excluded.emoji,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published,
  media = excluded.media;

insert into public.course_modules
  (id, course_id, title, emoji, intro, theory, sort_order, is_published, media)
values
  (
    'pmp-introduccion-sesiones',
    'poderosa-maquina-pacientes',
    'Introduccion y sesiones online',
    '🎬',
    'Arranque del curso, sesiones en vivo y foco de aplicacion: captar pacientes con redes, WhatsApp y contenido accionable.',
    $html$<p>El curso parte con una idea operativa: el telefono y WhatsApp pueden funcionar como una maquina de ventas si hay posicionamiento, contenido y seguimiento. La nota historica insiste en aplicar el curso completo, crear redes sociales, conectar boton WhatsApp, instalar ChatGPT y trabajar con foco.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/drive/folders/14ri8jTgHw7BbbssKQ8biZOXxkDV4Pfes" target="_blank" rel="noopener">Carpeta Drive del curso La Poderosa Maquina de Pacientes</a></li>
  <li>Videos: Bienvenida; Sesion 1 Manejo de Redes Sociales; Sesion 2 Palabras Poderosas; Sesion 3 Embudo de Ventas con NeuroWhatsapp; Sesion 4 Codigos reptiles; Sesion 5 Publicaciones atractivas; Sesion 6 Facebook Ads.</li>
</ul>$html$,
    10,
    true,
    '{}'::jsonb
  ),
  (
    'pmp-neuromarketing-persuasion',
    'poderosa-maquina-pacientes',
    'Neuromarketing y persuasion',
    '🧠',
    'Base de neuroventas: palabras poderosas, codigos reptiles, tres cerebros y publicidad enfocada en deseo, dolor y accion.',
    $html$<p>El modulo trabaja persuasion aplicada a salud: definir a quien se habla, poner el dedo en la llaga con cuidado, usar palabras poderosas y activar motivadores de atencion antes de vender. La nota historica aterriza el avatar en madres de adolescentes con preocupaciones de autoestima, ansiedad, depresion o socializacion.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/drive/folders/14ri8jTgHw7BbbssKQ8biZOXxkDV4Pfes" target="_blank" rel="noopener">Carpeta Drive del curso</a></li>
  <li>Videos: La magia del Neuromarketing; Palabras poderosas; Frases y parrafos persuasivos; Persuasion; Dinamica de los 3 cerebros; Codigos reptiles; Modelo boton instintivo; Tips de Neuroventas para publicidad.</li>
</ul>$html$,
    20,
    true,
    '{}'::jsonb
  ),
  (
    'pmp-whatsapp-trafico',
    'poderosa-maquina-pacientes',
    'WhatsApp Business y trafico',
    '📲',
    'Configuracion de WhatsApp Business y embudo conversacional para trafico frio, tibio y caliente.',
    $html$<p>El modulo cubre respaldo, instalacion, diferencias entre WhatsApp y WhatsApp Business, perfil de empresa, respuestas rapidas, catalogos, etiquetas y funnel. El objetivo es pasar de trafico frio a conversacion con contexto, capturando nombre, telefono, correo y preferencia de ayuda.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/drive/folders/14ri8jTgHw7BbbssKQ8biZOXxkDV4Pfes" target="_blank" rel="noopener">Carpeta Drive del curso</a></li>
  <li>Videos: Respaldar informacion; Instalar WhatsApp Business; Perfil de empresa; Respuestas automaticas y rapidas; Catalogos; Etiquetas; Funnel de ventas; Trafico frio, tibio y caliente.</li>
</ul>$html$,
    30,
    true,
    '{}'::jsonb
  ),
  (
    'pmp-estados-calendario',
    'poderosa-maquina-pacientes',
    'Estados, calendario y persuasion',
    '🗓️',
    'Uso de estados y calendario editorial para construir confianza, educar y abrir conversaciones.',
    $html$<p>La nota historica recomienda publicar con calendario, calentar audiencias y mezclar profesionalismo, servicios, casos, ofertas y contenido de valor. La logica es que la persona no entra a redes a comprar, sino a consumir contenido; el contenido debe atraer antes de pedir agenda.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/drive/folders/14ri8jTgHw7BbbssKQ8biZOXxkDV4Pfes" target="_blank" rel="noopener">Carpeta Drive del curso</a></li>
  <li>Videos: Atrapando con persuasion; Vender con calendario de publicaciones; En vivo vender por estados.</li>
</ul>$html$,
    40,
    true,
    '{}'::jsonb
  ),
  (
    'pmp-mensajes-impacto',
    'poderosa-maquina-pacientes',
    'Mensajes de alto impacto',
    '✍️',
    'Frameworks PAS, AIDA, CCCA, rapport y practicas para convertir interes en conversaciones agendables.',
    $html$<p>Este modulo baja la persuasion al mensaje: razones por las que no se agenda, errores de copy, rapport, PAS, AIDA, CCCA y practica desde el celular. El foco no es sonar vendedor, sino hacer que la persona vea ayuda concreta y un siguiente paso simple.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/drive/folders/14ri8jTgHw7BbbssKQ8biZOXxkDV4Pfes" target="_blank" rel="noopener">Carpeta Drive del curso</a></li>
  <li>Videos: Razones por las que no agendas; Error comun; Rapport en mensajes; Metodo PAS; Metodo AIDA; Metodo CCCA; Construir mensajes desde el celular; Practicas para agendar pacientes.</li>
</ul>$html$,
    50,
    true,
    '{}'::jsonb
  ),
  (
    'pmp-cierre-gatillos',
    'poderosa-maquina-pacientes',
    'Cierre y gatillos mentales',
    '🔐',
    'Cierre conversacional, pertenencia, anticipacion, urgencia y seguimiento para acelerar agenda.',
    $html$<p>El cierre se apoya en gatillos mentales y en reducir friccion: pertenencia, anticipacion, urgencia y un camino claro para agendar. La nota enfatiza usar tiempo limitado y llamados de accion concretos sin perder el tono de ayuda.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/drive/folders/14ri8jTgHw7BbbssKQ8biZOXxkDV4Pfes" target="_blank" rel="noopener">Carpeta Drive del curso</a></li>
  <li>Videos: Camino para agendar pacientes; Gatillo de pertenencia; Anticipacion; Urgencia; Secreto para agendar rapido; Practica de cierre con gatillos.</li>
</ul>$html$,
    60,
    true,
    '{}'::jsonb
  ),
  (
    'pmp-facebook-ads',
    'poderosa-maquina-pacientes',
    'Facebook Ads',
    '📣',
    'Configuracion inicial de anuncios, segmentacion, presupuesto, creatividad y campana orientada a WhatsApp.',
    $html$<p>El modulo cubre administrador de anuncios, objetivos, publicos personalizados, metodo de pago, segmentacion y campañas de resultados. La nota historica sugiere empezar con 3 a 4 piezas, bajo presupuesto, mujeres de 30 a 50, intereses ligados a salud mental y mensajes con promesa de valor, imagen de impacto y CTA.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/drive/folders/14ri8jTgHw7BbbssKQ8biZOXxkDV4Pfes" target="_blank" rel="noopener">Carpeta Drive del curso</a></li>
  <li>Videos: Administrador de anuncios; Objetivos; Publicos personalizados; Metodo de pago; Segmentacion; Campana de resultados; Campana navidena de agendamiento.</li>
</ul>$html$,
    70,
    true,
    '{}'::jsonb
  ),
  (
    'pmp-canva-ia-fanpage',
    'poderosa-maquina-pacientes',
    'Canva, IA y FanPage',
    '🎨',
    'Creacion de piezas, prompts para salud, FanPage, boton WhatsApp y publicaciones con apoyo de IA.',
    $html$<p>El cierre practico del curso junta Canva, IA, FanPage y grupos de Facebook. La nota historica propone piezas con imagen de impacto, slogan, CTA y variaciones para probar; tambien usar ChatGPT para generar guias de contenido y copies.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/drive/folders/14ri8jTgHw7BbbssKQ8biZOXxkDV4Pfes" target="_blank" rel="noopener">Carpeta Drive del curso</a></li>
  <li>Videos: Encontrar clientes en grupos; Canva; Anuncio en Canva; Instrucciones a IA; Prompts para sector salud; Perfil vs FanPage; Crear FanPage; Boton WhatsApp; Publicar con boton.</li>
</ul>$html$,
    80,
    true,
    '{}'::jsonb
  ),
  (
    'wap-estrategia-atraccion',
    'whatsagenda-pro',
    'Estrategia de atraccion',
    '🎯',
    'Primer paso para atraer pacientes con una promesa clara, contenido y un camino hacia WhatsApp.',
    $html$<p>La estrategia comienza definiendo a quien se quiere atraer, que problema concreto se aborda y que anzuelo abre la conversacion. El material trabaja atraccion de pacientes, mensajes persuasivos y recursos de bajo roce para iniciar agenda.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/file/d/1Pr7OMNSnc-fPD9HBblda71GjGq6lS2f_/view" target="_blank" rel="noopener">L1 Empezando tu estrategia de atraccion pctes</a></li>
  <li><a href="https://drive.google.com/file/d/14zCi_-HNVcjq66nt57NlBz_OXGbVo7ci/view" target="_blank" rel="noopener">L2.5 Anzuelos</a></li>
</ul>$html$,
    10,
    true,
    '{}'::jsonb
  ),
  (
    'wap-fanpage-boton-whatsapp',
    'whatsagenda-pro',
    'FanPage y boton WhatsApp',
    '🔗',
    'Creacion de FanPage, diferencia con perfil personal y conexion del boton WhatsApp.',
    $html$<p>La FanPage funciona como punto publico de confianza y como origen de publicaciones con boton hacia WhatsApp. El foco es que el usuario pueda pasar desde contenido o anuncio a una conversacion con el menor roce posible.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/file/d/1uRp-35jGF6_8FfR-g6NXf_fe01pX_tZd/view" target="_blank" rel="noopener">L1 Diferencia entre Perfil y FanPage</a></li>
  <li><a href="https://drive.google.com/file/d/1EdUSbKMROGqX3WZV8CQoT--SzattMwTA/view" target="_blank" rel="noopener">L2 Creando la Fanpage</a></li>
  <li><a href="https://drive.google.com/file/d/1pH1LzTsADv4jCHhlyJPokXkoTf-3LkKv/view" target="_blank" rel="noopener">L3 Conectando Boton WhatsApp</a></li>
  <li><a href="https://drive.google.com/file/d/1_BHzm-0oRKJRRYPcdabyjGv7NWQ7hJTg/view" target="_blank" rel="noopener">L4 Publicando con el boton</a></li>
</ul>$html$,
    20,
    true,
    '{}'::jsonb
  ),
  (
    'wap-respaldo-instalacion',
    'whatsagenda-pro',
    'Respaldo e instalacion WhatsApp Business',
    '🧰',
    'Respaldo previo e instalacion limpia de WhatsApp Business.',
    $html$<p>Antes de configurar la consulta en WhatsApp Business, el curso indica respaldar la informacion y luego instalar la app correcta. Esto reduce el riesgo de perdida de conversaciones y deja preparada la cuenta comercial.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/file/d/1-wXdN9MCO_AGtkW7tlepMhazRt5yUwVT/view" target="_blank" rel="noopener">L2 Creando un respaldo de tu info</a></li>
  <li><a href="https://drive.google.com/file/d/1cXhgEEU_GSGfKtoWrcPvdikfPl7RaBYn/view" target="_blank" rel="noopener">L3 Instalando WhatsApp Business</a></li>
</ul>$html$,
    30,
    true,
    '{}'::jsonb
  ),
  (
    'wap-perfil-consulta',
    'whatsagenda-pro',
    'Perfil de consulta',
    '🏥',
    'Configuracion del perfil profesional para que la consulta sea clara, confiable y accionable.',
    $html$<p>El perfil debe explicar quien atiende, que problema ayuda a resolver, horarios, direccion o modalidad online, enlace y descripcion breve. La meta es que una madre o paciente entienda rapidamente si corresponde escribir.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/file/d/18XHNGUh4SgB1-6P9B9PhxALusXJeS6U4/view" target="_blank" rel="noopener">L4 Perfil de tu consulta</a></li>
</ul>$html$,
    40,
    true,
    '{}'::jsonb
  ),
  (
    'wap-catalogo',
    'whatsagenda-pro',
    'Catalogo',
    '🗂️',
    'Catalogo de servicios para presentar opciones de ayuda y facilitar decisiones.',
    $html$<p>El catalogo permite ordenar servicios o recursos iniciales: sesion de evaluacion, orientacion breve, terapia online, material descargable o paquetes. Cada ficha debe tener nombre, descripcion simple, beneficio y siguiente paso.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/file/d/1zc2tZr5_rxiHhVEW3PxhvmgcL_Qnz4dJ/view" target="_blank" rel="noopener">L5 Optimiza el catalogo</a></li>
</ul>$html$,
    50,
    true,
    '{}'::jsonb
  ),
  (
    'wap-etiquetas',
    'whatsagenda-pro',
    'Etiquetas',
    '🏷️',
    'Organizacion de conversaciones por etapa, interes, origen y prioridad.',
    $html$<p>Las etiquetas convierten WhatsApp Business en un CRM simple. Sirven para separar nuevos interesados, seguimiento pendiente, agendados, no respondio, reagendar, paciente activo y referido.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/file/d/1eAYHKyw5IoQnkIX_uvSpxoJlgrUFYdva/view" target="_blank" rel="noopener">L6 Etiquetas para organizar</a></li>
</ul>$html$,
    60,
    true,
    '{}'::jsonb
  ),
  (
    'wap-respuestas-rapidas',
    'whatsagenda-pro',
    'Respuestas rapidas',
    '⚡',
    'Plantillas para responder rapido sin perder calidez ni personalizacion.',
    $html$<p>Las respuestas rapidas permiten contestar preguntas frecuentes y mantener consistencia. Deben cubrir saludo, informacion de atencion, precio o modalidad si aplica, requisitos para agendar, seguimiento y cierre amable.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/file/d/1HerigOEsh0ABI7pwH2t_2Aasv1m0E2Wh/view" target="_blank" rel="noopener">L7 Respuestas Rapidas</a></li>
</ul>$html$,
    70,
    true,
    '{}'::jsonb
  ),
  (
    'wap-mensajes-pas',
    'whatsagenda-pro',
    'Mensajes persuasivos y metodo PAS',
    '📝',
    'Construccion de mensajes con problema, agitacion y solucion para iniciar conversaciones.',
    $html$<p>El metodo PAS ordena mensajes breves: nombrar el problema, mostrar por que importa y ofrecer una solucion concreta. En salud, el tono debe ser cuidadoso: claro, empatico y orientado a ayuda, no a presion.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/file/d/1xnGNh59vmqt4IJznoEh2jW6W0bVPNfFi/view" target="_blank" rel="noopener">L2.1 Mensajes Persuasivos</a></li>
  <li><a href="https://drive.google.com/file/d/1pqOzqo-dHZCQChakE7ZrjW5ipAzGoDFu/view" target="_blank" rel="noopener">L2.2 Dominando el metodo PAS</a></li>
  <li><a href="https://drive.google.com/file/d/1IqSs-oPeBTe_kMDqh1fc5deyDIGozEeh/view" target="_blank" rel="noopener">L2.3 Metodo PAS en WhatsApp</a></li>
  <li><a href="https://drive.google.com/file/d/1lQEtiTXHw18p8tG5147CEMTNTP5pkQy1/view" target="_blank" rel="noopener">L2.4 Pegando Imagen y texto</a></li>
</ul>$html$,
    80,
    true,
    '{}'::jsonb
  ),
  (
    'wap-chatgpt-mensajes',
    'whatsagenda-pro',
    'ChatGPT para mensajes rapidos',
    '🤖',
    'Uso de ChatGPT para acelerar copies, respuestas y variaciones de mensajes.',
    $html$<p>El curso incluye primeros prompts e ideas para generar mensajes en segundos. La recomendacion operativa es usar ChatGPT para borradores y variantes, pero revisar tono, promesa, claridad y adecuacion etica antes de publicar o enviar.</p>
<p>Recursos externos:</p>
<ul>
  <li><a href="https://drive.google.com/file/d/1lJQA_7pfa8izuOySeDEH2dJ7JoNlKr_g/view" target="_blank" rel="noopener">L3.1 Primeras instrucciones a ChatGPT</a></li>
  <li><a href="https://drive.google.com/file/d/1t2YIOReVCuE1KMgPHGkdFm37-K_rPMYp/view" target="_blank" rel="noopener">Mensajes en 5 segundos</a></li>
</ul>$html$,
    90,
    true,
    '{}'::jsonb
  )
on conflict (id) do update set
  course_id = excluded.course_id,
  title = excluded.title,
  emoji = excluded.emoji,
  intro = excluded.intro,
  theory = excluded.theory,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published,
  media = excluded.media;

insert into public.course_items
  (id, course_id, module_id, type, title, level, statement_html, hint, starter, tests, options, correct_answer, explanation, solution_html, steps, sort_order, is_published)
values
  (
    'pmp-avatar-ideal',
    'poderosa-maquina-pacientes',
    'pmp-neuromarketing-persuasion',
    'development',
    'Definir avatar de paciente ideal',
    2,
    $html$<p>Define el avatar principal para una consulta psicologica orientada a adolescentes. Trabaja especialmente con la madre o adulto responsable como decisor: problema, deseo, miedo, objeciones, lenguaje que usa y primer paso que estaria dispuesta a tomar.</p>$html$,
    'No definas "todo el mundo". Escoge un segmento concreto y una situacion emocional reconocible.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    $html$<p>Un buen entregable incluye: quien decide, edad aproximada, dolor observable, frase textual que podria decir, cambio deseado y canal por donde llegaria.</p>$html$,
    '[]'::jsonb,
    10,
    true
  ),
  (
    'pmp-propuesta-mamas-adolescentes',
    'poderosa-maquina-pacientes',
    'pmp-neuromarketing-persuasion',
    'development',
    'Propuesta de valor para mamas de adolescentes',
    3,
    $html$<p>Redacta una propuesta de valor para madres de adolescentes con ansiedad, baja autoestima, depresion o dificultades sociales. Debe explicar de A a B: desde que situacion llega la familia y hacia que mejora concreta se mueve.</p>$html$,
    'Usa una promesa atractiva, concreta y realista. Evita prometer resultados clinicos garantizados.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    $html$<p>Formato sugerido: "Ayudo a [persona] que vive [problema] a lograr [resultado deseado] mediante [mecanismo], para que [beneficio cotidiano]".</p>$html$,
    '[]'::jsonb,
    20,
    true
  ),
  (
    'pmp-lead-magnets',
    'poderosa-maquina-pacientes',
    'pmp-whatsapp-trafico',
    'development',
    'Crear 3 lead magnets',
    2,
    $html$<p>Crea tres anzuelos para trafico frio orientado a madres de adolescentes. Cada lead magnet debe tener nombre, promesa, formato, dato que pedirias para entregarlo y primer mensaje de seguimiento por WhatsApp.</p>$html$,
    'Ejemplos de formato: checklist, cuestionario breve, guia PDF, audio corto, mini clase o sesion orientativa.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    $html$<p>El resultado debe permitir probar preferencias: por ejemplo socializacion, autoestima y ansiedad como tres entradas distintas.</p>$html$,
    '[]'::jsonb,
    30,
    true
  ),
  (
    'pmp-mensajes-pas-aida',
    'poderosa-maquina-pacientes',
    'pmp-mensajes-impacto',
    'guided_steps',
    'Escribir mensajes PAS y AIDA',
    3,
    $html$<p>Construye dos mensajes para WhatsApp o anuncio: uno con PAS y otro con AIDA. El caso base es una madre preocupada porque su hijo adolescente esta aislado, con baja autoestima o con ansiedad.</p>$html$,
    'Mantiene el tono de ayuda. El objetivo es abrir conversacion, no cerrar una venta agresiva.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    '',
    $steps$[
      {
        "kind": "short_text",
        "title": "Problema",
        "prompt": "Escribe en una frase el problema observable que vive la madre.",
        "accepted_keywords": ["hijo", "adolescente"],
        "sample_answer": "Ves que tu hijo adolescente se esta aislando y cada vez le cuesta mas hablar de lo que siente.",
        "hint": "Debe sonar como algo que la madre reconoce en casa.",
        "explanation": "PAS parte nombrando el problema con lenguaje concreto."
      },
      {
        "kind": "short_text",
        "title": "PAS completo",
        "prompt": "Redacta un mensaje PAS: problema, agitacion y solucion.",
        "accepted_keywords": ["ayuda", "sesion", "escribeme"],
        "sample_answer": "Si ves que tu hijo se aisla y no sabes como acercarte, esperar puede hacer que el problema crezca. Puedo orientarte con una primera sesion para entender que esta pasando y definir un plan de apoyo. Escribeme y lo vemos.",
        "hint": "Incluye un siguiente paso simple.",
        "explanation": "El mensaje conecta dolor, urgencia moderada y accion."
      },
      {
        "kind": "short_text",
        "title": "AIDA completo",
        "prompt": "Redacta una version AIDA: atencion, interes, deseo y accion.",
        "accepted_keywords": ["adolescente", "agenda"],
        "sample_answer": "Tu adolescente no tiene que enfrentar esto solo. Trabajo con familias que quieren recuperar comunicacion, autoestima y calma en casa. Agenda una orientacion inicial y conversemos que apoyo necesita.",
        "hint": "Hazlo breve y usable en una publicacion.",
        "explanation": "AIDA ordena el mensaje para capturar atencion y terminar en accion."
      }
    ]$steps$::jsonb,
    40,
    true
  ),
  (
    'pmp-calendario-publicaciones',
    'poderosa-maquina-pacientes',
    'pmp-estados-calendario',
    'development',
    'Planificar calendario de publicaciones',
    2,
    $html$<p>Diseña un calendario de 7 dias para estados, FanPage o Instagram. Debe mezclar profesionalismo, servicio, caso o historia, oferta, contenido educativo, prueba social y CTA a WhatsApp.</p>$html$,
    'Incluye objetivo de cada pieza y formato: texto, imagen, video corto o carrusel.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    $html$<p>Un calendario util no solo lista temas: indica que emocion activa, que objecion reduce y que accion pide.</p>$html$,
    '[]'::jsonb,
    50,
    true
  ),
  (
    'pmp-campana-inicial',
    'poderosa-maquina-pacientes',
    'pmp-facebook-ads',
    'guided_steps',
    'Disenar campana inicial con 3 a 4 piezas',
    4,
    $html$<p>Arma una primera campana orientada a WhatsApp con 3 a 4 piezas creativas. Define publico, promesa, presupuesto de prueba, CTA y criterio para decidir que pieza seguir optimizando.</p>$html$,
    'No partas por presupuesto alto. El objetivo es aprender que mensaje genera conversaciones calificadas.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    '',
    $steps$[
      {
        "kind": "short_text",
        "title": "Publico",
        "prompt": "Define publico inicial con edad, ubicacion, interes y situacion familiar.",
        "accepted_keywords": ["mujeres", "madres"],
        "sample_answer": "Mujeres de 30 a 50 anos, madres de adolescentes, interesadas en salud mental, ansiedad, depresion o bienestar familiar.",
        "hint": "Usa el avatar de la nota historica.",
        "explanation": "La segmentacion debe corresponder al decisor real."
      },
      {
        "kind": "short_text",
        "title": "Promesa y CTA",
        "prompt": "Escribe la promesa de valor y el llamado a la accion.",
        "accepted_keywords": ["whatsapp", "sesion"],
        "sample_answer": "Ayuda a tu hijo adolescente a recuperar calma y confianza. Escribeme por WhatsApp para una orientacion inicial.",
        "hint": "Promesa concreta, sin prometer cura garantizada.",
        "explanation": "La promesa abre conversacion y el CTA lleva a WhatsApp."
      },
      {
        "kind": "short_text",
        "title": "Piezas",
        "prompt": "Lista 3 o 4 piezas con formato y angulo.",
        "accepted_keywords": ["imagen", "video", "post"],
        "sample_answer": "1 imagen madre-hijo con CTA; 1 video corto sobre senales de alerta; 1 carrusel de autoestima; 1 post de orientacion gratuita.",
        "hint": "Cambia una variable relevante entre piezas.",
        "explanation": "Probar variaciones permite detectar que angulo funciona mejor."
      }
    ]$steps$::jsonb,
    60,
    true
  ),
  (
    'wap-configurar-perfil',
    'whatsagenda-pro',
    'wap-perfil-consulta',
    'guided_steps',
    'Configurar perfil de consulta',
    2,
    $html$<p>Define los datos que debe tener el perfil de WhatsApp Business para una consulta profesional.</p>$html$,
    'Piensa en lo que una persona necesita saber antes de escribir o agendar.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    '',
    $steps$[
      {
        "kind": "short_text",
        "title": "Descripcion",
        "prompt": "Escribe una descripcion breve de la consulta.",
        "accepted_keywords": ["atiendo", "consulta"],
        "sample_answer": "Consulta psicologica para adolescentes y familias, con atencion online y orientacion inicial para entender que apoyo necesita tu hijo.",
        "hint": "Debe caber en un perfil, no en una pagina completa.",
        "explanation": "La descripcion ayuda a decidir si escribir."
      },
      {
        "kind": "short_text",
        "title": "Datos clave",
        "prompt": "Lista los datos que vas a completar: horario, modalidad, ubicacion, enlace y correo si aplica.",
        "accepted_keywords": ["horario", "modalidad"],
        "sample_answer": "Horario de respuesta, modalidad online, comuna o pais, link de agenda, correo profesional y descripcion de servicios.",
        "hint": "Incluye datos que reduzcan preguntas repetidas.",
        "explanation": "Un perfil completo mejora confianza y ahorra conversacion administrativa."
      }
    ]$steps$::jsonb,
    10,
    true
  ),
  (
    'wap-configurar-catalogo',
    'whatsagenda-pro',
    'wap-catalogo',
    'development',
    'Crear catalogo de servicios',
    2,
    $html$<p>Crea 3 fichas de catalogo para WhatsApp Business. Cada ficha debe tener nombre, descripcion, beneficio, modalidad y CTA.</p>$html$,
    'No uses nombres genericos. Que cada servicio responda a una necesidad distinta.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    $html$<p>Ejemplos: orientacion inicial para padres, evaluacion psicologica adolescente, terapia online de seguimiento.</p>$html$,
    '[]'::jsonb,
    20,
    true
  ),
  (
    'wap-diseno-etiquetas',
    'whatsagenda-pro',
    'wap-etiquetas',
    'development',
    'Disenar sistema de etiquetas',
    2,
    $html$<p>Define un sistema de etiquetas para organizar conversaciones en WhatsApp Business. Incluye al menos origen, etapa y accion pendiente.</p>$html$,
    'Piensa como CRM: que necesitas ver rapido para no perder seguimientos.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    $html$<p>Un set inicial razonable: nuevo lead, respondido, seguimiento pendiente, agendado, no contesta, referido, urgencia administrativa.</p>$html$,
    '[]'::jsonb,
    30,
    true
  ),
  (
    'wap-respuestas-rapidas-base',
    'whatsagenda-pro',
    'wap-respuestas-rapidas',
    'guided_steps',
    'Crear respuestas rapidas base',
    2,
    $html$<p>Redacta respuestas rapidas para WhatsApp Business que puedas usar sin sonar automatico.</p>$html$,
    'Usa variables mentales: nombre, motivo, disponibilidad y siguiente paso.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    '',
    $steps$[
      {
        "kind": "short_text",
        "title": "Saludo",
        "prompt": "Redacta una respuesta rapida de bienvenida.",
        "accepted_keywords": ["hola", "gracias"],
        "sample_answer": "Hola, gracias por escribirme. Cuentame brevemente que esta pasando y si buscas apoyo para ti o para tu hijo/a.",
        "hint": "Debe invitar a responder, no cerrar la conversacion.",
        "explanation": "El saludo abre contexto y mantiene cercania."
      },
      {
        "kind": "short_text",
        "title": "Agenda",
        "prompt": "Redacta una respuesta para ofrecer horarios o siguiente paso.",
        "accepted_keywords": ["horario", "agenda"],
        "sample_answer": "Tengo algunos horarios disponibles esta semana. Si te parece, revisamos una primera orientacion para entender el caso y definir si corresponde iniciar atencion.",
        "hint": "No fuerces el cierre; ofrece un paso claro.",
        "explanation": "La respuesta reduce friccion hacia la agenda."
      },
      {
        "kind": "short_text",
        "title": "Seguimiento",
        "prompt": "Redacta un seguimiento amable para alguien que no respondio.",
        "accepted_keywords": ["seguimiento", "pendiente"],
        "sample_answer": "Te escribo para saber si aun necesitas orientacion. Si quieres, puedo ayudarte a revisar el siguiente paso con calma.",
        "hint": "Evita presion o urgencia artificial.",
        "explanation": "El seguimiento recupera conversaciones sin sonar invasivo."
      }
    ]$steps$::jsonb,
    40,
    true
  ),
  (
    'wap-mensaje-pas-consulta',
    'whatsagenda-pro',
    'wap-mensajes-pas',
    'guided_steps',
    'Mensaje PAS para WhatsApp',
    3,
    $html$<p>Construye un mensaje PAS para iniciar conversacion por WhatsApp con una persona interesada en atencion psicologica o apoyo familiar.</p>$html$,
    'PAS: problema, agitacion moderada, solucion concreta.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    '',
    $steps$[
      {
        "kind": "short_text",
        "title": "Problema",
        "prompt": "Escribe el problema en lenguaje simple.",
        "accepted_keywords": ["preocupa", "hijo"],
        "sample_answer": "Te preocupa ver que tu hijo esta mas ansioso, aislado o irritable y no sabes como ayudarlo.",
        "hint": "Describe una escena reconocible.",
        "explanation": "El problema debe conectar con la experiencia real."
      },
      {
        "kind": "short_text",
        "title": "Agitacion",
        "prompt": "Agrega una frase de consecuencia sin exagerar.",
        "accepted_keywords": ["tiempo", "crecer"],
        "sample_answer": "Cuando esto se deja pasar, la distancia en casa puede crecer y pedir ayuda se vuelve cada vez mas dificil.",
        "hint": "No uses miedo extremo.",
        "explanation": "La agitacion muestra por que conviene actuar."
      },
      {
        "kind": "short_text",
        "title": "Solucion",
        "prompt": "Cierra con solucion y CTA.",
        "accepted_keywords": ["orientacion", "whatsapp"],
        "sample_answer": "Podemos partir con una orientacion inicial para entender el caso y definir el apoyo adecuado. Escribeme por WhatsApp y coordinamos.",
        "hint": "Haz que el siguiente paso sea facil.",
        "explanation": "La solucion convierte interes en conversacion."
      }
    ]$steps$::jsonb,
    50,
    true
  ),
  (
    'wap-chatgpt-prompts',
    'whatsagenda-pro',
    'wap-chatgpt-mensajes',
    'development',
    'Prompts para mensajes rapidos',
    2,
    $html$<p>Escribe 3 prompts para pedirle a ChatGPT mensajes de WhatsApp: bienvenida, seguimiento y PAS. Cada prompt debe incluir contexto, publico objetivo, tono, objetivo y restricciones.</p>$html$,
    'No pidas solo "hazme un mensaje". Dale rol, audiencia, situacion y formato.',
    '',
    '[]'::jsonb,
    '[]'::jsonb,
    null,
    '',
    $html$<p>Un buen prompt dice: "Actua como experto en marketing etico para salud; escribe 5 versiones breves, empaticas, sin prometer resultados clinicos, con CTA a orientacion inicial".</p>$html$,
    '[]'::jsonb,
    60,
    true
  )
on conflict (id) do update set
  course_id = excluded.course_id,
  module_id = excluded.module_id,
  type = excluded.type,
  title = excluded.title,
  level = excluded.level,
  statement_html = excluded.statement_html,
  hint = excluded.hint,
  starter = excluded.starter,
  tests = excluded.tests,
  options = excluded.options,
  correct_answer = excluded.correct_answer,
  explanation = excluded.explanation,
  solution_html = excluded.solution_html,
  steps = excluded.steps,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;
