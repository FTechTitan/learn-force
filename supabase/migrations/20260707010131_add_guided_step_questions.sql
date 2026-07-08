-- ============================================================================
--  Preguntas de desarrollo guiadas paso a paso
--  Agrega el tipo guided_steps y un banco inicial para Estadística Aplicada.
-- ============================================================================

alter table public.course_items
  add column if not exists steps jsonb not null default '[]'::jsonb;

alter table public.course_items
  drop constraint if exists course_items_type_check;

alter table public.course_items
  add constraint course_items_type_check
  check (type in ('code', 'quiz_single', 'quiz_boolean', 'development', 'guided_steps'));

insert into public.course_modules
  (id, course_id, title, emoji, intro, theory, sort_order, is_published, media)
values (
  'estadistica-desarrollo',
  'estadistica-aplicada',
  'Ejercicios paso a paso',
  '🧭',
  'Problemas guiados para practicar formulas, calculos e interpretacion sin saltarse pasos.',
  '<p>Resuelve cada problema por etapas: identifica datos, elige la formula, calcula y luego interpreta el resultado. La idea es corregir el razonamiento, no solo el numero final.</p>',
  30,
  true,
  '{}'::jsonb
)
on conflict (id) do update set
  title = excluded.title,
  emoji = excluded.emoji,
  intro = excluded.intro,
  theory = excluded.theory,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published,
  media = excluded.media;

insert into public.course_items
  (id, course_id, module_id, type, title, level, statement_html, hint, steps, sort_order, is_published)
values
  (
    'est-dev-bayes-01',
    'estadistica-aplicada',
    'estadistica-desarrollo',
    'guided_steps',
    'Bayes con maquinas y defectos',
    3,
    '<p>Una maquina A produce el <b>70%</b> de las piezas y una maquina B produce el <b>30%</b>. La tasa de defectos es <b>2%</b> en A y <b>5%</b> en B. Si una pieza salio defectuosa, calcula la probabilidad de que venga de A.</p>',
    'Divide el problema en probabilidad total y luego Bayes.',
    '[
      {
        "kind": "info",
        "title": "Identifica los datos",
        "content_html": "<ul><li>P(A)=0,70</li><li>P(B)=0,30</li><li>P(D|A)=0,02</li><li>P(D|B)=0,05</li></ul>"
      },
      {
        "kind": "formula",
        "title": "Probabilidad total",
        "prompt": "Escribe la formula para P(D) usando A y B.",
        "accepted": ["P(D)=P(A)P(D|A)+P(B)P(D|B)", "P(D)=P(D|A)P(A)+P(D|B)P(B)"],
        "hint": "A y B forman una particion del origen de la pieza.",
        "explanation": "La probabilidad total suma los caminos que llegan al defecto: desde A y desde B."
      },
      {
        "kind": "numeric",
        "title": "Calcula P(D)",
        "prompt": "Ingresa P(D).",
        "answer": 0.029,
        "tolerance": 0.001,
        "hint": "Multiplica cada tasa de defecto por la proporcion de produccion.",
        "explanation": "P(D)=0,70*0,02 + 0,30*0,05 = 0,014 + 0,015 = 0,029."
      },
      {
        "kind": "single",
        "title": "Aplica Bayes",
        "prompt": "Cual formula calcula P(A|D)?",
        "options": [
          { "id": "a", "label": "P(A)P(D|A)/P(D)" },
          { "id": "b", "label": "P(D)P(A|D)/P(A)" },
          { "id": "c", "label": "P(A)+P(D|A)-P(D)" }
        ],
        "answer": "a",
        "hint": "Bayes invierte la condicion usando la probabilidad total.",
        "explanation": "P(A|D)=P(A)P(D|A)/P(D)."
      },
      {
        "kind": "numeric",
        "title": "Resultado final",
        "prompt": "Calcula P(A|D).",
        "answer": 0.4828,
        "tolerance": 0.01,
        "allow_percent": true,
        "hint": "Divide 0,70*0,02 por 0,029.",
        "explanation": "P(A|D)=0,014/0,029=0,4828, aproximadamente 48,3%."
      },
      {
        "kind": "short_text",
        "title": "Interpreta",
        "prompt": "Explica en una frase que significa el resultado.",
        "accepted_keywords": ["defectuosa", "maquina a", "probabilidad"],
        "sample_answer": "Si la pieza es defectuosa, hay cerca de 48,3% de probabilidad de que venga de la maquina A.",
        "hint": "Habla en contexto, no solo repitas el numero.",
        "explanation": "La probabilidad condicional se interpreta sabiendo que la pieza ya es defectuosa."
      }
    ]'::jsonb,
    10,
    true
  ),
  (
    'est-dev-total-01',
    'estadistica-aplicada',
    'estadistica-desarrollo',
    'guided_steps',
    'Probabilidad total con proveedores',
    2,
    '<p>Una tienda compra productos a tres proveedores: P1 entrega el <b>50%</b>, P2 el <b>30%</b> y P3 el <b>20%</b>. Sus tasas de atraso son <b>4%</b>, <b>8%</b> y <b>10%</b>, respectivamente. Calcula la probabilidad de que un producto llegue atrasado.</p>',
    'Pondera la tasa de atraso de cada proveedor por su participacion.',
    '[
      {
        "kind": "info",
        "title": "Datos",
        "content_html": "<ul><li>P(P1)=0,50 y P(Atraso|P1)=0,04</li><li>P(P2)=0,30 y P(Atraso|P2)=0,08</li><li>P(P3)=0,20 y P(Atraso|P3)=0,10</li></ul>"
      },
      {
        "kind": "single",
        "title": "Estrategia",
        "prompt": "Que regla corresponde usar?",
        "options": [
          { "id": "a", "label": "Probabilidad total" },
          { "id": "b", "label": "Complemento solamente" },
          { "id": "c", "label": "Permutaciones" }
        ],
        "answer": "a",
        "hint": "Hay varios caminos excluyentes para llegar al atraso.",
        "explanation": "Los proveedores forman una particion, por eso corresponde probabilidad total."
      },
      {
        "kind": "numeric",
        "title": "Aporte de P1",
        "prompt": "Calcula P(P1)*P(Atraso|P1).",
        "answer": 0.02,
        "tolerance": 0.001,
        "hint": "Multiplica 0,50 por 0,04.",
        "explanation": "0,50*0,04=0,020."
      },
      {
        "kind": "numeric",
        "title": "Resultado total",
        "prompt": "Ingresa la probabilidad total de atraso.",
        "answer": 0.064,
        "tolerance": 0.001,
        "allow_percent": true,
        "hint": "Suma los aportes de P1, P2 y P3.",
        "explanation": "0,50*0,04 + 0,30*0,08 + 0,20*0,10 = 0,064, es decir 6,4%."
      }
    ]'::jsonb,
    20,
    true
  ),
  (
    'est-dev-test-01',
    'estadistica-aplicada',
    'estadistica-desarrollo',
    'guided_steps',
    'Test medico y valor predictivo',
    4,
    '<p>Una enfermedad afecta al <b>1%</b> de la poblacion. Un test tiene sensibilidad <b>95%</b> y especificidad <b>90%</b>. Si una persona da positivo, calcula la probabilidad aproximada de que este enferma.</p>',
    'No confundas sensibilidad con valor predictivo positivo.',
    '[
      {
        "kind": "boolean",
        "title": "Tasa base",
        "prompt": "La prevalencia baja puede hacer que el valor predictivo positivo sea mucho menor que la sensibilidad.",
        "answer": true,
        "hint": "Piensa en cuantos sanos hay por cada enfermo.",
        "explanation": "Con muchos sanos, incluso una pequena tasa de falsos positivos puede pesar mucho."
      },
      {
        "kind": "numeric",
        "title": "Probabilidad de positivo",
        "prompt": "Calcula P(+).",
        "answer": 0.1085,
        "tolerance": 0.002,
        "hint": "P(+)=P(E)P(+|E)+P(S)P(+|S). Recuerda que P(+|S)=1-especificidad.",
        "explanation": "P(+)=0,01*0,95 + 0,99*0,10 = 0,0095 + 0,099 = 0,1085."
      },
      {
        "kind": "numeric",
        "title": "Bayes",
        "prompt": "Calcula P(E|+).",
        "answer": 0.0876,
        "tolerance": 0.01,
        "allow_percent": true,
        "hint": "Divide P(E)P(+|E) por P(+).",
        "explanation": "P(E|+)=0,0095/0,1085=0,0876, aproximadamente 8,8%."
      },
      {
        "kind": "short_text",
        "title": "Interpretacion",
        "prompt": "Explica por que el resultado no es cercano a 95%.",
        "accepted_keywords": ["prevalencia", "falsos positivos"],
        "sample_answer": "Como la prevalencia es baja, hay muchos sanos y los falsos positivos pesan mucho en los positivos.",
        "hint": "Menciona la tasa base.",
        "explanation": "La sensibilidad no es P(enfermo|positivo); para eso se necesita Bayes y la prevalencia."
      }
    ]'::jsonb,
    30,
    true
  ),
  (
    'est-dev-conteo-01',
    'estadistica-aplicada',
    'estadistica-desarrollo',
    'guided_steps',
    'Conteo de codigos con restricciones',
    2,
    '<p>Una clave tiene <b>2 letras distintas</b> tomadas de A, B, C, D, E y luego <b>2 digitos</b> que pueden repetirse. Calcula cuantas claves distintas existen.</p>',
    'Decide primero si importa el orden en cada parte.',
    '[
      {
        "kind": "boolean",
        "title": "Orden de letras",
        "prompt": "AB y BA cuentan como claves distintas.",
        "answer": true,
        "hint": "Una clave es una secuencia.",
        "explanation": "En codigos o claves, cambiar el orden cambia la clave."
      },
      {
        "kind": "numeric",
        "title": "Letras",
        "prompt": "Cuantas formas hay para las dos letras distintas?",
        "answer": 20,
        "tolerance": 0,
        "hint": "5 opciones para la primera y luego quedan 4.",
        "explanation": "5*4=20 arreglos ordenados de dos letras distintas."
      },
      {
        "kind": "numeric",
        "title": "Digitos",
        "prompt": "Cuantas formas hay para los dos digitos si pueden repetirse?",
        "answer": 100,
        "tolerance": 0,
        "hint": "Hay 10 opciones para cada digito.",
        "explanation": "10*10=100."
      },
      {
        "kind": "numeric",
        "title": "Total",
        "prompt": "Cuantas claves hay en total?",
        "answer": 2000,
        "tolerance": 0,
        "hint": "Multiplica letras por digitos.",
        "explanation": "20*100=2000 claves."
      }
    ]'::jsonb,
    40,
    true
  ),
  (
    'est-dev-binomial-01',
    'estadistica-aplicada',
    'estadistica-desarrollo',
    'guided_steps',
    'Binomial: esperanza, varianza y probabilidad',
    3,
    '<p>Sea <b>X ~ Bin(5, 0,4)</b>. Calcula la esperanza, la varianza y la probabilidad de obtener exactamente 2 exitos.</p>',
    'Usa las formulas de la distribucion binomial.',
    '[
      {
        "kind": "numeric",
        "title": "Esperanza",
        "prompt": "Calcula E(X).",
        "answer": 2,
        "tolerance": 0.001,
        "hint": "E(X)=np.",
        "explanation": "E(X)=5*0,4=2."
      },
      {
        "kind": "numeric",
        "title": "Varianza",
        "prompt": "Calcula Var(X).",
        "answer": 1.2,
        "tolerance": 0.001,
        "hint": "Var(X)=np(1-p).",
        "explanation": "Var(X)=5*0,4*0,6=1,2."
      },
      {
        "kind": "formula",
        "title": "Probabilidad puntual",
        "prompt": "Escribe la estructura para P(X=2).",
        "accepted": ["C(5,2)(0,4)^2(0,6)^3", "C(5,2)*(0,4)^2*(0,6)^3", "10(0,4)^2(0,6)^3"],
        "hint": "Usa combinaciones, exitos y fracasos.",
        "explanation": "La forma binomial es C(n,k)p^k(1-p)^(n-k)."
      },
      {
        "kind": "numeric",
        "title": "Calcula P(X=2)",
        "prompt": "Ingresa P(X=2).",
        "answer": 0.3456,
        "tolerance": 0.002,
        "hint": "C(5,2)=10.",
        "explanation": "10*(0,4)^2*(0,6)^3 = 0,3456."
      }
    ]'::jsonb,
    50,
    true
  ),
  (
    'est-dev-regresion-01',
    'estadistica-aplicada',
    'estadistica-desarrollo',
    'guided_steps',
    'Interpretar una regresion lineal',
    2,
    '<p>Un modelo estima la nota esperada segun horas de estudio como <code>Nota = 2,8 + 0,35*Horas</code>. Interpreta la pendiente y predice la nota para 8 horas.</p>',
    'Identifica intercepto, pendiente y reemplaza X por 8.',
    '[
      {
        "kind": "single",
        "title": "Pendiente",
        "prompt": "Que representa 0,35 en el modelo?",
        "options": [
          { "id": "a", "label": "La nota esperada cuando Horas=0" },
          { "id": "b", "label": "El aumento esperado en nota por cada hora adicional" },
          { "id": "c", "label": "La correlacion entre nota y horas" }
        ],
        "answer": "b",
        "hint": "La pendiente multiplica a la variable explicativa.",
        "explanation": "Por cada hora adicional de estudio, la nota esperada sube 0,35 puntos."
      },
      {
        "kind": "numeric",
        "title": "Prediccion",
        "prompt": "Calcula la nota esperada para 8 horas.",
        "answer": 5.6,
        "tolerance": 0.01,
        "hint": "Reemplaza Horas=8.",
        "explanation": "2,8 + 0,35*8 = 2,8 + 2,8 = 5,6."
      },
      {
        "kind": "short_text",
        "title": "Cuidado causal",
        "prompt": "Explica por que esta pendiente no prueba automaticamente causalidad.",
        "accepted_keywords": ["correlacion", "causalidad"],
        "sample_answer": "La regresion muestra asociacion; correlacion no implica causalidad sin un diseño que controle sesgos.",
        "hint": "Menciona asociacion versus causa.",
        "explanation": "Un modelo observacional puede estar afectado por variables omitidas o sesgo de seleccion."
      }
    ]'::jsonb,
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
  steps = excluded.steps,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;
