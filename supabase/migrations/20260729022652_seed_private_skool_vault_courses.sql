-- ============================================================================
--  Cursos privados desde vaults Skool locales.
--  Generado desde los indices Obsidian de CAR e Imperio Agentico.
--  No hardcodea contenido en frontend; deja courses.is_published=false.
-- ============================================================================

alter table public.courses
  add column if not exists media jsonb not null default '{}'::jsonb;

alter table public.course_modules
  add column if not exists media jsonb not null default '{}'::jsonb;

insert into public.courses
  (id, title, subtitle, description, emoji, sort_order, is_published, media)
values
  (
    'car-ecosistema-startup',
    'CAR / Ecosistema Startup',
    'Cagala, Aprende, Repite · classroom privado Skool',
    'Mega-curso privado con el inventario textual del ecosistema CAR: agentes IA, n8n, Claude Code, capital, ventas, marca personal, unit economics y playbooks para startups.',
    '🚀',
    100,
    false,
    '{"source_vault":"/home/ftt-2brocket/obsidian/CAR-skool-vault","index":"bruto/00_ÍNDICE.md","generated_from":"local_obsidian_skool_index"}'::jsonb
  ),
  (
    'imperio-agentico',
    'Imperio Agentico',
    'Imperio · classroom privado Skool',
    'Mega-curso privado con el inventario textual de Imperio Agentico: WhatsApp agents, Make, n8n, Airtable, prompts, Claude Code, GHL, niveles de comunidad y vibe-coding.',
    '🏛️',
    110,
    false,
    '{"source_vault":"/home/ftt-2brocket/obsidian/imperio-agentico-skool","index":"bruto/00_ÍNDICE.md","generated_from":"local_obsidian_skool_index"}'::jsonb
  )
on conflict (id) do update set
  title = excluded.title,
  subtitle = excluded.subtitle,
  description = excluded.description,
  emoji = excluded.emoji,
  sort_order = excluded.sort_order,
  is_published = false,
  media = excluded.media;

insert into public.course_modules
  (id, course_id, title, emoji, intro, theory, sort_order, is_published, media)
values
  (
    'car-ai-agents-starter-kit-latam',
    'car-ecosistema-startup',
    'AI Agents Starter Kit LATAM',
    '🚀',
    '26 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_1$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> AI Agents Starter Kit LATAM · 26 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/01_AI_Agents_Starter_Kit_LATAM.md" target="_blank" rel="noopener">🤖 AI Agents Starter Kit · LATAM</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/01_AI_Agents_Starter_Kit_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/02_M1_Del_Chatbot_al_Agente.md" target="_blank" rel="noopener">🧠 M1: Del Chatbot al Agente</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/02_M1_Del_Chatbot_al_Agente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/03_La_Revolución_Agéntica_2026.md" target="_blank" rel="noopener">🚀 La Revolución Agéntica 2026</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/03_La_Revolución_Agéntica_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/04_Mapeo_de_Procesos_para_Founders.md" target="_blank" rel="noopener">🔍 Mapeo de Procesos para Founders</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/04_Mapeo_de_Procesos_para_Founders.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/05_Anatomía_Perfil_Tools_Memoria.md" target="_blank" rel="noopener">🧬 Anatomía: Perfil, Tools, Memoria</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/05_Anatomía_Perfil_Tools_Memoria.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/06_M2_El_Cerebro_Modelos.md" target="_blank" rel="noopener">🧠 M2: El Cerebro (Modelos)</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/06_M2_El_Cerebro_Modelos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/07_Mapa_de_Proveedores_2026.md" target="_blank" rel="noopener">🗺️ Mapa de Proveedores 2026</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/07_Mapa_de_Proveedores_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/08_MVP_costo_cero_Gemini_NIM.md" target="_blank" rel="noopener">🆓 MVP costo cero (Gemini + NIM)</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/08_MVP_costo_cero_Gemini_NIM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/09_Económicos_MiniMax_MiMo_y_DeepSeek.md" target="_blank" rel="noopener">💸 Económicos: MiniMax, MiMo y DeepSeek</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/09_Económicos_MiniMax_MiMo_y_DeepSeek.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/10_El_Pro_GPT-54_y_Claude_Opus_47.md" target="_blank" rel="noopener">🚀 El Pro: GPT-5.4 y Claude Opus 4.7</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/10_El_Pro_GPT-54_y_Claude_Opus_47.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/11_M3_Sistema_Nervioso.md" target="_blank" rel="noopener">⚡ M3: Sistema Nervioso</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/11_M3_Sistema_Nervioso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/12_Lineal_vs_Agéntica_loops.md" target="_blank" rel="noopener">🔀 Lineal vs Agéntica (loops)</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/12_Lineal_vs_Agéntica_loops.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/13_No-Tech_Construyendo_con_Make.md" target="_blank" rel="noopener">🟢 No-Tech: Construyendo con Make</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/13_No-Tech_Construyendo_con_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/14_Tech_n8n_Self-hosted.md" target="_blank" rel="noopener">🟣 Tech: n8n Self-hosted</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/14_Tech_n8n_Self-hosted.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/15_Memoria_largo_plazo_RAG.md" target="_blank" rel="noopener">🧠 Memoria largo plazo (RAG)</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/15_Memoria_largo_plazo_RAG.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/16_M4_Agente_de_Ventas_WhatsApp.md" target="_blank" rel="noopener">💬 M4: Agente de Ventas WhatsApp</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/16_M4_Agente_de_Ventas_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/17_Estrategia_de_Conversión_WA.md" target="_blank" rel="noopener">🎯 Estrategia de Conversión WA</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/17_Estrategia_de_Conversión_WA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/18_Integrando_Moonflow_MiniMax.md" target="_blank" rel="noopener">🔌 Integrando: Moonflow / MiniMax</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/18_Integrando_Moonflow_MiniMax.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/19_El_Closer_Manejo_de_Objeciones.md" target="_blank" rel="noopener">💪 El Closer: Manejo de Objeciones</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/19_El_Closer_Manejo_de_Objeciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/20_ROI_y_Optimización.md" target="_blank" rel="noopener">📊 ROI y Optimización</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/20_ROI_y_Optimización.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/21_M5_Privacidad_y_Hardware.md" target="_blank" rel="noopener">🔒 M5: Privacidad y Hardware</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/21_M5_Privacidad_y_Hardware.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/22_LLMs_Locales_por_qué_y_cuándo.md" target="_blank" rel="noopener">🏠 LLMs Locales: por qué y cuándo</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/22_LLMs_Locales_por_qué_y_cuándo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/23_Demo_Ollama_local.md" target="_blank" rel="noopener">🖥️ Demo Ollama local</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/23_Demo_Ollama_local.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/24_Setup_de_Hardware_para_Agentes.md" target="_blank" rel="noopener">🖥️ Setup de Hardware para Agentes</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/24_Setup_de_Hardware_para_Agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/25_Qwen_36_local_n8n.md" target="_blank" rel="noopener">🦙 Qwen 3.6 local + n8n</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/25_Qwen_36_local_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/AI_Agents_Starter_Kit_LATAM/26_IA_Agéntica_LATAM_2026-2027.md" target="_blank" rel="noopener">🔮 IA Agéntica LATAM 2026-2027</a> <code>bruto/AI_Agents_Starter_Kit_LATAM/26_IA_Agéntica_LATAM_2026-2027.md</code></li>
</ul>$lf_module_1$,
    10,
    true,
    '{}'::jsonb
  ),
  (
    'car-asesorias-11-grabadas',
    'car-ecosistema-startup',
    'Asesorías 11 Grabadas',
    '🚀',
    '25 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_2$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Asesorías 11 Grabadas · 25 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/01_Asesorías_11_Grabadas.md" target="_blank" rel="noopener">📞 Asesorías 1:1 Grabadas</a> <code>bruto/Asesorías_11_Grabadas/01_Asesorías_11_Grabadas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/02_Asesoría_Legal_-_Investability.md" target="_blank" rel="noopener">Asesoría Legal - Investability</a> <code>bruto/Asesorías_11_Grabadas/02_Asesoría_Legal_-_Investability.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/03_Asesoría_de_Agosto_2025_por_Alejandra_Pérez.md" target="_blank" rel="noopener">Asesoría de Agosto 2025 por Alejandra Pérez</a> <code>bruto/Asesorías_11_Grabadas/03_Asesoría_de_Agosto_2025_por_Alejandra_Pérez.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/04_Asesoría_de_Septiembre_2025_por_Alejandra_Pérez.md" target="_blank" rel="noopener">Asesoría de Septiembre 2025 por Alejandra Pérez</a> <code>bruto/Asesorías_11_Grabadas/04_Asesoría_de_Septiembre_2025_por_Alejandra_Pérez.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/05_Asesoría_de_Noviembre_2025_por_Alejandra_Pérez.md" target="_blank" rel="noopener">Asesoría de Noviembre 2025 por Alejandra Pérez</a> <code>bruto/Asesorías_11_Grabadas/05_Asesoría_de_Noviembre_2025_por_Alejandra_Pérez.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/06_Asesoría_de_Enero_2026_por_Alejandra_Pérez.md" target="_blank" rel="noopener">Asesoría de Enero 2026 por Alejandra Pérez</a> <code>bruto/Asesorías_11_Grabadas/06_Asesoría_de_Enero_2026_por_Alejandra_Pérez.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/07_Asesoría_de_Febrero_2026_por_Alejandra_Pérez.md" target="_blank" rel="noopener">Asesoría de Febrero 2026 por Alejandra Pérez</a> <code>bruto/Asesorías_11_Grabadas/07_Asesoría_de_Febrero_2026_por_Alejandra_Pérez.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/08_IA_Marketing_Digital_por_Rodrigo_Rojo.md" target="_blank" rel="noopener">IA &amp; Marketing Digital por Rodrigo Rojo</a> <code>bruto/Asesorías_11_Grabadas/08_IA_Marketing_Digital_por_Rodrigo_Rojo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/09_Agosto_2025.md" target="_blank" rel="noopener">Agosto 2025</a> <code>bruto/Asesorías_11_Grabadas/09_Agosto_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/10_Septiembre_2025.md" target="_blank" rel="noopener">Septiembre 2025</a> <code>bruto/Asesorías_11_Grabadas/10_Septiembre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/11_Octubre_2025.md" target="_blank" rel="noopener">Octubre 2025</a> <code>bruto/Asesorías_11_Grabadas/11_Octubre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/12_Diciembre_2025.md" target="_blank" rel="noopener">Diciembre 2025</a> <code>bruto/Asesorías_11_Grabadas/12_Diciembre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/13_Enero_2026.md" target="_blank" rel="noopener">Enero 2026</a> <code>bruto/Asesorías_11_Grabadas/13_Enero_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/14_Afina_Tu_Pitch_por_Pía_Cardenas.md" target="_blank" rel="noopener">Afina Tu Pitch por Pía Cardenas</a> <code>bruto/Asesorías_11_Grabadas/14_Afina_Tu_Pitch_por_Pía_Cardenas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/15_Agosto_2025.md" target="_blank" rel="noopener">Agosto 2025</a> <code>bruto/Asesorías_11_Grabadas/15_Agosto_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/16_Septiembre_2025.md" target="_blank" rel="noopener">Septiembre 2025</a> <code>bruto/Asesorías_11_Grabadas/16_Septiembre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/17_Octubre_2025.md" target="_blank" rel="noopener">Octubre 2025</a> <code>bruto/Asesorías_11_Grabadas/17_Octubre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/18_Producto_Tecnología_por_Carlos_Villarroel.md" target="_blank" rel="noopener">Producto &amp; Tecnología por Carlos Villarroel</a> <code>bruto/Asesorías_11_Grabadas/18_Producto_Tecnología_por_Carlos_Villarroel.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/19_Agosto_2025.md" target="_blank" rel="noopener">Agosto 2025</a> <code>bruto/Asesorías_11_Grabadas/19_Agosto_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/20_Septiembre_2025.md" target="_blank" rel="noopener">Septiembre 2025</a> <code>bruto/Asesorías_11_Grabadas/20_Septiembre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/21_Octubre_2025.md" target="_blank" rel="noopener">Octubre 2025</a> <code>bruto/Asesorías_11_Grabadas/21_Octubre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/22_Noviembre_2025.md" target="_blank" rel="noopener">Noviembre 2025</a> <code>bruto/Asesorías_11_Grabadas/22_Noviembre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/23_Diciembre_2025.md" target="_blank" rel="noopener">Diciembre 2025</a> <code>bruto/Asesorías_11_Grabadas/23_Diciembre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/24_Pitch_frente_a_Inversionistas_por_Fede_de_Broota.md" target="_blank" rel="noopener">Pitch frente a Inversionistas por Fede de Broota</a> <code>bruto/Asesorías_11_Grabadas/24_Pitch_frente_a_Inversionistas_por_Fede_de_Broota.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Asesorías_11_Grabadas/25_Enero_2026.md" target="_blank" rel="noopener">Enero 2026</a> <code>bruto/Asesorías_11_Grabadas/25_Enero_2026.md</code></li>
</ul>$lf_module_2$,
    20,
    true,
    '{}'::jsonb
  ),
  (
    'car-automatiza-tu-negocio-con-n8n',
    'car-ecosistema-startup',
    'Automatiza tu Negocio con n8n',
    '🚀',
    '27 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_3$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Automatiza tu Negocio con n8n · 27 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/01_Automatiza_tu_Negocio_con_n8n.md" target="_blank" rel="noopener">🤖 Automatiza tu Negocio con n8n</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/01_Automatiza_tu_Negocio_con_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/02_Empieza_sin_saber_nada_técnico.md" target="_blank" rel="noopener">🧰 Empieza sin saber nada técnico</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/02_Empieza_sin_saber_nada_técnico.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/03_L01_Qué_es_n8n_y_por_qué_te_da_tiempo.md" target="_blank" rel="noopener">L0.1 · ¿Qué es n8n y por qué te da tiempo?</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/03_L01_Qué_es_n8n_y_por_qué_te_da_tiempo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/04_L02_Se_automatiza_o_lo_dejo_a_mano.md" target="_blank" rel="noopener">L0.2 · ¿Se automatiza o lo dejo a mano?</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/04_L02_Se_automatiza_o_lo_dejo_a_mano.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/05_L03_Monta_n8n_en_10_minutos.md" target="_blank" rel="noopener">L0.3 · Monta n8n en 10 minutos</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/05_L03_Monta_n8n_en_10_minutos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/06_L04_Los_5_errores_que_frenan_tu_flujo.md" target="_blank" rel="noopener">L0.4 · Los 5 errores que frenan tu flujo</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/06_L04_Los_5_errores_que_frenan_tu_flujo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/07_L05_Crea_tu_bot_de_Telegram.md" target="_blank" rel="noopener">L0.5 · Crea tu bot de Telegram</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/07_L05_Crea_tu_bot_de_Telegram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/08_Deja_de_pelear_con_el_contenido.md" target="_blank" rel="noopener">✍️ Deja de pelear con el contenido</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/08_Deja_de_pelear_con_el_contenido.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/09_L11_Tu_curador_de_contenido.md" target="_blank" rel="noopener">L1.1 · Tu curador de contenido</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/09_L11_Tu_curador_de_contenido.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/10_L12_Aprueba_y_publica_por_Telegram.md" target="_blank" rel="noopener">L1.2 · Aprueba y publica por Telegram</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/10_L12_Aprueba_y_publica_por_Telegram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/11_L13_Que_llegue_a_tu_hora_sin_repetir.md" target="_blank" rel="noopener">L1.3 · Que llegue a tu hora, sin repetir</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/11_L13_Que_llegue_a_tu_hora_sin_repetir.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/12_No_pierdas_clientes_por_desorden.md" target="_blank" rel="noopener">🎯 No pierdas clientes por desorden</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/12_No_pierdas_clientes_por_desorden.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/13_L21_Captura_leads_y_avísate_al_instante.md" target="_blank" rel="noopener">L2.1 · Captura leads y avísate al instante</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/13_L21_Captura_leads_y_avísate_al_instante.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/14_L22_Recordatorios_que_se_disparan_solos.md" target="_blank" rel="noopener">L2.2 · Recordatorios que se disparan solos</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/14_L22_Recordatorios_que_se_disparan_solos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/15_L23_Prepara_tu_outreach_en_lote.md" target="_blank" rel="noopener">L2.3 · Prepara tu outreach en lote</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/15_L23_Prepara_tu_outreach_en_lote.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/16_L24_Agenda_citas_sin_tenis_de_emails.md" target="_blank" rel="noopener">L2.4 · Agenda citas sin tenis de emails</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/16_L24_Agenda_citas_sin_tenis_de_emails.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/17_Que_tu_negocio_te_hable_por_Telegram.md" target="_blank" rel="noopener">💬 Que tu negocio te hable por Telegram</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/17_Que_tu_negocio_te_hable_por_Telegram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/18_L31_Decide_desde_el_celular.md" target="_blank" rel="noopener">L3.1 · Decide desde el celular</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/18_L31_Decide_desde_el_celular.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/19_L32_Un_bot_que_responde_tus_FAQ.md" target="_blank" rel="noopener">L3.2 · Un bot que responde tus FAQ</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/19_L32_Un_bot_que_responde_tus_FAQ.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/20_L33_Nota_de_voz_resumen_acciones.md" target="_blank" rel="noopener">L3.3 · Nota de voz → resumen + acciones</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/20_L33_Nota_de_voz_resumen_acciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/21_Casos_reales_Galería_por_dolor.md" target="_blank" rel="noopener">📚 Casos reales · Galería por dolor</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/21_Casos_reales_Galería_por_dolor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/22_L41_Galería_de_wins_por_dolor.md" target="_blank" rel="noopener">L4.1 · Galería de wins por dolor</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/22_L41_Galería_de_wins_por_dolor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/23_Bonus_Workshops_originales_de_n8n.md" target="_blank" rel="noopener">🎁 Bonus · Workshops originales de n8n</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/23_Bonus_Workshops_originales_de_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/24_Bonus_1_Generación_de_Contenido.md" target="_blank" rel="noopener">Bonus 1 · Generación de Contenido</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/24_Bonus_1_Generación_de_Contenido.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/24_Bonus_1_Generación_de_Contenido.transcript.md" target="_blank" rel="noopener">Transcripción — Bonus 1 · Generación de Contenido</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/24_Bonus_1_Generación_de_Contenido.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/25_Bonus_2_Automatizando_la_Conversión.md" target="_blank" rel="noopener">Bonus 2 · Automatizando la Conversión</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/25_Bonus_2_Automatizando_la_Conversión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Automatiza_tu_Negocio_con_n8n/25_Bonus_2_Automatizando_la_Conversión.transcript.md" target="_blank" rel="noopener">Transcripción — Bonus 2 · Automatizando la Conversión</a> <code>bruto/Automatiza_tu_Negocio_con_n8n/25_Bonus_2_Automatizando_la_Conversión.transcript.md</code></li>
</ul>$lf_module_3$,
    30,
    true,
    '{}'::jsonb
  ),
  (
    'car-claude-code-para-emprendedores-sin-programar',
    'car-ecosistema-startup',
    'Claude Code para Emprendedores sin programar',
    '🚀',
    '24 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_4$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Claude Code para Emprendedores sin programar · 24 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/01_Claude_Code_para_Emprendedores_sin_programar.md" target="_blank" rel="noopener">Claude Code para Emprendedores (sin programar)</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/01_Claude_Code_para_Emprendedores_sin_programar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/02_M00_El_nombre_te_mintió.md" target="_blank" rel="noopener">M00 — El nombre te mintió</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/02_M00_El_nombre_te_mintió.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/03_L01_El_nombre_te_mintió.md" target="_blank" rel="noopener">L0.1 · El nombre te mintió</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/03_L01_El_nombre_te_mintió.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/04_M01_La_oficina_abre.md" target="_blank" rel="noopener">M01 — La oficina abre</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/04_M01_La_oficina_abre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/05_L11_Las_tres_puertas.md" target="_blank" rel="noopener">L1.1 · Las tres puertas</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/05_L11_Las_tres_puertas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/06_L12_300_archivos.md" target="_blank" rel="noopener">L1.2 · 300 archivos</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/06_L12_300_archivos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/07_M02_Las_horas_que_vuelven.md" target="_blank" rel="noopener">M02 — Las horas que vuelven</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/07_M02_Las_horas_que_vuelven.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/08_L21_Cuadrar_los_gastos.md" target="_blank" rel="noopener">L2.1 · Cuadrar los gastos</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/08_L21_Cuadrar_los_gastos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/09_M03_El_empleado_aprende_tu_negocio.md" target="_blank" rel="noopener">M03 — El empleado aprende tu negocio</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/09_M03_El_empleado_aprende_tu_negocio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/10_L31_El_manual_CLAUDEmd.md" target="_blank" rel="noopener">L3.1 · El manual (CLAUDE.md)</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/10_L31_El_manual_CLAUDEmd.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/11_L32_Tu_primer_comando.md" target="_blank" rel="noopener">L3.2 · Tu primer comando</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/11_L32_Tu_primer_comando.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/12_M04_Llena_tu_pipeline.md" target="_blank" rel="noopener">M04 — Llena tu pipeline</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/12_M04_Llena_tu_pipeline.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/13_L41_Dossier_de_un_lead.md" target="_blank" rel="noopener">L4.1 · Dossier de un lead</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/13_L41_Dossier_de_un_lead.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/14_L42_Patrones_de_objeciones.md" target="_blank" rel="noopener">L4.2 · Patrones de objeciones</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/14_L42_Patrones_de_objeciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/15_M05_De_empleado_a_equipo.md" target="_blank" rel="noopener">M05 — De empleado a equipo</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/15_M05_De_empleado_a_equipo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/16_L51_Tu_equipo_de_especialistas.md" target="_blank" rel="noopener">L5.1 · Tu equipo de especialistas</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/16_L51_Tu_equipo_de_especialistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/17_L52_La_rutina_del_lunes.md" target="_blank" rel="noopener">L5.2 · La rutina del lunes</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/17_L52_La_rutina_del_lunes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/18_M06_Casos_Reales.md" target="_blank" rel="noopener">M06 — Casos Reales</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/18_M06_Casos_Reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/19_Casos_Reales.md" target="_blank" rel="noopener">Casos Reales</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/19_Casos_Reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/20_M07_Operación_Lunes_800.md" target="_blank" rel="noopener">M07 — Operación Lunes 8:00</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/20_M07_Operación_Lunes_800.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/21_L71_Operación_Lunes_800.md" target="_blank" rel="noopener">L7.1 · Operación Lunes 8:00</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/21_L71_Operación_Lunes_800.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/22_L72_El_examen_de_la_oficina.md" target="_blank" rel="noopener">L7.2 · El examen de la oficina</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/22_L72_El_examen_de_la_oficina.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/23_BONUS_MCP_para_founders.md" target="_blank" rel="noopener">BONUS — MCP para founders</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/23_BONUS_MCP_para_founders.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Claude_Code_para_Emprendedores_sin_programar/24_B81_MCP_para_founders.md" target="_blank" rel="noopener">B8.1 · MCP para founders</a> <code>bruto/Claude_Code_para_Emprendedores_sin_programar/24_B81_MCP_para_founders.md</code></li>
</ul>$lf_module_4$,
    40,
    true,
    '{}'::jsonb
  ),
  (
    'car-cofre-del-pirata',
    'car-ecosistema-startup',
    'Cofre del Pirata',
    '🚀',
    '104 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_5$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Cofre del Pirata · 104 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/01_Cofre_del_Pirata.md" target="_blank" rel="noopener">🏴‍☠️ Cofre del Pirata</a> <code>bruto/Cofre_del_Pirata/01_Cofre_del_Pirata.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/02_Cómo_usar_el_Cofre.md" target="_blank" rel="noopener">🗝️ Cómo usar el Cofre</a> <code>bruto/Cofre_del_Pirata/02_Cómo_usar_el_Cofre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/03_1_Prompts.md" target="_blank" rel="noopener">1️⃣ Prompts</a> <code>bruto/Cofre_del_Pirata/03_1_Prompts.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/04_00_Cómo_usar_los_prompts.md" target="_blank" rel="noopener">00 · Cómo usar los prompts</a> <code>bruto/Cofre_del_Pirata/04_00_Cómo_usar_los_prompts.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/05_P-01_Auditoría_Cero-Gasto.md" target="_blank" rel="noopener">P-01: Auditoría Cero-Gasto</a> <code>bruto/Cofre_del_Pirata/05_P-01_Auditoría_Cero-Gasto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/06_P-02_Validación_de_Hipótesis_en_5_Entrevistas.md" target="_blank" rel="noopener">P-02: Validación de Hipótesis en 5 Entrevistas</a> <code>bruto/Cofre_del_Pirata/06_P-02_Validación_de_Hipótesis_en_5_Entrevistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/07_P-03_Pricing_Inicial_sin_Sufrir.md" target="_blank" rel="noopener">P-03: Pricing Inicial sin Sufrir</a> <code>bruto/Cofre_del_Pirata/07_P-03_Pricing_Inicial_sin_Sufrir.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/08_P-04_Decisión_Hire_vs_Outsource_vs_Automatizar.md" target="_blank" rel="noopener">P-04: Decisión Hire vs Outsource vs Automatizar</a> <code>bruto/Cofre_del_Pirata/08_P-04_Decisión_Hire_vs_Outsource_vs_Automatizar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/09_P-05_Reunión_Investor_Advisor_en_24h.md" target="_blank" rel="noopener">P-05: Reunión Investor / Advisor en 24h</a> <code>bruto/Cofre_del_Pirata/09_P-05_Reunión_Investor_Advisor_en_24h.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/100_H-05_Mi_agente_cita_info_links_que_no_existen.md" target="_blank" rel="noopener">H-05: Mi agente cita info / links que no existen</a> <code>bruto/Cofre_del_Pirata/100_H-05_Mi_agente_cita_info_links_que_no_existen.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/101_H-06_No_sé_qué_automatizar_primero_parálisis.md" target="_blank" rel="noopener">H-06: No sé qué automatizar primero (parálisis)</a> <code>bruto/Cofre_del_Pirata/101_H-06_No_sé_qué_automatizar_primero_parálisis.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/102_H-07_Funciona_con_1_cliente_colapsa_con_10.md" target="_blank" rel="noopener">H-07: Funciona con 1 cliente, colapsa con 10</a> <code>bruto/Cofre_del_Pirata/102_H-07_Funciona_con_1_cliente_colapsa_con_10.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/103_H-04_El_prompt_no_persiste_entre_sesiones.md" target="_blank" rel="noopener">H-04: El prompt no persiste entre sesiones</a> <code>bruto/Cofre_del_Pirata/103_H-04_El_prompt_no_persiste_entre_sesiones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/104_H-08_El_agente_ignora_contexto_LATAM.md" target="_blank" rel="noopener">H-08: El agente ignora contexto LATAM</a> <code>bruto/Cofre_del_Pirata/104_H-08_El_agente_ignora_contexto_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/10_P-06_Outbound_LinkedIn_que_NO_huele_a_templated.md" target="_blank" rel="noopener">P-06: Outbound LinkedIn que NO huele a templated</a> <code>bruto/Cofre_del_Pirata/10_P-06_Outbound_LinkedIn_que_NO_huele_a_templated.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/11_P-07_Cold_Email_a_CEO_Empresa_Target.md" target="_blank" rel="noopener">P-07: Cold Email a CEO Empresa Target</a> <code>bruto/Cofre_del_Pirata/11_P-07_Cold_Email_a_CEO_Empresa_Target.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/12_P-08_Sales_Page_Long-Form_en_1_Día.md" target="_blank" rel="noopener">P-08: Sales Page Long-Form en 1 Día</a> <code>bruto/Cofre_del_Pirata/12_P-08_Sales_Page_Long-Form_en_1_Día.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/13_P-09_Re-purpose_1_Post_a_5_Canales.md" target="_blank" rel="noopener">P-09: Re-purpose 1 Post a 5 Canales</a> <code>bruto/Cofre_del_Pirata/13_P-09_Re-purpose_1_Post_a_5_Canales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/14_P-10_Análisis_de_Funnel_de_Conversión.md" target="_blank" rel="noopener">P-10: Análisis de Funnel de Conversión</a> <code>bruto/Cofre_del_Pirata/14_P-10_Análisis_de_Funnel_de_Conversión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/15_P-11_Estrategia_Newsletter_en_90_días.md" target="_blank" rel="noopener">P-11: Estrategia Newsletter en 90 días</a> <code>bruto/Cofre_del_Pirata/15_P-11_Estrategia_Newsletter_en_90_días.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/16_P-12_Win-back_de_Cancellation.md" target="_blank" rel="noopener">P-12: Win-back de Cancellation</a> <code>bruto/Cofre_del_Pirata/16_P-12_Win-back_de_Cancellation.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/17_P-13_Posicionamiento_en_1_Oración.md" target="_blank" rel="noopener">P-13: Posicionamiento en 1 Oración</a> <code>bruto/Cofre_del_Pirata/17_P-13_Posicionamiento_en_1_Oración.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/18_P-14_Plan_Operativo_Semanal_de_Founder_Solo.md" target="_blank" rel="noopener">P-14: Plan Operativo Semanal de Founder Solo</a> <code>bruto/Cofre_del_Pirata/18_P-14_Plan_Operativo_Semanal_de_Founder_Solo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/19_P-15_Métricas_Semanales_que_Importan.md" target="_blank" rel="noopener">P-15: Métricas Semanales que Importan</a> <code>bruto/Cofre_del_Pirata/19_P-15_Métricas_Semanales_que_Importan.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/20_P-16_Documentación_de_Proceso_para_Delegar_SOP.md" target="_blank" rel="noopener">P-16: Documentación de Proceso para Delegar (SOP)</a> <code>bruto/Cofre_del_Pirata/20_P-16_Documentación_de_Proceso_para_Delegar_SOP.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/21_P-17_Plantilla_de_Decisión_24h.md" target="_blank" rel="noopener">P-17: Plantilla de Decisión 24h</a> <code>bruto/Cofre_del_Pirata/21_P-17_Plantilla_de_Decisión_24h.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/22_P-18_Roadmap_Producto_90_días.md" target="_blank" rel="noopener">P-18: Roadmap Producto 90 días</a> <code>bruto/Cofre_del_Pirata/22_P-18_Roadmap_Producto_90_días.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/23_P-19_Análisis_de_Churn.md" target="_blank" rel="noopener">P-19: Análisis de Churn</a> <code>bruto/Cofre_del_Pirata/23_P-19_Análisis_de_Churn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/24_P-20_User_Interview_que_SÍ_Aprende.md" target="_blank" rel="noopener">P-20: User Interview que SÍ Aprende</a> <code>bruto/Cofre_del_Pirata/24_P-20_User_Interview_que_SÍ_Aprende.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/25_P-21_Responder_una_queja_sin_escalar.md" target="_blank" rel="noopener">P-21: Responder una queja sin escalar</a> <code>bruto/Cofre_del_Pirata/25_P-21_Responder_una_queja_sin_escalar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/26_P-22_Decir_que_no_sin_quemar_la_relación.md" target="_blank" rel="noopener">P-22: Decir que no sin quemar la relación</a> <code>bruto/Cofre_del_Pirata/26_P-22_Decir_que_no_sin_quemar_la_relación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/27_P-23_La_respuesta_a_la_pregunta_repetida.md" target="_blank" rel="noopener">P-23: La respuesta a la pregunta repetida</a> <code>bruto/Cofre_del_Pirata/27_P-23_La_respuesta_a_la_pregunta_repetida.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/28_P-24_Desarmar_a_un_cliente_enojado.md" target="_blank" rel="noopener">P-24: Desarmar a un cliente enojado</a> <code>bruto/Cofre_del_Pirata/28_P-24_Desarmar_a_un_cliente_enojado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/29_P-25_Resumir_un_contrato_y_sus_riesgos.md" target="_blank" rel="noopener">P-25: Resumir un contrato y sus riesgos</a> <code>bruto/Cofre_del_Pirata/29_P-25_Resumir_un_contrato_y_sus_riesgos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/30_P-26_Acuerdos_y_tareas_de_una_reunión.md" target="_blank" rel="noopener">P-26: Acuerdos y tareas de una reunión</a> <code>bruto/Cofre_del_Pirata/30_P-26_Acuerdos_y_tareas_de_una_reunión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/31_P-27_Comparar_dos_cotizaciones_y_decidir.md" target="_blank" rel="noopener">P-27: Comparar dos cotizaciones y decidir</a> <code>bruto/Cofre_del_Pirata/31_P-27_Comparar_dos_cotizaciones_y_decidir.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/32_P-28_Lo_accionable_de_un_reporte_largo.md" target="_blank" rel="noopener">P-28: Lo accionable de un reporte largo</a> <code>bruto/Cofre_del_Pirata/32_P-28_Lo_accionable_de_un_reporte_largo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/33_P-29_Construye_ingresos_recurrentes.md" target="_blank" rel="noopener">P-29: Construye ingresos recurrentes</a> <code>bruto/Cofre_del_Pirata/33_P-29_Construye_ingresos_recurrentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/34_P-30_Tus_primeros_100_clientes.md" target="_blank" rel="noopener">P-30: Tus primeros 100 clientes</a> <code>bruto/Cofre_del_Pirata/34_P-30_Tus_primeros_100_clientes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/35_P-31_Pivot_o_persiste.md" target="_blank" rel="noopener">P-31: Pivot o persiste</a> <code>bruto/Cofre_del_Pirata/35_P-31_Pivot_o_persiste.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/36_P-32_Sube_tus_precios.md" target="_blank" rel="noopener">P-32: Sube tus precios</a> <code>bruto/Cofre_del_Pirata/36_P-32_Sube_tus_precios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/37_P-33_Tu_cliente_ideal.md" target="_blank" rel="noopener">P-33: Tu cliente ideal</a> <code>bruto/Cofre_del_Pirata/37_P-33_Tu_cliente_ideal.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/38_2_Workflows_n8n.md" target="_blank" rel="noopener">2️⃣ Workflows n8n</a> <code>bruto/Cofre_del_Pirata/38_2_Workflows_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/39_00_Cómo_importar_workflows_n8n.md" target="_blank" rel="noopener">00 · Cómo importar workflows n8n</a> <code>bruto/Cofre_del_Pirata/39_00_Cómo_importar_workflows_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/40_W-01_Auto-aprobar_members_con_AI.md" target="_blank" rel="noopener">W-01: Auto-aprobar members con AI</a> <code>bruto/Cofre_del_Pirata/40_W-01_Auto-aprobar_members_con_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/41_W-02_Onboarding_DM_con_cheatsheet_IA.md" target="_blank" rel="noopener">W-02: Onboarding DM con cheatsheet IA</a> <code>bruto/Cofre_del_Pirata/41_W-02_Onboarding_DM_con_cheatsheet_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/42_W-03_Enriquecer_CRM_con_AI.md" target="_blank" rel="noopener">W-03: Enriquecer CRM con AI</a> <code>bruto/Cofre_del_Pirata/42_W-03_Enriquecer_CRM_con_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/43_W-04_Matriz_de_Eisenhower_Inbox.md" target="_blank" rel="noopener">W-04: Matriz de Eisenhower (Inbox)</a> <code>bruto/Cofre_del_Pirata/43_W-04_Matriz_de_Eisenhower_Inbox.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/44_W-05_Chatbot_WhatsApp_con_AI_agent.md" target="_blank" rel="noopener">W-05: Chatbot WhatsApp con AI agent</a> <code>bruto/Cofre_del_Pirata/44_W-05_Chatbot_WhatsApp_con_AI_agent.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/45_W-06_RSS_IndexNow_indexación.md" target="_blank" rel="noopener">W-06: RSS → IndexNow (indexación)</a> <code>bruto/Cofre_del_Pirata/45_W-06_RSS_IndexNow_indexación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/46_W-07_RSS_Google_Indexing_API.md" target="_blank" rel="noopener">W-07: RSS → Google Indexing API</a> <code>bruto/Cofre_del_Pirata/46_W-07_RSS_Google_Indexing_API.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/47_W-08_Workflows_n8n_con_Claude_Code_MCPs.md" target="_blank" rel="noopener">W-08: Workflows n8n con Claude Code + MCPs</a> <code>bruto/Cofre_del_Pirata/47_W-08_Workflows_n8n_con_Claude_Code_MCPs.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/48_W-09_CRM_Agéntico_con_NocoDB_n8n_AI.md" target="_blank" rel="noopener">W-09: CRM Agéntico con NocoDB + n8n + AI</a> <code>bruto/Cofre_del_Pirata/48_W-09_CRM_Agéntico_con_NocoDB_n8n_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/49_W-10_Recordatorios_de_eventos_a_WhatsApp.md" target="_blank" rel="noopener">W-10: Recordatorios de eventos a WhatsApp</a> <code>bruto/Cofre_del_Pirata/49_W-10_Recordatorios_de_eventos_a_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/50_W-11_Curador_de_contenido_Telegram.md" target="_blank" rel="noopener">W-11: Curador de contenido (Telegram)</a> <code>bruto/Cofre_del_Pirata/50_W-11_Curador_de_contenido_Telegram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/51_W-12_Agenda_de_citas_Calendar_Telegram.md" target="_blank" rel="noopener">W-12: Agenda de citas (Calendar + Telegram)</a> <code>bruto/Cofre_del_Pirata/51_W-12_Agenda_de_citas_Calendar_Telegram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/52_W-13_Nota_de_voz_resumen_acciones.md" target="_blank" rel="noopener">W-13: Nota de voz → resumen + acciones</a> <code>bruto/Cofre_del_Pirata/52_W-13_Nota_de_voz_resumen_acciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/53_3_AGENTSmd_CLAUDEmd.md" target="_blank" rel="noopener">3️⃣ AGENTS.md / CLAUDE.md</a> <code>bruto/Cofre_del_Pirata/53_3_AGENTSmd_CLAUDEmd.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/54_00_Cómo_usar_los_CLAUDEmd.md" target="_blank" rel="noopener">00 · Cómo usar los CLAUDE.md</a> <code>bruto/Cofre_del_Pirata/54_00_Cómo_usar_los_CLAUDEmd.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/55_CMD-01_Founder_Solo_tu_IA_como_Co-CEO.md" target="_blank" rel="noopener">CMD-01: Founder Solo (tu IA como Co-CEO)</a> <code>bruto/Cofre_del_Pirata/55_CMD-01_Founder_Solo_tu_IA_como_Co-CEO.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/56_CMD-02_Founder_con_Equipo_3-15_personas.md" target="_blank" rel="noopener">CMD-02: Founder con Equipo (3-15 personas)</a> <code>bruto/Cofre_del_Pirata/56_CMD-02_Founder_con_Equipo_3-15_personas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/57_CMD-03_Founder_con_Producto_SaaS.md" target="_blank" rel="noopener">CMD-03: Founder con Producto SaaS</a> <code>bruto/Cofre_del_Pirata/57_CMD-03_Founder_con_Producto_SaaS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/58_CMD-06_Devils_Advocate_mata_ideas_malas.md" target="_blank" rel="noopener">CMD-06: Devil&#39;s Advocate (mata ideas malas)</a> <code>bruto/Cofre_del_Pirata/58_CMD-06_Devils_Advocate_mata_ideas_malas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/59_5-PROD_5_AGENTSmd_de_producción_reales.md" target="_blank" rel="noopener">5-PROD: 5 AGENTS.md de producción reales</a> <code>bruto/Cofre_del_Pirata/59_5-PROD_5_AGENTSmd_de_producción_reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/60_4_Plantillas.md" target="_blank" rel="noopener">4️⃣ Plantillas</a> <code>bruto/Cofre_del_Pirata/60_4_Plantillas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/61_00_Cómo_usar_las_plantillas.md" target="_blank" rel="noopener">00 · Cómo usar las plantillas</a> <code>bruto/Cofre_del_Pirata/61_00_Cómo_usar_las_plantillas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/62_T-01_Sheet_de_Métricas_Semanales.md" target="_blank" rel="noopener">T-01: Sheet de Métricas Semanales</a> <code>bruto/Cofre_del_Pirata/62_T-01_Sheet_de_Métricas_Semanales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/63_T-02_Sheet_de_Pricing_Decision.md" target="_blank" rel="noopener">T-02: Sheet de Pricing Decision</a> <code>bruto/Cofre_del_Pirata/63_T-02_Sheet_de_Pricing_Decision.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/64_T-03_Tracker_de_OKRs_Trimestrales.md" target="_blank" rel="noopener">T-03: Tracker de OKRs Trimestrales</a> <code>bruto/Cofre_del_Pirata/64_T-03_Tracker_de_OKRs_Trimestrales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/65_T-06_Tracker_Churn_Win-Back.md" target="_blank" rel="noopener">T-06: Tracker Churn + Win-Back</a> <code>bruto/Cofre_del_Pirata/65_T-06_Tracker_Churn_Win-Back.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/66_T-07_Calculadora_de_Punto_de_Equilibrio.md" target="_blank" rel="noopener">T-07: Calculadora de Punto de Equilibrio</a> <code>bruto/Cofre_del_Pirata/66_T-07_Calculadora_de_Punto_de_Equilibrio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/67_T-08_Calculadora_de_Márgenes_de_Ganancia.md" target="_blank" rel="noopener">T-08: Calculadora de Márgenes de Ganancia</a> <code>bruto/Cofre_del_Pirata/67_T-08_Calculadora_de_Márgenes_de_Ganancia.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/68_T-09_Proyección_Financiera_Simple_3_meses.md" target="_blank" rel="noopener">T-09: Proyección Financiera Simple (3 meses)</a> <code>bruto/Cofre_del_Pirata/68_T-09_Proyección_Financiera_Simple_3_meses.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/69_5_Agentes.md" target="_blank" rel="noopener">5️⃣ 🤖 Agentes</a> <code>bruto/Cofre_del_Pirata/69_5_Agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/70_00_Qué_son_los_agentes_y_cómo_funcionan.md" target="_blank" rel="noopener">00 — Qué son los agentes y cómo funcionan</a> <code>bruto/Cofre_del_Pirata/70_00_Qué_son_los_agentes_y_cómo_funcionan.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/71_01_Cómo_instalar_agentes_multi-tool.md" target="_blank" rel="noopener">01 — Cómo instalar agentes (multi-tool)</a> <code>bruto/Cofre_del_Pirata/71_01_Cómo_instalar_agentes_multi-tool.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/72_02_Combinar_agentes_y_skills.md" target="_blank" rel="noopener">02 — Combinar agentes y skills</a> <code>bruto/Cofre_del_Pirata/72_02_Combinar_agentes_y_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/73_A-01_VoltAgent_awesome-claude-code-subagents.md" target="_blank" rel="noopener">A-01: VoltAgent · awesome-claude-code-subagents</a> <code>bruto/Cofre_del_Pirata/73_A-01_VoltAgent_awesome-claude-code-subagents.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/74_A-02_wshobson_agents.md" target="_blank" rel="noopener">A-02: wshobson · agents</a> <code>bruto/Cofre_del_Pirata/74_A-02_wshobson_agents.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/75_A-03_rshah515_claude-code-subagents.md" target="_blank" rel="noopener">A-03: rshah515 · claude-code-subagents</a> <code>bruto/Cofre_del_Pirata/75_A-03_rshah515_claude-code-subagents.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/76_A-04_0xfurai_claude-code-subagents.md" target="_blank" rel="noopener">A-04: 0xfurai · claude-code-subagents</a> <code>bruto/Cofre_del_Pirata/76_A-04_0xfurai_claude-code-subagents.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/77_A-05_msitarzewski_agency-agents.md" target="_blank" rel="noopener">A-05: msitarzewski · agency-agents</a> <code>bruto/Cofre_del_Pirata/77_A-05_msitarzewski_agency-agents.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/78_A-06_Crea_TU_agente_custom.md" target="_blank" rel="noopener">A-06: Crea TU agente custom</a> <code>bruto/Cofre_del_Pirata/78_A-06_Crea_TU_agente_custom.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/79_A-07_SEO_con_IA_Agentes_Pipeline.md" target="_blank" rel="noopener">A-07: SEO con IA + Agentes — Pipeline</a> <code>bruto/Cofre_del_Pirata/79_A-07_SEO_con_IA_Agentes_Pipeline.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/80_6_Skills.md" target="_blank" rel="noopener">6️⃣ 🛠️ Skills</a> <code>bruto/Cofre_del_Pirata/80_6_Skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/81_00_Qué_son_las_Skills_AGENTSmd_vs_CLAUDEmd.md" target="_blank" rel="noopener">00 — Qué son las Skills + AGENTS.md vs CLAUDE.md</a> <code>bruto/Cofre_del_Pirata/81_00_Qué_son_las_Skills_AGENTSmd_vs_CLAUDEmd.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/82_01_Cómo_instalar_skills_multi-tool.md" target="_blank" rel="noopener">01 — Cómo instalar skills (multi-tool)</a> <code>bruto/Cofre_del_Pirata/82_01_Cómo_instalar_skills_multi-tool.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/83_S-01_Anthropic_skills_oficial.md" target="_blank" rel="noopener">S-01: Anthropic · skills (oficial)</a> <code>bruto/Cofre_del_Pirata/83_S-01_Anthropic_skills_oficial.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/84_S-02_VoltAgent_awesome-agent-skills.md" target="_blank" rel="noopener">S-02: VoltAgent · awesome-agent-skills</a> <code>bruto/Cofre_del_Pirata/84_S-02_VoltAgent_awesome-agent-skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/85_S-03_coreyhaines31_marketingskills.md" target="_blank" rel="noopener">S-03: coreyhaines31 · marketingskills</a> <code>bruto/Cofre_del_Pirata/85_S-03_coreyhaines31_marketingskills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/86_S-04_alirezarezvani_claude-skills.md" target="_blank" rel="noopener">S-04: alirezarezvani · claude-skills</a> <code>bruto/Cofre_del_Pirata/86_S-04_alirezarezvani_claude-skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/87_S-05_ComposioHQ_awesome-claude-skills.md" target="_blank" rel="noopener">S-05: ComposioHQ · awesome-claude-skills</a> <code>bruto/Cofre_del_Pirata/87_S-05_ComposioHQ_awesome-claude-skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/88_S-06_Crea_TU_skill_custom.md" target="_blank" rel="noopener">S-06: Crea TU skill custom</a> <code>bruto/Cofre_del_Pirata/88_S-06_Crea_TU_skill_custom.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/89_7_Cheatsheets.md" target="_blank" rel="noopener">7️⃣ 🃏 Cheatsheets</a> <code>bruto/Cofre_del_Pirata/89_7_Cheatsheets.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/90_G-01_Stack_Founder_Solo_LATAM.md" target="_blank" rel="noopener">G-01: Stack Founder Solo LATAM</a> <code>bruto/Cofre_del_Pirata/90_G-01_Stack_Founder_Solo_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/91_G-02_Pricing_AI_Services_LATAM.md" target="_blank" rel="noopener">G-02: Pricing AI Services LATAM</a> <code>bruto/Cofre_del_Pirata/91_G-02_Pricing_AI_Services_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/92_G-03_CRM_Stack_Founder_Solo.md" target="_blank" rel="noopener">G-03: CRM Stack Founder Solo</a> <code>bruto/Cofre_del_Pirata/92_G-03_CRM_Stack_Founder_Solo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/93_FW-02_Build_vs_No-code_vs_Outsource.md" target="_blank" rel="noopener">FW-02: Build vs No-code vs Outsource</a> <code>bruto/Cofre_del_Pirata/93_FW-02_Build_vs_No-code_vs_Outsource.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/94_FW-03_Cuándo_poner_paywall_y_qué_cobrar.md" target="_blank" rel="noopener">FW-03: ¿Cuándo poner paywall y qué cobrar?</a> <code>bruto/Cofre_del_Pirata/94_FW-03_Cuándo_poner_paywall_y_qué_cobrar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/95_G-04_Frameworks_de_negocio_con_IA.md" target="_blank" rel="noopener">G-04: Frameworks de negocio con IA</a> <code>bruto/Cofre_del_Pirata/95_G-04_Frameworks_de_negocio_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/96_8_Playbooks.md" target="_blank" rel="noopener">8️⃣ 🔧 Playbooks</a> <code>bruto/Cofre_del_Pirata/96_8_Playbooks.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/97_H-01_Mi_agente_con_n8n_entra_en_bucle.md" target="_blank" rel="noopener">H-01: Mi agente con n8n entra en bucle</a> <code>bruto/Cofre_del_Pirata/97_H-01_Mi_agente_con_n8n_entra_en_bucle.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/98_H-02_El_output_suena_a_IA_y_no_a_mí.md" target="_blank" rel="noopener">H-02: El output suena a IA y no a mí</a> <code>bruto/Cofre_del_Pirata/98_H-02_El_output_suena_a_IA_y_no_a_mí.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cofre_del_Pirata/99_H-03_Mi_agente_alucina_datos_del_cliente.md" target="_blank" rel="noopener">H-03: Mi agente alucina datos del cliente</a> <code>bruto/Cofre_del_Pirata/99_H-03_Mi_agente_alucina_datos_del_cliente.md</code></li>
</ul>$lf_module_5$,
    50,
    true,
    '{}'::jsonb
  ),
  (
    'car-como-levantar-capital-latam',
    'car-ecosistema-startup',
    'Cómo Levantar Capital LATAM',
    '🚀',
    '10 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_6$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Cómo Levantar Capital LATAM · 10 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/01_Cómo_Levantar_Capital_LATAM.md" target="_blank" rel="noopener">💰 Cómo Levantar Capital · LATAM</a> <code>bruto/Cómo_Levantar_Capital_LATAM/01_Cómo_Levantar_Capital_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/02_INTRODUCCIÓN.md" target="_blank" rel="noopener">INTRODUCCIÓN</a> <code>bruto/Cómo_Levantar_Capital_LATAM/02_INTRODUCCIÓN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/03_Introducción_al_curso_con_Federico_Iriberry.md" target="_blank" rel="noopener">Introducción al curso con Federico Iriberry</a> <code>bruto/Cómo_Levantar_Capital_LATAM/03_Introducción_al_curso_con_Federico_Iriberry.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/04_PREPÁRATE_PARA_LEVANTAR_CAPITAL.md" target="_blank" rel="noopener">PREPÁRATE PARA LEVANTAR CAPITAL</a> <code>bruto/Cómo_Levantar_Capital_LATAM/04_PREPÁRATE_PARA_LEVANTAR_CAPITAL.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/05_El_viaje_de_una_Startup.md" target="_blank" rel="noopener">El viaje de una Startup</a> <code>bruto/Cómo_Levantar_Capital_LATAM/05_El_viaje_de_una_Startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/06_Análisis_del_Ecosistema_Emprendedor.md" target="_blank" rel="noopener">Análisis del Ecosistema Emprendedor</a> <code>bruto/Cómo_Levantar_Capital_LATAM/06_Análisis_del_Ecosistema_Emprendedor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/07_Porqué_es_importante_tener_una_estrategia.md" target="_blank" rel="noopener">¿Porqué es importante tener una estrategia?</a> <code>bruto/Cómo_Levantar_Capital_LATAM/07_Porqué_es_importante_tener_una_estrategia.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/08_Cuándo_es_mejor_acercarse_a_privados.md" target="_blank" rel="noopener">¿Cuándo es mejor acercarse a privados?</a> <code>bruto/Cómo_Levantar_Capital_LATAM/08_Cuándo_es_mejor_acercarse_a_privados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/09_Consejos_para_tu_Pitch_frente_a_inversionistas.md" target="_blank" rel="noopener">Consejos para tu Pitch frente a inversionistas</a> <code>bruto/Cómo_Levantar_Capital_LATAM/09_Consejos_para_tu_Pitch_frente_a_inversionistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Cómo_Levantar_Capital_LATAM/10_Etapas_Actores_y_Cuándo.md" target="_blank" rel="noopener">Etapas, Actores y ¿Cuándo?</a> <code>bruto/Cómo_Levantar_Capital_LATAM/10_Etapas_Actores_y_Cuándo.md</code></li>
</ul>$lf_module_6$,
    60,
    true,
    '{}'::jsonb
  ),
  (
    'car-empieza-aqui',
    'car-ecosistema-startup',
    'Empieza Aquí',
    '🚀',
    '19 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_7$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Empieza Aquí · 19 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/01_Empieza_Aquí.md" target="_blank" rel="noopener">🚀 Empieza Aquí</a> <code>bruto/Empieza_Aquí/01_Empieza_Aquí.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/02_La_nueva_era_de_emprender.md" target="_blank" rel="noopener">🌎 La nueva era de emprender</a> <code>bruto/Empieza_Aquí/02_La_nueva_era_de_emprender.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/03_Tus_primeros_pasos.md" target="_blank" rel="noopener">🎯 Tus primeros pasos</a> <code>bruto/Empieza_Aquí/03_Tus_primeros_pasos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/04_Preséntate_en_Presentaciones.md" target="_blank" rel="noopener">👋 Preséntate en Presentaciones</a> <code>bruto/Empieza_Aquí/04_Preséntate_en_Presentaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/05_Sistema_de_niveles.md" target="_blank" rel="noopener">🎮 Sistema de niveles</a> <code>bruto/Empieza_Aquí/05_Sistema_de_niveles.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/06_Mapa_del_classroom_y_el_feed.md" target="_blank" rel="noopener">🗺️ Mapa del classroom y el feed</a> <code>bruto/Empieza_Aquí/06_Mapa_del_classroom_y_el_feed.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/07_Eventos_en_vivo.md" target="_blank" rel="noopener">📅 Eventos en vivo</a> <code>bruto/Empieza_Aquí/07_Eventos_en_vivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/08_Cómo_encontrar_lo_que_buscas.md" target="_blank" rel="noopener">🔍 Cómo encontrar lo que buscas</a> <code>bruto/Empieza_Aquí/08_Cómo_encontrar_lo_que_buscas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/09_Cómo_destacar_en_CAR.md" target="_blank" rel="noopener">🌟 Cómo destacar en CAR</a> <code>bruto/Empieza_Aquí/09_Cómo_destacar_en_CAR.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/10_Cómo_destacar_en_la_comunidad.md" target="_blank" rel="noopener">🌟 Cómo destacar en la comunidad</a> <code>bruto/Empieza_Aquí/10_Cómo_destacar_en_la_comunidad.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/11_Saca_provecho.md" target="_blank" rel="noopener">📚 Saca provecho</a> <code>bruto/Empieza_Aquí/11_Saca_provecho.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/12_Cómo_sacarle_provecho_a_tu_membresía.md" target="_blank" rel="noopener">📚 Cómo sacarle provecho a tu membresía</a> <code>bruto/Empieza_Aquí/12_Cómo_sacarle_provecho_a_tu_membresía.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/13_Aprender_juntos.md" target="_blank" rel="noopener">👥 Aprender juntos</a> <code>bruto/Empieza_Aquí/13_Aprender_juntos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/14_Cómo_aprender_en_conjunto.md" target="_blank" rel="noopener">👥 Cómo aprender en conjunto</a> <code>bruto/Empieza_Aquí/14_Cómo_aprender_en_conjunto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/15_FAQ_preguntas_que_me_hacen_seguido.md" target="_blank" rel="noopener">❓ FAQ — preguntas que me hacen seguido</a> <code>bruto/Empieza_Aquí/15_FAQ_preguntas_que_me_hacen_seguido.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/16_Plan_de_carrera_qué_cursos_según_tu_etapa.md" target="_blank" rel="noopener">🎯 Plan de carrera — qué cursos según tu etapa</a> <code>bruto/Empieza_Aquí/16_Plan_de_carrera_qué_cursos_según_tu_etapa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/17_Gana_con_nosotros_40_forever.md" target="_blank" rel="noopener">💸 Gana $ con nosotros — 40% forever</a> <code>bruto/Empieza_Aquí/17_Gana_con_nosotros_40_forever.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/18_Tu_plan_de_las_primeras_2_semanas.md" target="_blank" rel="noopener">✅ Tu plan de las primeras 2 semanas</a> <code>bruto/Empieza_Aquí/18_Tu_plan_de_las_primeras_2_semanas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Empieza_Aquí/19_Bonus_el_Cofre_del_Pirata.md" target="_blank" rel="noopener">🏴‍☠️ Bonus: el Cofre del Pirata</a> <code>bruto/Empieza_Aquí/19_Bonus_el_Cofre_del_Pirata.md</code></li>
</ul>$lf_module_7$,
    70,
    true,
    '{}'::jsonb
  ),
  (
    'car-eventos-abiertos-del-ecosistema',
    'car-ecosistema-startup',
    'Eventos Abiertos del Ecosistema',
    '🚀',
    '6 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_8$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Eventos Abiertos del Ecosistema · 6 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Eventos_Abiertos_del_Ecosistema/01_Eventos_Abiertos_del_Ecosistema.md" target="_blank" rel="noopener">📅 Eventos Abiertos del Ecosistema</a> <code>bruto/Eventos_Abiertos_del_Ecosistema/01_Eventos_Abiertos_del_Ecosistema.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Eventos_Abiertos_del_Ecosistema/02_Webinars.md" target="_blank" rel="noopener">Webinars</a> <code>bruto/Eventos_Abiertos_del_Ecosistema/02_Webinars.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Eventos_Abiertos_del_Ecosistema/03_Tu_socio_el_mejor_activo_o_el_mayor_riesgo.md" target="_blank" rel="noopener">¿Tu socio: el mejor activo o el mayor riesgo?</a> <code>bruto/Eventos_Abiertos_del_Ecosistema/03_Tu_socio_el_mejor_activo_o_el_mayor_riesgo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Eventos_Abiertos_del_Ecosistema/04_De_Cero_a_Exit_con_David_y_Antti_de_ComunidadFeliz.md" target="_blank" rel="noopener">De Cero a Exit con David y Antti de ComunidadFeliz</a> <code>bruto/Eventos_Abiertos_del_Ecosistema/04_De_Cero_a_Exit_con_David_y_Antti_de_ComunidadFeliz.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Eventos_Abiertos_del_Ecosistema/05_Roast_My_Pitch.md" target="_blank" rel="noopener">Roast My Pitch</a> <code>bruto/Eventos_Abiertos_del_Ecosistema/05_Roast_My_Pitch.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Eventos_Abiertos_del_Ecosistema/06_Roast_My_Pitch_-_Enero_2026.md" target="_blank" rel="noopener">Roast My Pitch - Enero 2026</a> <code>bruto/Eventos_Abiertos_del_Ecosistema/06_Roast_My_Pitch_-_Enero_2026.md</code></li>
</ul>$lf_module_8$,
    80,
    true,
    '{}'::jsonb
  ),
  (
    'car-finanzas-aplicadas-101',
    'car-ecosistema-startup',
    'Finanzas Aplicadas 101',
    '🚀',
    '21 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_9$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Finanzas Aplicadas 101 · 21 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/01_Finanzas_Aplicadas_101.md" target="_blank" rel="noopener">📊 Finanzas Aplicadas 101</a> <code>bruto/Finanzas_Aplicadas_101/01_Finanzas_Aplicadas_101.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/02_Introducción.md" target="_blank" rel="noopener">Introducción</a> <code>bruto/Finanzas_Aplicadas_101/02_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/03_Bienvenida_al_curso.md" target="_blank" rel="noopener">Bienvenida al curso</a> <code>bruto/Finanzas_Aplicadas_101/03_Bienvenida_al_curso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/03_Bienvenida_al_curso.transcript.md" target="_blank" rel="noopener">Transcripción — Bienvenida al curso</a> <code>bruto/Finanzas_Aplicadas_101/03_Bienvenida_al_curso.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/04_Lógica_Financiera.md" target="_blank" rel="noopener">Lógica Financiera</a> <code>bruto/Finanzas_Aplicadas_101/04_Lógica_Financiera.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/05_Lógica_de_Márgenes_Brutos.md" target="_blank" rel="noopener">Lógica de Márgenes Brutos</a> <code>bruto/Finanzas_Aplicadas_101/05_Lógica_de_Márgenes_Brutos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/05_Lógica_de_Márgenes_Brutos.transcript.md" target="_blank" rel="noopener">Transcripción — Lógica de Márgenes Brutos</a> <code>bruto/Finanzas_Aplicadas_101/05_Lógica_de_Márgenes_Brutos.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/06_Estructuración_de_Costos.md" target="_blank" rel="noopener">Estructuración de Costos</a> <code>bruto/Finanzas_Aplicadas_101/06_Estructuración_de_Costos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/06_Estructuración_de_Costos.transcript.md" target="_blank" rel="noopener">Transcripción — Estructuración de Costos</a> <code>bruto/Finanzas_Aplicadas_101/06_Estructuración_de_Costos.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/07_Análisis_de_Unidad_de_negocio.md" target="_blank" rel="noopener">Análisis de Unidad de negocio</a> <code>bruto/Finanzas_Aplicadas_101/07_Análisis_de_Unidad_de_negocio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/07_Análisis_de_Unidad_de_negocio.transcript.md" target="_blank" rel="noopener">Transcripción — Análisis de Unidad de negocio</a> <code>bruto/Finanzas_Aplicadas_101/07_Análisis_de_Unidad_de_negocio.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/08_Aplicaciones_financieras_prácticas.md" target="_blank" rel="noopener">Aplicaciones financieras prácticas</a> <code>bruto/Finanzas_Aplicadas_101/08_Aplicaciones_financieras_prácticas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/08_Aplicaciones_financieras_prácticas.transcript.md" target="_blank" rel="noopener">Transcripción — Aplicaciones financieras prácticas</a> <code>bruto/Finanzas_Aplicadas_101/08_Aplicaciones_financieras_prácticas.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/09_Equilibrio_Económico.md" target="_blank" rel="noopener">Equilibrio Económico</a> <code>bruto/Finanzas_Aplicadas_101/09_Equilibrio_Económico.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/09_Equilibrio_Económico.transcript.md" target="_blank" rel="noopener">Transcripción — Equilibrio Económico</a> <code>bruto/Finanzas_Aplicadas_101/09_Equilibrio_Económico.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/10_Equilibrio_Financiero_o_Break_Even.md" target="_blank" rel="noopener">Equilibrio Financiero o Break Even</a> <code>bruto/Finanzas_Aplicadas_101/10_Equilibrio_Financiero_o_Break_Even.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/10_Equilibrio_Financiero_o_Break_Even.transcript.md" target="_blank" rel="noopener">Transcripción — Equilibrio Financiero o Break Even</a> <code>bruto/Finanzas_Aplicadas_101/10_Equilibrio_Financiero_o_Break_Even.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/11_Aplicación_Práctica.md" target="_blank" rel="noopener">Aplicación Práctica</a> <code>bruto/Finanzas_Aplicadas_101/11_Aplicación_Práctica.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/12_Uso_de_plantilla_exclusiva_para_calculo_break-even.md" target="_blank" rel="noopener">Uso de plantilla exclusiva para calculo break-even</a> <code>bruto/Finanzas_Aplicadas_101/12_Uso_de_plantilla_exclusiva_para_calculo_break-even.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/13_Resumen_del_curso_y_conclusiones.md" target="_blank" rel="noopener">Resumen del curso y conclusiones</a> <code>bruto/Finanzas_Aplicadas_101/13_Resumen_del_curso_y_conclusiones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Finanzas_Aplicadas_101/14_Conclusiones.md" target="_blank" rel="noopener">Conclusiones</a> <code>bruto/Finanzas_Aplicadas_101/14_Conclusiones.md</code></li>
</ul>$lf_module_9$,
    90,
    true,
    '{}'::jsonb
  ),
  (
    'car-fundraising-101-atrae-inversionistas',
    'car-ecosistema-startup',
    'Fundraising 101 Atrae Inversionistas',
    '🚀',
    '27 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_10$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Fundraising 101 Atrae Inversionistas · 27 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/01_Fundraising_101_Atrae_Inversionistas.md" target="_blank" rel="noopener">💰 Fundraising 101 · Atrae Inversionistas</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/01_Fundraising_101_Atrae_Inversionistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/02_Introducción.md" target="_blank" rel="noopener">Introducción</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/02_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/03_Conoce_a_Javier_Cueto_y_objetivos_del_curso.md" target="_blank" rel="noopener">Conoce a Javier Cueto y objetivos del curso.</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/03_Conoce_a_Javier_Cueto_y_objetivos_del_curso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/04_Fundamentos_del_fundraising_para_startups.md" target="_blank" rel="noopener">Fundamentos del fundraising para startups</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/04_Fundamentos_del_fundraising_para_startups.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/05_Es_esencial_el_fundraising_para_una_startup.md" target="_blank" rel="noopener">¿Es esencial el fundraising para una startup?</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/05_Es_esencial_el_fundraising_para_una_startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/06_Conceptos_básicos_Bootstrapping_o_Capital_Externo.md" target="_blank" rel="noopener">Conceptos básicos: Bootstrapping o Capital Externo</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/06_Conceptos_básicos_Bootstrapping_o_Capital_Externo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/07_Diferencias_entre_tipos_de_inversionistas.md" target="_blank" rel="noopener">Diferencias entre tipos de inversionistas</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/07_Diferencias_entre_tipos_de_inversionistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/08_Conceptos_básicos_de_rondas_de_inversión.md" target="_blank" rel="noopener">Conceptos básicos de rondas de inversión</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/08_Conceptos_básicos_de_rondas_de_inversión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/09_Cómo_evaluar_si_el_fundraising_es_necesario.md" target="_blank" rel="noopener">¿Cómo evaluar si el fundraising es necesario?</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/09_Cómo_evaluar_si_el_fundraising_es_necesario.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/10_Preparación_para_el_levantamiento_de_capital.md" target="_blank" rel="noopener">Preparación para el levantamiento de capital</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/10_Preparación_para_el_levantamiento_de_capital.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/11_Objetivos_del_módulo.md" target="_blank" rel="noopener">Objetivos del módulo</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/11_Objetivos_del_módulo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/12_Cómo_estructurar_tu_startup_para_atraer_capital.md" target="_blank" rel="noopener">¿Cómo estructurar tu startup para atraer capital?</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/12_Cómo_estructurar_tu_startup_para_atraer_capital.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/13_Documentos_clave_pitch_deck_financials_y_BP.md" target="_blank" rel="noopener">Documentos clave: pitch deck, financials, y BP.</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/13_Documentos_clave_pitch_deck_financials_y_BP.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/14_La_importancia_del_Storytelling-Propuesta_de_Valor.md" target="_blank" rel="noopener">La importancia del Storytelling-Propuesta de Valor</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/14_La_importancia_del_Storytelling-Propuesta_de_Valor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/15_Ejemplos_prácticos_de_pitch_deck_efectivos_LATAM.md" target="_blank" rel="noopener">Ejemplos prácticos de pitch deck efectivos LATAM</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/15_Ejemplos_prácticos_de_pitch_deck_efectivos_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/16_Crear_para_presentaciones_sin_alto_costo.md" target="_blank" rel="noopener">Crear para presentaciones sin alto costo</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/16_Crear_para_presentaciones_sin_alto_costo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/17_Identificación_y_acercamiento_a_inversionistas.md" target="_blank" rel="noopener">Identificación y acercamiento a inversionistas</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/17_Identificación_y_acercamiento_a_inversionistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/18_Cómo_y_dónde_encontrar_inversionistas_adecuados.md" target="_blank" rel="noopener">Cómo y dónde encontrar inversionistas adecuados</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/18_Cómo_y_dónde_encontrar_inversionistas_adecuados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/19_Estrategias_al_crear_relaciones_con_inversionistas.md" target="_blank" rel="noopener">Estrategias al crear relaciones con inversionistas</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/19_Estrategias_al_crear_relaciones_con_inversionistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/20_Proceso_de_acercamiento.md" target="_blank" rel="noopener">Proceso de acercamiento</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/20_Proceso_de_acercamiento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/21_Errores_comunes_al_acercarse_a_inversionistas.md" target="_blank" rel="noopener">Errores comunes al acercarse a inversionistas</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/21_Errores_comunes_al_acercarse_a_inversionistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/22_Negociación_y_cierre_de_la_ronda_de_inversión.md" target="_blank" rel="noopener">Negociación y cierre de la ronda de inversión</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/22_Negociación_y_cierre_de_la_ronda_de_inversión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/23_Estrategias_para_defender_tu_valoración.md" target="_blank" rel="noopener">Estrategias para defender tu valoración</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/23_Estrategias_para_defender_tu_valoración.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/24_Comprendiendo_las_condiciones_de_inversión.md" target="_blank" rel="noopener">Comprendiendo las condiciones de inversión</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/24_Comprendiendo_las_condiciones_de_inversión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/25_Consejos_para_el_cierre_efectivo_de_una_ronda.md" target="_blank" rel="noopener">Consejos para el cierre efectivo de una ronda</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/25_Consejos_para_el_cierre_efectivo_de_una_ronda.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/26_Startups_Latinas_que_negociaron_con_éxito.md" target="_blank" rel="noopener">Startups Latinas que negociaron con éxito</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/26_Startups_Latinas_que_negociaron_con_éxito.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Fundraising_101_Atrae_Inversionistas/27_Conclusiones_del_curso.md" target="_blank" rel="noopener">Conclusiones del curso</a> <code>bruto/Fundraising_101_Atrae_Inversionistas/27_Conclusiones_del_curso.md</code></li>
</ul>$lf_module_10$,
    100,
    true,
    '{}'::jsonb
  ),
  (
    'car-intro-a-llms-decide-cual-usar',
    'car-ecosistema-startup',
    'Intro a LLMs Decide cuál usar',
    '🚀',
    '21 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_11$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Intro a LLMs Decide cuál usar · 21 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/01_Intro_a_LLMs_Decide_cuál_usar.md" target="_blank" rel="noopener">🧠 Intro a LLMs · Decide cuál usar</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/01_Intro_a_LLMs_Decide_cuál_usar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/02_El_LLM_no_es_un_Oráculo.md" target="_blank" rel="noopener">🧱 El LLM no es un Oráculo</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/02_El_LLM_no_es_un_Oráculo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/03_11_El_LLM_no_es_un_Oráculo_ni_un_Google.md" target="_blank" rel="noopener">1.1 El LLM no es un Oráculo ni un Google</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/03_11_El_LLM_no_es_un_Oráculo_ni_un_Google.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/04_12_Tokens_y_Ventanas_de_Contexto.md" target="_blank" rel="noopener">1.2 Tokens y Ventanas de Contexto</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/04_12_Tokens_y_Ventanas_de_Contexto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/05_13_El_Coste_Real_De_Tokens_a_Dólares.md" target="_blank" rel="noopener">1.3 El Coste Real · De Tokens a Dólares</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/05_13_El_Coste_Real_De_Tokens_a_Dólares.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/06_Mapa_de_Modelos_2026.md" target="_blank" rel="noopener">🗺️ Mapa de Modelos 2026</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/06_Mapa_de_Modelos_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/07_21_Los_5_Grandes_Frontier_Models_2026.md" target="_blank" rel="noopener">2.1 Los 5 Grandes · Frontier Models 2026</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/07_21_Los_5_Grandes_Frontier_Models_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/08_22_Low-Cost_DeepSeek_y_Qwen.md" target="_blank" rel="noopener">2.2 Low-Cost · DeepSeek y Qwen</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/08_22_Low-Cost_DeepSeek_y_Qwen.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/09_23_Local_vs_Cloud_Privacidad_y_Wallet.md" target="_blank" rel="noopener">2.3 Local vs Cloud · Privacidad y Wallet</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/09_23_Local_vs_Cloud_Privacidad_y_Wallet.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/10_Framework_de_Decisión.md" target="_blank" rel="noopener">📊 Framework de Decisión</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/10_Framework_de_Decisión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/11_31_LMSYS_Arena_y_Artificial_Analysis.md" target="_blank" rel="noopener">3.1 LMSYS Arena y Artificial Analysis</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/11_31_LMSYS_Arena_y_Artificial_Analysis.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/12_32_Scale_AI_y_HuggingFace_Técnico.md" target="_blank" rel="noopener">3.2 Scale AI y HuggingFace · Técnico</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/12_32_Scale_AI_y_HuggingFace_Técnico.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/13_33_Cómo_leer_un_Leaderboard_en_5_min.md" target="_blank" rel="noopener">3.3 Cómo leer un Leaderboard en 5 min</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/13_33_Cómo_leer_un_Leaderboard_en_5_min.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/14_Matchmaking_Cuál_y_cuándo.md" target="_blank" rel="noopener">🎯 Matchmaking · ¿Cuál y cuándo?</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/14_Matchmaking_Cuál_y_cuándo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/15_41_Contenido_y_Multilingüismo_LATAM.md" target="_blank" rel="noopener">4.1 Contenido y Multilingüismo (LATAM)</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/15_41_Contenido_y_Multilingüismo_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/16_42_Análisis_de_Datos_y_SQL_Complejo.md" target="_blank" rel="noopener">4.2 Análisis de Datos y SQL Complejo</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/16_42_Análisis_de_Datos_y_SQL_Complejo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/17_43_Agentes_Autónomos_y_Tool_Use.md" target="_blank" rel="noopener">4.3 Agentes Autónomos y Tool Use</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/17_43_Agentes_Autónomos_y_Tool_Use.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/18_44_Matriz_de_Decisión_Costo_vs_Calidad.md" target="_blank" rel="noopener">4.4 Matriz de Decisión · Costo vs Calidad</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/18_44_Matriz_de_Decisión_Costo_vs_Calidad.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/19_Tu_Primer_Experimento_Real.md" target="_blank" rel="noopener">🧪 Tu Primer Experimento Real</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/19_Tu_Primer_Experimento_Real.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/20_51_Setup_OpenRouter_Universal_Remote.md" target="_blank" rel="noopener">5.1 Setup OpenRouter · Universal Remote</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/20_51_Setup_OpenRouter_Universal_Remote.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Intro_a_LLMs_Decide_cuál_usar/21_52_Test_AB_5_modelos_en_paralelo.md" target="_blank" rel="noopener">5.2 Test A/B · 5 modelos en paralelo</a> <code>bruto/Intro_a_LLMs_Decide_cuál_usar/21_52_Test_AB_5_modelos_en_paralelo.md</code></li>
</ul>$lf_module_11$,
    110,
    true,
    '{}'::jsonb
  ),
  (
    'car-marca-personal-en-linkedin',
    'car-ecosistema-startup',
    'Marca Personal en LinkedIn',
    '🚀',
    '27 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_12$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Marca Personal en LinkedIn · 27 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/01_Marca_Personal_en_LinkedIn.md" target="_blank" rel="noopener">🎯 Marca Personal en LinkedIn</a> <code>bruto/Marca_Personal_en_LinkedIn/01_Marca_Personal_en_LinkedIn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/02_Introducción.md" target="_blank" rel="noopener">Introducción</a> <code>bruto/Marca_Personal_en_LinkedIn/02_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/03_Conoce_a_Diego_Arias_y_Objetivos_del_Curso.md" target="_blank" rel="noopener">Conoce a Diego Arias y Objetivos del Curso</a> <code>bruto/Marca_Personal_en_LinkedIn/03_Conoce_a_Diego_Arias_y_Objetivos_del_Curso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/03_Conoce_a_Diego_Arias_y_Objetivos_del_Curso.transcript.md" target="_blank" rel="noopener">Transcripción — Conoce a Diego Arias y Objetivos del Curso</a> <code>bruto/Marca_Personal_en_LinkedIn/03_Conoce_a_Diego_Arias_y_Objetivos_del_Curso.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/04_Inspiración_y_Caso_de_éxito.md" target="_blank" rel="noopener">Inspiración y Caso de éxito</a> <code>bruto/Marca_Personal_en_LinkedIn/04_Inspiración_y_Caso_de_éxito.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/04_Inspiración_y_Caso_de_éxito.transcript.md" target="_blank" rel="noopener">Transcripción — Inspiración y Caso de éxito</a> <code>bruto/Marca_Personal_en_LinkedIn/04_Inspiración_y_Caso_de_éxito.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/05_Fundamentos_y_Perfil_Ganador.md" target="_blank" rel="noopener">Fundamentos y Perfil Ganador</a> <code>bruto/Marca_Personal_en_LinkedIn/05_Fundamentos_y_Perfil_Ganador.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/06_Definiciones_Bases.md" target="_blank" rel="noopener">Definiciones Bases</a> <code>bruto/Marca_Personal_en_LinkedIn/06_Definiciones_Bases.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/06_Definiciones_Bases.transcript.md" target="_blank" rel="noopener">Transcripción — Definiciones Bases</a> <code>bruto/Marca_Personal_en_LinkedIn/06_Definiciones_Bases.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/07_Perfil_Ganador.md" target="_blank" rel="noopener">Perfil Ganador</a> <code>bruto/Marca_Personal_en_LinkedIn/07_Perfil_Ganador.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/07_Perfil_Ganador.transcript.md" target="_blank" rel="noopener">Transcripción — Perfil Ganador</a> <code>bruto/Marca_Personal_en_LinkedIn/07_Perfil_Ganador.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/08_Postear_en_Linkedin_Estrategias_y_Acción.md" target="_blank" rel="noopener">Postear en Linkedin: Estrategias y Acción</a> <code>bruto/Marca_Personal_en_LinkedIn/08_Postear_en_Linkedin_Estrategias_y_Acción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/09_Posteos_Parte_I.md" target="_blank" rel="noopener">Posteos Parte I</a> <code>bruto/Marca_Personal_en_LinkedIn/09_Posteos_Parte_I.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/09_Posteos_Parte_I.transcript.md" target="_blank" rel="noopener">Transcripción — Posteos Parte I</a> <code>bruto/Marca_Personal_en_LinkedIn/09_Posteos_Parte_I.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/10_Posteos_Parte_II.md" target="_blank" rel="noopener">Posteos Parte II</a> <code>bruto/Marca_Personal_en_LinkedIn/10_Posteos_Parte_II.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/10_Posteos_Parte_II.transcript.md" target="_blank" rel="noopener">Transcripción — Posteos Parte II</a> <code>bruto/Marca_Personal_en_LinkedIn/10_Posteos_Parte_II.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/11_Posteos_Parte_III.md" target="_blank" rel="noopener">Posteos Parte III</a> <code>bruto/Marca_Personal_en_LinkedIn/11_Posteos_Parte_III.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/11_Posteos_Parte_III.transcript.md" target="_blank" rel="noopener">Transcripción — Posteos Parte III</a> <code>bruto/Marca_Personal_en_LinkedIn/11_Posteos_Parte_III.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/12_Posteos_Parte_IV.md" target="_blank" rel="noopener">Posteos Parte IV</a> <code>bruto/Marca_Personal_en_LinkedIn/12_Posteos_Parte_IV.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/12_Posteos_Parte_IV.transcript.md" target="_blank" rel="noopener">Transcripción — Posteos Parte IV</a> <code>bruto/Marca_Personal_en_LinkedIn/12_Posteos_Parte_IV.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/13_Productos_Digitales_para_Aplicar_en_tu_Linkedin.md" target="_blank" rel="noopener">Productos Digitales para Aplicar en tu Linkedin</a> <code>bruto/Marca_Personal_en_LinkedIn/13_Productos_Digitales_para_Aplicar_en_tu_Linkedin.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/14_Imágenes_Ganadoras_para_tus_posteos.md" target="_blank" rel="noopener">Imágenes Ganadoras para tus posteos</a> <code>bruto/Marca_Personal_en_LinkedIn/14_Imágenes_Ganadoras_para_tus_posteos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/15_Mitos_del_Trabajo.md" target="_blank" rel="noopener">Mitos del Trabajo</a> <code>bruto/Marca_Personal_en_LinkedIn/15_Mitos_del_Trabajo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/16_Trampas_Brutales_en_tu_Carrera_Profesional.md" target="_blank" rel="noopener">Trampas Brutales en tu Carrera Profesional</a> <code>bruto/Marca_Personal_en_LinkedIn/16_Trampas_Brutales_en_tu_Carrera_Profesional.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/17_Plantillas_de_Post_Ganadores_en_LinkedIn.md" target="_blank" rel="noopener">Plantillas de Post Ganadores en LinkedIn</a> <code>bruto/Marca_Personal_en_LinkedIn/17_Plantillas_de_Post_Ganadores_en_LinkedIn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/18_El_momento_para_postear_en_LinkedIn.md" target="_blank" rel="noopener">El momento para postear en LinkedIn</a> <code>bruto/Marca_Personal_en_LinkedIn/18_El_momento_para_postear_en_LinkedIn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Marca_Personal_en_LinkedIn/19_Herramientas_digitales_claves_que_uso_día_a_día.md" target="_blank" rel="noopener">Herramientas digitales claves que uso día a día</a> <code>bruto/Marca_Personal_en_LinkedIn/19_Herramientas_digitales_claves_que_uso_día_a_día.md</code></li>
</ul>$lf_module_12$,
    120,
    true,
    '{}'::jsonb
  ),
  (
    'car-masterclass-grabadas',
    'car-ecosistema-startup',
    'Masterclass Grabadas',
    '🚀',
    '18 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_13$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Masterclass Grabadas · 18 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/01_Masterclass_Grabadas.md" target="_blank" rel="noopener">🎓 Masterclass Grabadas</a> <code>bruto/Masterclass_Grabadas/01_Masterclass_Grabadas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/02_Cómo_Validar_tu_Producto_Guía_Brutalmente_Honesta.md" target="_blank" rel="noopener">Cómo Validar tu Producto: Guía Brutalmente Honesta</a> <code>bruto/Masterclass_Grabadas/02_Cómo_Validar_tu_Producto_Guía_Brutalmente_Honesta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/03_Runway_o_Ruina_Flujo_de_Caja_y_Riesgo_Financiero.md" target="_blank" rel="noopener">Runway o Ruina: Flujo de Caja y Riesgo Financiero</a> <code>bruto/Masterclass_Grabadas/03_Runway_o_Ruina_Flujo_de_Caja_y_Riesgo_Financiero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/04_Product_Market_Fit_Resuelve_un_problema_real.md" target="_blank" rel="noopener">Product Market Fit: ¿Resuelve un problema real?</a> <code>bruto/Masterclass_Grabadas/04_Product_Market_Fit_Resuelve_un_problema_real.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/05_Técnicas_para_Ventas_B2B.md" target="_blank" rel="noopener">Técnicas para Ventas B2B</a> <code>bruto/Masterclass_Grabadas/05_Técnicas_para_Ventas_B2B.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/06_Cómo_estructurar_tu_pitch_de_ventas.md" target="_blank" rel="noopener">Cómo estructurar tu pitch de ventas</a> <code>bruto/Masterclass_Grabadas/06_Cómo_estructurar_tu_pitch_de_ventas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/07_Growth_Hacking_cómo_escalar_tu_negocio.md" target="_blank" rel="noopener">Growth Hacking: cómo escalar tu negocio</a> <code>bruto/Masterclass_Grabadas/07_Growth_Hacking_cómo_escalar_tu_negocio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/08_Workshop_de_Gestión_del_Tiempo_y_Manejo_del_Estrés.md" target="_blank" rel="noopener">Workshop de Gestión del Tiempo y Manejo del Estrés</a> <code>bruto/Masterclass_Grabadas/08_Workshop_de_Gestión_del_Tiempo_y_Manejo_del_Estrés.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/09_Mentores_Todo_lo_que_tienes_que_saber.md" target="_blank" rel="noopener">👥 Mentores: Todo lo que tienes que saber.</a> <code>bruto/Masterclass_Grabadas/09_Mentores_Todo_lo_que_tienes_que_saber.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/10_Cofundadores_y_Primeras_Contrataciones.md" target="_blank" rel="noopener">🤝Cofundadores y Primeras Contrataciones</a> <code>bruto/Masterclass_Grabadas/10_Cofundadores_y_Primeras_Contrataciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/11_Transforma_tu_Tráfico_en_Ventas.md" target="_blank" rel="noopener">🔄 Transforma tu Tráfico en Ventas</a> <code>bruto/Masterclass_Grabadas/11_Transforma_tu_Tráfico_en_Ventas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/12_Embudos_de_Ventas_y_Loops_de_Crecimiento.md" target="_blank" rel="noopener">🌪️ Embudos de Ventas y Loops de Crecimiento</a> <code>bruto/Masterclass_Grabadas/12_Embudos_de_Ventas_y_Loops_de_Crecimiento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/13_Gestión_del_Talento.md" target="_blank" rel="noopener">Gestión del Talento</a> <code>bruto/Masterclass_Grabadas/13_Gestión_del_Talento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/14_Conquista_a_tu_Inversionista_por_Fede_de_Broota.md" target="_blank" rel="noopener">Conquista a tu Inversionista por Fede de Broota</a> <code>bruto/Masterclass_Grabadas/14_Conquista_a_tu_Inversionista_por_Fede_de_Broota.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/15_AMA.md" target="_blank" rel="noopener">AMA</a> <code>bruto/Masterclass_Grabadas/15_AMA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/16_Sesión_con_Andrés_Rodriguez_CRO_de_DIIO.md" target="_blank" rel="noopener">Sesión con Andrés Rodriguez CRO de DIIO</a> <code>bruto/Masterclass_Grabadas/16_Sesión_con_Andrés_Rodriguez_CRO_de_DIIO.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/17_Sesión_con_el_CEO_de_Pegasi_Luis_Santiago.md" target="_blank" rel="noopener">Sesión con el CEO de Pegasi Luis Santiago</a> <code>bruto/Masterclass_Grabadas/17_Sesión_con_el_CEO_de_Pegasi_Luis_Santiago.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Masterclass_Grabadas/18_Sesion_de_Automatización_de_Ventas_por_Funnelchat.md" target="_blank" rel="noopener">Sesion de Automatización de Ventas por Funnelchat</a> <code>bruto/Masterclass_Grabadas/18_Sesion_de_Automatización_de_Ventas_por_Funnelchat.md</code></li>
</ul>$lf_module_13$,
    130,
    true,
    '{}'::jsonb
  ),
  (
    'car-monetiza-tu-negocio-como-cobrar',
    'car-ecosistema-startup',
    'Monetiza tu negocio cómo cobrar',
    '🚀',
    '21 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_14$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Monetiza tu negocio cómo cobrar · 21 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/01_Monetiza_tu_negocio_cómo_cobrar.md" target="_blank" rel="noopener">Monetiza tu negocio: cómo cobrar</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/01_Monetiza_tu_negocio_cómo_cobrar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/02_M00_Por_qué_cobras_lo_que_cobras.md" target="_blank" rel="noopener">M00 — Por qué cobras lo que cobras</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/02_M00_Por_qué_cobras_lo_que_cobras.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/03_L01_El_error_de_pricing_del_founder.md" target="_blank" rel="noopener">L0.1 · El error de pricing del founder</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/03_L01_El_error_de_pricing_del_founder.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/04_L02_Cuánto_cuesta_entregar_lo_que_vendes.md" target="_blank" rel="noopener">L0.2 · Cuánto cuesta entregar lo que vendes</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/04_L02_Cuánto_cuesta_entregar_lo_que_vendes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/05_M01_Qué_modelo_de_ingresos_encaja.md" target="_blank" rel="noopener">M01 — Qué modelo de ingresos encaja</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/05_M01_Qué_modelo_de_ingresos_encaja.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/06_L11_El_árbol_de_modelos_de_ingreso.md" target="_blank" rel="noopener">L1.1 · El árbol de modelos de ingreso</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/06_L11_El_árbol_de_modelos_de_ingreso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/07_L12_Por_hora_vs_por_resultado.md" target="_blank" rel="noopener">L1.2 · Por hora vs por resultado</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/07_L12_Por_hora_vs_por_resultado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/08_L13_Ingresos_recurrentes.md" target="_blank" rel="noopener">L1.3 · Ingresos recurrentes</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/08_L13_Ingresos_recurrentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/09_M02_Pricing_real_en_LATAM.md" target="_blank" rel="noopener">M02 — Pricing real en LATAM</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/09_M02_Pricing_real_en_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/10_L21_Cómo_investigan_precios_con_IA.md" target="_blank" rel="noopener">L2.1 · Cómo investigan precios con IA</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/10_L21_Cómo_investigan_precios_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/11_L22_Las_3_palancas_del_precio.md" target="_blank" rel="noopener">L2.2 · Las 3 palancas del precio</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/11_L22_Las_3_palancas_del_precio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/12_L23_Cobrar_en_LATAM_sin_autodiscriminarse.md" target="_blank" rel="noopener">L2.3 · Cobrar en LATAM sin autodiscriminarse</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/12_L23_Cobrar_en_LATAM_sin_autodiscriminarse.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/13_M03_Paquetiza_tu_oferta.md" target="_blank" rel="noopener">M03 — Paquetiza tu oferta</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/13_M03_Paquetiza_tu_oferta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/14_L31_Qué_es_una_oferta.md" target="_blank" rel="noopener">L3.1 · Qué es una oferta</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/14_L31_Qué_es_una_oferta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/15_L32_Cómo_diseñas_una_oferta.md" target="_blank" rel="noopener">L3.2 · Cómo diseñas una oferta</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/15_L32_Cómo_diseñas_una_oferta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/16_L33_La_escalera_de_valor.md" target="_blank" rel="noopener">L3.3 · La escalera de valor</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/16_L33_La_escalera_de_valor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/17_M04_La_primera_venta_al_nuevo_precio.md" target="_blank" rel="noopener">M04 — La primera venta al nuevo precio</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/17_M04_La_primera_venta_al_nuevo_precio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/18_L41_Comunicar_un_precio_nuevo.md" target="_blank" rel="noopener">L4.1 · Comunicar un precio nuevo</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/18_L41_Comunicar_un_precio_nuevo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/19_L42_La_conversación_de_ventas.md" target="_blank" rel="noopener">L4.2 · La conversación de ventas</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/19_L42_La_conversación_de_ventas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/20_M05_Casos_reales.md" target="_blank" rel="noopener">M05 — Casos reales</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/20_M05_Casos_reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Monetiza_tu_negocio_cómo_cobrar/21_L51_Casos_por_arquetipo.md" target="_blank" rel="noopener">L5.1 · Casos por arquetipo</a> <code>bruto/Monetiza_tu_negocio_cómo_cobrar/21_L51_Casos_por_arquetipo.md</code></li>
</ul>$lf_module_14$,
    140,
    true,
    '{}'::jsonb
  ),
  (
    'car-planificacion-estrategica-para-startups',
    'car-ecosistema-startup',
    'Planificación Estratégica para Startups',
    '🚀',
    '58 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_15$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Planificación Estratégica para Startups · 58 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/01_Planificación_Estratégica_para_Startups.md" target="_blank" rel="noopener">🗺️ Planificación Estratégica para Startups</a> <code>bruto/Planificación_Estratégica_para_Startups/01_Planificación_Estratégica_para_Startups.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/02_Introducción.md" target="_blank" rel="noopener">Introducción</a> <code>bruto/Planificación_Estratégica_para_Startups/02_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/03_Qué_veremos_en_este_curso.md" target="_blank" rel="noopener">¿Qué veremos en este curso?</a> <code>bruto/Planificación_Estratégica_para_Startups/03_Qué_veremos_en_este_curso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/03_Qué_veremos_en_este_curso.transcript.md" target="_blank" rel="noopener">Transcripción — ¿Qué veremos en este curso?</a> <code>bruto/Planificación_Estratégica_para_Startups/03_Qué_veremos_en_este_curso.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/04_Qué_es_planificar_y_para_qué_sirve.md" target="_blank" rel="noopener">¿Qué es planificar y para qué sirve?</a> <code>bruto/Planificación_Estratégica_para_Startups/04_Qué_es_planificar_y_para_qué_sirve.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/05_Beneficios_de_la_planificación_estratégica.md" target="_blank" rel="noopener">Beneficios de la planificación estratégica</a> <code>bruto/Planificación_Estratégica_para_Startups/05_Beneficios_de_la_planificación_estratégica.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/05_Beneficios_de_la_planificación_estratégica.transcript.md" target="_blank" rel="noopener">Transcripción — Beneficios de la planificación estratégica</a> <code>bruto/Planificación_Estratégica_para_Startups/05_Beneficios_de_la_planificación_estratégica.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/06_Diferencias_en_estrategia_planificación_y_gestión.md" target="_blank" rel="noopener">Diferencias en estrategia, planificación y gestión</a> <code>bruto/Planificación_Estratégica_para_Startups/06_Diferencias_en_estrategia_planificación_y_gestión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/06_Diferencias_en_estrategia_planificación_y_gestión.transcript.md" target="_blank" rel="noopener">Transcripción — Diferencias en estrategia, planificación y gestión</a> <code>bruto/Planificación_Estratégica_para_Startups/06_Diferencias_en_estrategia_planificación_y_gestión.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/07_Flexibilidad_y_adaptabilidad_en_el_mundo_Startup.md" target="_blank" rel="noopener">Flexibilidad y adaptabilidad en el mundo Startup</a> <code>bruto/Planificación_Estratégica_para_Startups/07_Flexibilidad_y_adaptabilidad_en_el_mundo_Startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/07_Flexibilidad_y_adaptabilidad_en_el_mundo_Startup.transcript.md" target="_blank" rel="noopener">Transcripción — Flexibilidad y adaptabilidad en el mundo Startup</a> <code>bruto/Planificación_Estratégica_para_Startups/07_Flexibilidad_y_adaptabilidad_en_el_mundo_Startup.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/08_DE_DÓNDE_PARTIMOS_CONTEXTO_E_INFORMACIÓN_CLAVE.md" target="_blank" rel="noopener">¿DE DÓNDE PARTIMOS? CONTEXTO E INFORMACIÓN CLAVE</a> <code>bruto/Planificación_Estratégica_para_Startups/08_DE_DÓNDE_PARTIMOS_CONTEXTO_E_INFORMACIÓN_CLAVE.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/09_Entiende_tu_mercado_Análisis_PESTEL.md" target="_blank" rel="noopener">Entiende tu mercado: Análisis PESTEL</a> <code>bruto/Planificación_Estratégica_para_Startups/09_Entiende_tu_mercado_Análisis_PESTEL.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/09_Entiende_tu_mercado_Análisis_PESTEL.transcript.md" target="_blank" rel="noopener">Transcripción — Entiende tu mercado: Análisis PESTEL</a> <code>bruto/Planificación_Estratégica_para_Startups/09_Entiende_tu_mercado_Análisis_PESTEL.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/10_Dónde_estamos_parados_como_startup.md" target="_blank" rel="noopener">¿Dónde estamos parados como startup?</a> <code>bruto/Planificación_Estratégica_para_Startups/10_Dónde_estamos_parados_como_startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/10_Dónde_estamos_parados_como_startup.transcript.md" target="_blank" rel="noopener">Transcripción — ¿Dónde estamos parados como startup?</a> <code>bruto/Planificación_Estratégica_para_Startups/10_Dónde_estamos_parados_como_startup.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/11_Definiciones_estratégicas_sencillas.md" target="_blank" rel="noopener">Definiciones estratégicas sencillas</a> <code>bruto/Planificación_Estratégica_para_Startups/11_Definiciones_estratégicas_sencillas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/11_Definiciones_estratégicas_sencillas.transcript.md" target="_blank" rel="noopener">Transcripción — Definiciones estratégicas sencillas</a> <code>bruto/Planificación_Estratégica_para_Startups/11_Definiciones_estratégicas_sencillas.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/12_FOCO.md" target="_blank" rel="noopener">FOCO</a> <code>bruto/Planificación_Estratégica_para_Startups/12_FOCO.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/12_FOCO.transcript.md" target="_blank" rel="noopener">Transcripción — FOCO</a> <code>bruto/Planificación_Estratégica_para_Startups/12_FOCO.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/13_OBJETIVOS_Y_METAS_ESTRATÉGICAS.md" target="_blank" rel="noopener">OBJETIVOS Y METAS ESTRATÉGICAS</a> <code>bruto/Planificación_Estratégica_para_Startups/13_OBJETIVOS_Y_METAS_ESTRATÉGICAS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/14_Qué_queremos_construir.md" target="_blank" rel="noopener">¿Qué queremos construir?</a> <code>bruto/Planificación_Estratégica_para_Startups/14_Qué_queremos_construir.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/14_Qué_queremos_construir.transcript.md" target="_blank" rel="noopener">Transcripción — ¿Qué queremos construir?</a> <code>bruto/Planificación_Estratégica_para_Startups/14_Qué_queremos_construir.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/15_Metodología_Hitos_en_Retroceso.md" target="_blank" rel="noopener">Metodología Hitos en Retroceso</a> <code>bruto/Planificación_Estratégica_para_Startups/15_Metodología_Hitos_en_Retroceso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/15_Metodología_Hitos_en_Retroceso.transcript.md" target="_blank" rel="noopener">Transcripción — Metodología Hitos en Retroceso</a> <code>bruto/Planificación_Estratégica_para_Startups/15_Metodología_Hitos_en_Retroceso.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/16_Objetivos_efectivos.md" target="_blank" rel="noopener">Objetivos efectivos</a> <code>bruto/Planificación_Estratégica_para_Startups/16_Objetivos_efectivos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/16_Objetivos_efectivos.transcript.md" target="_blank" rel="noopener">Transcripción — Objetivos efectivos</a> <code>bruto/Planificación_Estratégica_para_Startups/16_Objetivos_efectivos.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/17_Ejemplos_prácticos_y_realistas.md" target="_blank" rel="noopener">Ejemplos prácticos y realistas</a> <code>bruto/Planificación_Estratégica_para_Startups/17_Ejemplos_prácticos_y_realistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/17_Ejemplos_prácticos_y_realistas.transcript.md" target="_blank" rel="noopener">Transcripción — Ejemplos prácticos y realistas</a> <code>bruto/Planificación_Estratégica_para_Startups/17_Ejemplos_prácticos_y_realistas.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/18_ESTRATEGIA_Y_PLANES_DE_ACCIÓN.md" target="_blank" rel="noopener">ESTRATEGIA Y PLANES DE ACCIÓN</a> <code>bruto/Planificación_Estratégica_para_Startups/18_ESTRATEGIA_Y_PLANES_DE_ACCIÓN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/19_Desde_el_contexto_a_la_realidad.md" target="_blank" rel="noopener">Desde el contexto a la realidad</a> <code>bruto/Planificación_Estratégica_para_Startups/19_Desde_el_contexto_a_la_realidad.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/19_Desde_el_contexto_a_la_realidad.transcript.md" target="_blank" rel="noopener">Transcripción — Desde el contexto a la realidad</a> <code>bruto/Planificación_Estratégica_para_Startups/19_Desde_el_contexto_a_la_realidad.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/20_Prioriza_lo_importante.md" target="_blank" rel="noopener">Prioriza lo importante</a> <code>bruto/Planificación_Estratégica_para_Startups/20_Prioriza_lo_importante.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/20_Prioriza_lo_importante.transcript.md" target="_blank" rel="noopener">Transcripción — Prioriza lo importante</a> <code>bruto/Planificación_Estratégica_para_Startups/20_Prioriza_lo_importante.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/21_Estrategia_clara_con_los_5W-1H.md" target="_blank" rel="noopener">Estrategia clara con los 5W-1H</a> <code>bruto/Planificación_Estratégica_para_Startups/21_Estrategia_clara_con_los_5W-1H.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/21_Estrategia_clara_con_los_5W-1H.transcript.md" target="_blank" rel="noopener">Transcripción — Estrategia clara con los 5W-1H</a> <code>bruto/Planificación_Estratégica_para_Startups/21_Estrategia_clara_con_los_5W-1H.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/22_SEGUIMIENTO_Y_ADAPTACIÓN.md" target="_blank" rel="noopener">SEGUIMIENTO Y ADAPTACIÓN</a> <code>bruto/Planificación_Estratégica_para_Startups/22_SEGUIMIENTO_Y_ADAPTACIÓN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/23_Plan_de_acción.md" target="_blank" rel="noopener">Plan de acción</a> <code>bruto/Planificación_Estratégica_para_Startups/23_Plan_de_acción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/23_Plan_de_acción.transcript.md" target="_blank" rel="noopener">Transcripción — Plan de acción</a> <code>bruto/Planificación_Estratégica_para_Startups/23_Plan_de_acción.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/24_Accountability_vs_Capacidades.md" target="_blank" rel="noopener">Accountability vs. Capacidades</a> <code>bruto/Planificación_Estratégica_para_Startups/24_Accountability_vs_Capacidades.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/24_Accountability_vs_Capacidades.transcript.md" target="_blank" rel="noopener">Transcripción — Accountability vs. Capacidades</a> <code>bruto/Planificación_Estratégica_para_Startups/24_Accountability_vs_Capacidades.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/25_Cómo_calendarizar_tu_trabajo_diario.md" target="_blank" rel="noopener">¿Cómo calendarizar tu trabajo diario?</a> <code>bruto/Planificación_Estratégica_para_Startups/25_Cómo_calendarizar_tu_trabajo_diario.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/25_Cómo_calendarizar_tu_trabajo_diario.transcript.md" target="_blank" rel="noopener">Transcripción — ¿Cómo calendarizar tu trabajo diario?</a> <code>bruto/Planificación_Estratégica_para_Startups/25_Cómo_calendarizar_tu_trabajo_diario.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/26_Definición_indicadores_clave_de_desempeño_KPIs.md" target="_blank" rel="noopener">Definición: indicadores clave de desempeño (KPIs)</a> <code>bruto/Planificación_Estratégica_para_Startups/26_Definición_indicadores_clave_de_desempeño_KPIs.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/26_Definición_indicadores_clave_de_desempeño_KPIs.transcript.md" target="_blank" rel="noopener">Transcripción — Definición: indicadores clave de desempeño (KPIs)</a> <code>bruto/Planificación_Estratégica_para_Startups/26_Definición_indicadores_clave_de_desempeño_KPIs.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/27_Mantenerse_realistas_pero_desafiados.md" target="_blank" rel="noopener">Mantenerse realistas pero desafiados</a> <code>bruto/Planificación_Estratégica_para_Startups/27_Mantenerse_realistas_pero_desafiados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/27_Mantenerse_realistas_pero_desafiados.transcript.md" target="_blank" rel="noopener">Transcripción — Mantenerse realistas pero desafiados</a> <code>bruto/Planificación_Estratégica_para_Startups/27_Mantenerse_realistas_pero_desafiados.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/28_Comunicación_y_alineación_con_la_planificación.md" target="_blank" rel="noopener">Comunicación y alineación con la planificación</a> <code>bruto/Planificación_Estratégica_para_Startups/28_Comunicación_y_alineación_con_la_planificación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/28_Comunicación_y_alineación_con_la_planificación.transcript.md" target="_blank" rel="noopener">Transcripción — Comunicación y alineación con la planificación</a> <code>bruto/Planificación_Estratégica_para_Startups/28_Comunicación_y_alineación_con_la_planificación.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/29_INTEGRACIÓN_DE_LA_PLANIFICACIÓN_ESTRATÉGICA.md" target="_blank" rel="noopener">INTEGRACIÓN DE LA PLANIFICACIÓN ESTRATÉGICA</a> <code>bruto/Planificación_Estratégica_para_Startups/29_INTEGRACIÓN_DE_LA_PLANIFICACIÓN_ESTRATÉGICA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/30_Planificación_Estratégica_vs_Gestión_Diaria.md" target="_blank" rel="noopener">Planificación Estratégica vs. Gestión Diaria</a> <code>bruto/Planificación_Estratégica_para_Startups/30_Planificación_Estratégica_vs_Gestión_Diaria.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/30_Planificación_Estratégica_vs_Gestión_Diaria.transcript.md" target="_blank" rel="noopener">Transcripción — Planificación Estratégica vs. Gestión Diaria</a> <code>bruto/Planificación_Estratégica_para_Startups/30_Planificación_Estratégica_vs_Gestión_Diaria.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/31_Herramientas_Digitales_de_Planificación.md" target="_blank" rel="noopener">Herramientas Digitales de Planificación</a> <code>bruto/Planificación_Estratégica_para_Startups/31_Herramientas_Digitales_de_Planificación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/31_Herramientas_Digitales_de_Planificación.transcript.md" target="_blank" rel="noopener">Transcripción — Herramientas Digitales de Planificación</a> <code>bruto/Planificación_Estratégica_para_Startups/31_Herramientas_Digitales_de_Planificación.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/32_Errores_Comunes_de_Planificación_y_Cómo_Evitarlos.md" target="_blank" rel="noopener">Errores Comunes de Planificación y Cómo Evitarlos</a> <code>bruto/Planificación_Estratégica_para_Startups/32_Errores_Comunes_de_Planificación_y_Cómo_Evitarlos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/32_Errores_Comunes_de_Planificación_y_Cómo_Evitarlos.transcript.md" target="_blank" rel="noopener">Transcripción — Errores Comunes de Planificación y Cómo Evitarlos</a> <code>bruto/Planificación_Estratégica_para_Startups/32_Errores_Comunes_de_Planificación_y_Cómo_Evitarlos.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/33_Conclusiones_Finales.md" target="_blank" rel="noopener">Conclusiones Finales</a> <code>bruto/Planificación_Estratégica_para_Startups/33_Conclusiones_Finales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Planificación_Estratégica_para_Startups/33_Conclusiones_Finales.transcript.md" target="_blank" rel="noopener">Transcripción — Conclusiones Finales</a> <code>bruto/Planificación_Estratégica_para_Startups/33_Conclusiones_Finales.transcript.md</code></li>
</ul>$lf_module_15$,
    150,
    true,
    '{}'::jsonb
  ),
  (
    'car-podcasts-car',
    'car-ecosistema-startup',
    'Podcasts CAR',
    '🚀',
    '53 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_16$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Podcasts CAR · 53 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/01_Podcasts_CAR.md" target="_blank" rel="noopener">🎙️ Podcasts CAR</a> <code>bruto/Podcasts_CAR/01_Podcasts_CAR.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/02_Es_La_Hora_De_Aprender.md" target="_blank" rel="noopener">🎙️ Es La Hora De Aprender</a> <code>bruto/Podcasts_CAR/02_Es_La_Hora_De_Aprender.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/03_EP14_Un_agente_por_persona_o_por_equipo.md" target="_blank" rel="noopener">EP14: ¿Un agente por persona o por equipo?</a> <code>bruto/Podcasts_CAR/03_EP14_Un_agente_por_persona_o_por_equipo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/04_EP13_Karpathy_a_Anthropic_Google_IO_2026.md" target="_blank" rel="noopener">EP13: Karpathy a Anthropic · Google I/O 2026</a> <code>bruto/Podcasts_CAR/04_EP13_Karpathy_a_Anthropic_Google_IO_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/05_EP12_Ley_IA_Chile_agentes_autónomos_default.md" target="_blank" rel="noopener">EP12: Ley IA Chile · agentes autónomos · default</a> <code>bruto/Podcasts_CAR/05_EP12_Ley_IA_Chile_agentes_autónomos_default.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/06_EP11_Coinbase_echó_7000_por_IA_ventana_LATAM.md" target="_blank" rel="noopener">EP11: Coinbase echó 7000 por IA · ventana LATAM</a> <code>bruto/Podcasts_CAR/06_EP11_Coinbase_echó_7000_por_IA_ventana_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/07_EP10_Para_qué_servimos_los_humanos_en_la_era_IA.md" target="_blank" rel="noopener">EP10: Para qué servimos los humanos en la era IA</a> <code>bruto/Podcasts_CAR/07_EP10_Para_qué_servimos_los_humanos_en_la_era_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/08_EP09_Estrategia_IA_según_tamaño_de_empresa.md" target="_blank" rel="noopener">EP09: Estrategia IA según tamaño de empresa</a> <code>bruto/Podcasts_CAR/08_EP09_Estrategia_IA_según_tamaño_de_empresa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/09_EP08_Crisis_Anthropic_alternativas_y_IA_local.md" target="_blank" rel="noopener">EP08: Crisis Anthropic · alternativas y IA local</a> <code>bruto/Podcasts_CAR/09_EP08_Crisis_Anthropic_alternativas_y_IA_local.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/10_EP07_Se_cayó_Claude_Plan_B_para_tu_IA.md" target="_blank" rel="noopener">EP07: Se cayó Claude · Plan B para tu IA</a> <code>bruto/Podcasts_CAR/10_EP07_Se_cayó_Claude_Plan_B_para_tu_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/11_EP06_Cuánto_invertir_en_IA_y_Construir_en_Público.md" target="_blank" rel="noopener">EP06: Cuánto invertir en IA y Construir en Público</a> <code>bruto/Podcasts_CAR/11_EP06_Cuánto_invertir_en_IA_y_Construir_en_Público.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/12_EP05_OpenClaw_Agentes_y_Estrategia_Empresa.md" target="_blank" rel="noopener">EP05: OpenClaw, Agentes y Estrategia Empresa</a> <code>bruto/Podcasts_CAR/12_EP05_OpenClaw_Agentes_y_Estrategia_Empresa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/13_EP04_Más_agentes_que_empleados_en_tu_empresa.md" target="_blank" rel="noopener">EP04: Más agentes que empleados en tu empresa</a> <code>bruto/Podcasts_CAR/13_EP04_Más_agentes_que_empleados_en_tu_empresa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/14_EP03_LatamGPT_Pentágono_y_Despidos_por_IA.md" target="_blank" rel="noopener">EP03: LatamGPT, Pentágono y Despidos por IA</a> <code>bruto/Podcasts_CAR/14_EP03_LatamGPT_Pentágono_y_Despidos_por_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/15_EP02_Herramientas_IA_Build_vs_Buy_Procesos.md" target="_blank" rel="noopener">EP02: Herramientas IA · Build vs Buy · Procesos</a> <code>bruto/Podcasts_CAR/15_EP02_Herramientas_IA_Build_vs_Buy_Procesos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/16_EP01_OpenClaw_y_el_Futuro_del_Trabajo.md" target="_blank" rel="noopener">EP01: OpenClaw y el Futuro del Trabajo</a> <code>bruto/Podcasts_CAR/16_EP01_OpenClaw_y_el_Futuro_del_Trabajo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/17_EP15_Fable_5_qué_modelo_usar_para_cada_tarea.md" target="_blank" rel="noopener">EP15: Fable 5 · qué modelo usar para cada tarea</a> <code>bruto/Podcasts_CAR/17_EP15_Fable_5_qué_modelo_usar_para_cada_tarea.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/18_Ecosistema_Startup.md" target="_blank" rel="noopener">🎙️ Ecosistema Startup</a> <code>bruto/Podcasts_CAR/18_Ecosistema_Startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/19_Eco35_Contrata_ganas_y_hambre_Comunidad_Feliz.md" target="_blank" rel="noopener">Eco35: Contrata ganas y hambre · Comunidad Feliz</a> <code>bruto/Podcasts_CAR/19_Eco35_Contrata_ganas_y_hambre_Comunidad_Feliz.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/20_Eco34_Growth_sin_humo.md" target="_blank" rel="noopener">Eco34: Growth sin humo</a> <code>bruto/Podcasts_CAR/20_Eco34_Growth_sin_humo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/21_Eco33_Startup_sin_bullshit_Silicon_Valley.md" target="_blank" rel="noopener">Eco33: Startup sin bullshit · Silicon Valley</a> <code>bruto/Podcasts_CAR/21_Eco33_Startup_sin_bullshit_Silicon_Valley.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/22_Eco32_Bootstrapping_SoSafe_sin_capital.md" target="_blank" rel="noopener">Eco32: Bootstrapping · SoSafe sin capital</a> <code>bruto/Podcasts_CAR/22_Eco32_Bootstrapping_SoSafe_sin_capital.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/23_Eco31_Finanzas_básicas_para_founders.md" target="_blank" rel="noopener">Eco31: Finanzas básicas para founders</a> <code>bruto/Podcasts_CAR/23_Eco31_Finanzas_básicas_para_founders.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/24_Eco30_Segmentar_mercado_ICP_vs_buyer.md" target="_blank" rel="noopener">Eco30: Segmentar mercado · ICP vs buyer</a> <code>bruto/Podcasts_CAR/24_Eco30_Segmentar_mercado_ICP_vs_buyer.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/25_Eco29_Identificar_necesidades_reales.md" target="_blank" rel="noopener">Eco29: Identificar necesidades reales</a> <code>bruto/Podcasts_CAR/25_Eco29_Identificar_necesidades_reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/26_Eco28_Automatizar_o_morir.md" target="_blank" rel="noopener">Eco28: Automatizar o morir</a> <code>bruto/Podcasts_CAR/26_Eco28_Automatizar_o_morir.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/27_Eco27_Oportunidades_en_crisis_buyDepa.md" target="_blank" rel="noopener">Eco27: Oportunidades en crisis · buyDepa</a> <code>bruto/Podcasts_CAR/27_Eco27_Oportunidades_en_crisis_buyDepa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/28_Eco26_IA_como_socio_sin_equity.md" target="_blank" rel="noopener">Eco26: IA como socio sin equity</a> <code>bruto/Podcasts_CAR/28_Eco26_IA_como_socio_sin_equity.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/29_Eco25_Crowdfunding_inmobiliario_Lares.md" target="_blank" rel="noopener">Eco25: Crowdfunding inmobiliario · Lares</a> <code>bruto/Podcasts_CAR/29_Eco25_Crowdfunding_inmobiliario_Lares.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/30_Eco24_El_arte_de_pivotear_Alba.md" target="_blank" rel="noopener">Eco24: El arte de pivotear · Alba</a> <code>bruto/Podcasts_CAR/30_Eco24_El_arte_de_pivotear_Alba.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/31_Eco23_Aceleradoras_desde_adentro_500_Global.md" target="_blank" rel="noopener">Eco23: Aceleradoras desde adentro · 500 Global</a> <code>bruto/Podcasts_CAR/31_Eco23_Aceleradoras_desde_adentro_500_Global.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/32_Eco22_Growth_Hacking_con_data_Rodrigo_Rojo.md" target="_blank" rel="noopener">Eco22: Growth Hacking con data · Rodrigo Rojo</a> <code>bruto/Podcasts_CAR/32_Eco22_Growth_Hacking_con_data_Rodrigo_Rojo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/33_Eco21b_Venture_Debt_sin_diluirte.md" target="_blank" rel="noopener">Eco21b: Venture Debt sin diluirte</a> <code>bruto/Podcasts_CAR/33_Eco21b_Venture_Debt_sin_diluirte.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/34_Eco21a_SaaS_sin_morir_en_el_intento.md" target="_blank" rel="noopener">Eco21a: SaaS sin morir en el intento</a> <code>bruto/Podcasts_CAR/34_Eco21a_SaaS_sin_morir_en_el_intento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/35_Eco20_Capital_con_gobierno_sin_equity.md" target="_blank" rel="noopener">Eco20: Capital con gobierno · sin equity</a> <code>bruto/Podcasts_CAR/35_Eco20_Capital_con_gobierno_sin_equity.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/36_Eco19_Levantar_capital_sin_morir_en_el_intento.md" target="_blank" rel="noopener">Eco19: Levantar capital sin morir en el intento</a> <code>bruto/Podcasts_CAR/36_Eco19_Levantar_capital_sin_morir_en_el_intento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/37_Eco18_Directorios_en_una_startup.md" target="_blank" rel="noopener">Eco18: Directorios en una startup</a> <code>bruto/Podcasts_CAR/37_Eco18_Directorios_en_una_startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/38_Eco17_Talento_y_cultura_en_startups.md" target="_blank" rel="noopener">Eco17: Talento y cultura en startups</a> <code>bruto/Podcasts_CAR/38_Eco17_Talento_y_cultura_en_startups.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/39_Eco15_Internacionalizar_Cowork_Latam.md" target="_blank" rel="noopener">Eco15: Internacionalizar · Cowork Latam</a> <code>bruto/Podcasts_CAR/39_Eco15_Internacionalizar_Cowork_Latam.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/40_Eco14_Startups_con_impacto_Karün.md" target="_blank" rel="noopener">Eco14: Startups con impacto · Karün</a> <code>bruto/Podcasts_CAR/40_Eco14_Startups_con_impacto_Karün.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/41_Eco13_Product_Market_Fit_Hussam_Sufan.md" target="_blank" rel="noopener">Eco13: Product Market Fit · Hussam Sufan</a> <code>bruto/Podcasts_CAR/41_Eco13_Product_Market_Fit_Hussam_Sufan.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/42_Eco12_Cómo_valorar_una_startup.md" target="_blank" rel="noopener">Eco12: Cómo valorar una startup</a> <code>bruto/Podcasts_CAR/42_Eco12_Cómo_valorar_una_startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/43_Eco11_Qué_es_realmente_una_startup.md" target="_blank" rel="noopener">Eco11: ¿Qué es realmente una startup?</a> <code>bruto/Podcasts_CAR/43_Eco11_Qué_es_realmente_una_startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/44_Eco10_Corporate_Venture_Capital_Consorcio.md" target="_blank" rel="noopener">Eco10: Corporate Venture Capital · Consorcio</a> <code>bruto/Podcasts_CAR/44_Eco10_Corporate_Venture_Capital_Consorcio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/45_Eco09_Socios_y_cofundadores.md" target="_blank" rel="noopener">Eco09: Socios y cofundadores</a> <code>bruto/Podcasts_CAR/45_Eco09_Socios_y_cofundadores.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/46_Eco08_Inversión_Ángel_Pato_Rojas.md" target="_blank" rel="noopener">Eco08: Inversión Ángel · Pato Rojas</a> <code>bruto/Podcasts_CAR/46_Eco08_Inversión_Ángel_Pato_Rojas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/47_Eco07_Venture_Capital_sin_romanticismo.md" target="_blank" rel="noopener">Eco07: Venture Capital sin romanticismo</a> <code>bruto/Podcasts_CAR/47_Eco07_Venture_Capital_sin_romanticismo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/48_Eco06_Abogados_como_actor_clave.md" target="_blank" rel="noopener">Eco06: Abogados como actor clave</a> <code>bruto/Podcasts_CAR/48_Eco06_Abogados_como_actor_clave.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/49_Eco05_Levantar_capital_Cuando_no_si.md" target="_blank" rel="noopener">Eco05: ¿Levantar capital? Cuando, no si</a> <code>bruto/Podcasts_CAR/49_Eco05_Levantar_capital_Cuando_no_si.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/50_Eco04_10_actores_clave_del_ecosistema.md" target="_blank" rel="noopener">Eco04: 10 actores clave del ecosistema</a> <code>bruto/Podcasts_CAR/50_Eco04_10_actores_clave_del_ecosistema.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/51_Eco03_El_primer_pivote_del_Pódcast.md" target="_blank" rel="noopener">Eco03: El primer pivote del Pódcast</a> <code>bruto/Podcasts_CAR/51_Eco03_El_primer_pivote_del_Pódcast.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/52_Eco02_AMA_Pago_Fácil_mentoría.md" target="_blank" rel="noopener">Eco02: AMA · Pago Fácil + mentoría</a> <code>bruto/Podcasts_CAR/52_Eco02_AMA_Pago_Fácil_mentoría.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Podcasts_CAR/53_Eco01_AMA_equity_vesting_decisiones.md" target="_blank" rel="noopener">Eco01: AMA · equity, vesting, decisiones</a> <code>bruto/Podcasts_CAR/53_Eco01_AMA_equity_vesting_decisiones.md</code></li>
</ul>$lf_module_16$,
    160,
    true,
    '{}'::jsonb
  ),
  (
    'car-postular-a-fondos-publicos-latam',
    'car-ecosistema-startup',
    'Postular a Fondos Públicos LATAM',
    '🚀',
    '13 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_17$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Postular a Fondos Públicos LATAM · 13 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/01_Postular_a_Fondos_Públicos_LATAM.md" target="_blank" rel="noopener">🎯 Postular a Fondos Públicos LATAM</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/01_Postular_a_Fondos_Públicos_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/02_INTRODUCCIÓN.md" target="_blank" rel="noopener">INTRODUCCIÓN</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/02_INTRODUCCIÓN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/03_Conoce_a_Felipe_Díaz.md" target="_blank" rel="noopener">Conoce a Felipe Díaz</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/03_Conoce_a_Felipe_Díaz.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/04_Cómo_levantar_fondos_publicos.md" target="_blank" rel="noopener">¿Cómo levantar fondos publicos?</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/04_Cómo_levantar_fondos_publicos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/05_Por_dónde_comienzo.md" target="_blank" rel="noopener">¿Por dónde comienzo?</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/05_Por_dónde_comienzo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/06_Cómo_plantear_un_problema_para_innovar.md" target="_blank" rel="noopener">Cómo plantear un problema para innovar</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/06_Cómo_plantear_un_problema_para_innovar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/07_Diferencias_emprendedor_comerciante_y_empresario.md" target="_blank" rel="noopener">Diferencias: emprendedor, comerciante y empresario</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/07_Diferencias_emprendedor_comerciante_y_empresario.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/08_Qué_es_un_proyecto_de_innovación.md" target="_blank" rel="noopener">¿Qué es un proyecto de innovación?</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/08_Qué_es_un_proyecto_de_innovación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/09_Valores_del_emprendedora.md" target="_blank" rel="noopener">Valores del emprendedor/a</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/09_Valores_del_emprendedora.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/10_Cómo_elegir_el_fondo.md" target="_blank" rel="noopener">¿Cómo elegir el fondo?</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/10_Cómo_elegir_el_fondo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/11_Tips_para_mejorar_tu_postulación.md" target="_blank" rel="noopener">Tips para mejorar tu postulación</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/11_Tips_para_mejorar_tu_postulación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/12_PRODUCTO_DESCARGABLE.md" target="_blank" rel="noopener">PRODUCTO DESCARGABLE</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/12_PRODUCTO_DESCARGABLE.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Postular_a_Fondos_Públicos_LATAM/13_Diseña_tu_Proyecto_para_Postular_a_Fondos_Públicos.md" target="_blank" rel="noopener">Diseña tu Proyecto para Postular a Fondos Públicos</a> <code>bruto/Postular_a_Fondos_Públicos_LATAM/13_Diseña_tu_Proyecto_para_Postular_a_Fondos_Públicos.md</code></li>
</ul>$lf_module_17$,
    170,
    true,
    '{}'::jsonb
  ),
  (
    'car-seo-con-ia-agentes',
    'car-ecosistema-startup',
    'SEO con IA Agentes',
    '🚀',
    '28 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_18$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> SEO con IA Agentes · 28 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/01_SEO_con_IA_Agentes.md" target="_blank" rel="noopener">🎯 SEO con IA + Agentes</a> <code>bruto/SEO_con_IA_Agentes/01_SEO_con_IA_Agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/02_Bienvenida_y_contexto.md" target="_blank" rel="noopener">🧭 Bienvenida y contexto</a> <code>bruto/SEO_con_IA_Agentes/02_Bienvenida_y_contexto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/03_L01_Por_qué_ningún_consultor_me_sirvió.md" target="_blank" rel="noopener">L0.1 · Por qué ningún consultor me sirvió</a> <code>bruto/SEO_con_IA_Agentes/03_L01_Por_qué_ningún_consultor_me_sirvió.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/04_L02_SEO_en_la_era_del_AI_Overview.md" target="_blank" rel="noopener">L0.2 · SEO en la era del AI Overview</a> <code>bruto/SEO_con_IA_Agentes/04_L02_SEO_en_la_era_del_AI_Overview.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/05_Estrategia_SEO_para_tu_etapa.md" target="_blank" rel="noopener">🎯 Estrategia SEO para tu etapa</a> <code>bruto/SEO_con_IA_Agentes/05_Estrategia_SEO_para_tu_etapa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/06_L11_Keywords_que_valen_la_pena.md" target="_blank" rel="noopener">L1.1 · Keywords que valen la pena</a> <code>bruto/SEO_con_IA_Agentes/06_L11_Keywords_que_valen_la_pena.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/07_L12_Analiza_tu_competencia.md" target="_blank" rel="noopener">L1.2 · Analiza tu competencia</a> <code>bruto/SEO_con_IA_Agentes/07_L12_Analiza_tu_competencia.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/08_L13_Plan_de_contenido_en_1_página.md" target="_blank" rel="noopener">L1.3 · Plan de contenido en 1 página</a> <code>bruto/SEO_con_IA_Agentes/08_L13_Plan_de_contenido_en_1_página.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/09_Conoce_dónde_estás.md" target="_blank" rel="noopener">🔍 Conoce dónde estás</a> <code>bruto/SEO_con_IA_Agentes/09_Conoce_dónde_estás.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/10_L21_Conecta_Google_Search_Console.md" target="_blank" rel="noopener">L2.1 · Conecta Google Search Console</a> <code>bruto/SEO_con_IA_Agentes/10_L21_Conecta_Google_Search_Console.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/11_L22_Auditoría_express_de_tu_contenido.md" target="_blank" rel="noopener">L2.2 · Auditoría express de tu contenido</a> <code>bruto/SEO_con_IA_Agentes/11_L22_Auditoría_express_de_tu_contenido.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/12_Instala_y_corre_los_5_agentes.md" target="_blank" rel="noopener">🤖 Instala y corre los 5 agentes</a> <code>bruto/SEO_con_IA_Agentes/12_Instala_y_corre_los_5_agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/13_L31_Instala_Claude_Code_5_agentes.md" target="_blank" rel="noopener">L3.1 · Instala Claude Code + 5 agentes</a> <code>bruto/SEO_con_IA_Agentes/13_L31_Instala_Claude_Code_5_agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/14_L32_Tu_primera_keyword_con_el_agente.md" target="_blank" rel="noopener">L3.2 · Tu primera keyword con el agente</a> <code>bruto/SEO_con_IA_Agentes/14_L32_Tu_primera_keyword_con_el_agente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/15_L33_Pipeline_completo_keyword_a_borrador.md" target="_blank" rel="noopener">L3.3 · Pipeline completo: keyword a borrador</a> <code>bruto/SEO_con_IA_Agentes/15_L33_Pipeline_completo_keyword_a_borrador.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/16_Publica_y_mide.md" target="_blank" rel="noopener">📤 Publica y mide</a> <code>bruto/SEO_con_IA_Agentes/16_Publica_y_mide.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/17_L41_Schema_canonical_y_GSC_submit.md" target="_blank" rel="noopener">L4.1 · Schema, canonical y GSC submit</a> <code>bruto/SEO_con_IA_Agentes/17_L41_Schema_canonical_y_GSC_submit.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/18_L42_Qué_mirar_en_GSC_12_semanas.md" target="_blank" rel="noopener">L4.2 · Qué mirar en GSC (12 semanas)</a> <code>bruto/SEO_con_IA_Agentes/18_L42_Qué_mirar_en_GSC_12_semanas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/19_L43_Cuándo_y_cómo_iterar_un_artículo.md" target="_blank" rel="noopener">L4.3 · Cuándo (y cómo) iterar un artículo</a> <code>bruto/SEO_con_IA_Agentes/19_L43_Cuándo_y_cómo_iterar_un_artículo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/20_L44_Indexación_multi-motor_URLs.md" target="_blank" rel="noopener">L4.4 · Indexación multi-motor + URLs</a> <code>bruto/SEO_con_IA_Agentes/20_L44_Indexación_multi-motor_URLs.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/21_Casos_reales.md" target="_blank" rel="noopener">📈 Casos reales</a> <code>bruto/SEO_con_IA_Agentes/21_Casos_reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/22_L51_Caso_real_Ecosistema_Startup.md" target="_blank" rel="noopener">L5.1 · Caso real: Ecosistema Startup</a> <code>bruto/SEO_con_IA_Agentes/22_L51_Caso_real_Ecosistema_Startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/23_Que_sepan_que_existes.md" target="_blank" rel="noopener">📣 Que sepan que existes</a> <code>bruto/SEO_con_IA_Agentes/23_Que_sepan_que_existes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/24_L61_Backlinks_sin_comprarlos.md" target="_blank" rel="noopener">L6.1 · Backlinks sin comprarlos</a> <code>bruto/SEO_con_IA_Agentes/24_L61_Backlinks_sin_comprarlos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/25_L62_Publicar_no_es_distribuir.md" target="_blank" rel="noopener">L6.2 · Publicar no es distribuir</a> <code>bruto/SEO_con_IA_Agentes/25_L62_Publicar_no_es_distribuir.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/26_L63_AI_search_off-page_Junio_2026.md" target="_blank" rel="noopener">L6.3 · AI search off-page (Junio 2026)</a> <code>bruto/SEO_con_IA_Agentes/26_L63_AI_search_off-page_Junio_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/27_Qué_hago_ahora.md" target="_blank" rel="noopener">🗺️ ¿Qué hago ahora?</a> <code>bruto/SEO_con_IA_Agentes/27_Qué_hago_ahora.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/SEO_con_IA_Agentes/28_L71_Qué_hago_ahora_Tu_ruta.md" target="_blank" rel="noopener">L7.1 · ¿Qué hago ahora? Tu ruta</a> <code>bruto/SEO_con_IA_Agentes/28_L71_Qué_hago_ahora_Tu_ruta.md</code></li>
</ul>$lf_module_18$,
    180,
    true,
    '{}'::jsonb
  ),
  (
    'car-segmentacion-y-buyer-personas',
    'car-ecosistema-startup',
    'Segmentación y Buyer Personas',
    '🚀',
    '58 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_19$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Segmentación y Buyer Personas · 58 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/01_Segmentación_y_Buyer_Personas.md" target="_blank" rel="noopener">🎯 Segmentación y Buyer Personas</a> <code>bruto/Segmentación_y_Buyer_Personas/01_Segmentación_y_Buyer_Personas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/02_INTRODUCCIÓN.md" target="_blank" rel="noopener">INTRODUCCIÓN</a> <code>bruto/Segmentación_y_Buyer_Personas/02_INTRODUCCIÓN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/03_Segmentación_de_mercado_para_startups.md" target="_blank" rel="noopener">Segmentación de mercado para startups</a> <code>bruto/Segmentación_y_Buyer_Personas/03_Segmentación_de_mercado_para_startups.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/03_Segmentación_de_mercado_para_startups.transcript.md" target="_blank" rel="noopener">Transcripción — Segmentación de mercado para startups</a> <code>bruto/Segmentación_y_Buyer_Personas/03_Segmentación_de_mercado_para_startups.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/04_Objetivos_del_curso.md" target="_blank" rel="noopener">Objetivos del curso</a> <code>bruto/Segmentación_y_Buyer_Personas/04_Objetivos_del_curso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/04_Objetivos_del_curso.transcript.md" target="_blank" rel="noopener">Transcripción — Objetivos del curso</a> <code>bruto/Segmentación_y_Buyer_Personas/04_Objetivos_del_curso.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/05_Conoce_a_Rodrigo_Rojo.md" target="_blank" rel="noopener">Conoce a Rodrigo Rojo</a> <code>bruto/Segmentación_y_Buyer_Personas/05_Conoce_a_Rodrigo_Rojo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/05_Conoce_a_Rodrigo_Rojo.transcript.md" target="_blank" rel="noopener">Transcripción — Conoce a Rodrigo Rojo</a> <code>bruto/Segmentación_y_Buyer_Personas/05_Conoce_a_Rodrigo_Rojo.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/06_FUNDAMENTOS_DE_LA_SEGMENTACIÓN_DE_MERCADO.md" target="_blank" rel="noopener">FUNDAMENTOS DE LA SEGMENTACIÓN DE MERCADO</a> <code>bruto/Segmentación_y_Buyer_Personas/06_FUNDAMENTOS_DE_LA_SEGMENTACIÓN_DE_MERCADO.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/07_Definición_de_segmentación_de_mercado.md" target="_blank" rel="noopener">Definición de segmentación de mercado</a> <code>bruto/Segmentación_y_Buyer_Personas/07_Definición_de_segmentación_de_mercado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/07_Definición_de_segmentación_de_mercado.transcript.md" target="_blank" rel="noopener">Transcripción — Definición de segmentación de mercado</a> <code>bruto/Segmentación_y_Buyer_Personas/07_Definición_de_segmentación_de_mercado.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/08_Beneficios_de_una_segmentación_efectiva.md" target="_blank" rel="noopener">Beneficios de una segmentación efectiva</a> <code>bruto/Segmentación_y_Buyer_Personas/08_Beneficios_de_una_segmentación_efectiva.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/08_Beneficios_de_una_segmentación_efectiva.transcript.md" target="_blank" rel="noopener">Transcripción — Beneficios de una segmentación efectiva</a> <code>bruto/Segmentación_y_Buyer_Personas/08_Beneficios_de_una_segmentación_efectiva.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/09_Tipos_principales_de_segmentación.md" target="_blank" rel="noopener">Tipos principales de segmentación</a> <code>bruto/Segmentación_y_Buyer_Personas/09_Tipos_principales_de_segmentación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/09_Tipos_principales_de_segmentación.transcript.md" target="_blank" rel="noopener">Transcripción — Tipos principales de segmentación</a> <code>bruto/Segmentación_y_Buyer_Personas/09_Tipos_principales_de_segmentación.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/10_ANÁLISIS_DEL_MERCADO_TOTAL_TAM_SAM_SOM.md" target="_blank" rel="noopener">ANÁLISIS DEL MERCADO TOTAL (TAM, SAM, SOM)</a> <code>bruto/Segmentación_y_Buyer_Personas/10_ANÁLISIS_DEL_MERCADO_TOTAL_TAM_SAM_SOM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/11_Total_Addressable_Market_TAM.md" target="_blank" rel="noopener">Total Addressable Market (TAM)</a> <code>bruto/Segmentación_y_Buyer_Personas/11_Total_Addressable_Market_TAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/11_Total_Addressable_Market_TAM.transcript.md" target="_blank" rel="noopener">Transcripción — Total Addressable Market (TAM)</a> <code>bruto/Segmentación_y_Buyer_Personas/11_Total_Addressable_Market_TAM.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/12_Serviceable_Available_Market_SAM.md" target="_blank" rel="noopener">Serviceable Available Market (SAM)</a> <code>bruto/Segmentación_y_Buyer_Personas/12_Serviceable_Available_Market_SAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/12_Serviceable_Available_Market_SAM.transcript.md" target="_blank" rel="noopener">Transcripción — Serviceable Available Market (SAM)</a> <code>bruto/Segmentación_y_Buyer_Personas/12_Serviceable_Available_Market_SAM.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/13_Serviceable_Obtainable_Market_SOM.md" target="_blank" rel="noopener">Serviceable Obtainable Market (SOM)</a> <code>bruto/Segmentación_y_Buyer_Personas/13_Serviceable_Obtainable_Market_SOM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/13_Serviceable_Obtainable_Market_SOM.transcript.md" target="_blank" rel="noopener">Transcripción — Serviceable Obtainable Market (SOM)</a> <code>bruto/Segmentación_y_Buyer_Personas/13_Serviceable_Obtainable_Market_SOM.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/14_Cómo_calcular_y_utilizar_TAM_SAM_y_SOM.md" target="_blank" rel="noopener">Cómo calcular y utilizar TAM, SAM y SOM</a> <code>bruto/Segmentación_y_Buyer_Personas/14_Cómo_calcular_y_utilizar_TAM_SAM_y_SOM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/14_Cómo_calcular_y_utilizar_TAM_SAM_y_SOM.transcript.md" target="_blank" rel="noopener">Transcripción — Cómo calcular y utilizar TAM, SAM y SOM</a> <code>bruto/Segmentación_y_Buyer_Personas/14_Cómo_calcular_y_utilizar_TAM_SAM_y_SOM.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/15_IDEAL_CUSTOMER_PROFILE_ICP_Y_BUYER_PERSONA.md" target="_blank" rel="noopener">IDEAL CUSTOMER PROFILE (ICP) Y BUYER PERSONA</a> <code>bruto/Segmentación_y_Buyer_Personas/15_IDEAL_CUSTOMER_PROFILE_ICP_Y_BUYER_PERSONA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/16_Definición_y_diferencias_entre_ICP_y_Buyer_Persona.md" target="_blank" rel="noopener">Definición y diferencias entre ICP y Buyer Persona</a> <code>bruto/Segmentación_y_Buyer_Personas/16_Definición_y_diferencias_entre_ICP_y_Buyer_Persona.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/16_Definición_y_diferencias_entre_ICP_y_Buyer_Persona.transcript.md" target="_blank" rel="noopener">Transcripción — Definición y diferencias entre ICP y Buyer Persona</a> <code>bruto/Segmentación_y_Buyer_Personas/16_Definición_y_diferencias_entre_ICP_y_Buyer_Persona.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/17_Cómo_crear_un_ICP_efectivo.md" target="_blank" rel="noopener">Cómo crear un ICP efectivo</a> <code>bruto/Segmentación_y_Buyer_Personas/17_Cómo_crear_un_ICP_efectivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/17_Cómo_crear_un_ICP_efectivo.transcript.md" target="_blank" rel="noopener">Transcripción — Cómo crear un ICP efectivo</a> <code>bruto/Segmentación_y_Buyer_Personas/17_Cómo_crear_un_ICP_efectivo.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/18_Desarrollo_de_Buyer_Personas_detalladas.md" target="_blank" rel="noopener">Desarrollo de Buyer Personas detalladas</a> <code>bruto/Segmentación_y_Buyer_Personas/18_Desarrollo_de_Buyer_Personas_detalladas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/18_Desarrollo_de_Buyer_Personas_detalladas.transcript.md" target="_blank" rel="noopener">Transcripción — Desarrollo de Buyer Personas detalladas</a> <code>bruto/Segmentación_y_Buyer_Personas/18_Desarrollo_de_Buyer_Personas_detalladas.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/19_Aplicacion_en_Estrategia_de_Marketing.md" target="_blank" rel="noopener">Aplicación en Estrategia de Marketing</a> <code>bruto/Segmentación_y_Buyer_Personas/19_Aplicacion_en_Estrategia_de_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/19_Aplicacion_en_Estrategia_de_Marketing.transcript.md" target="_blank" rel="noopener">Transcripción — Aplicación en Estrategia de Marketing</a> <code>bruto/Segmentación_y_Buyer_Personas/19_Aplicacion_en_Estrategia_de_Marketing.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/20_PROCESO_DE_SEGMENTACIÓN.md" target="_blank" rel="noopener">PROCESO DE SEGMENTACIÓN</a> <code>bruto/Segmentación_y_Buyer_Personas/20_PROCESO_DE_SEGMENTACIÓN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/21_Identificación_de_variables_clave_para_tu_startup.md" target="_blank" rel="noopener">Identificación de variables clave para tu startup</a> <code>bruto/Segmentación_y_Buyer_Personas/21_Identificación_de_variables_clave_para_tu_startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/21_Identificación_de_variables_clave_para_tu_startup.transcript.md" target="_blank" rel="noopener">Transcripción — Identificación de variables clave para tu startup</a> <code>bruto/Segmentación_y_Buyer_Personas/21_Identificación_de_variables_clave_para_tu_startup.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/22_Desarrollo_de_perfiles_de_segmentos.md" target="_blank" rel="noopener">Desarrollo de perfiles de segmentos</a> <code>bruto/Segmentación_y_Buyer_Personas/22_Desarrollo_de_perfiles_de_segmentos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/22_Desarrollo_de_perfiles_de_segmentos.transcript.md" target="_blank" rel="noopener">Transcripción — Desarrollo de perfiles de segmentos</a> <code>bruto/Segmentación_y_Buyer_Personas/22_Desarrollo_de_perfiles_de_segmentos.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/23_Evaluación_de_la_atractividad_de_los_segmentos.md" target="_blank" rel="noopener">Evaluación de la atractividad de los segmentos</a> <code>bruto/Segmentación_y_Buyer_Personas/23_Evaluación_de_la_atractividad_de_los_segmentos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/23_Evaluación_de_la_atractividad_de_los_segmentos.transcript.md" target="_blank" rel="noopener">Transcripción — Evaluación de la atractividad de los segmentos</a> <code>bruto/Segmentación_y_Buyer_Personas/23_Evaluación_de_la_atractividad_de_los_segmentos.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/24_Selección_de_segmentos_objetivo.md" target="_blank" rel="noopener">Selección de segmentos objetivo</a> <code>bruto/Segmentación_y_Buyer_Personas/24_Selección_de_segmentos_objetivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/24_Selección_de_segmentos_objetivo.transcript.md" target="_blank" rel="noopener">Transcripción — Selección de segmentos objetivo</a> <code>bruto/Segmentación_y_Buyer_Personas/24_Selección_de_segmentos_objetivo.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/25_ESTRATEGIAS_DE_TARGETING.md" target="_blank" rel="noopener">ESTRATEGIAS DE TARGETING</a> <code>bruto/Segmentación_y_Buyer_Personas/25_ESTRATEGIAS_DE_TARGETING.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/26_Marketing_concentrado_vs_diferenciado.md" target="_blank" rel="noopener">Marketing concentrado vs. diferenciado</a> <code>bruto/Segmentación_y_Buyer_Personas/26_Marketing_concentrado_vs_diferenciado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/26_Marketing_concentrado_vs_diferenciado.transcript.md" target="_blank" rel="noopener">Transcripción — Marketing concentrado vs. diferenciado</a> <code>bruto/Segmentación_y_Buyer_Personas/26_Marketing_concentrado_vs_diferenciado.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/27_Posicionamiento_para_los_segmentos_elegidos.md" target="_blank" rel="noopener">Posicionamiento para los segmentos elegidos</a> <code>bruto/Segmentación_y_Buyer_Personas/27_Posicionamiento_para_los_segmentos_elegidos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/27_Posicionamiento_para_los_segmentos_elegidos.transcript.md" target="_blank" rel="noopener">Transcripción — Posicionamiento para los segmentos elegidos</a> <code>bruto/Segmentación_y_Buyer_Personas/27_Posicionamiento_para_los_segmentos_elegidos.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/28_Adaptación_del_productoservicio_al_segmento.md" target="_blank" rel="noopener">Adaptación del producto/servicio al segmento</a> <code>bruto/Segmentación_y_Buyer_Personas/28_Adaptación_del_productoservicio_al_segmento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/28_Adaptación_del_productoservicio_al_segmento.transcript.md" target="_blank" rel="noopener">Transcripción — Adaptación del producto/servicio al segmento</a> <code>bruto/Segmentación_y_Buyer_Personas/28_Adaptación_del_productoservicio_al_segmento.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/29_IMPLEMENTACIÓN_Y_MEDICIÓN.md" target="_blank" rel="noopener">IMPLEMENTACIÓN Y MEDICIÓN</a> <code>bruto/Segmentación_y_Buyer_Personas/29_IMPLEMENTACIÓN_Y_MEDICIÓN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/30_Alineación_de_la_estrategia_de_marketing.md" target="_blank" rel="noopener">Alineación de la estrategia de marketing</a> <code>bruto/Segmentación_y_Buyer_Personas/30_Alineación_de_la_estrategia_de_marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/30_Alineación_de_la_estrategia_de_marketing.transcript.md" target="_blank" rel="noopener">Transcripción — Alineación de la estrategia de marketing</a> <code>bruto/Segmentación_y_Buyer_Personas/30_Alineación_de_la_estrategia_de_marketing.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/31_KPIs_para_medir_el_éxito_de_la_segmentación.md" target="_blank" rel="noopener">KPIs para medir el éxito de la segmentación</a> <code>bruto/Segmentación_y_Buyer_Personas/31_KPIs_para_medir_el_éxito_de_la_segmentación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/31_KPIs_para_medir_el_éxito_de_la_segmentación.transcript.md" target="_blank" rel="noopener">Transcripción — KPIs para medir el éxito de la segmentación</a> <code>bruto/Segmentación_y_Buyer_Personas/31_KPIs_para_medir_el_éxito_de_la_segmentación.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/32_Ajuste_y_refinamiento_continuo.md" target="_blank" rel="noopener">Ajuste y refinamiento continuo</a> <code>bruto/Segmentación_y_Buyer_Personas/32_Ajuste_y_refinamiento_continuo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/32_Ajuste_y_refinamiento_continuo.transcript.md" target="_blank" rel="noopener">Transcripción — Ajuste y refinamiento continuo</a> <code>bruto/Segmentación_y_Buyer_Personas/32_Ajuste_y_refinamiento_continuo.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/33_FELICIDADES.md" target="_blank" rel="noopener">¡FELICIDADES!</a> <code>bruto/Segmentación_y_Buyer_Personas/33_FELICIDADES.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Segmentación_y_Buyer_Personas/34_Plantilla_Buyer_Personas_y_análisis_de_mercado.md" target="_blank" rel="noopener">Plantilla: Buyer Personas y análisis de mercado</a> <code>bruto/Segmentación_y_Buyer_Personas/34_Plantilla_Buyer_Personas_y_análisis_de_mercado.md</code></li>
</ul>$lf_module_19$,
    190,
    true,
    '{}'::jsonb
  ),
  (
    'car-startup-inception-latam',
    'car-ecosistema-startup',
    'Startup Inception LATAM',
    '🚀',
    '31 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_20$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Startup Inception LATAM · 31 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/01_Startup_Inception_LATAM.md" target="_blank" rel="noopener">🚀 Startup Inception · LATAM</a> <code>bruto/Startup_Inception_LATAM/01_Startup_Inception_LATAM.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/02_Introducción.md" target="_blank" rel="noopener">Introducción</a> <code>bruto/Startup_Inception_LATAM/02_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/03_Quién_es_Cristian_Tala.md" target="_blank" rel="noopener">¿Quién es Cristian Tala?</a> <code>bruto/Startup_Inception_LATAM/03_Quién_es_Cristian_Tala.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/03_Quién_es_Cristian_Tala.transcript.md" target="_blank" rel="noopener">Transcripción — ¿Quién es Cristian Tala?</a> <code>bruto/Startup_Inception_LATAM/03_Quién_es_Cristian_Tala.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/04_Qué_es_una_Startup.md" target="_blank" rel="noopener">¿Qué es una Startup?</a> <code>bruto/Startup_Inception_LATAM/04_Qué_es_una_Startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/05_Definición_y_Características_de_una_Startup.md" target="_blank" rel="noopener">Definición y Características de una Startup</a> <code>bruto/Startup_Inception_LATAM/05_Definición_y_Características_de_una_Startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/05_Definición_y_Características_de_una_Startup.transcript.md" target="_blank" rel="noopener">Transcripción — Definición y Características de una Startup</a> <code>bruto/Startup_Inception_LATAM/05_Definición_y_Características_de_una_Startup.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/06_El_Ecosistema.md" target="_blank" rel="noopener">El Ecosistema</a> <code>bruto/Startup_Inception_LATAM/06_El_Ecosistema.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/06_El_Ecosistema.transcript.md" target="_blank" rel="noopener">Transcripción — El Ecosistema</a> <code>bruto/Startup_Inception_LATAM/06_El_Ecosistema.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/07_Retos_y_aprendizajes_de_una_Startup_que_tuvo_Exit.md" target="_blank" rel="noopener">Retos y aprendizajes de una Startup que tuvo Exit</a> <code>bruto/Startup_Inception_LATAM/07_Retos_y_aprendizajes_de_una_Startup_que_tuvo_Exit.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/07_Retos_y_aprendizajes_de_una_Startup_que_tuvo_Exit.transcript.md" target="_blank" rel="noopener">Transcripción — Retos y aprendizajes de una Startup que tuvo Exit</a> <code>bruto/Startup_Inception_LATAM/07_Retos_y_aprendizajes_de_una_Startup_que_tuvo_Exit.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/08_Modelos_de_Negocios.md" target="_blank" rel="noopener">Modelos de Negocios</a> <code>bruto/Startup_Inception_LATAM/08_Modelos_de_Negocios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/08_Modelos_de_Negocios.transcript.md" target="_blank" rel="noopener">Transcripción — Modelos de Negocios</a> <code>bruto/Startup_Inception_LATAM/08_Modelos_de_Negocios.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/09_Entendiendo_las_necesidades_del_mercado.md" target="_blank" rel="noopener">Entendiendo las necesidades del mercado</a> <code>bruto/Startup_Inception_LATAM/09_Entendiendo_las_necesidades_del_mercado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/10_Identificar_las_necesidades_del_mercado.md" target="_blank" rel="noopener">Identificar las necesidades del mercado</a> <code>bruto/Startup_Inception_LATAM/10_Identificar_las_necesidades_del_mercado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/10_Identificar_las_necesidades_del_mercado.transcript.md" target="_blank" rel="noopener">Transcripción — Identificar las necesidades del mercado</a> <code>bruto/Startup_Inception_LATAM/10_Identificar_las_necesidades_del_mercado.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/11_Validación_de_ideas_PoC_y_MVP_en_pocas_palabras.md" target="_blank" rel="noopener">Validación de ideas: PoC y MVP en pocas palabras</a> <code>bruto/Startup_Inception_LATAM/11_Validación_de_ideas_PoC_y_MVP_en_pocas_palabras.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/11_Validación_de_ideas_PoC_y_MVP_en_pocas_palabras.transcript.md" target="_blank" rel="noopener">Transcripción — Validación de ideas: PoC y MVP en pocas palabras</a> <code>bruto/Startup_Inception_LATAM/11_Validación_de_ideas_PoC_y_MVP_en_pocas_palabras.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/12_Propósito_y_Mentalidad.md" target="_blank" rel="noopener">Propósito y Mentalidad</a> <code>bruto/Startup_Inception_LATAM/12_Propósito_y_Mentalidad.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/13_Desarrollo_de_un_propósito.md" target="_blank" rel="noopener">Desarrollo de un propósito</a> <code>bruto/Startup_Inception_LATAM/13_Desarrollo_de_un_propósito.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/13_Desarrollo_de_un_propósito.transcript.md" target="_blank" rel="noopener">Transcripción — Desarrollo de un propósito</a> <code>bruto/Startup_Inception_LATAM/13_Desarrollo_de_un_propósito.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/14_Cultivando_una_mentalidad_Startupera.md" target="_blank" rel="noopener">Cultivando una mentalidad Startupera</a> <code>bruto/Startup_Inception_LATAM/14_Cultivando_una_mentalidad_Startupera.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/14_Cultivando_una_mentalidad_Startupera.transcript.md" target="_blank" rel="noopener">Transcripción — Cultivando una mentalidad Startupera</a> <code>bruto/Startup_Inception_LATAM/14_Cultivando_una_mentalidad_Startupera.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/15_Introducción_a_una_COOLtura.md" target="_blank" rel="noopener">Introducción a una COOLtura 😎</a> <code>bruto/Startup_Inception_LATAM/15_Introducción_a_una_COOLtura.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/15_Introducción_a_una_COOLtura.transcript.md" target="_blank" rel="noopener">Transcripción — Introducción a una COOLtura 😎</a> <code>bruto/Startup_Inception_LATAM/15_Introducción_a_una_COOLtura.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/16_Bonus_Track_Emprendedor.md" target="_blank" rel="noopener">Bonus Track Emprendedor</a> <code>bruto/Startup_Inception_LATAM/16_Bonus_Track_Emprendedor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/17_Primera_inversión_con_Martín_Delanghe_de_Broota.md" target="_blank" rel="noopener">Primera inversión con Martín Delanghe de Broota</a> <code>bruto/Startup_Inception_LATAM/17_Primera_inversión_con_Martín_Delanghe_de_Broota.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/17_Primera_inversión_con_Martín_Delanghe_de_Broota.transcript.md" target="_blank" rel="noopener">Transcripción — Primera inversión con Martín Delanghe de Broota</a> <code>bruto/Startup_Inception_LATAM/17_Primera_inversión_con_Martín_Delanghe_de_Broota.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/18_Conclusiones.md" target="_blank" rel="noopener">Conclusiones</a> <code>bruto/Startup_Inception_LATAM/18_Conclusiones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/19_Palabras_finales.md" target="_blank" rel="noopener">Palabras finales</a> <code>bruto/Startup_Inception_LATAM/19_Palabras_finales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Startup_Inception_LATAM/19_Palabras_finales.transcript.md" target="_blank" rel="noopener">Transcripción — Palabras finales</a> <code>bruto/Startup_Inception_LATAM/19_Palabras_finales.transcript.md</code></li>
</ul>$lf_module_20$,
    200,
    true,
    '{}'::jsonb
  ),
  (
    'car-tu-c-suite-de-ia',
    'car-ecosistema-startup',
    'Tu C-Suite de IA',
    '🚀',
    '31 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_21$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Tu C-Suite de IA · 31 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/01_Tu_C-Suite_de_IA.md" target="_blank" rel="noopener">Tu C-Suite de IA</a> <code>bruto/Tu_C-Suite_de_IA/01_Tu_C-Suite_de_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/02_M00_De_operador_a_director.md" target="_blank" rel="noopener">M00 — De operador a director</a> <code>bruto/Tu_C-Suite_de_IA/02_M00_De_operador_a_director.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/03_L01_El_mito_del_agente_que_hace_todo.md" target="_blank" rel="noopener">L0.1 · El mito del agente que hace todo</a> <code>bruto/Tu_C-Suite_de_IA/03_L01_El_mito_del_agente_que_hace_todo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/04_L02_Agentic_workflows_y_mapa_de_herramientas.md" target="_blank" rel="noopener">L0.2 · Agentic workflows y mapa de herramientas</a> <code>bruto/Tu_C-Suite_de_IA/04_L02_Agentic_workflows_y_mapa_de_herramientas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/05_L03_Mapea_tu_negocio.md" target="_blank" rel="noopener">L0.3 · Mapea tu negocio</a> <code>bruto/Tu_C-Suite_de_IA/05_L03_Mapea_tu_negocio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/06_L04_Tu_organigrama_de_agentes.md" target="_blank" rel="noopener">L0.4 · Tu organigrama de agentes</a> <code>bruto/Tu_C-Suite_de_IA/06_L04_Tu_organigrama_de_agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/07_M01_El_orquestador.md" target="_blank" rel="noopener">M01 — El orquestador</a> <code>bruto/Tu_C-Suite_de_IA/07_M01_El_orquestador.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/08_L11_El_orquestador_no_hace_coordina.md" target="_blank" rel="noopener">L1.1 · El orquestador no hace: coordina</a> <code>bruto/Tu_C-Suite_de_IA/08_L11_El_orquestador_no_hace_coordina.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/09_L12_La_fuente_de_verdad.md" target="_blank" rel="noopener">L1.2 · La fuente de verdad</a> <code>bruto/Tu_C-Suite_de_IA/09_L12_La_fuente_de_verdad.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/10_L13_Monta_tu_orquestador_mínimo.md" target="_blank" rel="noopener">L1.3 · Monta tu orquestador mínimo</a> <code>bruto/Tu_C-Suite_de_IA/10_L13_Monta_tu_orquestador_mínimo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/11_M02_El_equipo_de_cara_al_cliente.md" target="_blank" rel="noopener">M02 — El equipo de cara al cliente</a> <code>bruto/Tu_C-Suite_de_IA/11_M02_El_equipo_de_cara_al_cliente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/12_L21_Tu_CMO_de_IA.md" target="_blank" rel="noopener">L2.1 · Tu CMO de IA</a> <code>bruto/Tu_C-Suite_de_IA/12_L21_Tu_CMO_de_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/13_L22_Tu_equipo_de_ventas_SDR_y_closer.md" target="_blank" rel="noopener">L2.2 · Tu equipo de ventas (SDR y closer)</a> <code>bruto/Tu_C-Suite_de_IA/13_L22_Tu_equipo_de_ventas_SDR_y_closer.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/14_L23_Tu_Soporte_de_IA.md" target="_blank" rel="noopener">L2.3 · Tu Soporte de IA</a> <code>bruto/Tu_C-Suite_de_IA/14_L23_Tu_Soporte_de_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/15_M03_El_equipo_que_opera_y_construye.md" target="_blank" rel="noopener">M03 — El equipo que opera y construye</a> <code>bruto/Tu_C-Suite_de_IA/15_M03_El_equipo_que_opera_y_construye.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/16_L31_Tu_COO_de_IA.md" target="_blank" rel="noopener">L3.1 · Tu COO de IA</a> <code>bruto/Tu_C-Suite_de_IA/16_L31_Tu_COO_de_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/17_L32_Tu_CFO_de_IA.md" target="_blank" rel="noopener">L3.2 · Tu CFO de IA</a> <code>bruto/Tu_C-Suite_de_IA/17_L32_Tu_CFO_de_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/18_L33_Tu_CTO_de_IA.md" target="_blank" rel="noopener">L3.3 · Tu CTO de IA</a> <code>bruto/Tu_C-Suite_de_IA/18_L33_Tu_CTO_de_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/19_M04_Handoffs_que_trabajen_juntos.md" target="_blank" rel="noopener">M04 — Handoffs: que trabajen juntos</a> <code>bruto/Tu_C-Suite_de_IA/19_M04_Handoffs_que_trabajen_juntos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/20_L41_El_handoff_entre_agentes.md" target="_blank" rel="noopener">L4.1 · El handoff entre agentes</a> <code>bruto/Tu_C-Suite_de_IA/20_L41_El_handoff_entre_agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/21_L42_Determinista_no_agéntico_puro.md" target="_blank" rel="noopener">L4.2 · Determinista, no agéntico puro</a> <code>bruto/Tu_C-Suite_de_IA/21_L42_Determinista_no_agéntico_puro.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/22_L43_Tu_tablero_de_control.md" target="_blank" rel="noopener">L4.3 · Tu tablero de control</a> <code>bruto/Tu_C-Suite_de_IA/22_L43_Tu_tablero_de_control.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/23_M05_La_escalera_de_autonomía.md" target="_blank" rel="noopener">M05 — La escalera de autonomía</a> <code>bruto/Tu_C-Suite_de_IA/23_M05_La_escalera_de_autonomía.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/24_L51_La_escalera_de_autonomía.md" target="_blank" rel="noopener">L5.1 · La escalera de autonomía</a> <code>bruto/Tu_C-Suite_de_IA/24_L51_La_escalera_de_autonomía.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/25_L52_Audita_a_tu_equipo.md" target="_blank" rel="noopener">L5.2 · Audita a tu equipo</a> <code>bruto/Tu_C-Suite_de_IA/25_L52_Audita_a_tu_equipo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/26_L53_Qué_NO_delegar.md" target="_blank" rel="noopener">L5.3 · Qué NO delegar</a> <code>bruto/Tu_C-Suite_de_IA/26_L53_Qué_NO_delegar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/27_M06_El_plano_integrador.md" target="_blank" rel="noopener">M06 — El plano integrador</a> <code>bruto/Tu_C-Suite_de_IA/27_M06_El_plano_integrador.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/28_L61_El_plano_de_tu_empresa_agéntica.md" target="_blank" rel="noopener">L6.1 · El plano de tu empresa agéntica</a> <code>bruto/Tu_C-Suite_de_IA/28_L61_El_plano_de_tu_empresa_agéntica.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/29_L62_Cuándo_correr_sin_ti_over-the-loop.md" target="_blank" rel="noopener">L6.2 · Cuándo correr sin ti (over-the-loop)</a> <code>bruto/Tu_C-Suite_de_IA/29_L62_Cuándo_correr_sin_ti_over-the-loop.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/30_M07_Casos_reales.md" target="_blank" rel="noopener">M07 — Casos reales</a> <code>bruto/Tu_C-Suite_de_IA/30_M07_Casos_reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_C-Suite_de_IA/31_L71_Organigramas_en_producción.md" target="_blank" rel="noopener">L7.1 · Organigramas en producción</a> <code>bruto/Tu_C-Suite_de_IA/31_L71_Organigramas_en_producción.md</code></li>
</ul>$lf_module_21$,
    210,
    true,
    '{}'::jsonb
  ),
  (
    'car-tu-primer-empleado-de-ia-claude',
    'car-ecosistema-startup',
    'Tu Primer Empleado de IA Claude',
    '🚀',
    '25 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_22$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Tu Primer Empleado de IA Claude · 25 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/01_Tu_Primer_Empleado_de_IA_Claude.md" target="_blank" rel="noopener">🤖 Tu Primer Empleado de IA · Claude</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/01_Tu_Primer_Empleado_de_IA_Claude.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/02_M00_Introducción.md" target="_blank" rel="noopener">M00: Introducción</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/02_M00_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/03_L01-_Bienvenida_y_qué_es_Claude.md" target="_blank" rel="noopener">L0.1- Bienvenida y qué es Claude</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/03_L01-_Bienvenida_y_qué_es_Claude.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/04_L02_-_Los_Modelos_de_Claude_Cuál_Usar_y_Cuándo.md" target="_blank" rel="noopener">L0.2 - Los Modelos de Claude: Cuál Usar y Cuándo</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/04_L02_-_Los_Modelos_de_Claude_Cuál_Usar_y_Cuándo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/05_L03_-_Tus_Herramientas_Artifacts_Memory_Search.md" target="_blank" rel="noopener">L0.3 - Tus Herramientas: Artifacts, Memory, Search</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/05_L03_-_Tus_Herramientas_Artifacts_Memory_Search.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/06_M01_Claude_Projects.md" target="_blank" rel="noopener">M01: Claude Projects</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/06_M01_Claude_Projects.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/07_L11_Qué_es_un_Project_y_para_qué_sirve.md" target="_blank" rel="noopener">L1.1: Qué es un Project y para qué sirve</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/07_L11_Qué_es_un_Project_y_para_qué_sirve.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/08_L12_Carga_el_contexto_perfecto.md" target="_blank" rel="noopener">L1.2: Carga el contexto perfecto</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/08_L12_Carga_el_contexto_perfecto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/09_L13_Flujos_reales_del_founder.md" target="_blank" rel="noopener">L1.3: Flujos reales del founder</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/09_L13_Flujos_reales_del_founder.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/10_L14_Tu_stack_de_Projects.md" target="_blank" rel="noopener">L1.4: Tu stack de Projects</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/10_L14_Tu_stack_de_Projects.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/11_L15_Las_3_capas_de_memoria_de_tu_empleado.md" target="_blank" rel="noopener">L1.5: Las 3 capas de memoria de tu empleado</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/11_L15_Las_3_capas_de_memoria_de_tu_empleado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/12_M02_Claude_Cowork.md" target="_blank" rel="noopener">M02: Claude Cowork</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/12_M02_Claude_Cowork.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/13_L21_Cowork_vs_Projects.md" target="_blank" rel="noopener">L2.1: Cowork vs Projects</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/13_L21_Cowork_vs_Projects.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/14_L22_Tu_primer_task_autónomo.md" target="_blank" rel="noopener">L2.2: Tu primer task autónomo</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/14_L22_Tu_primer_task_autónomo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/15_L23_Flujos_de_trabajo_reales.md" target="_blank" rel="noopener">L2.3: Flujos de trabajo reales</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/15_L23_Flujos_de_trabajo_reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/16_L24_Conecta_tus_herramientas.md" target="_blank" rel="noopener">L2.4: Conecta tus herramientas</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/16_L24_Conecta_tus_herramientas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/17_L25_Delega_sin_estar_presente.md" target="_blank" rel="noopener">L2.5: Delega sin estar presente</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/17_L25_Delega_sin_estar_presente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/18_M03_Entrena_y_amplía_a_tu_empleado.md" target="_blank" rel="noopener">M03: Entrena y amplía a tu empleado</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/18_M03_Entrena_y_amplía_a_tu_empleado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/19_L31_Crea_Skills_sin_escribir_código.md" target="_blank" rel="noopener">L3.1: Crea Skills sin escribir código</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/19_L31_Crea_Skills_sin_escribir_código.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/20_L32_Live_Artifacts_tu_negocio_en_un_panel_vivo.md" target="_blank" rel="noopener">L3.2: Live Artifacts: tu negocio en un panel vivo</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/20_L32_Live_Artifacts_tu_negocio_en_un_panel_vivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/21_L33_Claude_for_Chrome_con_cuidado.md" target="_blank" rel="noopener">L3.3: Claude for Chrome (con cuidado)</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/21_L33_Claude_for_Chrome_con_cuidado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/22_M04_Casos_Reales.md" target="_blank" rel="noopener">M04: Casos Reales</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/22_M04_Casos_Reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/23_L41_Casos_Reales_30_dolores.md" target="_blank" rel="noopener">L4.1: Casos Reales: 30 dolores</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/23_L41_Casos_Reales_30_dolores.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/24_M05_Capstone_y_ahora_qué.md" target="_blank" rel="noopener">M05: Capstone — ¿y ahora qué?</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/24_M05_Capstone_y_ahora_qué.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Tu_Primer_Empleado_de_IA_Claude/25_L51_Tu_empleado_IA_según_tu_tipo_de_negocio.md" target="_blank" rel="noopener">L5.1: Tu empleado IA según tu tipo de negocio</a> <code>bruto/Tu_Primer_Empleado_de_IA_Claude/25_L51_Tu_empleado_IA_según_tu_tipo_de_negocio.md</code></li>
</ul>$lf_module_22$,
    220,
    true,
    '{}'::jsonb
  ),
  (
    'car-unit-economics-y-crecimiento',
    'car-ecosistema-startup',
    'Unit Economics y Crecimiento',
    '🚀',
    '22 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_23$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Unit Economics y Crecimiento · 22 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/01_Unit_Economics_y_Crecimiento.md" target="_blank" rel="noopener">📊 Unit Economics y Crecimiento</a> <code>bruto/Unit_Economics_y_Crecimiento/01_Unit_Economics_y_Crecimiento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/02_CRECER_CON_FUNDAMENTO.md" target="_blank" rel="noopener">CRECER CON FUNDAMENTO</a> <code>bruto/Unit_Economics_y_Crecimiento/02_CRECER_CON_FUNDAMENTO.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/03_Conoce_a_Martín_y_las_Units_Economics.md" target="_blank" rel="noopener">Conoce a Martín y las Units Economics</a> <code>bruto/Unit_Economics_y_Crecimiento/03_Conoce_a_Martín_y_las_Units_Economics.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/03_Conoce_a_Martín_y_las_Units_Economics.transcript.md" target="_blank" rel="noopener">Transcripción — Conoce a Martín y las Units Economics</a> <code>bruto/Unit_Economics_y_Crecimiento/03_Conoce_a_Martín_y_las_Units_Economics.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/04_MÉTRICAS_CLAVE.md" target="_blank" rel="noopener">MÉTRICAS CLAVE</a> <code>bruto/Unit_Economics_y_Crecimiento/04_MÉTRICAS_CLAVE.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/05_Analizando_el_CACCosto_de_Adquisición_de_Cliente.md" target="_blank" rel="noopener">Analizando el CAC(Costo de Adquisición de Cliente)</a> <code>bruto/Unit_Economics_y_Crecimiento/05_Analizando_el_CACCosto_de_Adquisición_de_Cliente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/05_CAC_estructurado.md" target="_blank" rel="noopener">CAC — Costo de Adquisición de Cliente</a> <code>bruto/Unit_Economics_y_Crecimiento/05_CAC_estructurado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/05_CAC_transcripcion.md" target="_blank" rel="noopener">Transcripción · Analizando el CAC (Costo de Adquisición de Cliente)</a> <code>bruto/Unit_Economics_y_Crecimiento/05_CAC_transcripcion.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/06_Calculando_el_LTV_Lifetime_Value_del_Cliente.md" target="_blank" rel="noopener">Calculando el LTV – Lifetime Value del Cliente</a> <code>bruto/Unit_Economics_y_Crecimiento/06_Calculando_el_LTV_Lifetime_Value_del_Cliente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/06_LTV_estructurado.md" target="_blank" rel="noopener">LTV — Lifetime Value del Cliente</a> <code>bruto/Unit_Economics_y_Crecimiento/06_LTV_estructurado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/06_LTV_transcripcion.md" target="_blank" rel="noopener">Transcripción · Calculando el LTV (Lifetime Value del Cliente)</a> <code>bruto/Unit_Economics_y_Crecimiento/06_LTV_transcripcion.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/07_Crecimiento_Rentable_estructurado.md" target="_blank" rel="noopener">La Fórmula del Crecimiento Rentable — Ratio LTV/CAC</a> <code>bruto/Unit_Economics_y_Crecimiento/07_Crecimiento_Rentable_estructurado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/07_Crecimiento_Rentable_transcripcion.md" target="_blank" rel="noopener">Transcripción · La Fórmula del Crecimiento Rentable</a> <code>bruto/Unit_Economics_y_Crecimiento/07_Crecimiento_Rentable_transcripcion.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/07_La_Fórmula_del_Crecimiento_Rentable.md" target="_blank" rel="noopener">La Fórmula del Crecimiento Rentable</a> <code>bruto/Unit_Economics_y_Crecimiento/07_La_Fórmula_del_Crecimiento_Rentable.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/08_Payback_estructurado.md" target="_blank" rel="noopener">Payback — Período de Recuperación</a> <code>bruto/Unit_Economics_y_Crecimiento/08_Payback_estructurado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/08_Payback_o_período_de_recuperación.md" target="_blank" rel="noopener">Payback o período de recuperación</a> <code>bruto/Unit_Economics_y_Crecimiento/08_Payback_o_período_de_recuperación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/08_Payback_transcripcion.md" target="_blank" rel="noopener">Transcripción · Payback o período de recuperación</a> <code>bruto/Unit_Economics_y_Crecimiento/08_Payback_transcripcion.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/09_Cómo_escalar_mi_Startup.md" target="_blank" rel="noopener">¿Cómo escalar mi Startup?</a> <code>bruto/Unit_Economics_y_Crecimiento/09_Cómo_escalar_mi_Startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/10_Cuando_escalar_estructurado.md" target="_blank" rel="noopener">¿Cuándo escalar mi Startup?</a> <code>bruto/Unit_Economics_y_Crecimiento/10_Cuando_escalar_estructurado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/10_Cuando_escalar_transcripcion.md" target="_blank" rel="noopener">Transcripción · Cuándo escalar mi Startup</a> <code>bruto/Unit_Economics_y_Crecimiento/10_Cuando_escalar_transcripcion.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/10_Cuándo_escalar_mi_Startup.md" target="_blank" rel="noopener">¿Cuándo escalar mi Startup?</a> <code>bruto/Unit_Economics_y_Crecimiento/10_Cuándo_escalar_mi_Startup.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Unit_Economics_y_Crecimiento/11_Plantilla_Métricas_Clave_y_Unit_Economics.md" target="_blank" rel="noopener">Plantilla: Métricas Clave y Unit Economics</a> <code>bruto/Unit_Economics_y_Crecimiento/11_Plantilla_Métricas_Clave_y_Unit_Economics.md</code></li>
</ul>$lf_module_23$,
    230,
    true,
    '{}'::jsonb
  ),
  (
    'car-validacion-de-ideas-sin-excusas',
    'car-ecosistema-startup',
    'Validación de Ideas Sin Excusas',
    '🚀',
    '24 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_24$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Validación de Ideas Sin Excusas · 24 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/01_Validación_de_Ideas_Sin_Excusas.md" target="_blank" rel="noopener">🚀 Validación de Ideas · Sin Excusas</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/01_Validación_de_Ideas_Sin_Excusas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/02_Encuentra_el_Problema.md" target="_blank" rel="noopener">🔍 Encuentra el Problema</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/02_Encuentra_el_Problema.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/03_01_Encuentra_el_problema_n8nReddit.md" target="_blank" rel="noopener">0.1 Encuentra el problema (n8n+Reddit)</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/03_01_Encuentra_el_problema_n8nReddit.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/03_01_Encuentra_el_problema_n8nReddit.transcript.md" target="_blank" rel="noopener">Transcripción — 0.1 Encuentra el problema (n8n+Reddit)</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/03_01_Encuentra_el_problema_n8nReddit.transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/04_Mindset_Validar_Sin_Excusas.md" target="_blank" rel="noopener">🧹 Mindset · Validar Sin Excusas</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/04_Mindset_Validar_Sin_Excusas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/05_11_La_era_de_la_validación_instantánea.md" target="_blank" rel="noopener">1.1 La era de la validación instantánea</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/05_11_La_era_de_la_validación_instantánea.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/06_12_Por_qué_el_dinero_no_es_tu_problema.md" target="_blank" rel="noopener">1.2 Por qué el dinero no es tu problema</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/06_12_Por_qué_el_dinero_no_es_tu_problema.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/07_13_El_Mito_del_Cofounder_Técnico.md" target="_blank" rel="noopener">1.3 El Mito del Cofounder Técnico</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/07_13_El_Mito_del_Cofounder_Técnico.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/08_Validar_Sin_Construir_Nada.md" target="_blank" rel="noopener">🧪 Validar Sin Construir Nada</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/08_Validar_Sin_Construir_Nada.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/09_21_Smoke_Tests_Validar_sin_producto.md" target="_blank" rel="noopener">2.1 Smoke Tests · Validar sin producto</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/09_21_Smoke_Tests_Validar_sin_producto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/10_22_Landing_que_Convierte_con_IA.md" target="_blank" rel="noopener">2.2 Landing que Convierte con IA</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/10_22_Landing_que_Convierte_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/11_23_Entrevistas_que_revelan_dolor_real.md" target="_blank" rel="noopener">2.3 Entrevistas que revelan dolor real</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/11_23_Entrevistas_que_revelan_dolor_real.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/12_Disposición_a_Pago.md" target="_blank" rel="noopener">💰 Disposición a Pago</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/12_Disposición_a_Pago.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/13_31_El_test_de_disposición_a_pago.md" target="_blank" rel="noopener">3.1 El test de disposición a pago</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/13_31_El_test_de_disposición_a_pago.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/14_32_Waitlists_de_Alto_Valor.md" target="_blank" rel="noopener">3.2 Waitlists de Alto Valor</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/14_32_Waitlists_de_Alto_Valor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/15_33_Pre-vender_antes_de_construir.md" target="_blank" rel="noopener">3.3 Pre-vender antes de construir</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/15_33_Pre-vender_antes_de_construir.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/16_AI_Agents_para_Validation_Loops.md" target="_blank" rel="noopener">🤖 AI Agents para Validation Loops</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/16_AI_Agents_para_Validation_Loops.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/17_41_Outreach_automatizado_con_Agents.md" target="_blank" rel="noopener">4.1 Outreach automatizado con Agents</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/17_41_Outreach_automatizado_con_Agents.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/18_42_Agents_para_seguimiento_de_leads.md" target="_blank" rel="noopener">4.2 Agents para seguimiento de leads</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/18_42_Agents_para_seguimiento_de_leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/19_43_Agents_para_análisis_de_feedback.md" target="_blank" rel="noopener">4.3 Agents para análisis de feedback</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/19_43_Agents_para_análisis_de_feedback.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/20_Tu_Sprint_de_Validación_48h.md" target="_blank" rel="noopener">⚡ Tu Sprint de Validación 48h</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/20_Tu_Sprint_de_Validación_48h.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/21_51_Tu_checklist_de_validación.md" target="_blank" rel="noopener">5.1 Tu checklist de validación</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/21_51_Tu_checklist_de_validación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/22_52_Ejecuta_en_48_horas.md" target="_blank" rel="noopener">5.2 Ejecuta en 48 horas</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/22_52_Ejecuta_en_48_horas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Validación_de_Ideas_Sin_Excusas/23_53_Del_validation_al_implementation.md" target="_blank" rel="noopener">5.3 Del validation al implementation</a> <code>bruto/Validación_de_Ideas_Sin_Excusas/23_53_Del_validation_al_implementation.md</code></li>
</ul>$lf_module_24$,
    240,
    true,
    '{}'::jsonb
  ),
  (
    'car-vende-mas-con-ia',
    'car-ecosistema-startup',
    'Vende Más con IA',
    '🚀',
    '27 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_25$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Vende Más con IA · 27 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/01_Vende_Más_con_IA.md" target="_blank" rel="noopener">🎯 Vende Más con IA</a> <code>bruto/Vende_Más_con_IA/01_Vende_Más_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/02_Introducción.md" target="_blank" rel="noopener">🧭 Introducción</a> <code>bruto/Vende_Más_con_IA/02_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/03_Dónde_Está_Tu_Cliente.md" target="_blank" rel="noopener">🧭 ¿Dónde Está Tu Cliente?</a> <code>bruto/Vende_Más_con_IA/03_Dónde_Está_Tu_Cliente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/04_Bienvenida_al_Sistema.md" target="_blank" rel="noopener">👋 Bienvenida al Sistema</a> <code>bruto/Vende_Más_con_IA/04_Bienvenida_al_Sistema.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/05_Reglas_del_Canal_LinkedIn.md" target="_blank" rel="noopener">📋 Reglas del Canal LinkedIn</a> <code>bruto/Vende_Más_con_IA/05_Reglas_del_Canal_LinkedIn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/06_Sistema_de_Ventas_con_IA.md" target="_blank" rel="noopener">💬 Sistema de Ventas con IA</a> <code>bruto/Vende_Más_con_IA/06_Sistema_de_Ventas_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/07_El_Sistema_de_Ventas_con_IA.md" target="_blank" rel="noopener">⚙️ El Sistema de Ventas con IA</a> <code>bruto/Vende_Más_con_IA/07_El_Sistema_de_Ventas_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/08_Prospecta_en_LinkedIn_con_IA.md" target="_blank" rel="noopener">🔗 Prospecta en LinkedIn con IA</a> <code>bruto/Vende_Más_con_IA/08_Prospecta_en_LinkedIn_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/09_El_Prompt_que_Convierte.md" target="_blank" rel="noopener">✍️ El Prompt que Convierte</a> <code>bruto/Vende_Más_con_IA/09_El_Prompt_que_Convierte.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/10_Follow-up_sin_Parecer_Robot.md" target="_blank" rel="noopener">🔄 Follow-up sin Parecer Robot</a> <code>bruto/Vende_Más_con_IA/10_Follow-up_sin_Parecer_Robot.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/11_Prospección_en_Instagram.md" target="_blank" rel="noopener">📸 Prospección en Instagram</a> <code>bruto/Vende_Más_con_IA/11_Prospección_en_Instagram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/12_Te_Sirve_Instagram.md" target="_blank" rel="noopener">🤔 ¿Te Sirve Instagram?</a> <code>bruto/Vende_Más_con_IA/12_Te_Sirve_Instagram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/13_Prospectos_en_Instagram_con_IA.md" target="_blank" rel="noopener">🔎 Prospectos en Instagram con IA</a> <code>bruto/Vende_Más_con_IA/13_Prospectos_en_Instagram_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/14_El_DM_que_No_Te_Quema_la_Cuenta.md" target="_blank" rel="noopener">💬 El DM que No Te Quema la Cuenta</a> <code>bruto/Vende_Más_con_IA/14_El_DM_que_No_Te_Quema_la_Cuenta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/15_Encontrar_Clientes_con_Google.md" target="_blank" rel="noopener">🔍 Encontrar Clientes con Google</a> <code>bruto/Vende_Más_con_IA/15_Encontrar_Clientes_con_Google.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/16_Operadores_de_Búsqueda_Sales_Nav.md" target="_blank" rel="noopener">🔍 Operadores de Búsqueda (Sales Nav)</a> <code>bruto/Vende_Más_con_IA/16_Operadores_de_Búsqueda_Sales_Nav.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/17_De_Búsqueda_Manual_a_Lista_Auto.md" target="_blank" rel="noopener">📃 De Búsqueda Manual a Lista Auto</a> <code>bruto/Vende_Más_con_IA/17_De_Búsqueda_Manual_a_Lista_Auto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/18_Enriquecer_y_Calificar_con_IA.md" target="_blank" rel="noopener">🧮 Enriquecer y Calificar con IA</a> <code>bruto/Vende_Más_con_IA/18_Enriquecer_y_Calificar_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/19_Automatiza_el_Volumen.md" target="_blank" rel="noopener">⚙️ Automatiza el Volumen</a> <code>bruto/Vende_Más_con_IA/19_Automatiza_el_Volumen.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/20_El_Sistema_Multicanal_Completo.md" target="_blank" rel="noopener">🧩 El Sistema Multicanal Completo</a> <code>bruto/Vende_Más_con_IA/20_El_Sistema_Multicanal_Completo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/21_Qué_Automatizar_y_el_Límite_Legal.md" target="_blank" rel="noopener">⚖️ Qué Automatizar (y el Límite Legal)</a> <code>bruto/Vende_Más_con_IA/21_Qué_Automatizar_y_el_Límite_Legal.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/22_El_Salto_al_Agente_Full-Auto.md" target="_blank" rel="noopener">🚀 El Salto al Agente Full-Auto</a> <code>bruto/Vende_Más_con_IA/22_El_Salto_al_Agente_Full-Auto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/23_Casos_Reales.md" target="_blank" rel="noopener">🏆 Casos Reales</a> <code>bruto/Vende_Más_con_IA/23_Casos_Reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/24_Casos_Reales_Ventas_con_IA.md" target="_blank" rel="noopener">🏆 Casos Reales: Ventas con IA</a> <code>bruto/Vende_Más_con_IA/24_Casos_Reales_Ventas_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/25_Sales_Navigator_Upgrade_Pago.md" target="_blank" rel="noopener">💼 Sales Navigator (Upgrade Pago)</a> <code>bruto/Vende_Más_con_IA/25_Sales_Navigator_Upgrade_Pago.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/26_Cuándo_Vale_Sales_Navigator.md" target="_blank" rel="noopener">💰 ¿Cuándo Vale Sales Navigator?</a> <code>bruto/Vende_Más_con_IA/26_Cuándo_Vale_Sales_Navigator.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Vende_Más_con_IA/27_Arma_Tu_Lista_en_Sales_Navigator.md" target="_blank" rel="noopener">📋 Arma Tu Lista en Sales Navigator</a> <code>bruto/Vende_Más_con_IA/27_Arma_Tu_Lista_en_Sales_Navigator.md</code></li>
</ul>$lf_module_25$,
    250,
    true,
    '{}'::jsonb
  ),
  (
    'car-workshops-grabados',
    'car-ecosistema-startup',
    'Workshops Grabados',
    '🚀',
    '18 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_26$<p>Inventario privado del classroom CAR extraido desde Skool. Usalo como mapa de exploracion: cada modulo apunta a las notas locales extraidas, sin descargar ni embeber videos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/CAR-skool-vault</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Workshops Grabados · 18 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/01_Workshops_Grabados.md" target="_blank" rel="noopener">📺 Workshops Grabados</a> <code>bruto/Workshops_Grabados/01_Workshops_Grabados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/02_Workshops_de_Automatización.md" target="_blank" rel="noopener">Workshops de Automatización</a> <code>bruto/Workshops_Grabados/02_Workshops_de_Automatización.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/03_Generación_de_Contenido_en_RRSS_por_Cristian_Tala.md" target="_blank" rel="noopener">Generación de Contenido en RRSS por Cristian Tala</a> <code>bruto/Workshops_Grabados/03_Generación_de_Contenido_en_RRSS_por_Cristian_Tala.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/04_Workshop_sobre_Make_con_Francisco_de_Brito.md" target="_blank" rel="noopener">Workshop sobre Make con Francisco de Brito</a> <code>bruto/Workshops_Grabados/04_Workshop_sobre_Make_con_Francisco_de_Brito.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/05_Automatizando_la_Conversión_con_Cristian_Tala.md" target="_blank" rel="noopener">Automatizando la Conversión con Cristian Tala</a> <code>bruto/Workshops_Grabados/05_Automatizando_la_Conversión_con_Cristian_Tala.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/06_Workshops_de_Jorge_Zamora.md" target="_blank" rel="noopener">Workshops de Jorge Zamora</a> <code>bruto/Workshops_Grabados/06_Workshops_de_Jorge_Zamora.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/07_Usar_IA_para_Ventas_B2B.md" target="_blank" rel="noopener">Usar IA para Ventas B2B</a> <code>bruto/Workshops_Grabados/07_Usar_IA_para_Ventas_B2B.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/08_Captación_de_Clientes_en_Ventas_B2B.md" target="_blank" rel="noopener">Captación de Clientes en Ventas B2B</a> <code>bruto/Workshops_Grabados/08_Captación_de_Clientes_en_Ventas_B2B.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/09_Cómo_sacarle_el_jugo_a_tu_CRM_Pt1.md" target="_blank" rel="noopener">¿Cómo sacarle el jugo a tu CRM? Pt.1</a> <code>bruto/Workshops_Grabados/09_Cómo_sacarle_el_jugo_a_tu_CRM_Pt1.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/10_Cómo_sacarle_el_jugo_a_tu_CRM_Pt_2.md" target="_blank" rel="noopener">¿Cómo sacarle el jugo a tu CRM? Pt. 2</a> <code>bruto/Workshops_Grabados/10_Cómo_sacarle_el_jugo_a_tu_CRM_Pt_2.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/11_Conversión_de_Prospectos_B2B_Pt1.md" target="_blank" rel="noopener">Conversión de Prospectos B2B Pt.1</a> <code>bruto/Workshops_Grabados/11_Conversión_de_Prospectos_B2B_Pt1.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/12_Workshops_de_Investability.md" target="_blank" rel="noopener">Workshops de Investability</a> <code>bruto/Workshops_Grabados/12_Workshops_de_Investability.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/13_Financiamiento_Inicial_por_Ale_Perez_-_Noviembre.md" target="_blank" rel="noopener">Financiamiento Inicial por Ale Perez - Noviembre</a> <code>bruto/Workshops_Grabados/13_Financiamiento_Inicial_por_Ale_Perez_-_Noviembre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/14_Financiamiento_Inicial_por_Ale_Perez_-_Diciembre.md" target="_blank" rel="noopener">Financiamiento Inicial por Ale Perez - Diciembre</a> <code>bruto/Workshops_Grabados/14_Financiamiento_Inicial_por_Ale_Perez_-_Diciembre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/15_Blinda_tu_Producto_por_Diego_Pinto.md" target="_blank" rel="noopener">&quot;Blinda tu Producto&quot; por Diego Pinto</a> <code>bruto/Workshops_Grabados/15_Blinda_tu_Producto_por_Diego_Pinto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/16_Workshops_Misceláneos.md" target="_blank" rel="noopener">Workshops Misceláneos</a> <code>bruto/Workshops_Grabados/16_Workshops_Misceláneos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/17_Potencia_tu_Linkedin_por_Diego_Arias.md" target="_blank" rel="noopener">Potencia tu Linkedin por Diego Arias</a> <code>bruto/Workshops_Grabados/17_Potencia_tu_Linkedin_por_Diego_Arias.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/CAR-skool-vault/bruto/Workshops_Grabados/18_Planificación_Exitosa_con_OKR_por_Javier_Ergas.md" target="_blank" rel="noopener">Planificación Exitosa con OKR por Javier Ergas</a> <code>bruto/Workshops_Grabados/18_Planificación_Exitosa_con_OKR_por_Javier_Ergas.md</code></li>
</ul>$lf_module_26$,
    260,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-agentes-de-whatsapp',
    'imperio-agentico',
    'Agentes de WhatsApp',
    '🏛️',
    '20 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_27$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Agentes de WhatsApp · 20 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/01_Agentes_de_WhatsApp.md" target="_blank" rel="noopener">Agentes de WhatsApp</a> <code>bruto/Agentes_de_WhatsApp/01_Agentes_de_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/02_Empieza_Aquí_Plug_Play.md" target="_blank" rel="noopener">🏁 Empieza Aquí (Plug &amp; Play)</a> <code>bruto/Agentes_de_WhatsApp/02_Empieza_Aquí_Plug_Play.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/03_0_Introducción.md" target="_blank" rel="noopener">🎬 0. Introducción</a> <code>bruto/Agentes_de_WhatsApp/03_0_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/04_1_Qué_vamos_a_necesitar.md" target="_blank" rel="noopener">🧩 1. Qué vamos a necesitar?</a> <code>bruto/Agentes_de_WhatsApp/04_1_Qué_vamos_a_necesitar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/05_2_Crear_base_de_Airtable.md" target="_blank" rel="noopener">🗂️ 2. Crear base de Airtable</a> <code>bruto/Agentes_de_WhatsApp/05_2_Crear_base_de_Airtable.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/06_3_Cloud_o_Servidor_EvolutionAPI.md" target="_blank" rel="noopener">🌐 3. ¿Cloud o Servidor? (EvolutionAPI)</a> <code>bruto/Agentes_de_WhatsApp/06_3_Cloud_o_Servidor_EvolutionAPI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/07_3A_Cloud_Evolution_API.md" target="_blank" rel="noopener">☁️ 3A. Cloud (Evolution API)</a> <code>bruto/Agentes_de_WhatsApp/07_3A_Cloud_Evolution_API.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/08_3B_Servidor_EvolutionAPI.md" target="_blank" rel="noopener">🖥️ 3B. (Servidor) EvolutionAPI</a> <code>bruto/Agentes_de_WhatsApp/08_3B_Servidor_EvolutionAPI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/09_4_Conectar_Evolution_a_N8N.md" target="_blank" rel="noopener">🔌 4. Conectar Evolution a N8N</a> <code>bruto/Agentes_de_WhatsApp/09_4_Conectar_Evolution_a_N8N.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/10_5_Conectar_Airtable_a_N8N.md" target="_blank" rel="noopener">🔗 5. Conectar Airtable a N8N</a> <code>bruto/Agentes_de_WhatsApp/10_5_Conectar_Airtable_a_N8N.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/11_6_Prueba_en_vivo.md" target="_blank" rel="noopener">🚀 6. Prueba en vivo</a> <code>bruto/Agentes_de_WhatsApp/11_6_Prueba_en_vivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/12_VER_Para_Profundización.md" target="_blank" rel="noopener">[VER] Para Profundización</a> <code>bruto/Agentes_de_WhatsApp/12_VER_Para_Profundización.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/13_7_Recepción_de_Mensajes.md" target="_blank" rel="noopener">✉️ 7. Recepción de Mensajes</a> <code>bruto/Agentes_de_WhatsApp/13_7_Recepción_de_Mensajes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/14_8_Formateo_de_mensajes_text_audio_image.md" target="_blank" rel="noopener">🧩 8. Formateo de mensajes (text, audio, image)</a> <code>bruto/Agentes_de_WhatsApp/14_8_Formateo_de_mensajes_text_audio_image.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/15_9_Recolección_de_mensajes_fragmentados.md" target="_blank" rel="noopener">🔄 9. Recolección de mensajes fragmentados</a> <code>bruto/Agentes_de_WhatsApp/15_9_Recolección_de_mensajes_fragmentados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/16_10_Prompting_y_configuración_de_Agentes.md" target="_blank" rel="noopener">🤖 10. Prompting y configuración de Agentes</a> <code>bruto/Agentes_de_WhatsApp/16_10_Prompting_y_configuración_de_Agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/17_11_Selección_de_Modelos_y_Uso_de_Memoria.md" target="_blank" rel="noopener">🧠 11. Selección de Modelos y Uso de Memoria</a> <code>bruto/Agentes_de_WhatsApp/17_11_Selección_de_Modelos_y_Uso_de_Memoria.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/18_12_Herramientas_subflujos_y_subagentes.md" target="_blank" rel="noopener">🛠️ 12. Herramientas, subflujos y subagentes</a> <code>bruto/Agentes_de_WhatsApp/18_12_Herramientas_subflujos_y_subagentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/19_13_Repaso_de_flujo_de_agentes_y_herramientas.md" target="_blank" rel="noopener">🔁 13. Repaso de flujo de agentes y herramientas</a> <code>bruto/Agentes_de_WhatsApp/19_13_Repaso_de_flujo_de_agentes_y_herramientas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Agentes_de_WhatsApp/20_14_Formateo_y_envío_de_mensajes.md" target="_blank" rel="noopener">📤 14. Formateo y envío de mensajes</a> <code>bruto/Agentes_de_WhatsApp/20_14_Formateo_y_envío_de_mensajes.md</code></li>
</ul>$lf_module_27$,
    10,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-airtable-desde-0',
    'imperio-agentico',
    'Airtable Desde 0',
    '🏛️',
    '17 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_28$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Airtable Desde 0 · 17 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/01_Airtable_Desde_0.md" target="_blank" rel="noopener">Airtable Desde 0</a> <code>bruto/Airtable_Desde_0/01_Airtable_Desde_0.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/02_Empieza_Aquí.md" target="_blank" rel="noopener">🏁 Empieza Aquí</a> <code>bruto/Airtable_Desde_0/02_Empieza_Aquí.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/03_Intro_a_Airtable.md" target="_blank" rel="noopener">🟢 Intro a Airtable</a> <code>bruto/Airtable_Desde_0/03_Intro_a_Airtable.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/04_Creación_y_Configuración_de_Bases.md" target="_blank" rel="noopener">🧱 Creación y Configuración de Bases</a> <code>bruto/Airtable_Desde_0/04_Creación_y_Configuración_de_Bases.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/05_Campos_y_Vistas.md" target="_blank" rel="noopener">🔭 Campos y Vistas</a> <code>bruto/Airtable_Desde_0/05_Campos_y_Vistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/06_Vistas_y_Fórmulas_Básicas.md" target="_blank" rel="noopener">🔍Vistas y Fórmulas Básicas</a> <code>bruto/Airtable_Desde_0/06_Vistas_y_Fórmulas_Básicas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/07_Formularios_Inteligente.md" target="_blank" rel="noopener">📄 Formularios Inteligente</a> <code>bruto/Airtable_Desde_0/07_Formularios_Inteligente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/08_Permisos_Colaboradores_y_Roles.md" target="_blank" rel="noopener">🔐 Permisos, Colaboradores y Roles</a> <code>bruto/Airtable_Desde_0/08_Permisos_Colaboradores_y_Roles.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/09_Automatizaciones_Nativas.md" target="_blank" rel="noopener">⚙️Automatizaciones Nativas</a> <code>bruto/Airtable_Desde_0/09_Automatizaciones_Nativas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/10_Conectando_Airtable_con_Make.md" target="_blank" rel="noopener">🔗 Conectando Airtable con Make</a> <code>bruto/Airtable_Desde_0/10_Conectando_Airtable_con_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/11_Interfaces.md" target="_blank" rel="noopener">🧩 Interfaces</a> <code>bruto/Airtable_Desde_0/11_Interfaces.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/12_Proyecto_Final_Parte_0.md" target="_blank" rel="noopener">🏆 Proyecto Final – Parte 0</a> <code>bruto/Airtable_Desde_0/12_Proyecto_Final_Parte_0.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/13_Proyecto_Final_Parte_1.md" target="_blank" rel="noopener">🏆 Proyecto Final – Parte 1</a> <code>bruto/Airtable_Desde_0/13_Proyecto_Final_Parte_1.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/14_Proyecto_Final_Parte_2.md" target="_blank" rel="noopener">🏆 Proyecto Final – Parte 2</a> <code>bruto/Airtable_Desde_0/14_Proyecto_Final_Parte_2.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/15_Proyecto_Final_Parte_3.md" target="_blank" rel="noopener">🏆 Proyecto Final – Parte 3</a> <code>bruto/Airtable_Desde_0/15_Proyecto_Final_Parte_3.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/16_Proyecto_Final_Parte_4.md" target="_blank" rel="noopener">🏆 Proyecto Final – Parte 4</a> <code>bruto/Airtable_Desde_0/16_Proyecto_Final_Parte_4.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Airtable_Desde_0/17_Proyecto_Final_Parte_5.md" target="_blank" rel="noopener">🏆 Proyecto Final – Parte 5</a> <code>bruto/Airtable_Desde_0/17_Proyecto_Final_Parte_5.md</code></li>
</ul>$lf_module_28$,
    20,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-automatizaciones-make',
    'imperio-agentico',
    'Automatizaciones Make',
    '🏛️',
    '64 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_29$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Automatizaciones Make · 64 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/01_Automatizaciones_Make.md" target="_blank" rel="noopener">Automatizaciones Make</a> <code>bruto/Automatizaciones_Make/01_Automatizaciones_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/02_Automatizaciones.md" target="_blank" rel="noopener">🤖 Automatizaciones</a> <code>bruto/Automatizaciones_Make/02_Automatizaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/03_Crea_Contenido_UGC_automático_con_Sora.md" target="_blank" rel="noopener">📽️ Crea Contenido UGC automático con Sora</a> <code>bruto/Automatizaciones_Make/03_Crea_Contenido_UGC_automático_con_Sora.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/04_Extraer_y_analizar_reseñas_de_Amazon_con_Apify.md" target="_blank" rel="noopener">⭐️ Extraer y analizar reseñas de Amazon con Apify</a> <code>bruto/Automatizaciones_Make/04_Extraer_y_analizar_reseñas_de_Amazon_con_Apify.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/05_Analiza_Ads_de_Facebook_de_tu_Competencia.md" target="_blank" rel="noopener">🔍 Analiza Ads de Facebook de tu Competencia</a> <code>bruto/Automatizaciones_Make/05_Analiza_Ads_de_Facebook_de_tu_Competencia.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/06_Extrae_Publicaciones_de_Grupos_de_Facebook.md" target="_blank" rel="noopener">🚵 Extrae Publicaciones de Grupos de Facebook</a> <code>bruto/Automatizaciones_Make/06_Extrae_Publicaciones_de_Grupos_de_Facebook.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/07_Sistema_IA_para_Crear_Contenido_Autom_en_RRSS.md" target="_blank" rel="noopener">🧩Sistema IA para Crear Contenido Autom. en RRSS</a> <code>bruto/Automatizaciones_Make/07_Sistema_IA_para_Crear_Contenido_Autom_en_RRSS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/08_Crea_Extensiones_de_Chrome_con_IA.md" target="_blank" rel="noopener">🌐Crea Extensiones de Chrome con IA</a> <code>bruto/Automatizaciones_Make/08_Crea_Extensiones_de_Chrome_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/09_Crea_Anuncios_de_Texto_en_Masa_Canva_Make.md" target="_blank" rel="noopener">🤮Crea Anuncios de Texto en Masa | Canva + Make</a> <code>bruto/Automatizaciones_Make/09_Crea_Anuncios_de_Texto_en_Masa_Canva_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/10_Conecta_Cualquier_IA_a_tus_Automatizaciones.md" target="_blank" rel="noopener">📌Conecta Cualquier IA a tus Automatizaciones</a> <code>bruto/Automatizaciones_Make/10_Conecta_Cualquier_IA_a_tus_Automatizaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/11_Crea_Reels_Virales_Kling_AI_ChatGPT.md" target="_blank" rel="noopener">⛏️Crea Reels Virales | Kling AI + ChatGPT</a> <code>bruto/Automatizaciones_Make/11_Crea_Reels_Virales_Kling_AI_ChatGPT.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/12_Asistente_Whatsapp_Google_Calendar.md" target="_blank" rel="noopener">❤️ Asistente Whatsapp + Google Calendar</a> <code>bruto/Automatizaciones_Make/12_Asistente_Whatsapp_Google_Calendar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/13_Sistema_de_Ventas_Calificación_Automatica_Leads.md" target="_blank" rel="noopener">👑Sistema de Ventas Calificación Automatica Leads</a> <code>bruto/Automatizaciones_Make/13_Sistema_de_Ventas_Calificación_Automatica_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/14_Prospecta_y_Redacta_Propuestas_Personalizadas.md" target="_blank" rel="noopener">✈️Prospecta y Redacta Propuestas Personalizadas</a> <code>bruto/Automatizaciones_Make/14_Prospecta_y_Redacta_Propuestas_Personalizadas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/15_Encuentra_Leads_con_APIFY_y_Personaliza_Mails.md" target="_blank" rel="noopener">👀Encuentra Leads con APIFY y Personaliza Mails</a> <code>bruto/Automatizaciones_Make/15_Encuentra_Leads_con_APIFY_y_Personaliza_Mails.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/16_Crea_Imágenes_FLUX_LoRA_Make_Replicate.md" target="_blank" rel="noopener">🔥Crea Imágenes FLUX LoRA + Make + Replicate</a> <code>bruto/Automatizaciones_Make/16_Crea_Imágenes_FLUX_LoRA_Make_Replicate.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/17_Automatiza_un_Blog_de_WordPress_Make_ChatGPT.md" target="_blank" rel="noopener">🌐Automatiza un Blog de WordPress Make + ChatGPT</a> <code>bruto/Automatizaciones_Make/17_Automatiza_un_Blog_de_WordPress_Make_ChatGPT.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/18_Crea_Aplicaciones_IA_en_segundos_sin_programar.md" target="_blank" rel="noopener">⚡Crea Aplicaciones IA en segundos (sin programar)</a> <code>bruto/Automatizaciones_Make/18_Crea_Aplicaciones_IA_en_segundos_sin_programar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/19_Crea_Asistentes_de_Voz_con_VAPI_Importa_Datos.md" target="_blank" rel="noopener">📞Crea Asistentes de Voz con VAPI + Importa Datos</a> <code>bruto/Automatizaciones_Make/19_Crea_Asistentes_de_Voz_con_VAPI_Importa_Datos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/20_Facturación_Automática_ChatGPT_Sheets_Make.md" target="_blank" rel="noopener">📄Facturación Automática ChatGPT + Sheets + Make</a> <code>bruto/Automatizaciones_Make/20_Facturación_Automática_ChatGPT_Sheets_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/21_Automatiza_Tareas_desde_ChatGPT.md" target="_blank" rel="noopener">🤖Automatiza Tareas desde ChatGPT</a> <code>bruto/Automatizaciones_Make/21_Automatiza_Tareas_desde_ChatGPT.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/22_Crea_Ebooks_Personalizados_Completos_Automático.md" target="_blank" rel="noopener">📕Crea Ebooks Personalizados Completos Automático</a> <code>bruto/Automatizaciones_Make/22_Crea_Ebooks_Personalizados_Completos_Automático.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/23_RSS_Para_Crear_Contenido_en_Tiempo_Real.md" target="_blank" rel="noopener">📰 RSS Para Crear Contenido en Tiempo Real</a> <code>bruto/Automatizaciones_Make/23_RSS_Para_Crear_Contenido_en_Tiempo_Real.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/24_Conseguir_Leads_de_IG_Manychat_Mailerlite.md" target="_blank" rel="noopener">📷 Conseguir Leads de IG Manychat + Mailerlite</a> <code>bruto/Automatizaciones_Make/24_Conseguir_Leads_de_IG_Manychat_Mailerlite.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/25_Crear_y_Publicar_Posts_IG_en_Masa_Nuevo.md" target="_blank" rel="noopener">📷 Crear y Publicar Posts IG en Masa (Nuevo)</a> <code>bruto/Automatizaciones_Make/25_Crear_y_Publicar_Posts_IG_en_Masa_Nuevo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/26_Creación_y_Publicación_en_Masa_Shorts_YouTube.md" target="_blank" rel="noopener">📽️ Creación y Publicación en Masa Shorts YouTube</a> <code>bruto/Automatizaciones_Make/26_Creación_y_Publicación_en_Masa_Shorts_YouTube.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/27_Sistema_IA_para_Crear_Contenido_Automatizado.md" target="_blank" rel="noopener">🔥 Sistema IA para Crear Contenido Automatizado</a> <code>bruto/Automatizaciones_Make/27_Sistema_IA_para_Crear_Contenido_Automatizado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/28_Personalizar_Correos_Masivos_con_ChatGPT.md" target="_blank" rel="noopener">📧 Personalizar Correos Masivos con ChatGPT</a> <code>bruto/Automatizaciones_Make/28_Personalizar_Correos_Masivos_con_ChatGPT.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/29_Encontrar_Leads_y_Envía_Mails_con_IA_Básico.md" target="_blank" rel="noopener">🔍 Encontrar Leads y Envía Mails con IA (Básico)</a> <code>bruto/Automatizaciones_Make/29_Encontrar_Leads_y_Envía_Mails_con_IA_Básico.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/30_Automatizaciones_Imperiales.md" target="_blank" rel="noopener">👑 Automatizaciones Imperiales</a> <code>bruto/Automatizaciones_Make/30_Automatizaciones_Imperiales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/31_Edición_con_NanoBanana_Gemini_Oscar.md" target="_blank" rel="noopener">Edición con NanoBanana + Gemini | Oscar</a> <code>bruto/Automatizaciones_Make/31_Edición_con_NanoBanana_Gemini_Oscar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/32_Sistema_Contable_Flor.md" target="_blank" rel="noopener">Sistema Contable | Flor</a> <code>bruto/Automatizaciones_Make/32_Sistema_Contable_Flor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/33_Extensión_Precios_y_Horarios_Flor.md" target="_blank" rel="noopener">Extensión Precios y Horarios | Flor</a> <code>bruto/Automatizaciones_Make/33_Extensión_Precios_y_Horarios_Flor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/34_Reels_virales_Freepik_Kling_Airtable_v2_Carlos.md" target="_blank" rel="noopener">Reels virales Freepik, Kling, Airtable v2 | Carlos</a> <code>bruto/Automatizaciones_Make/34_Reels_virales_Freepik_Kling_Airtable_v2_Carlos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/35_YouTube_a_Instagram_Ale.md" target="_blank" rel="noopener">YouTube a Instagram | Ale</a> <code>bruto/Automatizaciones_Make/35_YouTube_a_Instagram_Ale.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/36_PDF_a_Instagram_Ale.md" target="_blank" rel="noopener">PDF a Instagram | Ale</a> <code>bruto/Automatizaciones_Make/36_PDF_a_Instagram_Ale.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/37_Pedidos_WooCommerce_a_Sheets_Oscar.md" target="_blank" rel="noopener">Pedidos WooCommerce a Sheets | Oscar</a> <code>bruto/Automatizaciones_Make/37_Pedidos_WooCommerce_a_Sheets_Oscar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/38_Carruseles_de_Instagram_con_IA_y_Make_Marco.md" target="_blank" rel="noopener">Carruseles de Instagram con IA y Make | Marco</a> <code>bruto/Automatizaciones_Make/38_Carruseles_de_Instagram_con_IA_y_Make_Marco.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/39_Transcribe_Videos_de_YouTube_Jordi.md" target="_blank" rel="noopener">Transcribe Videos de YouTube | Jordi</a> <code>bruto/Automatizaciones_Make/39_Transcribe_Videos_de_YouTube_Jordi.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/40_Blog_con_Imágenes_Replicate_WordPress_Melina.md" target="_blank" rel="noopener">Blog con Imágenes (Replicate + WordPress) | Melina</a> <code>bruto/Automatizaciones_Make/40_Blog_con_Imágenes_Replicate_WordPress_Melina.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/41_Blog_con_Categorías_Raúl_Salazar.md" target="_blank" rel="noopener">Blog con Categorías | Raúl Salazar</a> <code>bruto/Automatizaciones_Make/41_Blog_con_Categorías_Raúl_Salazar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/42_Transcripción_de_Llamadas_Carlos_Dominguez.md" target="_blank" rel="noopener">Transcripción de Llamadas | Carlos Dominguez</a> <code>bruto/Automatizaciones_Make/42_Transcripción_de_Llamadas_Carlos_Dominguez.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/43_Preguntas_Frecuentes.md" target="_blank" rel="noopener">❓Preguntas Frecuentes</a> <code>bruto/Automatizaciones_Make/43_Preguntas_Frecuentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/44_Conexion_Google_Make_COMPLETA.md" target="_blank" rel="noopener">📌 Conexion Google + Make COMPLETA</a> <code>bruto/Automatizaciones_Make/44_Conexion_Google_Make_COMPLETA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/45_Taller_Intro_a_Make_para_Principiantes.md" target="_blank" rel="noopener">Taller: Intro a Make para Principiantes</a> <code>bruto/Automatizaciones_Make/45_Taller_Intro_a_Make_para_Principiantes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/46_Cómo_Conectar_API_de_X_Twitter_con_Make.md" target="_blank" rel="noopener">Cómo Conectar API de X (Twitter) con Make</a> <code>bruto/Automatizaciones_Make/46_Cómo_Conectar_API_de_X_Twitter_con_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/47_Cómo_Conectar_API_de_ManyChat_a_Make.md" target="_blank" rel="noopener">Cómo Conectar API de ManyChat a Make</a> <code>bruto/Automatizaciones_Make/47_Cómo_Conectar_API_de_ManyChat_a_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/48_Cómo_Conectar_API_de_MailerLite_a_Make.md" target="_blank" rel="noopener">Cómo Conectar API de MailerLite a Make</a> <code>bruto/Automatizaciones_Make/48_Cómo_Conectar_API_de_MailerLite_a_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/49_Cómo_Perplexity_puede_Buscar_en_la_Web_con_Make.md" target="_blank" rel="noopener">Cómo Perplexity puede Buscar en la Web con Make</a> <code>bruto/Automatizaciones_Make/49_Cómo_Perplexity_puede_Buscar_en_la_Web_con_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/50_Cómo_Transformar_Comprobantes_a_Datos_con_GSheets.md" target="_blank" rel="noopener">Cómo Transformar Comprobantes a Datos con G.Sheets</a> <code>bruto/Automatizaciones_Make/50_Cómo_Transformar_Comprobantes_a_Datos_con_GSheets.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/51_Cómo_Extraer_Datos_de_PDFs_imgs_a_Google_Sheets.md" target="_blank" rel="noopener">Cómo Extraer Datos de PDFs (imgs) a Google Sheets</a> <code>bruto/Automatizaciones_Make/51_Cómo_Extraer_Datos_de_PDFs_imgs_a_Google_Sheets.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/52_Cómo_Conectar_API_de_Deepseek_a_Makecom.md" target="_blank" rel="noopener">Cómo Conectar API de Deepseek a Make.com</a> <code>bruto/Automatizaciones_Make/52_Cómo_Conectar_API_de_Deepseek_a_Makecom.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/53_Error_Dropbox_Missing_Scope_401.md" target="_blank" rel="noopener">Error Dropbox Missing Scope 401</a> <code>bruto/Automatizaciones_Make/53_Error_Dropbox_Missing_Scope_401.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/54_Resolución_de_Errores_en_MAKE_Método_Alternativo.md" target="_blank" rel="noopener">Resolución de Errores en MAKE | Método Alternativo</a> <code>bruto/Automatizaciones_Make/54_Resolución_de_Errores_en_MAKE_Método_Alternativo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/55_Asistentes.md" target="_blank" rel="noopener">🔍Asistentes</a> <code>bruto/Automatizaciones_Make/55_Asistentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/56_Asistente_de_Tonalidad_Tono_de_Voz.md" target="_blank" rel="noopener">🔥Asistente de Tonalidad (Tono de Voz)</a> <code>bruto/Automatizaciones_Make/56_Asistente_de_Tonalidad_Tono_de_Voz.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/57_TUTORIAL_Cómo_Usar_Asistentes_IA.md" target="_blank" rel="noopener">[TUTORIAL] Cómo Usar Asistentes IA</a> <code>bruto/Automatizaciones_Make/57_TUTORIAL_Cómo_Usar_Asistentes_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/58_Asistente_de_SEO_para_Blogs.md" target="_blank" rel="noopener">Asistente de SEO para Blogs</a> <code>bruto/Automatizaciones_Make/58_Asistente_de_SEO_para_Blogs.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/59_Asistente_de_Facebook.md" target="_blank" rel="noopener">Asistente de Facebook</a> <code>bruto/Automatizaciones_Make/59_Asistente_de_Facebook.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/60_Asistente_de_Instagram.md" target="_blank" rel="noopener">Asistente de Instagram</a> <code>bruto/Automatizaciones_Make/60_Asistente_de_Instagram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/61_Asistente_de_X_Ex-Twitter.md" target="_blank" rel="noopener">Asistente de X (Ex-Twitter)</a> <code>bruto/Automatizaciones_Make/61_Asistente_de_X_Ex-Twitter.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/62_Asistente_de_LinkedIN.md" target="_blank" rel="noopener">Asistente de LinkedIN</a> <code>bruto/Automatizaciones_Make/62_Asistente_de_LinkedIN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/63_Agentes_Make.md" target="_blank" rel="noopener">Agentes Make</a> <code>bruto/Automatizaciones_Make/63_Agentes_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_Make/64_Tu_Primer_Agente_IA_en_Make_Donna_Asistente_IA.md" target="_blank" rel="noopener">Tu Primer Agente IA en Make (Donna | Asistente IA)</a> <code>bruto/Automatizaciones_Make/64_Tu_Primer_Agente_IA_en_Make_Donna_Asistente_IA.md</code></li>
</ul>$lf_module_29$,
    30,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-automatizaciones-n8n',
    'imperio-agentico',
    'Automatizaciones n8n',
    '🏛️',
    '19 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_30$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Automatizaciones n8n · 19 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/01_Automatizaciones_n8n.md" target="_blank" rel="noopener">Automatizaciones n8n</a> <code>bruto/Automatizaciones_n8n/01_Automatizaciones_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/02_Automatizaciones.md" target="_blank" rel="noopener">👑 Automatizaciones</a> <code>bruto/Automatizaciones_n8n/02_Automatizaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/03_Automatiza_Videos_de_Canciones_Infantiles.md" target="_blank" rel="noopener">👶 Automatiza Videos de Canciones Infantiles</a> <code>bruto/Automatizaciones_n8n/03_Automatiza_Videos_de_Canciones_Infantiles.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/04_Cold_Email_n8n.md" target="_blank" rel="noopener">Cold Email n8n</a> <code>bruto/Automatizaciones_n8n/04_Cold_Email_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/05_Mejora_Fotografías_Nanobanana_Restaurant.md" target="_blank" rel="noopener">📸 Mejora Fotografías Nanobanana Restaurant</a> <code>bruto/Automatizaciones_n8n/05_Mejora_Fotografías_Nanobanana_Restaurant.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/06_Crea_Comerciales_Cinemáticos_con_IA.md" target="_blank" rel="noopener">🎥Crea Comerciales Cinemáticos con IA</a> <code>bruto/Automatizaciones_n8n/06_Crea_Comerciales_Cinemáticos_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/07_Sistema_Facturación_Automática.md" target="_blank" rel="noopener">💰 Sistema Facturación Automática</a> <code>bruto/Automatizaciones_n8n/07_Sistema_Facturación_Automática.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/08_Agente_de_Contenido_en_LinkedIn_Plantilla.md" target="_blank" rel="noopener">👑Agente de Contenido en LinkedIn [+ Plantilla]</a> <code>bruto/Automatizaciones_n8n/08_Agente_de_Contenido_en_LinkedIn_Plantilla.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/09_Scraping_de_Videos_de_YouTube_con_Transcript.md" target="_blank" rel="noopener">🗂️ Scraping de Videos de YouTube con Transcript</a> <code>bruto/Automatizaciones_n8n/09_Scraping_de_Videos_de_YouTube_con_Transcript.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/10_Agente_de_WhatsApp_que_Agenda_y_Recuerda_247.md" target="_blank" rel="noopener">🤖 Agente de WhatsApp que Agenda y Recuerda 24/7</a> <code>bruto/Automatizaciones_n8n/10_Agente_de_WhatsApp_que_Agenda_y_Recuerda_247.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/11_Agente_Generador_y_Editor_de_Imágenes_con_IA.md" target="_blank" rel="noopener">🤖 Agente Generador y Editor de Imágenes con IA</a> <code>bruto/Automatizaciones_n8n/11_Agente_Generador_y_Editor_de_Imágenes_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/12_Instalaciones_y_Configuraciones.md" target="_blank" rel="noopener">⚙️ Instalaciones y Configuraciones</a> <code>bruto/Automatizaciones_n8n/12_Instalaciones_y_Configuraciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/13_PASO_1_Cómo_instalar_n8n_en_tu_VPS.md" target="_blank" rel="noopener">🎥 [PASO 1] Cómo instalar n8n en tu VPS</a> <code>bruto/Automatizaciones_n8n/13_PASO_1_Cómo_instalar_n8n_en_tu_VPS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/14_Instala_Claude_Code_automatiza_en_n8n.md" target="_blank" rel="noopener">Instala Claude Code (automatiza en n8n)</a> <code>bruto/Automatizaciones_n8n/14_Instala_Claude_Code_automatiza_en_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/15_Instalación_y_configuración_de_N8N_en_VPS.md" target="_blank" rel="noopener">🎥 Instalación y configuración de N8N en VPS</a> <code>bruto/Automatizaciones_n8n/15_Instalación_y_configuración_de_N8N_en_VPS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/16_Instalación_completa_de_EvolutionAPI_en_VPS.md" target="_blank" rel="noopener">🚀 Instalación completa de EvolutionAPI en VPS</a> <code>bruto/Automatizaciones_n8n/16_Instalación_completa_de_EvolutionAPI_en_VPS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/17_Instalación_de_Chatwoot_en_tu_VPS_con_EasyPanel.md" target="_blank" rel="noopener">💬 Instalación de Chatwoot en tu VPS con EasyPanel</a> <code>bruto/Automatizaciones_n8n/17_Instalación_de_Chatwoot_en_tu_VPS_con_EasyPanel.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/18_GUIA_Configura_tu_Agente_de_LinkedIn.md" target="_blank" rel="noopener">👑 [GUIA] Configura tu Agente de LinkedIn</a> <code>bruto/Automatizaciones_n8n/18_GUIA_Configura_tu_Agente_de_LinkedIn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Automatizaciones_n8n/19_GUIA_Configura_tus_Anuncios_Cinemáticos.md" target="_blank" rel="noopener">👑 [GUIA] Configura tus Anuncios Cinemáticos</a> <code>bruto/Automatizaciones_n8n/19_GUIA_Configura_tus_Anuncios_Cinemáticos.md</code></li>
</ul>$lf_module_30$,
    40,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-biblioteca-de-prompts',
    'imperio-agentico',
    'Biblioteca de Prompts',
    '🏛️',
    '200 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_31$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Biblioteca de Prompts · 200 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/01_Biblioteca_de_Prompts.md" target="_blank" rel="noopener">Biblioteca de Prompts</a> <code>bruto/Biblioteca_de_Prompts/01_Biblioteca_de_Prompts.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/02_Instrucciones.md" target="_blank" rel="noopener">📎 Instrucciones</a> <code>bruto/Biblioteca_de_Prompts/02_Instrucciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/03_Cómo_usar_la_Biblioteca_de_Prompts_en_2026.md" target="_blank" rel="noopener">Cómo usar la Biblioteca de Prompts en 2026</a> <code>bruto/Biblioteca_de_Prompts/03_Cómo_usar_la_Biblioteca_de_Prompts_en_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/04_La_Fórmula_Esencial_de_ChatGPT.md" target="_blank" rel="noopener">La Fórmula Esencial de ChatGPT</a> <code>bruto/Biblioteca_de_Prompts/04_La_Fórmula_Esencial_de_ChatGPT.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/05_Cómo_Optimizar_el_Uso_de_ChatGPT.md" target="_blank" rel="noopener">Cómo Optimizar el Uso de ChatGPT</a> <code>bruto/Biblioteca_de_Prompts/05_Cómo_Optimizar_el_Uso_de_ChatGPT.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/06_13_Tipos_de_Prompt_para_ChatGPT.md" target="_blank" rel="noopener">13 Tipos de Prompt para ChatGPT</a> <code>bruto/Biblioteca_de_Prompts/06_13_Tipos_de_Prompt_para_ChatGPT.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/07_La_Variedad_de_Personalidades_Actuar_como.md" target="_blank" rel="noopener">La Variedad de Personalidades &quot;Actuar como...&quot;</a> <code>bruto/Biblioteca_de_Prompts/07_La_Variedad_de_Personalidades_Actuar_como.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/08_Copywriting.md" target="_blank" rel="noopener">✍️ Copywriting</a> <code>bruto/Biblioteca_de_Prompts/08_Copywriting.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/09_Haciendo_la_Copia_de_Anuncios_Más_Interesante.md" target="_blank" rel="noopener">Haciendo la Copia de Anuncios Más Interesante</a> <code>bruto/Biblioteca_de_Prompts/09_Haciendo_la_Copia_de_Anuncios_Más_Interesante.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/100_Crear_Estrategias_Promocionales.md" target="_blank" rel="noopener">🔥 Crear Estrategias Promocionales</a> <code>bruto/Biblioteca_de_Prompts/100_Crear_Estrategias_Promocionales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/101_Comunicación_con_Afiliados.md" target="_blank" rel="noopener">Comunicación con Afiliados</a> <code>bruto/Biblioteca_de_Prompts/101_Comunicación_con_Afiliados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/102_Embudo_de_Ventas_Sales_Funnel.md" target="_blank" rel="noopener">📈 Embudo de Ventas (Sales Funnel)</a> <code>bruto/Biblioteca_de_Prompts/102_Embudo_de_Ventas_Sales_Funnel.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/103_Escogiendo_un_Nicho.md" target="_blank" rel="noopener">Escogiendo un Nicho</a> <code>bruto/Biblioteca_de_Prompts/103_Escogiendo_un_Nicho.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/104_Escribiendo_una_Página_de_Ventas.md" target="_blank" rel="noopener">🔥 Escribiendo una Página de Ventas</a> <code>bruto/Biblioteca_de_Prompts/104_Escribiendo_una_Página_de_Ventas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/105_Landing_Page_Para_Opt-ins_o_Registro_a_Webinars.md" target="_blank" rel="noopener">Landing Page (Para Opt-ins o Registro a Webinars)</a> <code>bruto/Biblioteca_de_Prompts/105_Landing_Page_Para_Opt-ins_o_Registro_a_Webinars.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/106_Generando_Ideas_de_Embudos.md" target="_blank" rel="noopener">Generando Ideas de Embudos</a> <code>bruto/Biblioteca_de_Prompts/106_Generando_Ideas_de_Embudos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/107_Redacción_de_una_Página_de_Venta_Adicional.md" target="_blank" rel="noopener">Redacción de una Página de Venta Adicional</a> <code>bruto/Biblioteca_de_Prompts/107_Redacción_de_una_Página_de_Venta_Adicional.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/108_Redactando_un_Texto_de_Oferta_Complementaria.md" target="_blank" rel="noopener">Redactando un Texto de Oferta Complementaria</a> <code>bruto/Biblioteca_de_Prompts/108_Redactando_un_Texto_de_Oferta_Complementaria.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/109_Escribiendo_una_Página_de_Agradecimientos.md" target="_blank" rel="noopener">Escribiendo una Página de Agradecimientos</a> <code>bruto/Biblioteca_de_Prompts/109_Escribiendo_una_Página_de_Agradecimientos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/10_Escritura_de_Copia_de_Ventas_Extensa.md" target="_blank" rel="noopener">Escritura de Copia de Ventas Extensa</a> <code>bruto/Biblioteca_de_Prompts/10_Escritura_de_Copia_de_Ventas_Extensa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/110_Generación_de_Leads.md" target="_blank" rel="noopener">🧲 Generación de Leads</a> <code>bruto/Biblioteca_de_Prompts/110_Generación_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/111_Realizando_Encuestas_para_Generación_de_Leads.md" target="_blank" rel="noopener">Realizando Encuestas para Generación de Leads</a> <code>bruto/Biblioteca_de_Prompts/111_Realizando_Encuestas_para_Generación_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/112_Analizando_Métricas_de_Generación_de_Leads.md" target="_blank" rel="noopener">Analizando Métricas de Generación de Leads</a> <code>bruto/Biblioteca_de_Prompts/112_Analizando_Métricas_de_Generación_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/113_Desarrollo_de_Formularios_de_Captura_de_Leads.md" target="_blank" rel="noopener">Desarrollo de Formularios de Captura de Leads</a> <code>bruto/Biblioteca_de_Prompts/113_Desarrollo_de_Formularios_de_Captura_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/114_Investigación_Competidores_para_Captura_de_Leads.md" target="_blank" rel="noopener">Investigación Competidores para Captura de Leads</a> <code>bruto/Biblioteca_de_Prompts/114_Investigación_Competidores_para_Captura_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/115_Campañas_de_Correo_para_Nutrición_de_Leads.md" target="_blank" rel="noopener">Campañas de Correo para Nutrición de Leads</a> <code>bruto/Biblioteca_de_Prompts/115_Campañas_de_Correo_para_Nutrición_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/116_Conducción_de_Webinars_para_Generación_de_Leads.md" target="_blank" rel="noopener">Conducción de Webinars para Generación de Leads</a> <code>bruto/Biblioteca_de_Prompts/116_Conducción_de_Webinars_para_Generación_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/117_Palabras_Clave_para_Generación_de_Leads.md" target="_blank" rel="noopener">Palabras Clave para Generación de Leads</a> <code>bruto/Biblioteca_de_Prompts/117_Palabras_Clave_para_Generación_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/118_Creando_Lead_Magnets_Atractivos.md" target="_blank" rel="noopener">🔥 Creando Lead Magnets Atractivos</a> <code>bruto/Biblioteca_de_Prompts/118_Creando_Lead_Magnets_Atractivos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/119_Estrategias_de_Marketing_de_ReferenciaIncentivos.md" target="_blank" rel="noopener">Estrategias de Marketing de Referencia/Incentivos</a> <code>bruto/Biblioteca_de_Prompts/119_Estrategias_de_Marketing_de_ReferenciaIncentivos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/11_Generando_Ideas_para_Titulares.md" target="_blank" rel="noopener">🔥 Generando Ideas para Titulares</a> <code>bruto/Biblioteca_de_Prompts/11_Generando_Ideas_para_Titulares.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/120_Estrategias_en_Redes_para_Generación_de_Leads.md" target="_blank" rel="noopener">Estrategias en Redes para Generación de Leads</a> <code>bruto/Biblioteca_de_Prompts/120_Estrategias_en_Redes_para_Generación_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/121_Marketing_de_Relaciones_Públicas.md" target="_blank" rel="noopener">📣 Marketing de Relaciones Públicas</a> <code>bruto/Biblioteca_de_Prompts/121_Marketing_de_Relaciones_Públicas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/122_Mensajes_de_Marca_para_Relaciones_Públicas.md" target="_blank" rel="noopener">Mensajes de Marca para Relaciones Públicas</a> <code>bruto/Biblioteca_de_Prompts/122_Mensajes_de_Marca_para_Relaciones_Públicas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/123_Eventos_Para_Medios_y_Conferencias_de_Prensa.md" target="_blank" rel="noopener">Eventos Para Medios y Conferencias de Prensa</a> <code>bruto/Biblioteca_de_Prompts/123_Eventos_Para_Medios_y_Conferencias_de_Prensa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/124_Orientación_para_Gestión_de_Crisis.md" target="_blank" rel="noopener">Orientación para Gestión de Crisis</a> <code>bruto/Biblioteca_de_Prompts/124_Orientación_para_Gestión_de_Crisis.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/125_Estrategias_de_Colaboración_con_Influencers.md" target="_blank" rel="noopener">Estrategias de Colaboración con Influencers</a> <code>bruto/Biblioteca_de_Prompts/125_Estrategias_de_Colaboración_con_Influencers.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/126_Redes_Sociales_para_Relaciones_Públicas.md" target="_blank" rel="noopener">Redes Sociales para Relaciones Públicas</a> <code>bruto/Biblioteca_de_Prompts/126_Redes_Sociales_para_Relaciones_Públicas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/127_Creación_de_Oportunidades_de_Product_Placement.md" target="_blank" rel="noopener">Creación de Oportunidades de Product Placement</a> <code>bruto/Biblioteca_de_Prompts/127_Creación_de_Oportunidades_de_Product_Placement.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/128_Análisis_de_Métricas_de_Compromiso.md" target="_blank" rel="noopener">Análisis de Métricas de Compromiso</a> <code>bruto/Biblioteca_de_Prompts/128_Análisis_de_Métricas_de_Compromiso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/129_Comunicados_de_Prensa_para_un_Impacto_Máximo.md" target="_blank" rel="noopener">Comunicados de Prensa para un Impacto Máximo</a> <code>bruto/Biblioteca_de_Prompts/129_Comunicados_de_Prensa_para_un_Impacto_Máximo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/12_Escritura_Copia_de_Ventas_Centrada_en_Beneficios.md" target="_blank" rel="noopener">Escritura Copia de Ventas Centrada en Beneficios</a> <code>bruto/Biblioteca_de_Prompts/12_Escritura_Copia_de_Ventas_Centrada_en_Beneficios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/130_Creación_de_Ángulos_Atractivos_para_Historias.md" target="_blank" rel="noopener">🔥 Creación de Ángulos Atractivos para Historias</a> <code>bruto/Biblioteca_de_Prompts/130_Creación_de_Ángulos_Atractivos_para_Historias.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/131_Propuestas_para_Entradas_de_Blogs_Invitados.md" target="_blank" rel="noopener">Propuestas para Entradas de Blogs Invitados</a> <code>bruto/Biblioteca_de_Prompts/131_Propuestas_para_Entradas_de_Blogs_Invitados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/132_Contenido_para_Blogs_Empresariales.md" target="_blank" rel="noopener">Contenido para Blogs Empresariales</a> <code>bruto/Biblioteca_de_Prompts/132_Contenido_para_Blogs_Empresariales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/133_Entrevistas_y_Reportajes_para_Medios.md" target="_blank" rel="noopener">Entrevistas y Reportajes para Medios</a> <code>bruto/Biblioteca_de_Prompts/133_Entrevistas_y_Reportajes_para_Medios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/134_Identifica_Medios_de_Comunicación.md" target="_blank" rel="noopener">Identifica Medios de Comunicación</a> <code>bruto/Biblioteca_de_Prompts/134_Identifica_Medios_de_Comunicación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/135_Páginas_Web.md" target="_blank" rel="noopener">💻 Páginas Web</a> <code>bruto/Biblioteca_de_Prompts/135_Páginas_Web.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/136_Estrategias_de_Venta_Adicional_Upsell.md" target="_blank" rel="noopener">Estrategias de Venta Adicional (Upsell)</a> <code>bruto/Biblioteca_de_Prompts/136_Estrategias_de_Venta_Adicional_Upsell.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/137_Estrategias_de_Venta_Cruzada_Cross_Sell.md" target="_blank" rel="noopener">Estrategias de Venta Cruzada (Cross Sell)</a> <code>bruto/Biblioteca_de_Prompts/137_Estrategias_de_Venta_Cruzada_Cross_Sell.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/138_Escribe_Descripciones_de_Productos.md" target="_blank" rel="noopener">Escribe Descripciones de Productos</a> <code>bruto/Biblioteca_de_Prompts/138_Escribe_Descripciones_de_Productos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/139_Comparación_de_Productos.md" target="_blank" rel="noopener">Comparación de Productos</a> <code>bruto/Biblioteca_de_Prompts/139_Comparación_de_Productos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/13_Creación_de_Propuestas_Únicas_de_Venta_USP.md" target="_blank" rel="noopener">Creación de Propuestas Únicas de Venta (USP)</a> <code>bruto/Biblioteca_de_Prompts/13_Creación_de_Propuestas_Únicas_de_Venta_USP.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/140_Escribe_Reseñas_de_Productos.md" target="_blank" rel="noopener">Escribe Reseñas de Productos</a> <code>bruto/Biblioteca_de_Prompts/140_Escribe_Reseñas_de_Productos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/141_Estrategias_de_Agrupación_de_Productos_Bundling.md" target="_blank" rel="noopener">Estrategias de Agrupación de Productos (Bundling)</a> <code>bruto/Biblioteca_de_Prompts/141_Estrategias_de_Agrupación_de_Productos_Bundling.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/142_Beneficios_del_Producto_para_Landing_Page.md" target="_blank" rel="noopener">🔥 Beneficios del Producto para Landing Page</a> <code>bruto/Biblioteca_de_Prompts/142_Beneficios_del_Producto_para_Landing_Page.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/143_Escribe_Testimonios_de_Producto.md" target="_blank" rel="noopener">Escribe Testimonios de Producto</a> <code>bruto/Biblioteca_de_Prompts/143_Escribe_Testimonios_de_Producto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/144_Crea_Títulos_para_Landing_Pages.md" target="_blank" rel="noopener">Crea Títulos para Landing Pages</a> <code>bruto/Biblioteca_de_Prompts/144_Crea_Títulos_para_Landing_Pages.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/145_Generación_de_Ideas_de_Productos.md" target="_blank" rel="noopener">Generación de Ideas de Productos</a> <code>bruto/Biblioteca_de_Prompts/145_Generación_de_Ideas_de_Productos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/146_Tablas_de_Comparación_de_Productos.md" target="_blank" rel="noopener">Tablas de Comparación de Productos</a> <code>bruto/Biblioteca_de_Prompts/146_Tablas_de_Comparación_de_Productos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/147_Traducción_de_Contenido_para_Sitios_Web.md" target="_blank" rel="noopener">Traducción de Contenido para Sitios Web</a> <code>bruto/Biblioteca_de_Prompts/147_Traducción_de_Contenido_para_Sitios_Web.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/148_Redacción_de_Descripciones_de_Productos.md" target="_blank" rel="noopener">Redacción de Descripciones de Productos</a> <code>bruto/Biblioteca_de_Prompts/148_Redacción_de_Descripciones_de_Productos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/149_Creando_Ofertas_Irresistibles.md" target="_blank" rel="noopener">Creando Ofertas Irresistibles</a> <code>bruto/Biblioteca_de_Prompts/149_Creando_Ofertas_Irresistibles.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/14_Traducción_de_Anuncios_Publicitarios.md" target="_blank" rel="noopener">Traducción de Anuncios Publicitarios</a> <code>bruto/Biblioteca_de_Prompts/14_Traducción_de_Anuncios_Publicitarios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/150_Creando_Ideas_Visuales_para_Sitios_Web.md" target="_blank" rel="noopener">Creando Ideas Visuales para Sitios Web</a> <code>bruto/Biblioteca_de_Prompts/150_Creando_Ideas_Visuales_para_Sitios_Web.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/151_Optimización_de_Llamadas_a_la_Acción_CTA.md" target="_blank" rel="noopener">Optimización de Llamadas a la Acción (CTA)</a> <code>bruto/Biblioteca_de_Prompts/151_Optimización_de_Llamadas_a_la_Acción_CTA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/152_Generación_de_Ideas_de_Descuentos.md" target="_blank" rel="noopener">Generación de Ideas de Descuentos</a> <code>bruto/Biblioteca_de_Prompts/152_Generación_de_Ideas_de_Descuentos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/153_Influencer_Marketing.md" target="_blank" rel="noopener">💫 Influencer Marketing</a> <code>bruto/Biblioteca_de_Prompts/153_Influencer_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/154_Redacción_de_Propuesta_para_Influencer.md" target="_blank" rel="noopener">Redacción de Propuesta para Influencer</a> <code>bruto/Biblioteca_de_Prompts/154_Redacción_de_Propuesta_para_Influencer.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/155_Personalización_de_Mensajes_para_Influencers.md" target="_blank" rel="noopener">Personalización de Mensajes para Influencers</a> <code>bruto/Biblioteca_de_Prompts/155_Personalización_de_Mensajes_para_Influencers.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/156_Redacción_de_Briefs_Creativos_para_Influencers.md" target="_blank" rel="noopener">🔥 Redacción de Briefs Creativos para Influencers</a> <code>bruto/Biblioteca_de_Prompts/156_Redacción_de_Briefs_Creativos_para_Influencers.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/157_Automatización_de_Contacto_con_Influencers.md" target="_blank" rel="noopener">Automatización de Contacto con Influencers</a> <code>bruto/Biblioteca_de_Prompts/157_Automatización_de_Contacto_con_Influencers.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/158_Generación_de_Acuerdos_con_Influencers.md" target="_blank" rel="noopener">Generación de Acuerdos con Influencers</a> <code>bruto/Biblioteca_de_Prompts/158_Generación_de_Acuerdos_con_Influencers.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/159_Redacción_de_Informes_de_Rendimiento.md" target="_blank" rel="noopener">Redacción de Informes de Rendimiento</a> <code>bruto/Biblioteca_de_Prompts/159_Redacción_de_Informes_de_Rendimiento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/15_Redacción_de_Textos_de_Venta_de_Extensión_Media.md" target="_blank" rel="noopener">Redacción de Textos de Venta de Extensión Media</a> <code>bruto/Biblioteca_de_Prompts/15_Redacción_de_Textos_de_Venta_de_Extensión_Media.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/160_Identificación_de_Temas_en_Tendencia.md" target="_blank" rel="noopener">Identificación de Temas en Tendencia</a> <code>bruto/Biblioteca_de_Prompts/160_Identificación_de_Temas_en_Tendencia.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/161_Servicio_al_Cliente.md" target="_blank" rel="noopener">☎️ Servicio al Cliente</a> <code>bruto/Biblioteca_de_Prompts/161_Servicio_al_Cliente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/162_Resumen_de_Comentarios_de_Clientes.md" target="_blank" rel="noopener">Resumen de Comentarios de Clientes</a> <code>bruto/Biblioteca_de_Prompts/162_Resumen_de_Comentarios_de_Clientes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/163_Creación_de_Preguntas_Frecuentes_FAQ.md" target="_blank" rel="noopener">🔥 Creación de Preguntas Frecuentes (FAQ)</a> <code>bruto/Biblioteca_de_Prompts/163_Creación_de_Preguntas_Frecuentes_FAQ.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/164_Respuestas_a_Correos_Electrónicos_de_Clientes.md" target="_blank" rel="noopener">Respuestas a Correos Electrónicos de Clientes</a> <code>bruto/Biblioteca_de_Prompts/164_Respuestas_a_Correos_Electrónicos_de_Clientes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/165_Respuestas_a_Comentarios_con_IA.md" target="_blank" rel="noopener">Respuestas a Comentarios con IA</a> <code>bruto/Biblioteca_de_Prompts/165_Respuestas_a_Comentarios_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/166_Generación_de_Encuestas_de_Feedback_de_Productos.md" target="_blank" rel="noopener">Generación de Encuestas de Feedback de Productos</a> <code>bruto/Biblioteca_de_Prompts/166_Generación_de_Encuestas_de_Feedback_de_Productos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/167_Creación_de_Contenido_de_Consejos_sobre_Productos.md" target="_blank" rel="noopener">Creación de Contenido de Consejos sobre Productos</a> <code>bruto/Biblioteca_de_Prompts/167_Creación_de_Contenido_de_Consejos_sobre_Productos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/168_LinkedIn_Marketing.md" target="_blank" rel="noopener">💼 LinkedIn Marketing</a> <code>bruto/Biblioteca_de_Prompts/168_LinkedIn_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/169_Escritura_de_Publicaciones_en_LinkedIn.md" target="_blank" rel="noopener">🔥 Escritura de Publicaciones en LinkedIn</a> <code>bruto/Biblioteca_de_Prompts/169_Escritura_de_Publicaciones_en_LinkedIn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/16_Meta_-_Facebook_Ads.md" target="_blank" rel="noopener">💥 Meta - Facebook Ads</a> <code>bruto/Biblioteca_de_Prompts/16_Meta_-_Facebook_Ads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/170_Automatización_del_Crecimiento_de_Contenido.md" target="_blank" rel="noopener">Automatización del Crecimiento de Contenido</a> <code>bruto/Biblioteca_de_Prompts/170_Automatización_del_Crecimiento_de_Contenido.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/171_Generación_de_Ideas_de_Contenido_para_LinkedIn.md" target="_blank" rel="noopener">Generación de Ideas de Contenido para LinkedIn</a> <code>bruto/Biblioteca_de_Prompts/171_Generación_de_Ideas_de_Contenido_para_LinkedIn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/172_Crecimiento_en_LinkedIn_para_Empresas_B2B.md" target="_blank" rel="noopener">Crecimiento en LinkedIn para Empresas B2B</a> <code>bruto/Biblioteca_de_Prompts/172_Crecimiento_en_LinkedIn_para_Empresas_B2B.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/173_Construcción_de_Hashtags_para_LinkedIn.md" target="_blank" rel="noopener">Construcción de Hashtags para LinkedIn</a> <code>bruto/Biblioteca_de_Prompts/173_Construcción_de_Hashtags_para_LinkedIn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/174_Chatbots.md" target="_blank" rel="noopener">🤖 Chatbots</a> <code>bruto/Biblioteca_de_Prompts/174_Chatbots.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/175_Creando_Chatbots_para_Redes_Sociales.md" target="_blank" rel="noopener">Creando Chatbots para Redes Sociales</a> <code>bruto/Biblioteca_de_Prompts/175_Creando_Chatbots_para_Redes_Sociales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/176_Chatbot_con_Campañas_de_Marketing.md" target="_blank" rel="noopener">Chatbot con Campañas de Marketing</a> <code>bruto/Biblioteca_de_Prompts/176_Chatbot_con_Campañas_de_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/177_Análisis_de_las_Métricas_de_Conversión_del_Chatbot.md" target="_blank" rel="noopener">Análisis de las Métricas de Conversión del Chatbot</a> <code>bruto/Biblioteca_de_Prompts/177_Análisis_de_las_Métricas_de_Conversión_del_Chatbot.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/178_Implementación_de_Chatbots_para_Soporte_Web.md" target="_blank" rel="noopener">Implementación de Chatbots para Soporte Web</a> <code>bruto/Biblioteca_de_Prompts/178_Implementación_de_Chatbots_para_Soporte_Web.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/179_Flujos_de_Conversación_para_Chatbots.md" target="_blank" rel="noopener">🔥 Flujos de Conversación para Chatbots</a> <code>bruto/Biblioteca_de_Prompts/179_Flujos_de_Conversación_para_Chatbots.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/17_Escribir_Copia_de_Anuncio_que_Convierta.md" target="_blank" rel="noopener">🔥 Escribir Copia de Anuncio que Convierta</a> <code>bruto/Biblioteca_de_Prompts/17_Escribir_Copia_de_Anuncio_que_Convierta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/180_Chatbots_para_la_Generación_de_Leads.md" target="_blank" rel="noopener">Chatbots para la Generación de Leads</a> <code>bruto/Biblioteca_de_Prompts/180_Chatbots_para_la_Generación_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/181_Seguridad_y_Privacidad_de_Chatbots.md" target="_blank" rel="noopener">Seguridad y Privacidad de Chatbots</a> <code>bruto/Biblioteca_de_Prompts/181_Seguridad_y_Privacidad_de_Chatbots.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/182_Pruebas_de_Funcionalidad_y_Rendimiento_de_Chatbots.md" target="_blank" rel="noopener">Pruebas de Funcionalidad y Rendimiento de Chatbots</a> <code>bruto/Biblioteca_de_Prompts/182_Pruebas_de_Funcionalidad_y_Rendimiento_de_Chatbots.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/183_Personalización_según_la_Voz_y_Tono_de_la_Marca.md" target="_blank" rel="noopener">Personalización según la Voz y Tono de la Marca</a> <code>bruto/Biblioteca_de_Prompts/183_Personalización_según_la_Voz_y_Tono_de_la_Marca.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/184_Creación_de_Chatbots_para_Servicio_al_Cliente.md" target="_blank" rel="noopener">Creación de Chatbots para Servicio al Cliente</a> <code>bruto/Biblioteca_de_Prompts/184_Creación_de_Chatbots_para_Servicio_al_Cliente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/185_Chatbots_con_Procesamiento_de_Lenguaje_Natural.md" target="_blank" rel="noopener">Chatbots con Procesamiento de Lenguaje Natural</a> <code>bruto/Biblioteca_de_Prompts/185_Chatbots_con_Procesamiento_de_Lenguaje_Natural.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/186_Desarrollando_Chatbots_Multilingües.md" target="_blank" rel="noopener">Desarrollando Chatbots Multilingües</a> <code>bruto/Biblioteca_de_Prompts/186_Desarrollando_Chatbots_Multilingües.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/187_TikTik_Marketing.md" target="_blank" rel="noopener">🎶 TikTik Marketing</a> <code>bruto/Biblioteca_de_Prompts/187_TikTik_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/188_Creación_de_Ideas_de_Contenido_para_TikTok.md" target="_blank" rel="noopener">Creación de Ideas de Contenido para TikTok</a> <code>bruto/Biblioteca_de_Prompts/188_Creación_de_Ideas_de_Contenido_para_TikTok.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/189_Creación_de_Guiones_Virales_para_TikTok.md" target="_blank" rel="noopener">Creación de Guiones Virales para TikTok</a> <code>bruto/Biblioteca_de_Prompts/189_Creación_de_Guiones_Virales_para_TikTok.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/18_Investigar_Dolor_y_Deseos_de_Persona_Compradora.md" target="_blank" rel="noopener">Investigar Dolor y Deseos de Persona Compradora</a> <code>bruto/Biblioteca_de_Prompts/18_Investigar_Dolor_y_Deseos_de_Persona_Compradora.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/190_Ideas_Creativas_para_las_Tendencias_de_TikTok.md" target="_blank" rel="noopener">Ideas Creativas para las Tendencias de TikTok</a> <code>bruto/Biblioteca_de_Prompts/190_Ideas_Creativas_para_las_Tendencias_de_TikTok.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/191_Varios.md" target="_blank" rel="noopener">🪄 Varios</a> <code>bruto/Biblioteca_de_Prompts/191_Varios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/192_Propuesta_para_un_Cliente_Potencial.md" target="_blank" rel="noopener">Propuesta para un Cliente Potencial</a> <code>bruto/Biblioteca_de_Prompts/192_Propuesta_para_un_Cliente_Potencial.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/193_Genera_e_Interpreta_Palabras_Clave_Keywords.md" target="_blank" rel="noopener">Genera e Interpreta Palabras Clave (Keywords)</a> <code>bruto/Biblioteca_de_Prompts/193_Genera_e_Interpreta_Palabras_Clave_Keywords.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/194_Creando_un_Buyer_Persona.md" target="_blank" rel="noopener">🔥 Creando un Buyer Persona</a> <code>bruto/Biblioteca_de_Prompts/194_Creando_un_Buyer_Persona.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/195_Genera_Ideas_Para_Encuestas_a_Clientes.md" target="_blank" rel="noopener">Genera Ideas Para Encuestas a Clientes</a> <code>bruto/Biblioteca_de_Prompts/195_Genera_Ideas_Para_Encuestas_a_Clientes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/196_Desarrolla_Estrategias_de_Retención_de_Clientes.md" target="_blank" rel="noopener">Desarrolla Estrategias de Retención de Clientes</a> <code>bruto/Biblioteca_de_Prompts/196_Desarrolla_Estrategias_de_Retención_de_Clientes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/197_Idea_Negocios_sin_Financiamiento.md" target="_blank" rel="noopener">Idea Negocios sin Financiamiento</a> <code>bruto/Biblioteca_de_Prompts/197_Idea_Negocios_sin_Financiamiento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/198_Resume_Apuntes_de_Reuniones.md" target="_blank" rel="noopener">Resume Apuntes de Reuniones</a> <code>bruto/Biblioteca_de_Prompts/198_Resume_Apuntes_de_Reuniones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/199_Desarrolla_una_Voz_de_Marca_y_Tono.md" target="_blank" rel="noopener">Desarrolla una Voz de Marca y Tono</a> <code>bruto/Biblioteca_de_Prompts/199_Desarrolla_una_Voz_de_Marca_y_Tono.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/19_Redacción_de_un_Brief_para_un_Editor_de_Video.md" target="_blank" rel="noopener">Redacción de un Brief para un Editor de Video</a> <code>bruto/Biblioteca_de_Prompts/19_Redacción_de_un_Brief_para_un_Editor_de_Video.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/200_Analizando_a_tu_Competencia.md" target="_blank" rel="noopener">Analizando a tu Competencia</a> <code>bruto/Biblioteca_de_Prompts/200_Analizando_a_tu_Competencia.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/20_Generación_de_Imágenes_que_Captan_la_Atención.md" target="_blank" rel="noopener">Generación de Imágenes que Captan la Atención</a> <code>bruto/Biblioteca_de_Prompts/20_Generación_de_Imágenes_que_Captan_la_Atención.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/21_Generación_de_Ideas_para_Ángulos_de_Marketing.md" target="_blank" rel="noopener">Generación de Ideas para Ángulos de Marketing</a> <code>bruto/Biblioteca_de_Prompts/21_Generación_de_Ideas_para_Ángulos_de_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/22_Reescribiendo_Versión_AB_de_Creativo_Ganador.md" target="_blank" rel="noopener">Reescribiendo Versión A/B de Creativo Ganador</a> <code>bruto/Biblioteca_de_Prompts/22_Reescribiendo_Versión_AB_de_Creativo_Ganador.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/23_Email_Marketing.md" target="_blank" rel="noopener">✉️ Email Marketing</a> <code>bruto/Biblioteca_de_Prompts/23_Email_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/24_Redacción_de_líneas_de_asunto_para_correos.md" target="_blank" rel="noopener">Redacción de líneas de asunto para correos</a> <code>bruto/Biblioteca_de_Prompts/24_Redacción_de_líneas_de_asunto_para_correos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/25_Redacción_de_correos_electrónicos_de_ventas.md" target="_blank" rel="noopener">Redacción de correos electrónicos de ventas</a> <code>bruto/Biblioteca_de_Prompts/25_Redacción_de_correos_electrónicos_de_ventas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/26_Generando_Ideas_para_Boletines_de_Correo.md" target="_blank" rel="noopener">Generando Ideas para Boletines de Correo</a> <code>bruto/Biblioteca_de_Prompts/26_Generando_Ideas_para_Boletines_de_Correo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/27_Redacción_de_Boletines.md" target="_blank" rel="noopener">Redacción de Boletines</a> <code>bruto/Biblioteca_de_Prompts/27_Redacción_de_Boletines.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/28_Generación_de_Ideas_para_Campañas_de_Correo.md" target="_blank" rel="noopener">🔥 Generación de Ideas para Campañas de Correo</a> <code>bruto/Biblioteca_de_Prompts/28_Generación_de_Ideas_para_Campañas_de_Correo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/29_Ideas_de_Imanes_de_Clientes_Lead_Magnets.md" target="_blank" rel="noopener">Ideas de Imanes de Clientes (Lead Magnets)</a> <code>bruto/Biblioteca_de_Prompts/29_Ideas_de_Imanes_de_Clientes_Lead_Magnets.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/30_Redacción_de_Correos_Electrónicos_de_Lanzamiento.md" target="_blank" rel="noopener">Redacción de Correos Electrónicos de Lanzamiento</a> <code>bruto/Biblioteca_de_Prompts/30_Redacción_de_Correos_Electrónicos_de_Lanzamiento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/31_Construcción_de_Automatizaciones_de_Correo.md" target="_blank" rel="noopener">Construcción de Automatizaciones de Correo</a> <code>bruto/Biblioteca_de_Prompts/31_Construcción_de_Automatizaciones_de_Correo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/32_Generación_de_Copias_para_Correos_Fríos.md" target="_blank" rel="noopener">Generación de Copias para Correos Fríos</a> <code>bruto/Biblioteca_de_Prompts/32_Generación_de_Copias_para_Correos_Fríos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/33_Marketing_por_SMS.md" target="_blank" rel="noopener">Marketing por SMS</a> <code>bruto/Biblioteca_de_Prompts/33_Marketing_por_SMS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/34_Realización_de_Pruebas_AB.md" target="_blank" rel="noopener">Realización de Pruebas A/B</a> <code>bruto/Biblioteca_de_Prompts/34_Realización_de_Pruebas_AB.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/35_Correos_de_Recuperación_de_Carritos_Abandonados.md" target="_blank" rel="noopener">Correos de Recuperación de Carritos Abandonados</a> <code>bruto/Biblioteca_de_Prompts/35_Correos_de_Recuperación_de_Carritos_Abandonados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/36_Generando_Secuencias_de_Seguimiento_por_Correo.md" target="_blank" rel="noopener">Generando Secuencias de Seguimiento por Correo</a> <code>bruto/Biblioteca_de_Prompts/36_Generando_Secuencias_de_Seguimiento_por_Correo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/37_SEO.md" target="_blank" rel="noopener">♻️ SEO</a> <code>bruto/Biblioteca_de_Prompts/37_SEO.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/38_Generando_Ideas_de_Contenido.md" target="_blank" rel="noopener">Generando Ideas de Contenido</a> <code>bruto/Biblioteca_de_Prompts/38_Generando_Ideas_de_Contenido.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/39_Optimización_SEO.md" target="_blank" rel="noopener">🔥 Optimización SEO</a> <code>bruto/Biblioteca_de_Prompts/39_Optimización_SEO.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/40_Escribiendo_Entradas_de_Blog.md" target="_blank" rel="noopener">Escribiendo Entradas de Blog</a> <code>bruto/Biblioteca_de_Prompts/40_Escribiendo_Entradas_de_Blog.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/41_Generando_Ideas_de_Citas_para_Negocios_Locales.md" target="_blank" rel="noopener">Generando Ideas de Citas para Negocios Locales</a> <code>bruto/Biblioteca_de_Prompts/41_Generando_Ideas_de_Citas_para_Negocios_Locales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/42_Realizando_Investigación_de_Backlinks.md" target="_blank" rel="noopener">Realizando Investigación de Backlinks</a> <code>bruto/Biblioteca_de_Prompts/42_Realizando_Investigación_de_Backlinks.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/43_Creando_Redirecciones_301.md" target="_blank" rel="noopener">Creando Redirecciones 301</a> <code>bruto/Biblioteca_de_Prompts/43_Creando_Redirecciones_301.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/44_Ideas_para_mi_Listado_Empresarial_en_Google.md" target="_blank" rel="noopener">Ideas para mi Listado Empresarial en Google</a> <code>bruto/Biblioteca_de_Prompts/44_Ideas_para_mi_Listado_Empresarial_en_Google.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/45_Realizando_Análisis_de_Competencia.md" target="_blank" rel="noopener">Realizando Análisis de Competencia</a> <code>bruto/Biblioteca_de_Prompts/45_Realizando_Análisis_de_Competencia.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/46_Creando_Mapas_del_Sitio.md" target="_blank" rel="noopener">Creando Mapas del Sitio</a> <code>bruto/Biblioteca_de_Prompts/46_Creando_Mapas_del_Sitio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/47_Creación_de_Descripciones_Meta.md" target="_blank" rel="noopener">Creación de Descripciones Meta</a> <code>bruto/Biblioteca_de_Prompts/47_Creación_de_Descripciones_Meta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/48_Optimización_del_Contenido_del_Sitio_Web.md" target="_blank" rel="noopener">Optimización del Contenido del Sitio Web</a> <code>bruto/Biblioteca_de_Prompts/48_Optimización_del_Contenido_del_Sitio_Web.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/49_Seguimiento_de_Palabras_Clave_de_Competidores.md" target="_blank" rel="noopener">Seguimiento de Palabras Clave de Competidores</a> <code>bruto/Biblioteca_de_Prompts/49_Seguimiento_de_Palabras_Clave_de_Competidores.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/50_Creación_de_Etiquetas_de_Título.md" target="_blank" rel="noopener">Creación de Etiquetas de Título</a> <code>bruto/Biblioteca_de_Prompts/50_Creación_de_Etiquetas_de_Título.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/51_Redes_Sociales.md" target="_blank" rel="noopener">💬 Redes Sociales</a> <code>bruto/Biblioteca_de_Prompts/51_Redes_Sociales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/52_Generación_de_Ideas_de_Contenido_Atractivas.md" target="_blank" rel="noopener">🔥 Generación de Ideas de Contenido Atractivas</a> <code>bruto/Biblioteca_de_Prompts/52_Generación_de_Ideas_de_Contenido_Atractivas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/53_Creando_Docenas_de_Captions_Para_RRSS.md" target="_blank" rel="noopener">Creando Docenas de Captions Para RRSS</a> <code>bruto/Biblioteca_de_Prompts/53_Creando_Docenas_de_Captions_Para_RRSS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/54_Automatización_del_Crecimiento_en_Instagram.md" target="_blank" rel="noopener">Automatización del Crecimiento en Instagram</a> <code>bruto/Biblioteca_de_Prompts/54_Automatización_del_Crecimiento_en_Instagram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/55_Creación_de_Podcasts.md" target="_blank" rel="noopener">Creación de Podcasts</a> <code>bruto/Biblioteca_de_Prompts/55_Creación_de_Podcasts.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/56_Automatización_del_Crecimiento_Canal_de_YouTube.md" target="_blank" rel="noopener">Automatización del Crecimiento Canal de YouTube</a> <code>bruto/Biblioteca_de_Prompts/56_Automatización_del_Crecimiento_Canal_de_YouTube.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/57_Generación_de_Ideas_para_Tableros_de_Pinterest.md" target="_blank" rel="noopener">Generación de Ideas para Tableros de Pinterest</a> <code>bruto/Biblioteca_de_Prompts/57_Generación_de_Ideas_para_Tableros_de_Pinterest.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/58_Automatización_del_Crecimiento_en_TikTok.md" target="_blank" rel="noopener">Automatización del Crecimiento en TikTok</a> <code>bruto/Biblioteca_de_Prompts/58_Automatización_del_Crecimiento_en_TikTok.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/59_Generación_de_Ideas_para_Transmisiones_en_Vivo.md" target="_blank" rel="noopener">Generación de Ideas para Transmisiones en Vivo</a> <code>bruto/Biblioteca_de_Prompts/59_Generación_de_Ideas_para_Transmisiones_en_Vivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/60_YouTube_Marketing.md" target="_blank" rel="noopener">🎥 YouTube Marketing</a> <code>bruto/Biblioteca_de_Prompts/60_YouTube_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/61_Creación_de_Guiones_Videos_de_YouTube.md" target="_blank" rel="noopener">Creación de Guiones Videos de YouTube</a> <code>bruto/Biblioteca_de_Prompts/61_Creación_de_Guiones_Videos_de_YouTube.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/62_Descripción_de_Videos.md" target="_blank" rel="noopener">🔥 Descripción de Videos</a> <code>bruto/Biblioteca_de_Prompts/62_Descripción_de_Videos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/63_Automatización_del_Crecimiento_en_YouTube.md" target="_blank" rel="noopener">Automatización del Crecimiento en YouTube</a> <code>bruto/Biblioteca_de_Prompts/63_Automatización_del_Crecimiento_en_YouTube.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/64_Marketing_de_Contenido.md" target="_blank" rel="noopener">📃 Marketing de Contenido</a> <code>bruto/Biblioteca_de_Prompts/64_Marketing_de_Contenido.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/65_Escribir_Propuestas_de_Artículos_de_Invitado.md" target="_blank" rel="noopener">Escribir Propuestas de Artículos de Invitado</a> <code>bruto/Biblioteca_de_Prompts/65_Escribir_Propuestas_de_Artículos_de_Invitado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/66_Escribir_Artículos_de_Invitado.md" target="_blank" rel="noopener">Escribir Artículos de Invitado</a> <code>bruto/Biblioteca_de_Prompts/66_Escribir_Artículos_de_Invitado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/67_Desarrollo_de_Calendarios_de_Contenido.md" target="_blank" rel="noopener">🔥Desarrollo de Calendarios de Contenido</a> <code>bruto/Biblioteca_de_Prompts/67_Desarrollo_de_Calendarios_de_Contenido.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/68_Generación_de_Ideas_para_Lead_Magnets.md" target="_blank" rel="noopener">Generación de Ideas para Lead Magnets</a> <code>bruto/Biblioteca_de_Prompts/68_Generación_de_Ideas_para_Lead_Magnets.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/69_Generación_de_Esquemas_para_Publicaciones_de_Blog.md" target="_blank" rel="noopener">Generación de Esquemas para Publicaciones de Blog</a> <code>bruto/Biblioteca_de_Prompts/69_Generación_de_Esquemas_para_Publicaciones_de_Blog.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/70_Creación_de_Infografías.md" target="_blank" rel="noopener">Creación de Infografías</a> <code>bruto/Biblioteca_de_Prompts/70_Creación_de_Infografías.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/71_Twitter_X_Marketing.md" target="_blank" rel="noopener">🐤 Twitter (X) Marketing</a> <code>bruto/Biblioteca_de_Prompts/71_Twitter_X_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/72_Escribiendo_Hilos_en_Twitter.md" target="_blank" rel="noopener">🔥 Escribiendo Hilos en Twitter</a> <code>bruto/Biblioteca_de_Prompts/72_Escribiendo_Hilos_en_Twitter.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/73_Automatización_del_Crecimiento_en_Twitter.md" target="_blank" rel="noopener">Automatización del Crecimiento en Twitter</a> <code>bruto/Biblioteca_de_Prompts/73_Automatización_del_Crecimiento_en_Twitter.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/74_Generación_de_Leads_en_Twitter.md" target="_blank" rel="noopener">Generación de Leads en Twitter</a> <code>bruto/Biblioteca_de_Prompts/74_Generación_de_Leads_en_Twitter.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/75_Escritura_de_Contenido_para_Twitter.md" target="_blank" rel="noopener">Escritura de Contenido para Twitter</a> <code>bruto/Biblioteca_de_Prompts/75_Escritura_de_Contenido_para_Twitter.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/76_Optimización_de_Perfiles_en_Twitter.md" target="_blank" rel="noopener">Optimización de Perfiles en Twitter</a> <code>bruto/Biblioteca_de_Prompts/76_Optimización_de_Perfiles_en_Twitter.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/77_Cómo_Hacer_que_tus_Tweets_se_Vuelvan_Virales.md" target="_blank" rel="noopener">Cómo Hacer que tus Tweets se Vuelvan Virales</a> <code>bruto/Biblioteca_de_Prompts/77_Cómo_Hacer_que_tus_Tweets_se_Vuelvan_Virales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/78_Automatización_del_Crecimiento_para_Empresas_B2B.md" target="_blank" rel="noopener">Automatización del Crecimiento para Empresas B2B</a> <code>bruto/Biblioteca_de_Prompts/78_Automatización_del_Crecimiento_para_Empresas_B2B.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/79_Investigación_Ads.md" target="_blank" rel="noopener">🔍 Investigación Ads</a> <code>bruto/Biblioteca_de_Prompts/79_Investigación_Ads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/80_Segmentación_de_Ads_en_Pinterest.md" target="_blank" rel="noopener">Segmentación de Ads en Pinterest</a> <code>bruto/Biblioteca_de_Prompts/80_Segmentación_de_Ads_en_Pinterest.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/81_Segmentación_de_Ads_en_X_Twitter.md" target="_blank" rel="noopener">Segmentación de Ads en X (Twitter)</a> <code>bruto/Biblioteca_de_Prompts/81_Segmentación_de_Ads_en_X_Twitter.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/82_Segmentación_de_Ads_en_Instagram.md" target="_blank" rel="noopener">Segmentación de Ads en Instagram</a> <code>bruto/Biblioteca_de_Prompts/82_Segmentación_de_Ads_en_Instagram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/83_Segmentación_de_Ads_en_LinkedIn.md" target="_blank" rel="noopener">Segmentación de Ads en LinkedIn</a> <code>bruto/Biblioteca_de_Prompts/83_Segmentación_de_Ads_en_LinkedIn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/84_Ideas_para_Textos_Publicitarios.md" target="_blank" rel="noopener">Ideas para Textos Publicitarios</a> <code>bruto/Biblioteca_de_Prompts/84_Ideas_para_Textos_Publicitarios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/85_Investigación_de_Palabras_Clave.md" target="_blank" rel="noopener">🔥 Investigación de Palabras Clave</a> <code>bruto/Biblioteca_de_Prompts/85_Investigación_de_Palabras_Clave.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/86_Análisis_del_Rendimiento_de_Anuncios.md" target="_blank" rel="noopener">Análisis del Rendimiento de Anuncios</a> <code>bruto/Biblioteca_de_Prompts/86_Análisis_del_Rendimiento_de_Anuncios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/87_Palabras_Clave_para_Ads_de_Google.md" target="_blank" rel="noopener">Palabras Clave para Ads de Google</a> <code>bruto/Biblioteca_de_Prompts/87_Palabras_Clave_para_Ads_de_Google.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/88_Marketing_de_Afiliados.md" target="_blank" rel="noopener">👥 Marketing de Afiliados</a> <code>bruto/Biblioteca_de_Prompts/88_Marketing_de_Afiliados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/89_Optimización_para_Conversiones.md" target="_blank" rel="noopener">Optimización para Conversiones</a> <code>bruto/Biblioteca_de_Prompts/89_Optimización_para_Conversiones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/90_Buscar_Nuevos_Afiliados.md" target="_blank" rel="noopener">Buscar Nuevos Afiliados</a> <code>bruto/Biblioteca_de_Prompts/90_Buscar_Nuevos_Afiliados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/91_Desarrollo_de_Nuevas_Ofertas.md" target="_blank" rel="noopener">Desarrollo de Nuevas Ofertas</a> <code>bruto/Biblioteca_de_Prompts/91_Desarrollo_de_Nuevas_Ofertas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/92_Gestión_de_Relaciones_con_Afiliados.md" target="_blank" rel="noopener">Gestión de Relaciones con Afiliados</a> <code>bruto/Biblioteca_de_Prompts/92_Gestión_de_Relaciones_con_Afiliados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/93_Análisis_de_Métricas_de_Rendimiento.md" target="_blank" rel="noopener">Análisis de Métricas de Rendimiento</a> <code>bruto/Biblioteca_de_Prompts/93_Análisis_de_Métricas_de_Rendimiento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/94_Organización_de_Webinars_para_Afiliados.md" target="_blank" rel="noopener">Organización de Webinars para Afiliados</a> <code>bruto/Biblioteca_de_Prompts/94_Organización_de_Webinars_para_Afiliados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/95_Creación_de_Programas_de_Incentivos.md" target="_blank" rel="noopener">Creación de Programas de Incentivos</a> <code>bruto/Biblioteca_de_Prompts/95_Creación_de_Programas_de_Incentivos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/96_Identificación_de_Afiliados_de_Alto_Rendimiento.md" target="_blank" rel="noopener">Identificación de Afiliados de Alto Rendimiento</a> <code>bruto/Biblioteca_de_Prompts/96_Identificación_de_Afiliados_de_Alto_Rendimiento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/97_Negociando_Tarifas_de_Comisión.md" target="_blank" rel="noopener">Negociando Tarifas de Comisión</a> <code>bruto/Biblioteca_de_Prompts/97_Negociando_Tarifas_de_Comisión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/98_Monitoreo_de_Cumplimiento.md" target="_blank" rel="noopener">Monitoreo de Cumplimiento</a> <code>bruto/Biblioteca_de_Prompts/98_Monitoreo_de_Cumplimiento.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Biblioteca_de_Prompts/99_Gestión_de_Relaciones_con_Afiliados.md" target="_blank" rel="noopener">Gestión de Relaciones con Afiliados</a> <code>bruto/Biblioteca_de_Prompts/99_Gestión_de_Relaciones_con_Afiliados.md</code></li>
</ul>$lf_module_31$,
    50,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-curso-obsoleto-agentes-ia-relevance-desde-0',
    'imperio-agentico',
    'CURSO OBSOLETO Agentes IA Relevance Desde 0',
    '🏛️',
    '18 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_32$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> CURSO OBSOLETO Agentes IA Relevance Desde 0 · 18 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/01_CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0.md" target="_blank" rel="noopener">(CURSO OBSOLETO) Agentes IA: Relevance Desde 0</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/01_CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/02_Mira_esto_primero.md" target="_blank" rel="noopener">➡️Mira esto primero</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/02_Mira_esto_primero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/03_Intro_a_Relevance_AI.md" target="_blank" rel="noopener">📘Intro a Relevance AI</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/03_Intro_a_Relevance_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/04_Templates_en_Relevance_AI.md" target="_blank" rel="noopener">🧩Templates en Relevance AI</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/04_Templates_en_Relevance_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/05_Creación_de_Agentes_IA.md" target="_blank" rel="noopener">🤖Creación de Agentes IA</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/05_Creación_de_Agentes_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/06_Intro_a_las_Tools.md" target="_blank" rel="noopener">🛠️Intro a las Tools</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/06_Intro_a_las_Tools.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/07_Diseño_de_Tools.md" target="_blank" rel="noopener">🎨Diseño de Tools</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/07_Diseño_de_Tools.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/08_Asistente_Personal_en_WhatsApp.md" target="_blank" rel="noopener">📱Asistente Personal en WhatsApp</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/08_Asistente_Personal_en_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/09_Consulta_Disponibilidad_en_Google_Calendar.md" target="_blank" rel="noopener">🗓️Consulta Disponibilidad en Google Calendar</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/09_Consulta_Disponibilidad_en_Google_Calendar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/10_Creación_de_Eventos_en_Google_Calendar.md" target="_blank" rel="noopener">✍️Creación de Eventos en Google Calendar</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/10_Creación_de_Eventos_en_Google_Calendar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/11_Ajustes_Avanzados_en_Google_Calendar.md" target="_blank" rel="noopener">⚙️Ajustes Avanzados en Google Calendar</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/11_Ajustes_Avanzados_en_Google_Calendar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/12_Automatización_de_Emails.md" target="_blank" rel="noopener">📤Automatización de Emails</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/12_Automatización_de_Emails.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/13_Creación_de_Subagentes.md" target="_blank" rel="noopener">🔗Creación de Subagentes</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/13_Creación_de_Subagentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/14_Despliegue_de_Agentes_en_WhatsApp_con_Whapi.md" target="_blank" rel="noopener">🌐Despliegue de Agentes en WhatsApp con Whapi</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/14_Despliegue_de_Agentes_en_WhatsApp_con_Whapi.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/15_Hilos_de_Conversación_en_WhatsApp.md" target="_blank" rel="noopener">💬Hilos de Conversación en WhatsApp</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/15_Hilos_de_Conversación_en_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/16_Recibe_Mensajes_de_Voz_en_WhatsApp.md" target="_blank" rel="noopener">🎙️Recibe Mensajes de Voz en WhatsApp</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/16_Recibe_Mensajes_de_Voz_en_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/17_Deploy_de_Agentes_en_Web_y_Correo_Electrónico.md" target="_blank" rel="noopener">🚀Deploy de Agentes en Web y Correo Electrónico</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/17_Deploy_de_Agentes_en_Web_y_Correo_Electrónico.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/18_Recursos_Plantillas.md" target="_blank" rel="noopener">📂Recursos &amp; Plantillas</a> <code>bruto/CURSO_OBSOLETO_Agentes_IA_Relevance_Desde_0/18_Recursos_Plantillas.md</code></li>
</ul>$lf_module_32$,
    60,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-claude-code',
    'imperio-agentico',
    'Claude Code',
    '🏛️',
    '39 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_33$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Claude Code · 39 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/01_Claude_Code.md" target="_blank" rel="noopener">Claude Code</a> <code>bruto/Claude_Code/01_Claude_Code.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/02_CURSO_COMPLETO_Claude_Code_3hrs.md" target="_blank" rel="noopener">👾 CURSO COMPLETO Claude Code (+3hrs)</a> <code>bruto/Claude_Code/02_CURSO_COMPLETO_Claude_Code_3hrs.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/03_Ads_Cinemáticos_con_Higgsfield_Claude_Code.md" target="_blank" rel="noopener">Ads Cinemáticos con Higgsfield + Claude Code</a> <code>bruto/Claude_Code/03_Ads_Cinemáticos_con_Higgsfield_Claude_Code.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/04_Playwright_Automatiza_lo_que_Claude_Code_no_podía.md" target="_blank" rel="noopener">Playwright: Automatiza lo que Claude Code no podía</a> <code>bruto/Claude_Code/04_Playwright_Automatiza_lo_que_Claude_Code_no_podía.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/05_Go_High_Level_Claude_Code_Funnels_de_10k.md" target="_blank" rel="noopener">Go High Level + Claude Code = Funnels de 10k</a> <code>bruto/Claude_Code/05_Go_High_Level_Claude_Code_Funnels_de_10k.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/06_Obsidian_Claude_Code_Memoria_Infinita.md" target="_blank" rel="noopener">Obsidian + Claude Code = Memoria Infinita</a> <code>bruto/Claude_Code/06_Obsidian_Claude_Code_Memoria_Infinita.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/07_Claude_Design_La_NUEVA_forma_de_diseñar.md" target="_blank" rel="noopener">Claude Design: La NUEVA forma de diseñar</a> <code>bruto/Claude_Code/07_Claude_Design_La_NUEVA_forma_de_diseñar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/08_Guía_completa_de_sesiones_en_Claude_Code.md" target="_blank" rel="noopener">Guía completa de sesiones en Claude Code</a> <code>bruto/Claude_Code/08_Guía_completa_de_sesiones_en_Claude_Code.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/09_Meta_Ads_Manager_Claude_Code_Media_Buyer.md" target="_blank" rel="noopener">Meta Ads Manager + Claude Code = Media Buyer</a> <code>bruto/Claude_Code/09_Meta_Ads_Manager_Claude_Code_Media_Buyer.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/10_Control_Remoto_controla_tu_PC_desde_el_celular.md" target="_blank" rel="noopener">Control Remoto: controla tu PC desde el celular</a> <code>bruto/Claude_Code/10_Control_Remoto_controla_tu_PC_desde_el_celular.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/11_Claude_Skills_qué_son.md" target="_blank" rel="noopener">Claude Skills... ¿qué son?</a> <code>bruto/Claude_Code/11_Claude_Skills_qué_son.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/12_Introducción_500_habilidades.md" target="_blank" rel="noopener">Introducción + 500 habilidades</a> <code>bruto/Claude_Code/12_Introducción_500_habilidades.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/13_Higgsfield_MCP_Claude_Code_Agencia_Creativa.md" target="_blank" rel="noopener">Higgsfield MCP + Claude Code = Agencia Creativa</a> <code>bruto/Claude_Code/13_Higgsfield_MCP_Claude_Code_Agencia_Creativa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/14_Claude_Skills.md" target="_blank" rel="noopener">Claude Skills</a> <code>bruto/Claude_Code/14_Claude_Skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/15_CÓMO_FUNCIONA.md" target="_blank" rel="noopener">CÓMO FUNCIONA</a> <code>bruto/Claude_Code/15_CÓMO_FUNCIONA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/16_IA_y_Tecnología_4_skills.md" target="_blank" rel="noopener">🤖 IA y Tecnología (4 skills)</a> <code>bruto/Claude_Code/16_IA_y_Tecnología_4_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/17_Ads_y_Medios_Pagados_22_skills.md" target="_blank" rel="noopener">📢 Ads y Medios Pagados (22 skills)</a> <code>bruto/Claude_Code/17_Ads_y_Medios_Pagados_22_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/18_Analítica_y_Datos_22_skills.md" target="_blank" rel="noopener">📊 Analítica y Datos (22 skills)</a> <code>bruto/Claude_Code/18_Analítica_y_Datos_22_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/19_Branding_y_Diseño_24_skills.md" target="_blank" rel="noopener">🎨 Branding y Diseño (24 skills)</a> <code>bruto/Claude_Code/19_Branding_y_Diseño_24_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/20_Cliente_y_Consultoría_18_skills.md" target="_blank" rel="noopener">🤝 Cliente y Consultoría (18 skills)</a> <code>bruto/Claude_Code/20_Cliente_y_Consultoría_18_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/21_Contenido_y_Copywriting_57_skills.md" target="_blank" rel="noopener">✍️ Contenido y Copywriting (57 skills)</a> <code>bruto/Claude_Code/21_Contenido_y_Copywriting_57_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/22_Cursos_y_Educación_20_skills.md" target="_blank" rel="noopener">🎓 Cursos y Educación (20 skills)</a> <code>bruto/Claude_Code/22_Cursos_y_Educación_20_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/23_E-commerce_y_Productos_24_skills.md" target="_blank" rel="noopener">🛒 E-commerce y Productos (24 skills)</a> <code>bruto/Claude_Code/23_E-commerce_y_Productos_24_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/24_Email_Marketing_42_skills.md" target="_blank" rel="noopener">📧 Email Marketing (42 skills)</a> <code>bruto/Claude_Code/24_Email_Marketing_42_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/25_Eventos_y_Oratoria_24_skills.md" target="_blank" rel="noopener">🎤 Eventos y Oratoria (24 skills)</a> <code>bruto/Claude_Code/25_Eventos_y_Oratoria_24_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/26_Finanzas_y_Precios_28_skills.md" target="_blank" rel="noopener">💰 Finanzas y Precios (28 skills)</a> <code>bruto/Claude_Code/26_Finanzas_y_Precios_28_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/27_RRHH_y_Equipo_29_skills.md" target="_blank" rel="noopener">👥 RRHH y Equipo (29 skills)</a> <code>bruto/Claude_Code/27_RRHH_y_Equipo_29_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/28_Industrias_Específicas_15_skills.md" target="_blank" rel="noopener">🏭 Industrias Específicas (15 skills)</a> <code>bruto/Claude_Code/28_Industrias_Específicas_15_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/29_Lanzamiento_y_Crecimiento_24_skills.md" target="_blank" rel="noopener">🚀 Lanzamiento y Crecimiento (24 skills)</a> <code>bruto/Claude_Code/29_Lanzamiento_y_Crecimiento_24_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/30_Legal_y_Cumplimiento_30_skills.md" target="_blank" rel="noopener">⚖️ Legal y Cumplimiento (30 skills)</a> <code>bruto/Claude_Code/30_Legal_y_Cumplimiento_30_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/31_ONG_y_Comunidad_2_skills.md" target="_blank" rel="noopener">💚 ONG y Comunidad (2 skills)</a> <code>bruto/Claude_Code/31_ONG_y_Comunidad_2_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/32_Operaciones_y_Sistemas_30_skills.md" target="_blank" rel="noopener">⚙️ Operaciones y Sistemas (30 skills)</a> <code>bruto/Claude_Code/32_Operaciones_y_Sistemas_30_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/33_SEO_y_Búsqueda_20_skills.md" target="_blank" rel="noopener">🔍 SEO y Búsqueda (20 skills)</a> <code>bruto/Claude_Code/33_SEO_y_Búsqueda_20_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/34_Redes_Sociales_38_skills.md" target="_blank" rel="noopener">📱 Redes Sociales (38 skills)</a> <code>bruto/Claude_Code/34_Redes_Sociales_38_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/35_Ventas_y_Embudos_31_skills.md" target="_blank" rel="noopener">💼 Ventas y Embudos (31 skills)</a> <code>bruto/Claude_Code/35_Ventas_y_Embudos_31_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/36_Claude_Skills_x_Imperiales_pronto.md" target="_blank" rel="noopener">Claude Skills x Imperiales (pronto)</a> <code>bruto/Claude_Code/36_Claude_Skills_x_Imperiales_pronto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/37_Framework_SMART.md" target="_blank" rel="noopener">Framework SMART</a> <code>bruto/Claude_Code/37_Framework_SMART.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/38_Instala_tu_Motor_Agéntico.md" target="_blank" rel="noopener">Instala tu Motor Agéntico</a> <code>bruto/Claude_Code/38_Instala_tu_Motor_Agéntico.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Code/39_Graphify_como_segundo_cerebro_Ahorra_tokens.md" target="_blank" rel="noopener">Graphify como segundo cerebro. Ahorra tokens.</a> <code>bruto/Claude_Code/39_Graphify_como_segundo_cerebro_Ahorra_tokens.md</code></li>
</ul>$lf_module_33$,
    70,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-claude-design',
    'imperio-agentico',
    'Claude Design',
    '🏛️',
    '107 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_34$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Claude Design · 107 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/01_Claude_Design.md" target="_blank" rel="noopener">Claude Design</a> <code>bruto/Claude_Design/01_Claude_Design.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/02_Claude_Design_Intro.md" target="_blank" rel="noopener">Claude Design Intro</a> <code>bruto/Claude_Design/02_Claude_Design_Intro.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/03_TODO_lo_que_Puedes_Diseñar_5_Casos_Reales.md" target="_blank" rel="noopener">TODO lo que Puedes Diseñar (5 Casos Reales)</a> <code>bruto/Claude_Design/03_TODO_lo_que_Puedes_Diseñar_5_Casos_Reales.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/04_Landing_Pages_Claude_Design_método_FRAME.md" target="_blank" rel="noopener">Landing Pages Claude Design (método F.R.A.M.E)</a> <code>bruto/Claude_Design/04_Landing_Pages_Claude_Design_método_FRAME.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/05_Templates_Landing_Pages.md" target="_blank" rel="noopener">Templates Landing Pages</a> <code>bruto/Claude_Design/05_Templates_Landing_Pages.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/06_Velora.md" target="_blank" rel="noopener">Velora</a> <code>bruto/Claude_Design/06_Velora.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/07_Liquid_Glass_Agency.md" target="_blank" rel="noopener">Liquid Glass Agency</a> <code>bruto/Claude_Design/07_Liquid_Glass_Agency.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/08_Viaje_a_Aetheris.md" target="_blank" rel="noopener">Viaje a Aetheris</a> <code>bruto/Claude_Design/08_Viaje_a_Aetheris.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/09_Urban_Jungle.md" target="_blank" rel="noopener">Urban Jungle</a> <code>bruto/Claude_Design/09_Urban_Jungle.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/100_Nexar.md" target="_blank" rel="noopener">Nexar</a> <code>bruto/Claude_Design/100_Nexar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/101_EcoVolta.md" target="_blank" rel="noopener">EcoVolta</a> <code>bruto/Claude_Design/101_EcoVolta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/102_Interactive_Portfolio.md" target="_blank" rel="noopener">Interactive Portfolio</a> <code>bruto/Claude_Design/102_Interactive_Portfolio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/103_Social_Media_Posts.md" target="_blank" rel="noopener">Social Media Posts</a> <code>bruto/Claude_Design/103_Social_Media_Posts.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/104_Inmobiliaria_Zenith.md" target="_blank" rel="noopener">Inmobiliaria Zenith</a> <code>bruto/Claude_Design/104_Inmobiliaria_Zenith.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/105_Video_Backgrounds.md" target="_blank" rel="noopener">Video Backgrounds</a> <code>bruto/Claude_Design/105_Video_Backgrounds.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/106_Backgrounds_-_Parte_1.md" target="_blank" rel="noopener">Backgrounds - Parte 1</a> <code>bruto/Claude_Design/106_Backgrounds_-_Parte_1.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/107_Backgrounds_Parte_2.md" target="_blank" rel="noopener">Backgrounds Parte 2</a> <code>bruto/Claude_Design/107_Backgrounds_Parte_2.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/10_Slam_Dunk.md" target="_blank" rel="noopener">Slam Dunk</a> <code>bruto/Claude_Design/10_Slam_Dunk.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/11_3D_Portfolio.md" target="_blank" rel="noopener">3D Portfolio</a> <code>bruto/Claude_Design/11_3D_Portfolio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/12_Prisma_Creative_Studio.md" target="_blank" rel="noopener">Prisma Creative Studio</a> <code>bruto/Claude_Design/12_Prisma_Creative_Studio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/13_Nike_Premium_Landing.md" target="_blank" rel="noopener">Nike Premium Landing</a> <code>bruto/Claude_Design/13_Nike_Premium_Landing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/14_Impressive_Hero.md" target="_blank" rel="noopener">Impressive Hero</a> <code>bruto/Claude_Design/14_Impressive_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/15_Asme.md" target="_blank" rel="noopener">Asme</a> <code>bruto/Claude_Design/15_Asme.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/16_Guardnet.md" target="_blank" rel="noopener">Guardnet</a> <code>bruto/Claude_Design/16_Guardnet.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/17_Portal.md" target="_blank" rel="noopener">Portal</a> <code>bruto/Claude_Design/17_Portal.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/18_VEX_Ventures.md" target="_blank" rel="noopener">VEX Ventures</a> <code>bruto/Claude_Design/18_VEX_Ventures.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/19_Orbis_NFT.md" target="_blank" rel="noopener">Orbis NFT</a> <code>bruto/Claude_Design/19_Orbis_NFT.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/20_Focus_AI.md" target="_blank" rel="noopener">Focus AI</a> <code>bruto/Claude_Design/20_Focus_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/21_Sync_AI.md" target="_blank" rel="noopener">Sync AI</a> <code>bruto/Claude_Design/21_Sync_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/22_Innovation.md" target="_blank" rel="noopener">Innovation</a> <code>bruto/Claude_Design/22_Innovation.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/23_Space_Voyage.md" target="_blank" rel="noopener">Space Voyage</a> <code>bruto/Claude_Design/23_Space_Voyage.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/24_FlowMate.md" target="_blank" rel="noopener">FlowMate</a> <code>bruto/Claude_Design/24_FlowMate.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/25_Securify_Data_Security.md" target="_blank" rel="noopener">Securify Data Security</a> <code>bruto/Claude_Design/25_Securify_Data_Security.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/26_Acreage_Farming.md" target="_blank" rel="noopener">Acreage Farming</a> <code>bruto/Claude_Design/26_Acreage_Farming.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/27_Pro_AI_Deck.md" target="_blank" rel="noopener">Pro AI Deck</a> <code>bruto/Claude_Design/27_Pro_AI_Deck.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/28_Crypto_Wealth.md" target="_blank" rel="noopener">Crypto Wealth</a> <code>bruto/Claude_Design/28_Crypto_Wealth.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/29_Vitara.md" target="_blank" rel="noopener">Vitara</a> <code>bruto/Claude_Design/29_Vitara.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/30_CodeNest_Coding_Platform.md" target="_blank" rel="noopener">CodeNest Coding Platform</a> <code>bruto/Claude_Design/30_CodeNest_Coding_Platform.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/31_AI_Designer_Portfolio.md" target="_blank" rel="noopener">AI Designer Portfolio</a> <code>bruto/Claude_Design/31_AI_Designer_Portfolio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/32_Grow_AI_Talent_Platform.md" target="_blank" rel="noopener">Grow AI Talent Platform</a> <code>bruto/Claude_Design/32_Grow_AI_Talent_Platform.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/33_Terra_Geo_Map.md" target="_blank" rel="noopener">Terra Geo Map</a> <code>bruto/Claude_Design/33_Terra_Geo_Map.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/34_AI_Designer_Agency.md" target="_blank" rel="noopener">AI Designer Agency</a> <code>bruto/Claude_Design/34_AI_Designer_Agency.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/35_NexaCore.md" target="_blank" rel="noopener">NexaCore</a> <code>bruto/Claude_Design/35_NexaCore.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/36_Automation_Machines.md" target="_blank" rel="noopener">Automation Machines</a> <code>bruto/Claude_Design/36_Automation_Machines.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/37_Portfolio_Cosmic.md" target="_blank" rel="noopener">Portfolio Cosmic</a> <code>bruto/Claude_Design/37_Portfolio_Cosmic.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/38_SkyElite_Private_Jets.md" target="_blank" rel="noopener">SkyElite Private Jets</a> <code>bruto/Claude_Design/38_SkyElite_Private_Jets.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/39_Aethera_Studio.md" target="_blank" rel="noopener">Aethera Studio</a> <code>bruto/Claude_Design/39_Aethera_Studio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/40_DesignPro_Academy.md" target="_blank" rel="noopener">DesignPro Academy</a> <code>bruto/Claude_Design/40_DesignPro_Academy.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/41_Stellar_AI.md" target="_blank" rel="noopener">Stellar AI</a> <code>bruto/Claude_Design/41_Stellar_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/42_Power_AI.md" target="_blank" rel="noopener">Power AI</a> <code>bruto/Claude_Design/42_Power_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/43_xPortfolio_Hero.md" target="_blank" rel="noopener">xPortfolio Hero</a> <code>bruto/Claude_Design/43_xPortfolio_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/44_NOVA_Space_Systems.md" target="_blank" rel="noopener">NOVA Space Systems</a> <code>bruto/Claude_Design/44_NOVA_Space_Systems.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/45_Orbit_Web3.md" target="_blank" rel="noopener">Orbit Web3</a> <code>bruto/Claude_Design/45_Orbit_Web3.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/46_Nexora_Automation.md" target="_blank" rel="noopener">Nexora Automation</a> <code>bruto/Claude_Design/46_Nexora_Automation.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/47_Nexus_IT_Solutions.md" target="_blank" rel="noopener">Nexus IT Solutions</a> <code>bruto/Claude_Design/47_Nexus_IT_Solutions.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/48_EVR_Ventures.md" target="_blank" rel="noopener">EVR Ventures</a> <code>bruto/Claude_Design/48_EVR_Ventures.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/49_Veloce_Finance.md" target="_blank" rel="noopener">Veloce Finance</a> <code>bruto/Claude_Design/49_Veloce_Finance.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/50_Planet_Orbit.md" target="_blank" rel="noopener">Planet Orbit</a> <code>bruto/Claude_Design/50_Planet_Orbit.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/51_Yacht_Club.md" target="_blank" rel="noopener">Yacht Club</a> <code>bruto/Claude_Design/51_Yacht_Club.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/52_NeoVision.md" target="_blank" rel="noopener">NeoVision</a> <code>bruto/Claude_Design/52_NeoVision.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/53_New_Era_Bold_Hero.md" target="_blank" rel="noopener">New Era Bold Hero</a> <code>bruto/Claude_Design/53_New_Era_Bold_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/54_E-commerce_Website.md" target="_blank" rel="noopener">E-commerce Website</a> <code>bruto/Claude_Design/54_E-commerce_Website.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/55_AKOR_Security.md" target="_blank" rel="noopener">AKOR Security</a> <code>bruto/Claude_Design/55_AKOR_Security.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/56_Wealth_Video_Hero.md" target="_blank" rel="noopener">Wealth Video Hero</a> <code>bruto/Claude_Design/56_Wealth_Video_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/57_Mindloop_Landing.md" target="_blank" rel="noopener">Mindloop Landing</a> <code>bruto/Claude_Design/57_Mindloop_Landing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/58_Luminex.md" target="_blank" rel="noopener">Luminex</a> <code>bruto/Claude_Design/58_Luminex.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/59_Celestia.md" target="_blank" rel="noopener">Celestia</a> <code>bruto/Claude_Design/59_Celestia.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/60_Datacore_Booking.md" target="_blank" rel="noopener">Datacore Booking</a> <code>bruto/Claude_Design/60_Datacore_Booking.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/61_Glassmorphism_Agency_Hero.md" target="_blank" rel="noopener">Glassmorphism Agency Hero</a> <code>bruto/Claude_Design/61_Glassmorphism_Agency_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/62_Email_Marketing.md" target="_blank" rel="noopener">Email Marketing</a> <code>bruto/Claude_Design/62_Email_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/63_HR_SaaS_Hero.md" target="_blank" rel="noopener">HR SaaS Hero</a> <code>bruto/Claude_Design/63_HR_SaaS_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/64_Bionova_Biotech.md" target="_blank" rel="noopener">Bionova Biotech</a> <code>bruto/Claude_Design/64_Bionova_Biotech.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/65_ClubX_Investors.md" target="_blank" rel="noopener">ClubX Investors</a> <code>bruto/Claude_Design/65_ClubX_Investors.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/66_Orbit_Engineers.md" target="_blank" rel="noopener">Orbit Engineers</a> <code>bruto/Claude_Design/66_Orbit_Engineers.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/67_Nickel_Payments.md" target="_blank" rel="noopener">Nickel Payments</a> <code>bruto/Claude_Design/67_Nickel_Payments.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/68_Apex_SaaS.md" target="_blank" rel="noopener">Apex SaaS</a> <code>bruto/Claude_Design/68_Apex_SaaS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/69_Railroadai.md" target="_blank" rel="noopener">Railroad.ai</a> <code>bruto/Claude_Design/69_Railroadai.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/70_Buzzentic_Agency.md" target="_blank" rel="noopener">Buzzentic Agency</a> <code>bruto/Claude_Design/70_Buzzentic_Agency.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/71_Mindloop.md" target="_blank" rel="noopener">Mindloop</a> <code>bruto/Claude_Design/71_Mindloop.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/72_Viktor_Portfolio.md" target="_blank" rel="noopener">Viktor Portfolio</a> <code>bruto/Claude_Design/72_Viktor_Portfolio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/73_Taskly.md" target="_blank" rel="noopener">Taskly</a> <code>bruto/Claude_Design/73_Taskly.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/74_Loader_Animation.md" target="_blank" rel="noopener">Loader Animation</a> <code>bruto/Claude_Design/74_Loader_Animation.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/75_EcoVolta_V2.md" target="_blank" rel="noopener">EcoVolta V2</a> <code>bruto/Claude_Design/75_EcoVolta_V2.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/76_Dark_Portfolio_Hero.md" target="_blank" rel="noopener">Dark Portfolio Hero</a> <code>bruto/Claude_Design/76_Dark_Portfolio_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/77_Logoisum_Video_Agency_Hero.md" target="_blank" rel="noopener">Logoisum Video Agency Hero</a> <code>bruto/Claude_Design/77_Logoisum_Video_Agency_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/78_Framelix_3D_Studios.md" target="_blank" rel="noopener">Framelix 3D Studios</a> <code>bruto/Claude_Design/78_Framelix_3D_Studios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/79_Bloom_AI.md" target="_blank" rel="noopener">Bloom AI</a> <code>bruto/Claude_Design/79_Bloom_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/80_WISA_Space.md" target="_blank" rel="noopener">WISA Space</a> <code>bruto/Claude_Design/80_WISA_Space.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/81_Targo_Logistics_Hero.md" target="_blank" rel="noopener">Targo Logistics Hero</a> <code>bruto/Claude_Design/81_Targo_Logistics_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/82_Neuralyn.md" target="_blank" rel="noopener">Neuralyn</a> <code>bruto/Claude_Design/82_Neuralyn.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/83_Weblex_Dark_Hero.md" target="_blank" rel="noopener">Weblex Dark Hero</a> <code>bruto/Claude_Design/83_Weblex_Dark_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/84_AI_Automation_Hero.md" target="_blank" rel="noopener">AI Automation Hero</a> <code>bruto/Claude_Design/84_AI_Automation_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/85_New_Era_Automotive_Hero.md" target="_blank" rel="noopener">New Era Automotive Hero</a> <code>bruto/Claude_Design/85_New_Era_Automotive_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/86_Synapse_Dark_Hero.md" target="_blank" rel="noopener">Synapse Dark Hero</a> <code>bruto/Claude_Design/86_Synapse_Dark_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/87_Bold_Portfolio_Hero.md" target="_blank" rel="noopener">Bold Portfolio Hero</a> <code>bruto/Claude_Design/87_Bold_Portfolio_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/88_Datacore_SaaS_Hero.md" target="_blank" rel="noopener">Datacore SaaS Hero</a> <code>bruto/Claude_Design/88_Datacore_SaaS_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/89_ClearInvoice_SaaS_Hero.md" target="_blank" rel="noopener">ClearInvoice SaaS Hero</a> <code>bruto/Claude_Design/89_ClearInvoice_SaaS_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/90_Web3_EOS_Hero.md" target="_blank" rel="noopener">Web3 EOS Hero</a> <code>bruto/Claude_Design/90_Web3_EOS_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/91_Digitwist_AI_Builder.md" target="_blank" rel="noopener">Digitwist AI Builder</a> <code>bruto/Claude_Design/91_Digitwist_AI_Builder.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/92_Price_Calculator.md" target="_blank" rel="noopener">Price Calculator</a> <code>bruto/Claude_Design/92_Price_Calculator.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/93_Taskora_SaaS_Hero.md" target="_blank" rel="noopener">Taskora SaaS Hero</a> <code>bruto/Claude_Design/93_Taskora_SaaS_Hero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/94_Investor_Deck.md" target="_blank" rel="noopener">Investor Deck</a> <code>bruto/Claude_Design/94_Investor_Deck.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/95_Scroll_Landing_Page.md" target="_blank" rel="noopener">Scroll Landing Page</a> <code>bruto/Claude_Design/95_Scroll_Landing_Page.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/96_Finlytic_AI_Agent.md" target="_blank" rel="noopener">Finlytic AI Agent</a> <code>bruto/Claude_Design/96_Finlytic_AI_Agent.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/97_Sentinel_AI.md" target="_blank" rel="noopener">Sentinel AI</a> <code>bruto/Claude_Design/97_Sentinel_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/98_Duolingo_Styleguide.md" target="_blank" rel="noopener">Duolingo Styleguide</a> <code>bruto/Claude_Design/98_Duolingo_Styleguide.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Claude_Design/99_Transform_Data.md" target="_blank" rel="noopener">Transform Data</a> <code>bruto/Claude_Design/99_Transform_Data.md</code></li>
</ul>$lf_module_34$,
    80,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-club-anual-imperial',
    'imperio-agentico',
    'Club Anual Imperial',
    '🏛️',
    '5 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_35$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Club Anual Imperial · 5 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Club_Anual_Imperial/01_Club_Anual_Imperial.md" target="_blank" rel="noopener">Club Anual Imperial</a> <code>bruto/Club_Anual_Imperial/01_Club_Anual_Imperial.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Club_Anual_Imperial/02_Bienvenida_al_Club_Imperial.md" target="_blank" rel="noopener">🔐 Bienvenida al Club Imperial</a> <code>bruto/Club_Anual_Imperial/02_Bienvenida_al_Club_Imperial.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Club_Anual_Imperial/03_Tu_Anillo_Imperial.md" target="_blank" rel="noopener">🚀 Tu Anillo Imperial</a> <code>bruto/Club_Anual_Imperial/03_Tu_Anillo_Imperial.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Club_Anual_Imperial/04_Convenios_Imperiales_USD_3000000.md" target="_blank" rel="noopener">👉 Convenios Imperiales (+ USD 3.000.000) 🚀</a> <code>bruto/Club_Anual_Imperial/04_Convenios_Imperiales_USD_3000000.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Club_Anual_Imperial/05_Cómo_Aplico_a_los_Convenios.md" target="_blank" rel="noopener">🏷️ ¿Cómo Aplico a los Convenios?</a> <code>bruto/Club_Anual_Imperial/05_Cómo_Aplico_a_los_Convenios.md</code></li>
</ul>$lf_module_35$,
    90,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-crea-conecta-convierte',
    'imperio-agentico',
    'Crea Conecta Convierte',
    '🏛️',
    '12 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_36$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Crea Conecta Convierte · 12 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/01_Crea_Conecta_Convierte.md" target="_blank" rel="noopener">Crea, Conecta, Convierte</a> <code>bruto/Crea_Conecta_Convierte/01_Crea_Conecta_Convierte.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/02_Módulo_1_Intro.md" target="_blank" rel="noopener">Módulo 1: Intro</a> <code>bruto/Crea_Conecta_Convierte/02_Módulo_1_Intro.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/03_Introducción_al_Modelo_CCC.md" target="_blank" rel="noopener">📘 Introducción al Modelo CCC</a> <code>bruto/Crea_Conecta_Convierte/03_Introducción_al_Modelo_CCC.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/04_Módulo_2_Crea.md" target="_blank" rel="noopener">Módulo 2: Crea</a> <code>bruto/Crea_Conecta_Convierte/04_Módulo_2_Crea.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/05_Crea.md" target="_blank" rel="noopener">🎨 Crea</a> <code>bruto/Crea_Conecta_Convierte/05_Crea.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/06_Módulo_3_Conecta.md" target="_blank" rel="noopener">Módulo 3: Conecta</a> <code>bruto/Crea_Conecta_Convierte/06_Módulo_3_Conecta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/07_Conecta.md" target="_blank" rel="noopener">🌐 Conecta</a> <code>bruto/Crea_Conecta_Convierte/07_Conecta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/08_Módulo_4_Convierte.md" target="_blank" rel="noopener">Módulo 4:  Convierte</a> <code>bruto/Crea_Conecta_Convierte/08_Módulo_4_Convierte.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/09_Convierte.md" target="_blank" rel="noopener">💰 Convierte</a> <code>bruto/Crea_Conecta_Convierte/09_Convierte.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/10_Secuencia_de_Correos.md" target="_blank" rel="noopener">✉️ Secuencia de Correos</a> <code>bruto/Crea_Conecta_Convierte/10_Secuencia_de_Correos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/11_Leads_de_Manychat_a_Mailerlite_alt.md" target="_blank" rel="noopener">📷 Leads de Manychat a Mailerlite (alt.)</a> <code>bruto/Crea_Conecta_Convierte/11_Leads_de_Manychat_a_Mailerlite_alt.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Crea_Conecta_Convierte/12_BONUS_Nuestro_Embudo_sin_humo.md" target="_blank" rel="noopener">BONUS: Nuestro Embudo (sin humo)</a> <code>bruto/Crea_Conecta_Convierte/12_BONUS_Nuestro_Embudo_sin_humo.md</code></li>
</ul>$lf_module_36$,
    100,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-como-vender-automatizaciones',
    'imperio-agentico',
    'Cómo Vender Automatizaciones',
    '🏛️',
    '20 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_37$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Cómo Vender Automatizaciones · 20 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/01_Cómo_Vender_Automatizaciones.md" target="_blank" rel="noopener">Cómo Vender Automatizaciones</a> <code>bruto/Cómo_Vender_Automatizaciones/01_Cómo_Vender_Automatizaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/02_POR_QUÉ_vender_IA_y_automatizaciones.md" target="_blank" rel="noopener">¿POR QUÉ vender IA y automatizaciones?</a> <code>bruto/Cómo_Vender_Automatizaciones/02_POR_QUÉ_vender_IA_y_automatizaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/03_Automatizaciones_de_ALTO_VALOR.md" target="_blank" rel="noopener">Automatizaciones de ALTO VALOR</a> <code>bruto/Cómo_Vender_Automatizaciones/03_Automatizaciones_de_ALTO_VALOR.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/04_OFERTA_irresistible.md" target="_blank" rel="noopener">OFERTA irresistible</a> <code>bruto/Cómo_Vender_Automatizaciones/04_OFERTA_irresistible.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/05_Estructura_de_COSTOS_y_PRECIOS.md" target="_blank" rel="noopener">Estructura de COSTOS y PRECIOS</a> <code>bruto/Cómo_Vender_Automatizaciones/05_Estructura_de_COSTOS_y_PRECIOS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/06_Proceso_de_VENTA.md" target="_blank" rel="noopener">Proceso de VENTA</a> <code>bruto/Cómo_Vender_Automatizaciones/06_Proceso_de_VENTA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/07_Lista_de_AUTOMATIZACIONES.md" target="_blank" rel="noopener">Lista de AUTOMATIZACIONES</a> <code>bruto/Cómo_Vender_Automatizaciones/07_Lista_de_AUTOMATIZACIONES.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/08_Modelos_de_Negocio_y_Pricing.md" target="_blank" rel="noopener">Modelos de Negocio y Pricing</a> <code>bruto/Cómo_Vender_Automatizaciones/08_Modelos_de_Negocio_y_Pricing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/09_Bonus_Como_Empezaría_con_100_USD.md" target="_blank" rel="noopener">Bonus: Como Empezaría con $100 USD</a> <code>bruto/Cómo_Vender_Automatizaciones/09_Bonus_Como_Empezaría_con_100_USD.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/10_Bonus_Creo_y_vendo_un_servicio_de_IA_en_3_horas.md" target="_blank" rel="noopener">Bonus: Creo y vendo un servicio de IA en 3 horas</a> <code>bruto/Cómo_Vender_Automatizaciones/10_Bonus_Creo_y_vendo_un_servicio_de_IA_en_3_horas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/11_Bonus_Gestión_de_Clientes_en_MAKE.md" target="_blank" rel="noopener">Bonus: Gestión de Clientes en MAKE</a> <code>bruto/Cómo_Vender_Automatizaciones/11_Bonus_Gestión_de_Clientes_en_MAKE.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/12_Recurso_CONTRATO.md" target="_blank" rel="noopener">Recurso: CONTRATO</a> <code>bruto/Cómo_Vender_Automatizaciones/12_Recurso_CONTRATO.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/13_Recurso_CUESTIONARIO.md" target="_blank" rel="noopener">Recurso: CUESTIONARIO</a> <code>bruto/Cómo_Vender_Automatizaciones/13_Recurso_CUESTIONARIO.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/14_Recurso_PRESENTACION.md" target="_blank" rel="noopener">Recurso: PRESENTACION</a> <code>bruto/Cómo_Vender_Automatizaciones/14_Recurso_PRESENTACION.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/15_Recurso_PROPUESTAS.md" target="_blank" rel="noopener">Recurso: PROPUESTAS</a> <code>bruto/Cómo_Vender_Automatizaciones/15_Recurso_PROPUESTAS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/16_Recurso_PLANIFICACIÓN.md" target="_blank" rel="noopener">Recurso: PLANIFICACIÓN</a> <code>bruto/Cómo_Vender_Automatizaciones/16_Recurso_PLANIFICACIÓN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/17_Recurso_GESTIÓN.md" target="_blank" rel="noopener">Recurso: GESTIÓN</a> <code>bruto/Cómo_Vender_Automatizaciones/17_Recurso_GESTIÓN.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/18_Workshop_Ventas.md" target="_blank" rel="noopener">Workshop Ventas</a> <code>bruto/Cómo_Vender_Automatizaciones/18_Workshop_Ventas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/19_Vendí_esta_automatización_por_5000_USD.md" target="_blank" rel="noopener">Vendí esta automatización por $5000 USD</a> <code>bruto/Cómo_Vender_Automatizaciones/19_Vendí_esta_automatización_por_5000_USD.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Cómo_Vender_Automatizaciones/20_Conseguir_Clientes_con_Claude_Code.md" target="_blank" rel="noopener">Conseguir Clientes con Claude Code</a> <code>bruto/Cómo_Vender_Automatizaciones/20_Conseguir_Clientes_con_Claude_Code.md</code></li>
</ul>$lf_module_37$,
    110,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-dashboard-agentes-de-whatsapp',
    'imperio-agentico',
    'Dashboard Agentes de Whatsapp',
    '🏛️',
    '11 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_38$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Dashboard Agentes de Whatsapp · 11 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/01_Dashboard_Agentes_de_Whatsapp.md" target="_blank" rel="noopener">Dashboard Agentes de Whatsapp</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/01_Dashboard_Agentes_de_Whatsapp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/02_Bienvenida_Lo_que_vas_a_construir.md" target="_blank" rel="noopener">👋 Bienvenida — Lo que vas a construir</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/02_Bienvenida_Lo_que_vas_a_construir.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/03_Prepara_tu_Espacio_de_Trabajo.md" target="_blank" rel="noopener">🧰 Prepara tu Espacio de Trabajo</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/03_Prepara_tu_Espacio_de_Trabajo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/04_Mesa_de_Trabajo_-_Claudemd_y_Git.md" target="_blank" rel="noopener">🏗️ Mesa de Trabajo - Claude.md y Git</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/04_Mesa_de_Trabajo_-_Claudemd_y_Git.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/05_Planeación_I_El_Agente_y_el_Negocio.md" target="_blank" rel="noopener">🧠 Planeación I — El Agente y el Negocio</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/05_Planeación_I_El_Agente_y_el_Negocio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/06_Planeación_II_WhatsApp_a_Fondo_Diseño.md" target="_blank" rel="noopener">📐 Planeación II — WhatsApp a Fondo + Diseño</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/06_Planeación_II_WhatsApp_a_Fondo_Diseño.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/07_La_App_por_Dentro_Deploy_a_Vercel.md" target="_blank" rel="noopener">🚀 La App por Dentro + Deploy a Vercel</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/07_La_App_por_Dentro_Deploy_a_Vercel.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/08_Conecta_tu_WhatsApp_con_YCloud_Coexistencia.md" target="_blank" rel="noopener">🔗 Conecta tu WhatsApp con YCloud (Coexistencia)</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/08_Conecta_tu_WhatsApp_con_YCloud_Coexistencia.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/09_One_Click_Install_Tu_Plataforma_en_15_Minutos.md" target="_blank" rel="noopener">📦 One Click Install —Tu Plataforma en ~15 Minutos</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/09_One_Click_Install_Tu_Plataforma_en_15_Minutos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/10_Configuración_Pruebas_Reales_Bonus.md" target="_blank" rel="noopener">🧪 Configuración + Pruebas Reales (Bonus)</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/10_Configuración_Pruebas_Reales_Bonus.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Dashboard_Agentes_de_Whatsapp/11_Outro_Tu_SaaS_vs_el_Agente_Nativo_de_Meta.md" target="_blank" rel="noopener">🏁 Outro — Tu SaaS vs el Agente Nativo de Meta</a> <code>bruto/Dashboard_Agentes_de_Whatsapp/11_Outro_Tu_SaaS_vs_el_Agente_Nativo_de_Meta.md</code></li>
</ul>$lf_module_38$,
    120,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-de-make-a-n8n',
    'imperio-agentico',
    'De Make a n8n',
    '🏛️',
    '24 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_39$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> De Make a n8n · 24 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/01_De_Make_a_n8n.md" target="_blank" rel="noopener">De Make a n8n</a> <code>bruto/De_Make_a_n8n/01_De_Make_a_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/02_Empieza_Aquí.md" target="_blank" rel="noopener">🏁 Empieza Aquí</a> <code>bruto/De_Make_a_n8n/02_Empieza_Aquí.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/03_Intro_al_Curso.md" target="_blank" rel="noopener">🎬 Intro al Curso</a> <code>bruto/De_Make_a_n8n/03_Intro_al_Curso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/04_Cómo_Instalar_N8N.md" target="_blank" rel="noopener">🛠️ Cómo Instalar N8N</a> <code>bruto/De_Make_a_n8n/04_Cómo_Instalar_N8N.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/05_Explorando_la_Interfaz.md" target="_blank" rel="noopener">🧭 Explorando la Interfaz</a> <code>bruto/De_Make_a_n8n/05_Explorando_la_Interfaz.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/06_Canvas_y_Flujos.md" target="_blank" rel="noopener">🧱 Canvas y Flujos</a> <code>bruto/De_Make_a_n8n/06_Canvas_y_Flujos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/07_Ejecuciones_y_Errores.md" target="_blank" rel="noopener">📊 Ejecuciones y Errores</a> <code>bruto/De_Make_a_n8n/07_Ejecuciones_y_Errores.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/08_Tipos_de_Triggers.md" target="_blank" rel="noopener">🎯 Tipos de Triggers</a> <code>bruto/De_Make_a_n8n/08_Tipos_de_Triggers.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/09_Condiciones_y_Rutas.md" target="_blank" rel="noopener">🔄 Condiciones y Rutas</a> <code>bruto/De_Make_a_n8n/09_Condiciones_y_Rutas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/10_Usando_Expresiones.md" target="_blank" rel="noopener">💻 Usando Expresiones</a> <code>bruto/De_Make_a_n8n/10_Usando_Expresiones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/11_Llamadas_HTTP.md" target="_blank" rel="noopener">🌐 Llamadas HTTP</a> <code>bruto/De_Make_a_n8n/11_Llamadas_HTTP.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/12_Agentes_con_IA_Intro.md" target="_blank" rel="noopener">🧠 Agentes con IA (Intro)</a> <code>bruto/De_Make_a_n8n/12_Agentes_con_IA_Intro.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/13_Modelos_IA_en_N8N.md" target="_blank" rel="noopener">🤖 Modelos IA en N8N</a> <code>bruto/De_Make_a_n8n/13_Modelos_IA_en_N8N.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/14_Memoria_del_Agente.md" target="_blank" rel="noopener">🧬 Memoria del Agente</a> <code>bruto/De_Make_a_n8n/14_Memoria_del_Agente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/15_Instrucciones_al_Agente.md" target="_blank" rel="noopener">🧾 Instrucciones al Agente</a> <code>bruto/De_Make_a_n8n/15_Instrucciones_al_Agente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/16_Integración_de_Tools.md" target="_blank" rel="noopener">🛠️ Integración de Tools</a> <code>bruto/De_Make_a_n8n/16_Integración_de_Tools.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/17_Un_Ejemplo_Práctico.md" target="_blank" rel="noopener">🚀 Un Ejemplo Práctico</a> <code>bruto/De_Make_a_n8n/17_Un_Ejemplo_Práctico.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/18_Intro_Flujo_Completo.md" target="_blank" rel="noopener">🧩 Intro Flujo Completo</a> <code>bruto/De_Make_a_n8n/18_Intro_Flujo_Completo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/19_Caso_Real_Completo.md" target="_blank" rel="noopener">🏗️ Caso Real Completo</a> <code>bruto/De_Make_a_n8n/19_Caso_Real_Completo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/20_Testeo_Agente_IA.md" target="_blank" rel="noopener">🧪 Testeo Agente IA</a> <code>bruto/De_Make_a_n8n/20_Testeo_Agente_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/21_Errores_en_Workflow.md" target="_blank" rel="noopener">🛠️ Errores en Workflow</a> <code>bruto/De_Make_a_n8n/21_Errores_en_Workflow.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/22_Flujo_en_Producción.md" target="_blank" rel="noopener">🗂️ Flujo en Producción</a> <code>bruto/De_Make_a_n8n/22_Flujo_en_Producción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/23_Repaso_Final_Agente_IA.md" target="_blank" rel="noopener">⚙️ Repaso Final Agente IA</a> <code>bruto/De_Make_a_n8n/23_Repaso_Final_Agente_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/De_Make_a_n8n/24_2000_Templates_n8n.md" target="_blank" rel="noopener">📁 +2000 Templates n8n</a> <code>bruto/De_Make_a_n8n/24_2000_Templates_n8n.md</code></li>
</ul>$lf_module_39$,
    130,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-empieza-aqui',
    'imperio-agentico',
    'Empieza Aquí',
    '🏛️',
    '10 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_40$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Empieza Aquí · 10 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/01_Empieza_Aquí.md" target="_blank" rel="noopener">➡️ Empieza Aquí</a> <code>bruto/Empieza_Aquí/01_Empieza_Aquí.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/02_Bienvenid.md" target="_blank" rel="noopener">👋 Bienvenid@</a> <code>bruto/Empieza_Aquí/02_Bienvenid.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/03_Comunidad.md" target="_blank" rel="noopener">🌐 Comunidad</a> <code>bruto/Empieza_Aquí/03_Comunidad.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/04_Classroom.md" target="_blank" rel="noopener">📚 Classroom</a> <code>bruto/Empieza_Aquí/04_Classroom.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/05_Niveles.md" target="_blank" rel="noopener">🏆 Niveles</a> <code>bruto/Empieza_Aquí/05_Niveles.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/06_Calendario.md" target="_blank" rel="noopener">📅 Calendario</a> <code>bruto/Empieza_Aquí/06_Calendario.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/07_Equipo.md" target="_blank" rel="noopener">💪🏻 Equipo</a> <code>bruto/Empieza_Aquí/07_Equipo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/08_Soporte.md" target="_blank" rel="noopener">🛠️ Soporte</a> <code>bruto/Empieza_Aquí/08_Soporte.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/09_Próximos_Pasos.md" target="_blank" rel="noopener">🐾 Próximos Pasos</a> <code>bruto/Empieza_Aquí/09_Próximos_Pasos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Empieza_Aquí/10_Club_Anual.md" target="_blank" rel="noopener">⭐️ Club Anual</a> <code>bruto/Empieza_Aquí/10_Club_Anual.md</code></li>
</ul>$lf_module_40$,
    140,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-ghl-desde-cero',
    'imperio-agentico',
    'GHL desde Cero',
    '🏛️',
    '14 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_41$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> GHL desde Cero · 14 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/01_GHL_desde_Cero.md" target="_blank" rel="noopener">GHL desde Cero</a> <code>bruto/GHL_desde_Cero/01_GHL_desde_Cero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/02_0_Empieza_Aquí.md" target="_blank" rel="noopener">🏁 0. Empieza Aquí</a> <code>bruto/GHL_desde_Cero/02_0_Empieza_Aquí.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/03_1_Introducción.md" target="_blank" rel="noopener">📍 1. Introducción</a> <code>bruto/GHL_desde_Cero/03_1_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/04_2_Setup_Branding_desde_Cero.md" target="_blank" rel="noopener">🧱 2. Setup &amp; Branding desde Cero</a> <code>bruto/GHL_desde_Cero/04_2_Setup_Branding_desde_Cero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/05_3_Canales_de_Comunicación.md" target="_blank" rel="noopener">📞  3. Canales de Comunicación</a> <code>bruto/GHL_desde_Cero/05_3_Canales_de_Comunicación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/06_4_CRM_Contactos_Campos_Personalizados.md" target="_blank" rel="noopener">👥 4. CRM: Contactos &amp; Campos Personalizados</a> <code>bruto/GHL_desde_Cero/06_4_CRM_Contactos_Campos_Personalizados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/07_5_Pipelines_Oportunidades.md" target="_blank" rel="noopener">🚦 5. Pipelines &amp; Oportunidades</a> <code>bruto/GHL_desde_Cero/07_5_Pipelines_Oportunidades.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/08_6_Funnel_Landing_Page_Calendario.md" target="_blank" rel="noopener">🎯 6. Funnel: Landing Page + Calendario</a> <code>bruto/GHL_desde_Cero/08_6_Funnel_Landing_Page_Calendario.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/09_7_Checkout_Pagos_Thank_You_Page.md" target="_blank" rel="noopener">💳 7. Checkout, Pagos &amp; Thank You Page</a> <code>bruto/GHL_desde_Cero/09_7_Checkout_Pagos_Thank_You_Page.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/10_8_Workflows_Confirmaciones_Recordatorios.md" target="_blank" rel="noopener">🤖 8. Workflows: Confirmaciones &amp; Recordatorios</a> <code>bruto/GHL_desde_Cero/10_8_Workflows_Confirmaciones_Recordatorios.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/11_9_Workflows_Reseñas_Cumples_Fidelización.md" target="_blank" rel="noopener">💚 9. Workflows: Reseñas, Cumples &amp; Fidelización</a> <code>bruto/GHL_desde_Cero/11_9_Workflows_Reseñas_Cumples_Fidelización.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/12_10_Workflows_Rescate_de_No-Shows_Nurturing.md" target="_blank" rel="noopener">🚑 10. Workflows: Rescate de No-Shows &amp; Nurturing</a> <code>bruto/GHL_desde_Cero/12_10_Workflows_Rescate_de_No-Shows_Nurturing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/13_11_AI_Chatbot_AI_Studio_Claude_Code_con_MCP.md" target="_blank" rel="noopener">🧠 11. AI Chatbot, AI Studio &amp; Claude Code con MCP</a> <code>bruto/GHL_desde_Cero/13_11_AI_Chatbot_AI_Studio_Claude_Code_con_MCP.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/GHL_desde_Cero/14_12_El_Después_Dashboard_Entrega_Replicación.md" target="_blank" rel="noopener">🏆 12. El Después Dashboard, Entrega &amp; Replicación</a> <code>bruto/GHL_desde_Cero/14_12_El_Después_Dashboard_Entrega_Replicación.md</code></li>
</ul>$lf_module_41$,
    150,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-grabaciones',
    'imperio-agentico',
    'Grabaciones',
    '🏛️',
    '104 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_42$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Grabaciones · 104 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/01_Grabaciones.md" target="_blank" rel="noopener">🔴 Grabaciones</a> <code>bruto/Grabaciones/01_Grabaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/02_Sesiones_en_Vivo.md" target="_blank" rel="noopener">🎥 Sesiones en Vivo</a> <code>bruto/Grabaciones/02_Sesiones_en_Vivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/03_Automatiza_Con_Fran.md" target="_blank" rel="noopener">⚙️ Automatiza Con Fran</a> <code>bruto/Grabaciones/03_Automatiza_Con_Fran.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/04_Nadie_te_enseña_esto_antes_de_vender.md" target="_blank" rel="noopener">Nadie te enseña esto antes de vender</a> <code>bruto/Grabaciones/04_Nadie_te_enseña_esto_antes_de_vender.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/05_El_error_que_arruina_tus_agentes_y_cómo_evitarlo.md" target="_blank" rel="noopener">El error que arruina tus agentes (y cómo evitarlo)</a> <code>bruto/Grabaciones/05_El_error_que_arruina_tus_agentes_y_cómo_evitarlo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/06_VPS_Fable_y_cobrar_lo_que_vale.md" target="_blank" rel="noopener">VPS, Fable y cobrar lo que vale</a> <code>bruto/Grabaciones/06_VPS_Fable_y_cobrar_lo_que_vale.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/07_Haiku_no_sirve_modelo_y_arquitectura_en_agentes.md" target="_blank" rel="noopener">Haiku no sirve: modelo y arquitectura en agentes</a> <code>bruto/Grabaciones/07_Haiku_no_sirve_modelo_y_arquitectura_en_agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/08_Vende_IA_sin_ser_programador_dashboard_y_agentes.md" target="_blank" rel="noopener">Vende IA sin ser programador, dashboard y agentes</a> <code>bruto/Grabaciones/08_Vende_IA_sin_ser_programador_dashboard_y_agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/09_WhatsApp_con_IA_sin_que_Meta_te_banee.md" target="_blank" rel="noopener">WhatsApp con IA sin que Meta te banee</a> <code>bruto/Grabaciones/09_WhatsApp_con_IA_sin_que_Meta_te_banee.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/100_JSON2Video_-_Joaquim_Cardona_Fundador.md" target="_blank" rel="noopener">JSON2Video - Joaquim Cardona (Fundador)</a> <code>bruto/Grabaciones/100_JSON2Video_-_Joaquim_Cardona_Fundador.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/101_Asistente_IA_que_convierte_tu_Voz_en_Mails.md" target="_blank" rel="noopener">Asistente IA que convierte tu Voz en Mails</a> <code>bruto/Grabaciones/101_Asistente_IA_que_convierte_tu_Voz_en_Mails.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/102_Construye_eBooks_Personalizados.md" target="_blank" rel="noopener">Construye eBooks Personalizados</a> <code>bruto/Grabaciones/102_Construye_eBooks_Personalizados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/103_Funnels_con_IA_-_Vicente_Visuals.md" target="_blank" rel="noopener">Funnels con IA - Vicente Visuals</a> <code>bruto/Grabaciones/103_Funnels_con_IA_-_Vicente_Visuals.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/104_SECRET_LAUNCH_20_de_Enero.md" target="_blank" rel="noopener">SECRET LAUNCH (20 de Enero)</a> <code>bruto/Grabaciones/104_SECRET_LAUNCH_20_de_Enero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/10_Claude_Code_vs_Hermes.md" target="_blank" rel="noopener">Claude Code vs Hermes</a> <code>bruto/Grabaciones/10_Claude_Code_vs_Hermes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/11_Auditoría_modelos_locales_y_primer_cliente.md" target="_blank" rel="noopener">Auditoría, modelos locales y primer cliente</a> <code>bruto/Grabaciones/11_Auditoría_modelos_locales_y_primer_cliente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/12_Claude_Code_cómo_planificar_antes_de_ejecutar.md" target="_blank" rel="noopener">Claude Code: cómo planificar antes de ejecutar</a> <code>bruto/Grabaciones/12_Claude_Code_cómo_planificar_antes_de_ejecutar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/13_El_error_que_destruye_tu_agente_de_WhatsApp.md" target="_blank" rel="noopener">El error que destruye tu agente de WhatsApp</a> <code>bruto/Grabaciones/13_El_error_que_destruye_tu_agente_de_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/14_Claude_Code_subagente_modelos_y_ahorro_de_tokens.md" target="_blank" rel="noopener">Claude Code, subagente, modelos y ahorro de tokens</a> <code>bruto/Grabaciones/14_Claude_Code_subagente_modelos_y_ahorro_de_tokens.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/15_Desplegar_agentes_en_la_nube_de_Anthropic_sin_VPS.md" target="_blank" rel="noopener">Desplegar agentes en la nube de Anthropic sin VPS</a> <code>bruto/Grabaciones/15_Desplegar_agentes_en_la_nube_de_Anthropic_sin_VPS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/16_Mandá_1000_mensajes_sin_que_te_baneen.md" target="_blank" rel="noopener">Mandá 1000 mensajes sin que te baneen</a> <code>bruto/Grabaciones/16_Mandá_1000_mensajes_sin_que_te_baneen.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/17_Claude_Code_NotebookLM_como_RAG.md" target="_blank" rel="noopener">Claude Code + NotebookLM como RAG</a> <code>bruto/Grabaciones/17_Claude_Code_NotebookLM_como_RAG.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/18_El_error_que_arruina_tus_agentes_de_WhatsApp.md" target="_blank" rel="noopener">El error que arruina tus agentes de WhatsApp</a> <code>bruto/Grabaciones/18_El_error_que_arruina_tus_agentes_de_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/19_Claude_Code_y_Estrategia_para_Empresas.md" target="_blank" rel="noopener">Claude Code y Estrategia para Empresas</a> <code>bruto/Grabaciones/19_Claude_Code_y_Estrategia_para_Empresas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/20_Agentes_IA_que_trabajan_por_ti.md" target="_blank" rel="noopener">Agentes IA que trabajan por ti</a> <code>bruto/Grabaciones/20_Agentes_IA_que_trabajan_por_ti.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/21_El_modelo_que_todos_deberían_usar_para_programar.md" target="_blank" rel="noopener">El modelo que todos deberían usar para programar</a> <code>bruto/Grabaciones/21_El_modelo_que_todos_deberían_usar_para_programar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/22_Escala_WhatsApp_domina_OpenClaw_salva_tu_VPS.md" target="_blank" rel="noopener">Escala WhatsApp, domina OpenClaw, salva tu VPS</a> <code>bruto/Grabaciones/22_Escala_WhatsApp_domina_OpenClaw_salva_tu_VPS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/23_Claude_Code_optimizar_modelos_y_detectar_errores.md" target="_blank" rel="noopener">Claude Code: optimizar modelos y detectar errores</a> <code>bruto/Grabaciones/23_Claude_Code_optimizar_modelos_y_detectar_errores.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/24_Evolution_API_vs_YCloud.md" target="_blank" rel="noopener">Evolution API vs YCloud</a> <code>bruto/Grabaciones/24_Evolution_API_vs_YCloud.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/25_Automatizaciones_con_IA_Landing_WhatsApp_Business.md" target="_blank" rel="noopener">Automatizaciones con IA Landing, WhatsApp Business</a> <code>bruto/Grabaciones/25_Automatizaciones_con_IA_Landing_WhatsApp_Business.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/26_Codex_vs_Claude_Code_Comparación_Solución.md" target="_blank" rel="noopener">Codex vs Claude Code: Comparación | Solución</a> <code>bruto/Grabaciones/26_Codex_vs_Claude_Code_Comparación_Solución.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/27_ClawbotOpenClaw_Casos_de_Uso_Instalación.md" target="_blank" rel="noopener">Clawbot/OpenClaw: Casos de Uso, Instalación</a> <code>bruto/Grabaciones/27_ClawbotOpenClaw_Casos_de_Uso_Instalación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/28_Simulación_de_Ventas_en_vivo.md" target="_blank" rel="noopener">Simulación de Ventas en vivo</a> <code>bruto/Grabaciones/28_Simulación_de_Ventas_en_vivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/29_Cómo_escalar_automatizaciones_sin_romper_flujos.md" target="_blank" rel="noopener">Cómo escalar automatizaciones sin romper flujos</a> <code>bruto/Grabaciones/29_Cómo_escalar_automatizaciones_sin_romper_flujos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/30_Cuándo_Usar_IA_vs_Lógica_OCR_n8n.md" target="_blank" rel="noopener">Cuándo Usar IA vs Lógica (OCR + n8n)</a> <code>bruto/Grabaciones/30_Cuándo_Usar_IA_vs_Lógica_OCR_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/31_Agentes_de_Voz_con_n8n_GoHighLevel.md" target="_blank" rel="noopener">Agentes de Voz con n8n + GoHighLevel</a> <code>bruto/Grabaciones/31_Agentes_de_Voz_con_n8n_GoHighLevel.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/32_Cómo_Evitar_Alucinaciones.md" target="_blank" rel="noopener">Cómo Evitar Alucinaciones</a> <code>bruto/Grabaciones/32_Cómo_Evitar_Alucinaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/33_Diseño_de_bases_de_datos_en_Airtable.md" target="_blank" rel="noopener">Diseño de bases de datos en Airtable</a> <code>bruto/Grabaciones/33_Diseño_de_bases_de_datos_en_Airtable.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/34_Prompting_Aplicado_en_Agentes_IA.md" target="_blank" rel="noopener">Prompting Aplicado en Agentes IA</a> <code>bruto/Grabaciones/34_Prompting_Aplicado_en_Agentes_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/35_Auditoría_de_procesos_y_diseño_de_soluciones.md" target="_blank" rel="noopener">Auditoría de procesos y diseño de soluciones</a> <code>bruto/Grabaciones/35_Auditoría_de_procesos_y_diseño_de_soluciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/36_Agentes_de_IA_en_WhatsApp_con_N8N.md" target="_blank" rel="noopener">Agentes de IA en WhatsApp con N8N</a> <code>bruto/Grabaciones/36_Agentes_de_IA_en_WhatsApp_con_N8N.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/37_Notebook_LM_N8N.md" target="_blank" rel="noopener">Notebook LM + N8N</a> <code>bruto/Grabaciones/37_Notebook_LM_N8N.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/38_IA_aplicada_a_problemas_realea.md" target="_blank" rel="noopener">IA aplicada a problemas realea</a> <code>bruto/Grabaciones/38_IA_aplicada_a_problemas_realea.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/39_Intro_a_n8n.md" target="_blank" rel="noopener">🔥 Intro a n8n</a> <code>bruto/Grabaciones/39_Intro_a_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/40_Prospección_Inteligente_y_Bases_de_Datos_con_IA.md" target="_blank" rel="noopener">Prospección Inteligente y Bases de Datos con IA</a> <code>bruto/Grabaciones/40_Prospección_Inteligente_y_Bases_de_Datos_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/41_Automatizando_el_Negocio_de_un_Miembro.md" target="_blank" rel="noopener">Automatizando el Negocio de un Miembro</a> <code>bruto/Grabaciones/41_Automatizando_el_Negocio_de_un_Miembro.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/42_Context_Engineering.md" target="_blank" rel="noopener">Context Engineering</a> <code>bruto/Grabaciones/42_Context_Engineering.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/43_Comparativa_de_Software_de_Automatización.md" target="_blank" rel="noopener">Comparativa de Software de Automatización</a> <code>bruto/Grabaciones/43_Comparativa_de_Software_de_Automatización.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/44_Gestionar_Desarrollos.md" target="_blank" rel="noopener">Gestionar Desarrollos</a> <code>bruto/Grabaciones/44_Gestionar_Desarrollos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/45_ManyChat_Agentes_y_Bases_de_Datos.md" target="_blank" rel="noopener">ManyChat + Agentes y Bases de Datos</a> <code>bruto/Grabaciones/45_ManyChat_Agentes_y_Bases_de_Datos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/46_Modelos_de_Negocio_y_Pricing.md" target="_blank" rel="noopener">Modelos de Negocio y Pricing</a> <code>bruto/Grabaciones/46_Modelos_de_Negocio_y_Pricing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/47_GPT-5.md" target="_blank" rel="noopener">GPT-5</a> <code>bruto/Grabaciones/47_GPT-5.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/48_Cómo_Plantear_un_Proyecto_de_Agente_de_IA.md" target="_blank" rel="noopener">Cómo Plantear un Proyecto de Agente de IA</a> <code>bruto/Grabaciones/48_Cómo_Plantear_un_Proyecto_de_Agente_de_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/49_Profundización_en_Airtable.md" target="_blank" rel="noopener">Profundización en Airtable</a> <code>bruto/Grabaciones/49_Profundización_en_Airtable.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/50_Tu_Primera_Automatización.md" target="_blank" rel="noopener">Tu Primera Automatización</a> <code>bruto/Grabaciones/50_Tu_Primera_Automatización.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/51_Presentar_Propuestas_Irresistibles.md" target="_blank" rel="noopener">Presentar Propuestas Irresistibles</a> <code>bruto/Grabaciones/51_Presentar_Propuestas_Irresistibles.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/52_Conecta_Apps_sin_Módulo_Nativo_en_Make.md" target="_blank" rel="noopener">Conecta Apps sin Módulo Nativo en Make</a> <code>bruto/Grabaciones/52_Conecta_Apps_sin_Módulo_Nativo_en_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/53_Planificar_Proyectos_de_Automatización.md" target="_blank" rel="noopener">Planificar Proyectos de Automatización</a> <code>bruto/Grabaciones/53_Planificar_Proyectos_de_Automatización.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/54_Make_vs_N8N.md" target="_blank" rel="noopener">Make vs N8N</a> <code>bruto/Grabaciones/54_Make_vs_N8N.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/55_Manychat.md" target="_blank" rel="noopener">Manychat!</a> <code>bruto/Grabaciones/55_Manychat.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/56_GoHighLevel.md" target="_blank" rel="noopener">GoHighLevel</a> <code>bruto/Grabaciones/56_GoHighLevel.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/57_Agentes_de_Make_Pt_2.md" target="_blank" rel="noopener">Agentes de Make (Pt. 2)</a> <code>bruto/Grabaciones/57_Agentes_de_Make_Pt_2.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/58_Agentes_de_Make.md" target="_blank" rel="noopener">Agentes de Make</a> <code>bruto/Grabaciones/58_Agentes_de_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/59_Cobros_por_WhatsApp.md" target="_blank" rel="noopener">Cobros por WhatsApp</a> <code>bruto/Grabaciones/59_Cobros_por_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/60_Interfaces_en_Airtable.md" target="_blank" rel="noopener">Interfaces en Airtable</a> <code>bruto/Grabaciones/60_Interfaces_en_Airtable.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/61_Detección_de_errores_en_Make.md" target="_blank" rel="noopener">Detección de errores en Make</a> <code>bruto/Grabaciones/61_Detección_de_errores_en_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/62_Chatbot_en_WhatsApp_Business.md" target="_blank" rel="noopener">Chatbot en WhatsApp Business</a> <code>bruto/Grabaciones/62_Chatbot_en_WhatsApp_Business.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/63_Iterator_Aggregator_Make.md" target="_blank" rel="noopener">Iterator + Aggregator (Make)</a> <code>bruto/Grabaciones/63_Iterator_Aggregator_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/64_Automatiza_WhatsApp_con_Wapi.md" target="_blank" rel="noopener">Automatiza WhatsApp con Wapi</a> <code>bruto/Grabaciones/64_Automatiza_WhatsApp_con_Wapi.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/65_Agentes_Replicables.md" target="_blank" rel="noopener">Agentes Replicables</a> <code>bruto/Grabaciones/65_Agentes_Replicables.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/66_Google_Sheets_y_Flujos.md" target="_blank" rel="noopener">Google Sheets y Flujos</a> <code>bruto/Grabaciones/66_Google_Sheets_y_Flujos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/67_APIs_y_Bases_de_Datos.md" target="_blank" rel="noopener">APIs y Bases de Datos</a> <code>bruto/Grabaciones/67_APIs_y_Bases_de_Datos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/68_Café_Café.md" target="_blank" rel="noopener">Café Café</a> <code>bruto/Grabaciones/68_Café_Café.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/69_Whapi.md" target="_blank" rel="noopener">Whapi</a> <code>bruto/Grabaciones/69_Whapi.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/70_Deployment_en_WhatsApp.md" target="_blank" rel="noopener">Deployment en WhatsApp</a> <code>bruto/Grabaciones/70_Deployment_en_WhatsApp.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/71_Relevance_AI.md" target="_blank" rel="noopener">Relevance AI</a> <code>bruto/Grabaciones/71_Relevance_AI.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/72_Calificación_de_Leads.md" target="_blank" rel="noopener">Calificación de Leads</a> <code>bruto/Grabaciones/72_Calificación_de_Leads.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/73_Apps_NO_Compatibles_con_Make.md" target="_blank" rel="noopener">Apps NO Compatibles con Make</a> <code>bruto/Grabaciones/73_Apps_NO_Compatibles_con_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/74_Documentos_y_Asistentes.md" target="_blank" rel="noopener">Documentos y Asistentes</a> <code>bruto/Grabaciones/74_Documentos_y_Asistentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/75_Equipo_de_Trabajo_IA.md" target="_blank" rel="noopener">Equipo de Trabajo IA</a> <code>bruto/Grabaciones/75_Equipo_de_Trabajo_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/76_Asistentes_ChatGPT_Make.md" target="_blank" rel="noopener">Asistentes ChatGPT + Make</a> <code>bruto/Grabaciones/76_Asistentes_ChatGPT_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/77_Webhooks_y_HTTPs.md" target="_blank" rel="noopener">Webhooks y HTTPs</a> <code>bruto/Grabaciones/77_Webhooks_y_HTTPs.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/78_Filtros_en_Make.md" target="_blank" rel="noopener">Filtros en Make</a> <code>bruto/Grabaciones/78_Filtros_en_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/79_Automatización_de_Onboarding.md" target="_blank" rel="noopener">Automatización de Onboarding</a> <code>bruto/Grabaciones/79_Automatización_de_Onboarding.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/80_Presentación.md" target="_blank" rel="noopener">Presentación</a> <code>bruto/Grabaciones/80_Presentación.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/81_Sesión_con_Benja.md" target="_blank" rel="noopener">🚀 Sesión con Benja</a> <code>bruto/Grabaciones/81_Sesión_con_Benja.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/82_Intro_a_Claude_Code_500_skills.md" target="_blank" rel="noopener">Intro a Claude Code + 500 skills</a> <code>bruto/Grabaciones/82_Intro_a_Claude_Code_500_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/83_Automatización_Clasificación_de_Leads_-_28_Mar.md" target="_blank" rel="noopener">Automatización Clasificación de Leads - 28 Mar</a> <code>bruto/Grabaciones/83_Automatización_Clasificación_de_Leads_-_28_Mar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/84_Automatizaciones_desde_Whatsapp_-_19_de_Feb.md" target="_blank" rel="noopener">Automatizaciones desde Whatsapp - 19 de Feb</a> <code>bruto/Grabaciones/84_Automatizaciones_desde_Whatsapp_-_19_de_Feb.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/85_RAG_Asistentes_Vector_Store_-_05_Febrero_2025.md" target="_blank" rel="noopener">(RAG) Asistentes &amp; Vector Store - 05 Febrero 2025</a> <code>bruto/Grabaciones/85_RAG_Asistentes_Vector_Store_-_05_Febrero_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/86_Lo_Que_Se_Viene_-_22_de_Enero.md" target="_blank" rel="noopener">Lo Que Se Viene - 22 de Enero</a> <code>bruto/Grabaciones/86_Lo_Que_Se_Viene_-_22_de_Enero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/87_Apify_para_Consiguir_Leads_-_8_de_Enero.md" target="_blank" rel="noopener">Apify para Consiguir Leads - 8 de Enero</a> <code>bruto/Grabaciones/87_Apify_para_Consiguir_Leads_-_8_de_Enero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/88_QA_18_de_Diciembre_Flux_LoRa.md" target="_blank" rel="noopener">Q&amp;A 18 de Diciembre: Flux LoRa</a> <code>bruto/Grabaciones/88_QA_18_de_Diciembre_Flux_LoRa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/89_QA_4_de_Diciembre_2024_APP_en_Vivo_con_IA.md" target="_blank" rel="noopener">Q&amp;A 4 de Diciembre 2024: APP en Vivo con IA</a> <code>bruto/Grabaciones/89_QA_4_de_Diciembre_2024_APP_en_Vivo_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/90_Automatización_con_Voz_-_20_de_Nov.md" target="_blank" rel="noopener">Automatización con Voz - 20 de Nov</a> <code>bruto/Grabaciones/90_Automatización_con_Voz_-_20_de_Nov.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/91_QA_6_de_Noviembre_2024.md" target="_blank" rel="noopener">Q&amp;A 6 de Noviembre 2024</a> <code>bruto/Grabaciones/91_QA_6_de_Noviembre_2024.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/92_QA_23_de_Octubre_2024.md" target="_blank" rel="noopener">Q&amp;A 23 de Octubre 2024</a> <code>bruto/Grabaciones/92_QA_23_de_Octubre_2024.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/93_QA_9_de_Octubre_2024.md" target="_blank" rel="noopener">Q&amp;A 9 de Octubre 2024</a> <code>bruto/Grabaciones/93_QA_9_de_Octubre_2024.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/94_QA_25_Septiembre_2024.md" target="_blank" rel="noopener">Q&amp;A 25 Septiembre 2024</a> <code>bruto/Grabaciones/94_QA_25_Septiembre_2024.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/95_QA_11_Septiembre_2024.md" target="_blank" rel="noopener">Q&amp;A 11 Septiembre 2024</a> <code>bruto/Grabaciones/95_QA_11_Septiembre_2024.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/96_New_page.md" target="_blank" rel="noopener">New page</a> <code>bruto/Grabaciones/96_New_page.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/97_Workshops_Webinars.md" target="_blank" rel="noopener">⭐ Workshops + Webinars</a> <code>bruto/Grabaciones/97_Workshops_Webinars.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/98_Makecom_-_Masterclass_con_Francisco_de_Brito.md" target="_blank" rel="noopener">Make.com - Masterclass con Francisco de Brito</a> <code>bruto/Grabaciones/98_Makecom_-_Masterclass_con_Francisco_de_Brito.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Grabaciones/99_Apify_Make_Webinar.md" target="_blank" rel="noopener">Apify + Make (Webinar)</a> <code>bruto/Grabaciones/99_Apify_Make_Webinar.md</code></li>
</ul>$lf_module_42$,
    160,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-make-desde-0',
    'imperio-agentico',
    'Make Desde 0',
    '🏛️',
    '20 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_43$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Make Desde 0 · 20 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/01_Make_Desde_0.md" target="_blank" rel="noopener">Make Desde 0</a> <code>bruto/Make_Desde_0/01_Make_Desde_0.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/02_Empieza_Make_Aquí.md" target="_blank" rel="noopener">🏁 Empieza Make Aquí</a> <code>bruto/Make_Desde_0/02_Empieza_Make_Aquí.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/03_Automatiza_con_Make.md" target="_blank" rel="noopener">🚀Automatiza con Make</a> <code>bruto/Make_Desde_0/03_Automatiza_con_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/04_Conceptos_Básicos_Cómo_Importar.md" target="_blank" rel="noopener">🧩Conceptos Básicos + Cómo Importar</a> <code>bruto/Make_Desde_0/04_Conceptos_Básicos_Cómo_Importar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/05_OPCIONAL_Conexión_de_Google_con_Make.md" target="_blank" rel="noopener">📌 (OPCIONAL) Conexión de Google con Make</a> <code>bruto/Make_Desde_0/05_OPCIONAL_Conexión_de_Google_con_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/06_Tu_Primer_Flujo_de_Trabajo.md" target="_blank" rel="noopener">🔧Tu Primer Flujo de Trabajo</a> <code>bruto/Make_Desde_0/06_Tu_Primer_Flujo_de_Trabajo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/07_Disparadores_Triggers.md" target="_blank" rel="noopener">⏰Disparadores / Triggers</a> <code>bruto/Make_Desde_0/07_Disparadores_Triggers.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/08_Filtros_y_Condiciones.md" target="_blank" rel="noopener">🔍Filtros y Condiciones</a> <code>bruto/Make_Desde_0/08_Filtros_y_Condiciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/09_Rutas_Alternativas_Routers.md" target="_blank" rel="noopener">🔀Rutas Alternativas / Routers</a> <code>bruto/Make_Desde_0/09_Rutas_Alternativas_Routers.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/10_Procesamiento_de_Listas_Iterator.md" target="_blank" rel="noopener">🔄Procesamiento de Listas / Iterator</a> <code>bruto/Make_Desde_0/10_Procesamiento_de_Listas_Iterator.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/11_Agrupación_de_Datos_Aggregator.md" target="_blank" rel="noopener">📊Agrupación de Datos / Aggregator</a> <code>bruto/Make_Desde_0/11_Agrupación_de_Datos_Aggregator.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/12_Variables_en_Make.md" target="_blank" rel="noopener">🗂️Variables en Make</a> <code>bruto/Make_Desde_0/12_Variables_en_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/13_Funciones_en_Make.md" target="_blank" rel="noopener">➕Funciones en Make</a> <code>bruto/Make_Desde_0/13_Funciones_en_Make.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/14_HTTP_y_Conexión_a_APIs_Externas.md" target="_blank" rel="noopener">🌐HTTP y Conexión a APIs Externas</a> <code>bruto/Make_Desde_0/14_HTTP_y_Conexión_a_APIs_Externas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/15_Webhooks_Personalizados_y_Avanzados.md" target="_blank" rel="noopener">📬Webhooks Personalizados y Avanzados</a> <code>bruto/Make_Desde_0/15_Webhooks_Personalizados_y_Avanzados.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/16_Integración_con_Herramientas_Avanzadas.md" target="_blank" rel="noopener">🔗Integración con Herramientas Avanzadas</a> <code>bruto/Make_Desde_0/16_Integración_con_Herramientas_Avanzadas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/17_Manejo_y_Resolución_de_Errores.md" target="_blank" rel="noopener">🛠️Manejo y Resolución de Errores</a> <code>bruto/Make_Desde_0/17_Manejo_y_Resolución_de_Errores.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/18_Mejores_Prácticas_y_Optimización.md" target="_blank" rel="noopener">📈 Mejores Prácticas y Optimización</a> <code>bruto/Make_Desde_0/18_Mejores_Prácticas_y_Optimización.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/19_Proyecto_Final.md" target="_blank" rel="noopener">🏆Proyecto Final</a> <code>bruto/Make_Desde_0/19_Proyecto_Final.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Make_Desde_0/20_BONUS_Intensivo_Google_Sheets_Make.md" target="_blank" rel="noopener">⭐BONUS: Intensivo Google Sheets + Make</a> <code>bruto/Make_Desde_0/20_BONUS_Intensivo_Google_Sheets_Make.md</code></li>
</ul>$lf_module_43$,
    170,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-mentalidad-ia',
    'imperio-agentico',
    'Mentalidad IA',
    '🏛️',
    '9 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_44$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Mentalidad IA · 9 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Mentalidad_IA/01_Mentalidad_IA.md" target="_blank" rel="noopener">Mentalidad IA</a> <code>bruto/Mentalidad_IA/01_Mentalidad_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Mentalidad_IA/02_Introducción_a_la_Mentalidad_IA.md" target="_blank" rel="noopener">Introducción a la Mentalidad IA</a> <code>bruto/Mentalidad_IA/02_Introducción_a_la_Mentalidad_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Mentalidad_IA/03_Generalista_vs_Especialista.md" target="_blank" rel="noopener">Generalista vs. Especialista</a> <code>bruto/Mentalidad_IA/03_Generalista_vs_Especialista.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Mentalidad_IA/04_GPTs_como_Agentes_Especialistas_en_Ti.md" target="_blank" rel="noopener">GPTs como Agentes Especialistas en Ti</a> <code>bruto/Mentalidad_IA/04_GPTs_como_Agentes_Especialistas_en_Ti.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Mentalidad_IA/05_Pensando_en_Prompts.md" target="_blank" rel="noopener">Pensando en Prompts</a> <code>bruto/Mentalidad_IA/05_Pensando_en_Prompts.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Mentalidad_IA/06_Automatización_de_Procesos_Especialistas.md" target="_blank" rel="noopener">Automatización de Procesos Especialistas</a> <code>bruto/Mentalidad_IA/06_Automatización_de_Procesos_Especialistas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Mentalidad_IA/07_Mirando_Hacia_el_Futuro.md" target="_blank" rel="noopener">Mirando Hacia el Futuro</a> <code>bruto/Mentalidad_IA/07_Mirando_Hacia_el_Futuro.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Mentalidad_IA/08_Lleva_los_GPTs_al_siguiente_nivel.md" target="_blank" rel="noopener">Lleva los GPTs al siguiente nivel</a> <code>bruto/Mentalidad_IA/08_Lleva_los_GPTs_al_siguiente_nivel.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Mentalidad_IA/09_Deep_Research_en_Ti.md" target="_blank" rel="noopener">Deep Research en Ti.</a> <code>bruto/Mentalidad_IA/09_Deep_Research_en_Ti.md</code></li>
</ul>$lf_module_44$,
    180,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-nivel-2-aprendiz',
    'imperio-agentico',
    'Nivel 2 - Aprendiz',
    '🏛️',
    '4 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_45$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Nivel 2 - Aprendiz · 4 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_2_-_Aprendiz/01_Nivel_2_-_Aprendiz.md" target="_blank" rel="noopener">Nivel 2 - Aprendiz 🌱</a> <code>bruto/Nivel_2_-_Aprendiz/01_Nivel_2_-_Aprendiz.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_2_-_Aprendiz/02_Nivel_2_Qué_esperar.md" target="_blank" rel="noopener">Nivel 2: ¿Qué esperar?</a> <code>bruto/Nivel_2_-_Aprendiz/02_Nivel_2_Qué_esperar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_2_-_Aprendiz/03_Imperio_OS.md" target="_blank" rel="noopener">🌱 Imperio OS</a> <code>bruto/Nivel_2_-_Aprendiz/03_Imperio_OS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_2_-_Aprendiz/04_Glosario_Imperial.md" target="_blank" rel="noopener">Glosario Imperial</a> <code>bruto/Nivel_2_-_Aprendiz/04_Glosario_Imperial.md</code></li>
</ul>$lf_module_45$,
    190,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-nivel-3-recluta',
    'imperio-agentico',
    'Nivel 3 - Recluta',
    '🏛️',
    '4 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_46$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Nivel 3 - Recluta · 4 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_3_-_Recluta/01_Nivel_3_-_Recluta.md" target="_blank" rel="noopener">Nivel 3 - Recluta 🛡️</a> <code>bruto/Nivel_3_-_Recluta/01_Nivel_3_-_Recluta.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_3_-_Recluta/02_Nivel_3_Qué_esperar.md" target="_blank" rel="noopener">Nivel 3: ¿Qué esperar?</a> <code>bruto/Nivel_3_-_Recluta/02_Nivel_3_Qué_esperar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_3_-_Recluta/03_Curso_Cómo_vender_automatizaciones.md" target="_blank" rel="noopener">Curso Cómo vender automatizaciones</a> <code>bruto/Nivel_3_-_Recluta/03_Curso_Cómo_vender_automatizaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_3_-_Recluta/04_Cómo_vendo_mis_automatizaciones.md" target="_blank" rel="noopener">Cómo vendo mis automatizaciones?</a> <code>bruto/Nivel_3_-_Recluta/04_Cómo_vendo_mis_automatizaciones.md</code></li>
</ul>$lf_module_46$,
    200,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-nivel-4-soldado',
    'imperio-agentico',
    'Nivel 4 - Soldado',
    '🏛️',
    '3 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_47$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Nivel 4 - Soldado · 3 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_4_-_Soldado/01_Nivel_4_-_Soldado.md" target="_blank" rel="noopener">Nivel 4 - Soldado ⚔️</a> <code>bruto/Nivel_4_-_Soldado/01_Nivel_4_-_Soldado.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_4_-_Soldado/02_Nivel_4_Qué_esperar.md" target="_blank" rel="noopener">Nivel 4: ¿Qué esperar?</a> <code>bruto/Nivel_4_-_Soldado/02_Nivel_4_Qué_esperar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_4_-_Soldado/03_Activa_tu_cuenta_de_GoHighLevel.md" target="_blank" rel="noopener">Activa tu cuenta de GoHighLevel 🛡️</a> <code>bruto/Nivel_4_-_Soldado/03_Activa_tu_cuenta_de_GoHighLevel.md</code></li>
</ul>$lf_module_47$,
    210,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-nivel-5-capitan',
    'imperio-agentico',
    'Nivel 5 - Capitán',
    '🏛️',
    '2 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_48$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Nivel 5 - Capitán · 2 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_5_-_Capitán/01_Nivel_5_-_Capitán.md" target="_blank" rel="noopener">Nivel 5 - Capitán 🗺️</a> <code>bruto/Nivel_5_-_Capitán/01_Nivel_5_-_Capitán.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_5_-_Capitán/02_Nivel_5_Qué_esperar.md" target="_blank" rel="noopener">Nivel 5: ¿Qué esperar?</a> <code>bruto/Nivel_5_-_Capitán/02_Nivel_5_Qué_esperar.md</code></li>
</ul>$lf_module_48$,
    220,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-nivel-6-comandante',
    'imperio-agentico',
    'Nivel 6 - Comandante',
    '🏛️',
    '13 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_49$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Nivel 6 - Comandante · 13 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/01_Nivel_6_-_Comandante.md" target="_blank" rel="noopener">Nivel 6 - Comandante 🎖️</a> <code>bruto/Nivel_6_-_Comandante/01_Nivel_6_-_Comandante.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/02_Nivel_6_Qué_esperar.md" target="_blank" rel="noopener">Nivel 6: ¿Qué esperar?</a> <code>bruto/Nivel_6_-_Comandante/02_Nivel_6_Qué_esperar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/03_Grabaciones_Sesiones_Comandantes.md" target="_blank" rel="noopener">Grabaciones Sesiones Comandantes</a> <code>bruto/Nivel_6_-_Comandante/03_Grabaciones_Sesiones_Comandantes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/04_Junio_de_2026.md" target="_blank" rel="noopener">Junio de 2026</a> <code>bruto/Nivel_6_-_Comandante/04_Junio_de_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/05_Abril_2026.md" target="_blank" rel="noopener">Abril 2026</a> <code>bruto/Nivel_6_-_Comandante/05_Abril_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/06_Marzo_de_2026.md" target="_blank" rel="noopener">Marzo de 2026</a> <code>bruto/Nivel_6_-_Comandante/06_Marzo_de_2026.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/07_Octubre_de_2025.md" target="_blank" rel="noopener">Octubre de 2025</a> <code>bruto/Nivel_6_-_Comandante/07_Octubre_de_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/08_Septiembre_2025.md" target="_blank" rel="noopener">Septiembre 2025</a> <code>bruto/Nivel_6_-_Comandante/08_Septiembre_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/09_Junio_2025.md" target="_blank" rel="noopener">Junio 2025</a> <code>bruto/Nivel_6_-_Comandante/09_Junio_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/10_Mayo_2025.md" target="_blank" rel="noopener">Mayo 2025</a> <code>bruto/Nivel_6_-_Comandante/10_Mayo_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/11_Abril_2025.md" target="_blank" rel="noopener">Abril 2025</a> <code>bruto/Nivel_6_-_Comandante/11_Abril_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/12_Marzo_2025.md" target="_blank" rel="noopener">Marzo 2025</a> <code>bruto/Nivel_6_-_Comandante/12_Marzo_2025.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_6_-_Comandante/13_Febrero_2025.md" target="_blank" rel="noopener">Febrero 2025</a> <code>bruto/Nivel_6_-_Comandante/13_Febrero_2025.md</code></li>
</ul>$lf_module_49$,
    230,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-nivel-7-general',
    'imperio-agentico',
    'Nivel 7 - General',
    '🏛️',
    '2 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_50$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Nivel 7 - General · 2 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_7_-_General/01_Nivel_7_-_General.md" target="_blank" rel="noopener">Nivel 7 - General 👑</a> <code>bruto/Nivel_7_-_General/01_Nivel_7_-_General.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_7_-_General/02_Nivel_7_Qué_esperar.md" target="_blank" rel="noopener">Nivel 7: ¿Qué esperar?</a> <code>bruto/Nivel_7_-_General/02_Nivel_7_Qué_esperar.md</code></li>
</ul>$lf_module_50$,
    240,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-nivel-8-gran-maestro',
    'imperio-agentico',
    'Nivel 8 - Gran Maestro',
    '🏛️',
    '2 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_51$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Nivel 8 - Gran Maestro · 2 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_8_-_Gran_Maestro/01_Nivel_8_-_Gran_Maestro.md" target="_blank" rel="noopener">Nivel 8 - Gran Maestro 🧙‍♂️</a> <code>bruto/Nivel_8_-_Gran_Maestro/01_Nivel_8_-_Gran_Maestro.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_8_-_Gran_Maestro/02_Nivel_8_Obtén_tu_Membresía_Gratuita.md" target="_blank" rel="noopener">Nivel 8: Obtén tu Membresía Gratuita</a> <code>bruto/Nivel_8_-_Gran_Maestro/02_Nivel_8_Obtén_tu_Membresía_Gratuita.md</code></li>
</ul>$lf_module_51$,
    250,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-nivel-9-aeternum',
    'imperio-agentico',
    'Nivel 9 - Æternum',
    '🏛️',
    '2 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_52$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Nivel 9 - Æternum · 2 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_9_-_Æternum/01_Nivel_9_-_Æternum.md" target="_blank" rel="noopener">Nivel 9 - Æternum</a> <code>bruto/Nivel_9_-_Æternum/01_Nivel_9_-_Æternum.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Nivel_9_-_Æternum/02_Felicidades.md" target="_blank" rel="noopener">Felicidades</a> <code>bruto/Nivel_9_-_Æternum/02_Felicidades.md</code></li>
</ul>$lf_module_52$,
    260,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-reto-imperial-openclaw',
    'imperio-agentico',
    'Reto Imperial OpenClaw',
    '🏛️',
    '40 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_53$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Reto Imperial OpenClaw · 40 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/01_Reto_Imperial_OpenClaw.md" target="_blank" rel="noopener">🦞 Reto Imperial OpenClaw</a> <code>bruto/Reto_Imperial_OpenClaw/01_Reto_Imperial_OpenClaw.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/02_HERMES_2026_Curso_COMPLETO_Agente_IA.md" target="_blank" rel="noopener">HERMES 2026: Curso COMPLETO (Agente IA)</a> <code>bruto/Reto_Imperial_OpenClaw/02_HERMES_2026_Curso_COMPLETO_Agente_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/03_Qué_es_OpenClaw_y_por_qué_te_importa.md" target="_blank" rel="noopener">🧭 ¿Qué es OpenClaw y por qué te importa?</a> <code>bruto/Reto_Imperial_OpenClaw/03_Qué_es_OpenClaw_y_por_qué_te_importa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/04_Antes_de_empezar_marco_mental.md" target="_blank" rel="noopener">📖 Antes de empezar: marco mental</a> <code>bruto/Reto_Imperial_OpenClaw/04_Antes_de_empezar_marco_mental.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/05_Qué_es_OpenClaw_ex_-_Clawdbot.md" target="_blank" rel="noopener">🦞 ¿Qué es OpenClaw? (ex - Clawdbot)</a> <code>bruto/Reto_Imperial_OpenClaw/05_Qué_es_OpenClaw_ex_-_Clawdbot.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/06_OpenClaw_mi_opinión_después_de_un_mes_de_uso.md" target="_blank" rel="noopener">​🔍 OpenClaw: mi opinión después de un mes de uso</a> <code>bruto/Reto_Imperial_OpenClaw/06_OpenClaw_mi_opinión_después_de_un_mes_de_uso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/07_Decisiones_requisitos_y_costos.md" target="_blank" rel="noopener">🛠️ Decisiones, requisitos y costos</a> <code>bruto/Reto_Imperial_OpenClaw/07_Decisiones_requisitos_y_costos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/08_Instala_tu_OpenClaw_vía_VPS_con_Hostinger.md" target="_blank" rel="noopener">🦞 Instala tu OpenClaw vía VPS con Hostinger</a> <code>bruto/Reto_Imperial_OpenClaw/08_Instala_tu_OpenClaw_vía_VPS_con_Hostinger.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/09_Curso_Instalación_en_VPS_con_Hostinger.md" target="_blank" rel="noopener">[Curso] 🚀 Instalación en VPS con Hostinger</a> <code>bruto/Reto_Imperial_OpenClaw/09_Curso_Instalación_en_VPS_con_Hostinger.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/10_Curso_Seguridad_y_Túnel_Privado_-_Tailscale.md" target="_blank" rel="noopener">[Curso] 🛡️ Seguridad y Túnel Privado - Tailscale</a> <code>bruto/Reto_Imperial_OpenClaw/10_Curso_Seguridad_y_Túnel_Privado_-_Tailscale.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/11_Curso_Configuración_y_uso_en_Telegram.md" target="_blank" rel="noopener">[Curso] 💬 Configuración y uso en Telegram</a> <code>bruto/Reto_Imperial_OpenClaw/11_Curso_Configuración_y_uso_en_Telegram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/12_Cómo_Proteger_Openclaw_en_un_VPS.md" target="_blank" rel="noopener">🔒 Cómo Proteger Openclaw en un VPS</a> <code>bruto/Reto_Imperial_OpenClaw/12_Cómo_Proteger_Openclaw_en_un_VPS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/13_Instala_tu_OpenClaw_vía_Mac_Mini_en_local.md" target="_blank" rel="noopener">🦞 Instala tu OpenClaw vía Mac Mini en local</a> <code>bruto/Reto_Imperial_OpenClaw/13_Instala_tu_OpenClaw_vía_Mac_Mini_en_local.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/14_OpenClaw_en_Mac_Mini_desde_cero_paso_a_paso.md" target="_blank" rel="noopener">🍎 OpenClaw en Mac Mini desde cero (paso a paso)</a> <code>bruto/Reto_Imperial_OpenClaw/14_OpenClaw_en_Mac_Mini_desde_cero_paso_a_paso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/15_OpenClaw_GRATIS_Ollama_IA_a_nivel_local.md" target="_blank" rel="noopener">🦙 OpenClaw GRATIS + Ollama (IA a nivel local)</a> <code>bruto/Reto_Imperial_OpenClaw/15_OpenClaw_GRATIS_Ollama_IA_a_nivel_local.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/16_Configura_tu_asistente_y_dale_alma.md" target="_blank" rel="noopener">🤖 Configura tu asistente y dale alma</a> <code>bruto/Reto_Imperial_OpenClaw/16_Configura_tu_asistente_y_dale_alma.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/17_Framework_SOUL.md" target="_blank" rel="noopener">🧬 Framework SOUL</a> <code>bruto/Reto_Imperial_OpenClaw/17_Framework_SOUL.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/18_Conceptos_clave.md" target="_blank" rel="noopener">💡 Conceptos clave</a> <code>bruto/Reto_Imperial_OpenClaw/18_Conceptos_clave.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/19_Tu_primera_tarea_contéctalo_a_Internet.md" target="_blank" rel="noopener">🆕 Tu primera tarea: contéctalo a Internet</a> <code>bruto/Reto_Imperial_OpenClaw/19_Tu_primera_tarea_contéctalo_a_Internet.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/20_Backups_automáticos_a_GitHub.md" target="_blank" rel="noopener">💾 Backups automáticos a GitHub</a> <code>bruto/Reto_Imperial_OpenClaw/20_Backups_automáticos_a_GitHub.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/21_Tu_primer_caso_de_uso_real.md" target="_blank" rel="noopener">😎 Tu primer caso de uso real</a> <code>bruto/Reto_Imperial_OpenClaw/21_Tu_primer_caso_de_uso_real.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/22_Tu_primer_caso_de_uso_real.md" target="_blank" rel="noopener">😎 Tu primer caso de uso real</a> <code>bruto/Reto_Imperial_OpenClaw/22_Tu_primer_caso_de_uso_real.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/23_El_Gran_Consejo_multi-agente.md" target="_blank" rel="noopener">🪐 El Gran Consejo (multi-agente)</a> <code>bruto/Reto_Imperial_OpenClaw/23_El_Gran_Consejo_multi-agente.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/24_Concepto_arquitectura_del_Gran_Consejo.md" target="_blank" rel="noopener">💡 Concepto: arquitectura del Gran Consejo</a> <code>bruto/Reto_Imperial_OpenClaw/24_Concepto_arquitectura_del_Gran_Consejo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/25_Roles_canales_y_memoria.md" target="_blank" rel="noopener">🎭 Roles, canales y memoria</a> <code>bruto/Reto_Imperial_OpenClaw/25_Roles_canales_y_memoria.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/26_Plan_de_acción_arma_tu_primer_Consejo.md" target="_blank" rel="noopener">🚀 Plan de acción: arma tu primer Consejo</a> <code>bruto/Reto_Imperial_OpenClaw/26_Plan_de_acción_arma_tu_primer_Consejo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/27_Centro_de_control.md" target="_blank" rel="noopener">🖥️ Centro de control</a> <code>bruto/Reto_Imperial_OpenClaw/27_Centro_de_control.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/28_Centro_de_Control_Mission_Control.md" target="_blank" rel="noopener">🖥️ Centro de Control (Mission Control)</a> <code>bruto/Reto_Imperial_OpenClaw/28_Centro_de_Control_Mission_Control.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/29_Optimiza_CronJobs_y_HeartBeats.md" target="_blank" rel="noopener">💙 Optimiza CronJobs y HeartBeats</a> <code>bruto/Reto_Imperial_OpenClaw/29_Optimiza_CronJobs_y_HeartBeats.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/30_Optimiza_CronJobs_y_HeartBeats.md" target="_blank" rel="noopener">💙 Optimiza CronJobs y HeartBeats</a> <code>bruto/Reto_Imperial_OpenClaw/30_Optimiza_CronJobs_y_HeartBeats.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/31_Cuentas_e_identidad_para_tus_agentes.md" target="_blank" rel="noopener">🌍 Cuentas e identidad para tus agentes</a> <code>bruto/Reto_Imperial_OpenClaw/31_Cuentas_e_identidad_para_tus_agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/32_Cuentas_e_identidad_para_tus_agentes.md" target="_blank" rel="noopener">🌍 Cuentas e identidad para tus agentes</a> <code>bruto/Reto_Imperial_OpenClaw/32_Cuentas_e_identidad_para_tus_agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/33_Acceso_a_correo_calendario_y_páginas_web.md" target="_blank" rel="noopener">📨 Acceso a correo, calendario y páginas web</a> <code>bruto/Reto_Imperial_OpenClaw/33_Acceso_a_correo_calendario_y_páginas_web.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/34_Correo_y_calendario_Google_Cloud.md" target="_blank" rel="noopener">📧 Correo y calendario (Google Cloud)</a> <code>bruto/Reto_Imperial_OpenClaw/34_Correo_y_calendario_Google_Cloud.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/35_Acceso_a_páginas_web_Playwright.md" target="_blank" rel="noopener">🌐 Acceso a páginas web (Playwright)</a> <code>bruto/Reto_Imperial_OpenClaw/35_Acceso_a_páginas_web_Playwright.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/36_Si_terminaste_todas_las_lecciones.md" target="_blank" rel="noopener">✅ Si terminaste todas las lecciones</a> <code>bruto/Reto_Imperial_OpenClaw/36_Si_terminaste_todas_las_lecciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/37_Si_terminaste_todas_las_lecciones.md" target="_blank" rel="noopener">✅ Si terminaste todas las lecciones</a> <code>bruto/Reto_Imperial_OpenClaw/37_Si_terminaste_todas_las_lecciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/38_Lives_OpenClaw_de_los_Miércoles_de_Vibecoding.md" target="_blank" rel="noopener">🔴 Lives OpenClaw (de los Miércoles de Vibecoding)</a> <code>bruto/Reto_Imperial_OpenClaw/38_Lives_OpenClaw_de_los_Miércoles_de_Vibecoding.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/39_OpenClaw_Claude_Code_Memoria_y_Skills.md" target="_blank" rel="noopener">🧠 OpenClaw + Claude Code: Memoria y Skills</a> <code>bruto/Reto_Imperial_OpenClaw/39_OpenClaw_Claude_Code_Memoria_y_Skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Reto_Imperial_OpenClaw/40_Claude_Code_vs_OpenClaw_Agentes_Sub-agentes.md" target="_blank" rel="noopener">🆚 Claude Code vs OpenClaw: Agentes, Sub-agentes.</a> <code>bruto/Reto_Imperial_OpenClaw/40_Claude_Code_vs_OpenClaw_Agentes_Sub-agentes.md</code></li>
</ul>$lf_module_53$,
    270,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-soporte',
    'imperio-agentico',
    'Soporte',
    '🏛️',
    '75 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_54$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Soporte · 75 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/01_Soporte.md" target="_blank" rel="noopener">🛠️ Soporte</a> <code>bruto/Soporte/01_Soporte.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/02_Como_obtener_soporte_dentro_de_Imperio_Digital.md" target="_blank" rel="noopener">🎥 Como obtener soporte dentro de Imperio Digital</a> <code>bruto/Soporte/02_Como_obtener_soporte_dentro_de_Imperio_Digital.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/03_Soporte.md" target="_blank" rel="noopener">Soporte 🔧</a> <code>bruto/Soporte/03_Soporte.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/04_Soporte_-_16_de_junio.md" target="_blank" rel="noopener">Soporte - 16 de junio</a> <code>bruto/Soporte/04_Soporte_-_16_de_junio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/05_Soporte_-_9_de_Junio.md" target="_blank" rel="noopener">Soporte - 9 de Junio</a> <code>bruto/Soporte/05_Soporte_-_9_de_Junio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/06_Soporte_-_27_de_Mayo.md" target="_blank" rel="noopener">Soporte - 27 de Mayo</a> <code>bruto/Soporte/06_Soporte_-_27_de_Mayo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/07_Soporte_-_19_de_Mayo.md" target="_blank" rel="noopener">Soporte - 19 de Mayo</a> <code>bruto/Soporte/07_Soporte_-_19_de_Mayo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/08_Soporte_-_12_de_Mayo.md" target="_blank" rel="noopener">Soporte - 12 de Mayo</a> <code>bruto/Soporte/08_Soporte_-_12_de_Mayo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/09_Soporte_-_5_de_Mayo.md" target="_blank" rel="noopener">Soporte - 5 de Mayo</a> <code>bruto/Soporte/09_Soporte_-_5_de_Mayo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/10_Soporte_-_28_de_Abril.md" target="_blank" rel="noopener">Soporte - 28 de Abril</a> <code>bruto/Soporte/10_Soporte_-_28_de_Abril.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/11_Soporte_-_21_de_Abril.md" target="_blank" rel="noopener">Soporte - 21 de Abril</a> <code>bruto/Soporte/11_Soporte_-_21_de_Abril.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/12_Soporte_-_14_de_Abril.md" target="_blank" rel="noopener">Soporte - 14 de Abril</a> <code>bruto/Soporte/12_Soporte_-_14_de_Abril.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/13_Soporte_-_7_de_Abril.md" target="_blank" rel="noopener">Soporte - 7 de Abril</a> <code>bruto/Soporte/13_Soporte_-_7_de_Abril.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/14_Soporte_-_31_de_Marzo.md" target="_blank" rel="noopener">Soporte - 31 de Marzo</a> <code>bruto/Soporte/14_Soporte_-_31_de_Marzo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/15_Soporte_-_24_de_Marzo.md" target="_blank" rel="noopener">Soporte - 24 de Marzo</a> <code>bruto/Soporte/15_Soporte_-_24_de_Marzo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/16_Soporte_-_17_de_Marzo.md" target="_blank" rel="noopener">Soporte - 17 de Marzo</a> <code>bruto/Soporte/16_Soporte_-_17_de_Marzo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/17_Soporte_-_10_de_Marzo.md" target="_blank" rel="noopener">Soporte - 10 de Marzo</a> <code>bruto/Soporte/17_Soporte_-_10_de_Marzo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/18_Soporte_-_3_de_Marzo.md" target="_blank" rel="noopener">Soporte - 3 de Marzo</a> <code>bruto/Soporte/18_Soporte_-_3_de_Marzo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/19_Soporte_-_24_de_Febrero.md" target="_blank" rel="noopener">Soporte - 24 de Febrero</a> <code>bruto/Soporte/19_Soporte_-_24_de_Febrero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/20_Soporte_-_10_de_Febrero.md" target="_blank" rel="noopener">Soporte - 10 de Febrero</a> <code>bruto/Soporte/20_Soporte_-_10_de_Febrero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/21_Soporte_-_3_de_Febrero.md" target="_blank" rel="noopener">Soporte - 3 de Febrero</a> <code>bruto/Soporte/21_Soporte_-_3_de_Febrero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/22_Soporte_-_27_de_Enero.md" target="_blank" rel="noopener">Soporte - 27 de Enero</a> <code>bruto/Soporte/22_Soporte_-_27_de_Enero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/23_Soporte_-_23_de_Enero.md" target="_blank" rel="noopener">Soporte - 23 de Enero</a> <code>bruto/Soporte/23_Soporte_-_23_de_Enero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/24_Soporte_-_6_de_Enero.md" target="_blank" rel="noopener">Soporte - 6 de Enero</a> <code>bruto/Soporte/24_Soporte_-_6_de_Enero.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/25_Soporte_-_30_de_Diciembre.md" target="_blank" rel="noopener">Soporte - 30 de Diciembre</a> <code>bruto/Soporte/25_Soporte_-_30_de_Diciembre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/26_Soporte_-_23_de_diciembre.md" target="_blank" rel="noopener">Soporte - 23 de diciembre</a> <code>bruto/Soporte/26_Soporte_-_23_de_diciembre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/27_Soporte_-_16_de_Dic.md" target="_blank" rel="noopener">Soporte - 16 de Dic</a> <code>bruto/Soporte/27_Soporte_-_16_de_Dic.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/28_Soporte_-_9_de_Diciembre.md" target="_blank" rel="noopener">Soporte - 9 de Diciembre</a> <code>bruto/Soporte/28_Soporte_-_9_de_Diciembre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/29_Soporte_-_2_de_Dic.md" target="_blank" rel="noopener">Soporte - 2 de Dic</a> <code>bruto/Soporte/29_Soporte_-_2_de_Dic.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/30_Soporte_-_25_de_Nov.md" target="_blank" rel="noopener">Soporte - 25 de Nov</a> <code>bruto/Soporte/30_Soporte_-_25_de_Nov.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/31_Soporte_-_13_de_Nov.md" target="_blank" rel="noopener">Soporte - 13 de Nov</a> <code>bruto/Soporte/31_Soporte_-_13_de_Nov.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/32_Soporte_-_21_de_Oct.md" target="_blank" rel="noopener">Soporte - 21 de Oct</a> <code>bruto/Soporte/32_Soporte_-_21_de_Oct.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/33_Soporte_-_8_de_Oct.md" target="_blank" rel="noopener">Soporte - 8 de Oct</a> <code>bruto/Soporte/33_Soporte_-_8_de_Oct.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/34_Soporte_-_23_de_Septiembre.md" target="_blank" rel="noopener">Soporte - 23 de Septiembre</a> <code>bruto/Soporte/34_Soporte_-_23_de_Septiembre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/35_Soporte_-_9_de_Septiembre.md" target="_blank" rel="noopener">Soporte - 9 de Septiembre</a> <code>bruto/Soporte/35_Soporte_-_9_de_Septiembre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/36_Soporte_-_3_de_Septiembre.md" target="_blank" rel="noopener">Soporte - 3 de Septiembre</a> <code>bruto/Soporte/36_Soporte_-_3_de_Septiembre.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/37_Soporte_-_26_de_Agosto.md" target="_blank" rel="noopener">Soporte - 26 de Agosto</a> <code>bruto/Soporte/37_Soporte_-_26_de_Agosto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/38_Soporte_-_19_de_Agosto.md" target="_blank" rel="noopener">Soporte - 19 de Agosto</a> <code>bruto/Soporte/38_Soporte_-_19_de_Agosto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/39_Soporte_-_12_de_Agosto.md" target="_blank" rel="noopener">Soporte - 12 de Agosto</a> <code>bruto/Soporte/39_Soporte_-_12_de_Agosto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/40_Soporte_-_5_de_Agosto.md" target="_blank" rel="noopener">Soporte - 5 de Agosto</a> <code>bruto/Soporte/40_Soporte_-_5_de_Agosto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/41_Soporte_-_29_de_Julio.md" target="_blank" rel="noopener">Soporte - 29 de Julio</a> <code>bruto/Soporte/41_Soporte_-_29_de_Julio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/42_Soporte_-_22_de_Julio.md" target="_blank" rel="noopener">Soporte - 22 de Julio</a> <code>bruto/Soporte/42_Soporte_-_22_de_Julio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/43_Soporte_-_15_de_Julio.md" target="_blank" rel="noopener">Soporte - 15 de Julio</a> <code>bruto/Soporte/43_Soporte_-_15_de_Julio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/44_Soporte_-_8_de_Julio.md" target="_blank" rel="noopener">Soporte - 8 de Julio</a> <code>bruto/Soporte/44_Soporte_-_8_de_Julio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/45_Soporte_-_1_de_Julio.md" target="_blank" rel="noopener">Soporte - 1 de Julio</a> <code>bruto/Soporte/45_Soporte_-_1_de_Julio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/46_Soporte_-_24_de_Junio.md" target="_blank" rel="noopener">Soporte - 24 de Junio</a> <code>bruto/Soporte/46_Soporte_-_24_de_Junio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/47_Soporte_-_17_de_Junio.md" target="_blank" rel="noopener">Soporte - 17 de Junio</a> <code>bruto/Soporte/47_Soporte_-_17_de_Junio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/48_Soporte_-_10_de_Junio.md" target="_blank" rel="noopener">Soporte - 10 de Junio</a> <code>bruto/Soporte/48_Soporte_-_10_de_Junio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/49_Soporte_-_3_de_Junio.md" target="_blank" rel="noopener">Soporte - 3 de Junio</a> <code>bruto/Soporte/49_Soporte_-_3_de_Junio.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/50_Soporte_-_27_de_May.md" target="_blank" rel="noopener">Soporte - 27 de May</a> <code>bruto/Soporte/50_Soporte_-_27_de_May.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/51_Soporte_-_20_de_May.md" target="_blank" rel="noopener">Soporte - 20 de May</a> <code>bruto/Soporte/51_Soporte_-_20_de_May.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/52_Soporte_-_13_de_May.md" target="_blank" rel="noopener">Soporte - 13 de May</a> <code>bruto/Soporte/52_Soporte_-_13_de_May.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/53_Soporte_-_6_de_May.md" target="_blank" rel="noopener">Soporte - 6 de May</a> <code>bruto/Soporte/53_Soporte_-_6_de_May.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/54_Soporte_-_29_de_Abr.md" target="_blank" rel="noopener">Soporte - 29 de Abr</a> <code>bruto/Soporte/54_Soporte_-_29_de_Abr.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/55_Soporte_-_22_de_Abr.md" target="_blank" rel="noopener">Soporte - 22 de Abr</a> <code>bruto/Soporte/55_Soporte_-_22_de_Abr.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/56_Soporte_-_15_de_Abr.md" target="_blank" rel="noopener">Soporte - 15 de Abr</a> <code>bruto/Soporte/56_Soporte_-_15_de_Abr.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/57_Soporte_-_8_de_Abr.md" target="_blank" rel="noopener">Soporte - 8 de Abr</a> <code>bruto/Soporte/57_Soporte_-_8_de_Abr.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/58_Soporte_-_1_de_Abr.md" target="_blank" rel="noopener">Soporte - 1 de Abr</a> <code>bruto/Soporte/58_Soporte_-_1_de_Abr.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/59_Soporte_-_25_de_Mar.md" target="_blank" rel="noopener">Soporte - 25 de Mar</a> <code>bruto/Soporte/59_Soporte_-_25_de_Mar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/60_Soporte_-_18_de_Mar.md" target="_blank" rel="noopener">Soporte - 18 de Mar</a> <code>bruto/Soporte/60_Soporte_-_18_de_Mar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/61_Soporte_-_4_de_Mar.md" target="_blank" rel="noopener">Soporte - 4 de Mar</a> <code>bruto/Soporte/61_Soporte_-_4_de_Mar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/62_Soporte_-_25_de_Feb.md" target="_blank" rel="noopener">Soporte - 25 de Feb</a> <code>bruto/Soporte/62_Soporte_-_25_de_Feb.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/63_Soporte_-_18_de_Feb.md" target="_blank" rel="noopener">Soporte - 18 de Feb</a> <code>bruto/Soporte/63_Soporte_-_18_de_Feb.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/64_Soporte_-_11_de_Feb.md" target="_blank" rel="noopener">Soporte - 11 de Feb</a> <code>bruto/Soporte/64_Soporte_-_11_de_Feb.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/65_Soporte_-_4_de_Feb.md" target="_blank" rel="noopener">Soporte - 4 de Feb</a> <code>bruto/Soporte/65_Soporte_-_4_de_Feb.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/66_Soporte_-_28_de_Ene.md" target="_blank" rel="noopener">Soporte - 28 de Ene</a> <code>bruto/Soporte/66_Soporte_-_28_de_Ene.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/67_Soporte_-_21_de_Ene.md" target="_blank" rel="noopener">Soporte - 21 de Ene</a> <code>bruto/Soporte/67_Soporte_-_21_de_Ene.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/68_Soporte_-_14_de_Ene.md" target="_blank" rel="noopener">Soporte - 14 de Ene</a> <code>bruto/Soporte/68_Soporte_-_14_de_Ene.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/69_Soporte_-_7_de_Ene.md" target="_blank" rel="noopener">Soporte - 7 de Ene</a> <code>bruto/Soporte/69_Soporte_-_7_de_Ene.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/70_Soporte_-_31_de_Dic.md" target="_blank" rel="noopener">Soporte - 31 de Dic</a> <code>bruto/Soporte/70_Soporte_-_31_de_Dic.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/71_Soporte_-_24_de_Dic.md" target="_blank" rel="noopener">Soporte - 24 de Dic</a> <code>bruto/Soporte/71_Soporte_-_24_de_Dic.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/72_Soporte_-_17_de_Dic.md" target="_blank" rel="noopener">Soporte - 17 de Dic</a> <code>bruto/Soporte/72_Soporte_-_17_de_Dic.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/73_Soporte_-_10_de_Dic.md" target="_blank" rel="noopener">Soporte - 10 de Dic</a> <code>bruto/Soporte/73_Soporte_-_10_de_Dic.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/74_New_page.md" target="_blank" rel="noopener">New page</a> <code>bruto/Soporte/74_New_page.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Soporte/75_New_page.md" target="_blank" rel="noopener">New page</a> <code>bruto/Soporte/75_New_page.md</code></li>
</ul>$lf_module_54$,
    280,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-vibe-coding',
    'imperio-agentico',
    'Vibe-Coding',
    '🏛️',
    '49 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_55$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> Vibe-Coding · 49 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/01_Vibe-Coding.md" target="_blank" rel="noopener">Vibe-Coding</a> <code>bruto/Vibe-Coding/01_Vibe-Coding.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/02_Sesiones_de_Vibe_Coding.md" target="_blank" rel="noopener">Sesiones de Vibe Coding</a> <code>bruto/Vibe-Coding/02_Sesiones_de_Vibe_Coding.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/03_Cómo_gestionar_clientes_y_contexto_con_Claude_Code.md" target="_blank" rel="noopener">Cómo gestionar clientes y contexto con Claude Code</a> <code>bruto/Vibe-Coding/03_Cómo_gestionar_clientes_y_contexto_con_Claude_Code.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/04_De_Vibe_Coding_a_Vibe_Marketing.md" target="_blank" rel="noopener">De Vibe Coding a Vibe Marketing</a> <code>bruto/Vibe-Coding/04_De_Vibe_Coding_a_Vibe_Marketing.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/05_Fable_5_vs_Opus_48_los_enfrentamos_en_vivo.md" target="_blank" rel="noopener">Fable 5 vs Opus 4.8: los enfrentamos en vivo</a> <code>bruto/Vibe-Coding/05_Fable_5_vs_Opus_48_los_enfrentamos_en_vivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/06_Tu_agente_programa_solo_mientras_duermes.md" target="_blank" rel="noopener">Tu agente programa solo mientras duermes</a> <code>bruto/Vibe-Coding/06_Tu_agente_programa_solo_mientras_duermes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/07_Arneses_Conectados_Hermes_Claude_Code_en_Vivo.md" target="_blank" rel="noopener">Arneses Conectados: Hermes + Claude Code en Vivo</a> <code>bruto/Vibe-Coding/07_Arneses_Conectados_Hermes_Claude_Code_en_Vivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/08_Domina_GitHub_como_un_experto.md" target="_blank" rel="noopener">Domina GitHub como un experto</a> <code>bruto/Vibe-Coding/08_Domina_GitHub_como_un_experto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/09_Hermes_vs_OpenClaw_Skills_en_Claude_Code.md" target="_blank" rel="noopener">Hermes vs OpenClaw + Skills en Claude Code</a> <code>bruto/Vibe-Coding/09_Hermes_vs_OpenClaw_Skills_en_Claude_Code.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/10_Cómo_estructurar_sesiones_y_agentes_en_Claude_Code.md" target="_blank" rel="noopener">Cómo estructurar sesiones y agentes en Claude Code</a> <code>bruto/Vibe-Coding/10_Cómo_estructurar_sesiones_y_agentes_en_Claude_Code.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/11_Claude_Code_N8N_Kit_MCP_y_Skills_desde_0.md" target="_blank" rel="noopener">Claude Code + N8N : Kit, MCP y Skills desde 0</a> <code>bruto/Vibe-Coding/11_Claude_Code_N8N_Kit_MCP_y_Skills_desde_0.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/12_Cerramos_Núcleo_Deploy_GitHub_y_pruebas_en_vivo.md" target="_blank" rel="noopener">Cerramos Núcleo: Deploy, GitHub y pruebas en vivo</a> <code>bruto/Vibe-Coding/12_Cerramos_Núcleo_Deploy_GitHub_y_pruebas_en_vivo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/13_Claude_Code_Desktop_vs_CLI_vs_Extensión.md" target="_blank" rel="noopener">Claude Code Desktop vs CLI vs Extensión</a> <code>bruto/Vibe-Coding/13_Claude_Code_Desktop_vs_CLI_vs_Extensión.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/14_Cómo_no_quemar_tokens_construyendo_una_app_real.md" target="_blank" rel="noopener">Cómo no quemar tokens construyendo una app real</a> <code>bruto/Vibe-Coding/14_Cómo_no_quemar_tokens_construyendo_una_app_real.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/15_Construimos_una_app_desde_0_con_Claude_Code.md" target="_blank" rel="noopener">Construimos una app desde 0 con Claude Code</a> <code>bruto/Vibe-Coding/15_Construimos_una_app_desde_0_con_Claude_Code.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/16_OpenClaw_Claude_Code_Memoria_y_Skills.md" target="_blank" rel="noopener">OpenClaw + Claude Code: Memoria y Skills</a> <code>bruto/Vibe-Coding/16_OpenClaw_Claude_Code_Memoria_y_Skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/17_Claude_Code_estructura_de_proyectos_y_skills.md" target="_blank" rel="noopener">Claude Code: estructura de proyectos y skills</a> <code>bruto/Vibe-Coding/17_Claude_Code_estructura_de_proyectos_y_skills.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/18_Claude_Code_vs_OpenClaw_Agentes_Sub-agentes.md" target="_blank" rel="noopener">Claude Code vs OpenClaw: Agentes, Sub-agentes.</a> <code>bruto/Vibe-Coding/18_Claude_Code_vs_OpenClaw_Agentes_Sub-agentes.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/19_Vibe_Coding_Anti_Gravity_Claude_Code_y_OpenClaw.md" target="_blank" rel="noopener">Vibe Coding: Anti Gravity, Claude Code y OpenClaw</a> <code>bruto/Vibe-Coding/19_Vibe_Coding_Anti_Gravity_Claude_Code_y_OpenClaw.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/20_Claude.md" target="_blank" rel="noopener">Claude</a> <code>bruto/Vibe-Coding/20_Claude.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/21_Antigravity.md" target="_blank" rel="noopener">Antigravity</a> <code>bruto/Vibe-Coding/21_Antigravity.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/22_Cómo_Proteger_Openclaw_en_un_VPS.md" target="_blank" rel="noopener">🔒 Cómo Proteger Openclaw en un VPS</a> <code>bruto/Vibe-Coding/22_Cómo_Proteger_Openclaw_en_un_VPS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/23_Empieza_Aquí.md" target="_blank" rel="noopener">🏁 Empieza Aquí</a> <code>bruto/Vibe-Coding/23_Empieza_Aquí.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/24_Introducción.md" target="_blank" rel="noopener">📖 Introducción</a> <code>bruto/Vibe-Coding/24_Introducción.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/25_Instalación_Antigravity.md" target="_blank" rel="noopener">⚙️ Instalación Antigravity</a> <code>bruto/Vibe-Coding/25_Instalación_Antigravity.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/26_Conexión_MCPs_Supabase.md" target="_blank" rel="noopener">🤓 Conexión MCPs + Supabase</a> <code>bruto/Vibe-Coding/26_Conexión_MCPs_Supabase.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/27_Proyecto_1.md" target="_blank" rel="noopener">🏆  Proyecto 1</a> <code>bruto/Vibe-Coding/27_Proyecto_1.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/28_Maquetación_MVP.md" target="_blank" rel="noopener">📝 Maquetación MVP</a> <code>bruto/Vibe-Coding/28_Maquetación_MVP.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/29_Despliegue_en_Local.md" target="_blank" rel="noopener">🏗️ Despliegue en Local</a> <code>bruto/Vibe-Coding/29_Despliegue_en_Local.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/30_Troubleshooting_y_Supabase.md" target="_blank" rel="noopener">📊 Troubleshooting y Supabase</a> <code>bruto/Vibe-Coding/30_Troubleshooting_y_Supabase.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/31_8_Integración_n8n_Github.md" target="_blank" rel="noopener">8️⃣ Integración n8n &amp; Github</a> <code>bruto/Vibe-Coding/31_8_Integración_n8n_Github.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/32_Auth_con_Supabase_y_Deploy_a_Vercel.md" target="_blank" rel="noopener">🚀 Auth con Supabase y Deploy a Vercel</a> <code>bruto/Vibe-Coding/32_Auth_con_Supabase_y_Deploy_a_Vercel.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/33_BONUS_Progressive_Web_App.md" target="_blank" rel="noopener">⭐ BONUS: Progressive Web App</a> <code>bruto/Vibe-Coding/33_BONUS_Progressive_Web_App.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/34_OpenClaw.md" target="_blank" rel="noopener">OpenClaw</a> <code>bruto/Vibe-Coding/34_OpenClaw.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/35_Qué_es_OpenClaw_ex_-_Clawdbot.md" target="_blank" rel="noopener">¿Qué es OpenClaw? (ex - Clawdbot)</a> <code>bruto/Vibe-Coding/35_Qué_es_OpenClaw_ex_-_Clawdbot.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/36_Curso_Instalación_en_VPS_con_Hostinger.md" target="_blank" rel="noopener">[Curso] Instalación en VPS con Hostinger</a> <code>bruto/Vibe-Coding/36_Curso_Instalación_en_VPS_con_Hostinger.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/37_Curso_Configuración_y_uso_en_Telegram.md" target="_blank" rel="noopener">[Curso] Configuración y uso en Telegram</a> <code>bruto/Vibe-Coding/37_Curso_Configuración_y_uso_en_Telegram.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/38_Curso_Seguridad_y_Túnel_Privado_-_Tailscale.md" target="_blank" rel="noopener">[Curso] Seguridad y Túnel Privado - Tailscale</a> <code>bruto/Vibe-Coding/38_Curso_Seguridad_y_Túnel_Privado_-_Tailscale.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/39_Framework_SOUL_El_1_que_saca_OpenClaw_al_máximo.md" target="_blank" rel="noopener">Framework SOUL: El 1% que saca OpenClaw al máximo</a> <code>bruto/Vibe-Coding/39_Framework_SOUL_El_1_que_saca_OpenClaw_al_máximo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/40_OpenClaw_en_Mac_Mini_desde_cero_paso_a_paso.md" target="_blank" rel="noopener">OpenClaw en Mac Mini desde cero (paso a paso)</a> <code>bruto/Vibe-Coding/40_OpenClaw_en_Mac_Mini_desde_cero_paso_a_paso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/41_OpenClaw_mi_opinión_después_de_un_mes_de_uso.md" target="_blank" rel="noopener">OpenClaw: mi opinión después de un mes de uso</a> <code>bruto/Vibe-Coding/41_OpenClaw_mi_opinión_después_de_un_mes_de_uso.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/42_OpenClaw_GRATIS_Ollama_IA_a_nivel_local.md" target="_blank" rel="noopener">OpenClaw GRATIS + Ollama (IA a nivel local)</a> <code>bruto/Vibe-Coding/42_OpenClaw_GRATIS_Ollama_IA_a_nivel_local.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/43_Tutoriales_Rápidos.md" target="_blank" rel="noopener">Tutoriales Rápidos</a> <code>bruto/Vibe-Coding/43_Tutoriales_Rápidos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/44_Supabase_Self-Hosted_en_tu_VPS_Guía_Completa.md" target="_blank" rel="noopener">Supabase Self-Hosted en tu VPS — Guía Completa</a> <code>bruto/Vibe-Coding/44_Supabase_Self-Hosted_en_tu_VPS_Guía_Completa.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/45_Forge_-_La_Forja.md" target="_blank" rel="noopener">Forge - La Forja</a> <code>bruto/Vibe-Coding/45_Forge_-_La_Forja.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/46_Bienvenida_-_Qué_es_Forge.md" target="_blank" rel="noopener">🔨 Bienvenida - Qué es Forge</a> <code>bruto/Vibe-Coding/46_Bienvenida_-_Qué_es_Forge.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/47_Forge_El_Arsenal_Completo.md" target="_blank" rel="noopener">⚡ Forge — El Arsenal Completo</a> <code>bruto/Vibe-Coding/47_Forge_El_Arsenal_Completo.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/48_Construimos_desde_cero_TIPITI_BOOKS.md" target="_blank" rel="noopener">Construimos desde cero TIPITI BOOKS</a> <code>bruto/Vibe-Coding/48_Construimos_desde_cero_TIPITI_BOOKS.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/Vibe-Coding/49_Qué_es_un_Arnés_de_Agentes_IA.md" target="_blank" rel="noopener">¿Qué es un Arnés de Agentes IA?</a> <code>bruto/Vibe-Coding/49_Qué_es_un_Arnés_de_Agentes_IA.md</code></li>
</ul>$lf_module_55$,
    290,
    true,
    '{}'::jsonb
  ),
  (
    'imperio-n8n-desde-0',
    'imperio-agentico',
    'n8n Desde 0',
    '🏛️',
    '23 lecciones referenciadas desde el indice local del vault privado.',
    $lf_module_56$<p>Inventario privado del classroom Imperio extraido desde Skool. Sirve como mapa de estudio y accion; las rutas enlazan a notas locales y no a videos embebidos.</p>
<p><strong>Fuente local:</strong> <code>/home/ftt-2brocket/obsidian/imperio-agentico-skool</code><br><strong>Indice:</strong> <code>bruto/00_ÍNDICE.md</code><br><strong>Modulo fuente:</strong> n8n Desde 0 · 23 lecciones referenciadas.</p>
<ul>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/01_n8n_Desde_0.md" target="_blank" rel="noopener">n8n Desde 0</a> <code>bruto/n8n_Desde_0/01_n8n_Desde_0.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/02_Qué_es_Automatizar.md" target="_blank" rel="noopener">🧠 Qué es Automatizar</a> <code>bruto/n8n_Desde_0/02_Qué_es_Automatizar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/03_Lógica_y_Ejemplos.md" target="_blank" rel="noopener">⚙️ Lógica y Ejemplos</a> <code>bruto/n8n_Desde_0/03_Lógica_y_Ejemplos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/04_Tour_por_n8n.md" target="_blank" rel="noopener">🧭 Tour por n8n</a> <code>bruto/n8n_Desde_0/04_Tour_por_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/05_Instala_n8n.md" target="_blank" rel="noopener">💻 Instala n8n</a> <code>bruto/n8n_Desde_0/05_Instala_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/06_Integración_Google_x_n8n.md" target="_blank" rel="noopener">🔐 Integración Google x n8n</a> <code>bruto/n8n_Desde_0/06_Integración_Google_x_n8n.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/07_Tu_primera_automatizacion_con_IA.md" target="_blank" rel="noopener">🤖 Tu primera automatizacion con IA</a> <code>bruto/n8n_Desde_0/07_Tu_primera_automatizacion_con_IA.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/08_El_8020_de_las_automatizaciones.md" target="_blank" rel="noopener">⭐️ El 80/20 de las automatizaciones</a> <code>bruto/n8n_Desde_0/08_El_8020_de_las_automatizaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/09_Nodo_1_Schedule_Trigger_El_Despertador.md" target="_blank" rel="noopener">Nodo 1: Schedule Trigger (El Despertador)</a> <code>bruto/n8n_Desde_0/09_Nodo_1_Schedule_Trigger_El_Despertador.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/10_Nodo_2_Event_Triggers_Trigers_de_Aplicaciones.md" target="_blank" rel="noopener">Nodo 2: Event Triggers (Trigers de Aplicaciones)</a> <code>bruto/n8n_Desde_0/10_Nodo_2_Event_Triggers_Trigers_de_Aplicaciones.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/11_Nodo_3_Execute_Workflow_Sub-workflows.md" target="_blank" rel="noopener">Nodo 3: Execute Workflow (Sub-workflows)</a> <code>bruto/n8n_Desde_0/11_Nodo_3_Execute_Workflow_Sub-workflows.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/12_Nodo_4_Split_Out_Separar.md" target="_blank" rel="noopener">Nodo 4: Split Out (Separar)</a> <code>bruto/n8n_Desde_0/12_Nodo_4_Split_Out_Separar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/13_Nodo_5_Aggregate_AgruparEmpaquetar.md" target="_blank" rel="noopener">Nodo 5: Aggregate (Agrupar/Empaquetar)</a> <code>bruto/n8n_Desde_0/13_Nodo_5_Aggregate_AgruparEmpaquetar.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/14_Nodo_6_Edit_Fields_Crear_Variables.md" target="_blank" rel="noopener">Nodo 6: Edit Fields (Crear Variables)</a> <code>bruto/n8n_Desde_0/14_Nodo_6_Edit_Fields_Crear_Variables.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/15_Nodo_7_If_El_Portero_VIP.md" target="_blank" rel="noopener">Nodo 7: If (El Portero VIP)</a> <code>bruto/n8n_Desde_0/15_Nodo_7_If_El_Portero_VIP.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/16_Nodo_8_Switch_El_Distribuidor.md" target="_blank" rel="noopener">Nodo 8: Switch (El Distribuidor)</a> <code>bruto/n8n_Desde_0/16_Nodo_8_Switch_El_Distribuidor.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/17_Nodo_9_Code_El_Comodín.md" target="_blank" rel="noopener">Nodo 9: Code (El Comodín)</a> <code>bruto/n8n_Desde_0/17_Nodo_9_Code_El_Comodín.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/18_Nodo_10_HTTP_Request_El_Arquitecto.md" target="_blank" rel="noopener">Nodo 10: HTTP Request (El Arquitecto)</a> <code>bruto/n8n_Desde_0/18_Nodo_10_HTTP_Request_El_Arquitecto.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/19_Nodo_11_Loop_Over_Items_El_Procesador_de_Listas.md" target="_blank" rel="noopener">Nodo 11: Loop Over Items (El Procesador de Listas)</a> <code>bruto/n8n_Desde_0/19_Nodo_11_Loop_Over_Items_El_Procesador_de_Listas.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/20_Nodo_12_Webhook_El_Timbre_y_el_Buzón.md" target="_blank" rel="noopener">Nodo 12: Webhook (El Timbre y el Buzón)</a> <code>bruto/n8n_Desde_0/20_Nodo_12_Webhook_El_Timbre_y_el_Buzón.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/21_Nodo_13_AI_Agent_El_Cerebro_con_Manos.md" target="_blank" rel="noopener">Nodo 13: AI Agent (El Cerebro con Manos)</a> <code>bruto/n8n_Desde_0/21_Nodo_13_AI_Agent_El_Cerebro_con_Manos.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/22_Nodo_14_Merge_El_Reencuentro.md" target="_blank" rel="noopener">Nodo 14: Merge (El Reencuentro)</a> <code>bruto/n8n_Desde_0/22_Nodo_14_Merge_El_Reencuentro.md</code></li>
  <li><a href="file:///home/ftt-2brocket/obsidian/imperio-agentico-skool/bruto/n8n_Desde_0/23_Nodo_15_Information_Extractor.md" target="_blank" rel="noopener">Nodo 15: Information Extractor</a> <code>bruto/n8n_Desde_0/23_Nodo_15_Information_Extractor.md</code></li>
</ul>$lf_module_56$,
    300,
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
  (id, course_id, module_id, type, title, level, statement_html, hint, tests, options, solution_html, sort_order, is_published)
values
  (
    'car-explorar-modulos-prioritarios',
    'car-ecosistema-startup',
    'car-empieza-aqui',
    'development',
    'Explorar modulos prioritarios',
    1,
    $lf_item_statement_1$<p>Elige 3 modulos del inventario que tengan impacto directo en tus objetivos actuales. Para cada uno, registra por que importa, que nota fuente vas a revisar primero y que resultado esperas obtener.</p>$lf_item_statement_1$,
    'Parte por modulos con aplicacion inmediata, no por el inventario completo.',
    '[]'::jsonb,
    '[]'::jsonb,
    $lf_item_solution_1$<p>Resultado esperado: lista priorizada de 3 modulos, criterio de seleccion y primera nota a revisar por modulo.</p>$lf_item_solution_1$,
    10,
    true
  ),
  (
    'car-extraer-aprendizajes-aplicables',
    'car-ecosistema-startup',
    'car-empieza-aqui',
    'development',
    'Extraer aprendizajes aplicables',
    2,
    $lf_item_statement_2$<p>Despues de revisar un modulo, sintetiza 5 aprendizajes accionables. Cada aprendizaje debe incluir contexto, decision recomendada y una evidencia o referencia de la nota fuente.</p>$lf_item_statement_2$,
    'Evita resumen generico: fuerza cada aprendizaje a terminar en una accion concreta.',
    '[]'::jsonb,
    '[]'::jsonb,
    $lf_item_solution_2$<p>Resultado esperado: cinco aprendizajes con referencia local, decision sugerida y posible uso en tus proyectos privados.</p>$lf_item_solution_2$,
    20,
    true
  ),
  (
    'car-disenar-implementacion-propia',
    'car-ecosistema-startup',
    'car-empieza-aqui',
    'development',
    'Disenar una implementacion propia',
    3,
    $lf_item_statement_3$<p>Convierte una idea del curso en una implementacion propia. Define objetivo, usuario, flujo, herramientas, datos necesarios, riesgos y primer prototipo verificable.</p>$lf_item_statement_3$,
    'Baja la idea a un entregable pequeno que puedas validar en menos de una semana.',
    '[]'::jsonb,
    '[]'::jsonb,
    $lf_item_solution_3$<p>Resultado esperado: ficha de implementacion con alcance, herramientas, riesgos y criterio de exito.</p>$lf_item_solution_3$,
    30,
    true
  ),
  (
    'car-registrar-proximos-pasos',
    'car-ecosistema-startup',
    'car-empieza-aqui',
    'development',
    'Registrar proximos pasos',
    2,
    $lf_item_statement_4$<p>Cierra la sesion de estudio con proximos pasos. Anota tareas, responsables, fecha tentativa, dependencias y que evidencia confirmara que el aprendizaje se transformo en avance real.</p>$lf_item_statement_4$,
    'Si no hay fecha ni evidencia, todavia es una intencion y no un plan.',
    '[]'::jsonb,
    '[]'::jsonb,
    $lf_item_solution_4$<p>Resultado esperado: lista de tareas accionables con fecha, dependencia y evidencia de cierre.</p>$lf_item_solution_4$,
    40,
    true
  ),
  (
    'imperio-explorar-modulos-prioritarios',
    'imperio-agentico',
    'imperio-empieza-aqui',
    'development',
    'Explorar modulos prioritarios',
    1,
    $lf_item_statement_5$<p>Elige 3 modulos del inventario que tengan impacto directo en tus objetivos actuales. Para cada uno, registra por que importa, que nota fuente vas a revisar primero y que resultado esperas obtener.</p>$lf_item_statement_5$,
    'Parte por modulos con aplicacion inmediata, no por el inventario completo.',
    '[]'::jsonb,
    '[]'::jsonb,
    $lf_item_solution_5$<p>Resultado esperado: lista priorizada de 3 modulos, criterio de seleccion y primera nota a revisar por modulo.</p>$lf_item_solution_5$,
    10,
    true
  ),
  (
    'imperio-extraer-aprendizajes-aplicables',
    'imperio-agentico',
    'imperio-empieza-aqui',
    'development',
    'Extraer aprendizajes aplicables',
    2,
    $lf_item_statement_6$<p>Despues de revisar un modulo, sintetiza 5 aprendizajes accionables. Cada aprendizaje debe incluir contexto, decision recomendada y una evidencia o referencia de la nota fuente.</p>$lf_item_statement_6$,
    'Evita resumen generico: fuerza cada aprendizaje a terminar en una accion concreta.',
    '[]'::jsonb,
    '[]'::jsonb,
    $lf_item_solution_6$<p>Resultado esperado: cinco aprendizajes con referencia local, decision sugerida y posible uso en tus proyectos privados.</p>$lf_item_solution_6$,
    20,
    true
  ),
  (
    'imperio-disenar-implementacion-propia',
    'imperio-agentico',
    'imperio-empieza-aqui',
    'development',
    'Disenar una implementacion propia',
    3,
    $lf_item_statement_7$<p>Convierte una idea del curso en una implementacion propia. Define objetivo, usuario, flujo, herramientas, datos necesarios, riesgos y primer prototipo verificable.</p>$lf_item_statement_7$,
    'Baja la idea a un entregable pequeno que puedas validar en menos de una semana.',
    '[]'::jsonb,
    '[]'::jsonb,
    $lf_item_solution_7$<p>Resultado esperado: ficha de implementacion con alcance, herramientas, riesgos y criterio de exito.</p>$lf_item_solution_7$,
    30,
    true
  ),
  (
    'imperio-registrar-proximos-pasos',
    'imperio-agentico',
    'imperio-empieza-aqui',
    'development',
    'Registrar proximos pasos',
    2,
    $lf_item_statement_8$<p>Cierra la sesion de estudio con proximos pasos. Anota tareas, responsables, fecha tentativa, dependencias y que evidencia confirmara que el aprendizaje se transformo en avance real.</p>$lf_item_statement_8$,
    'Si no hay fecha ni evidencia, todavia es una intencion y no un plan.',
    '[]'::jsonb,
    '[]'::jsonb,
    $lf_item_solution_8$<p>Resultado esperado: lista de tareas accionables con fecha, dependencia y evidencia de cierre.</p>$lf_item_solution_8$,
    40,
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
  tests = excluded.tests,
  options = excluded.options,
  solution_html = excluded.solution_html,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;
