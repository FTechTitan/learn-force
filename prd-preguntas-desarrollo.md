# PRD - Preguntas de desarrollo paso a paso

## Objetivo

Agregar un nuevo tipo de ejercicio configurable desde Supabase para preguntas de desarrollo guiadas paso a paso. Este formato debe servir para resolver problemas de estadistica donde el alumno no solo elige una alternativa, sino que construye la solucion por etapas.

## Problema

El curso actualmente soporta:

- `quiz_boolean`: verdadero/falso.
- `quiz_single`: alternativas.
- `code`: ejercicios de programacion corregidos con tests.

Para estadistica falta un formato intermedio: ejercicios de desarrollo que permitan practicar razonamiento, formulas, calculos e interpretacion sin exigir una respuesta larga libre imposible de corregir automaticamente.

## Propuesta

Crear un nuevo tipo de item:

```text
guided_steps
```

Cada ejercicio `guided_steps` contiene un enunciado general y una lista ordenada de pasos. El alumno debe completar un paso antes de avanzar al siguiente. Cada paso puede tener pista, correccion inmediata y explicacion.

## Ejemplo de uso

Ejercicio: Bayes paso a paso.

Enunciado:

> Una maquina A produce el 70% de las piezas y B produce el 30%. La tasa de defectos es 2% en A y 5% en B. Si una pieza salio defectuosa, calcula la probabilidad de que venga de A.

Pasos:

1. Identificar datos dados.
2. Calcular `P(D)` usando probabilidad total.
3. Elegir la formula correcta de Bayes.
4. Calcular `P(A|D)`.
5. Interpretar el resultado en palabras.

## Tipos de paso

### `info`

Paso informativo. No pide respuesta; solo muestra datos, recordatorio o mini explicacion.

Campos:

```json
{
  "kind": "info",
  "title": "Identifica los datos",
  "content_html": "<ul><li>P(A)=0,70</li><li>P(B)=0,30</li></ul>"
}
```

### `numeric`

Respuesta numerica con tolerancia.

Campos:

```json
{
  "kind": "numeric",
  "title": "Calcula P(D)",
  "prompt": "Ingresa el valor de P(D)",
  "answer": 0.029,
  "tolerance": 0.001,
  "hint": "Usa probabilidad total.",
  "explanation": "P(D)=0,70*0,02 + 0,30*0,05 = 0,029."
}
```

### `single`

Alternativa dentro del paso.

Campos:

```json
{
  "kind": "single",
  "title": "Elige la formula",
  "prompt": "Cual formula permite calcular P(A|D)?",
  "options": [
    { "id": "a", "label": "P(A)P(D|A)/P(D)" },
    { "id": "b", "label": "P(D)P(A|D)/P(A)" }
  ],
  "answer": "a",
  "hint": "Bayes invierte una condicional.",
  "explanation": "P(A|D)=P(A)P(D|A)/P(D)."
}
```

### `boolean`

Verdadero/falso dentro del paso.

Campos:

```json
{
  "kind": "boolean",
  "title": "Revisa independencia",
  "prompt": "A y D son independientes en este problema.",
  "answer": false,
  "hint": "D depende de la maquina de origen.",
  "explanation": "La probabilidad de defecto cambia segun la maquina."
}
```

### `short_text`

Respuesta escrita corta. Se corrige con palabras clave o patrones aceptados.

Campos:

```json
{
  "kind": "short_text",
  "title": "Interpreta el resultado",
  "prompt": "Explica en una frase que significa P(A|D)=0,483.",
  "accepted_keywords": ["defectuosa", "probabilidad", "maquina A"],
  "sample_answer": "Si la pieza es defectuosa, hay cerca de 48,3% de probabilidad de que venga de la maquina A.",
  "hint": "Habla en contexto, no solo repitas el numero.",
  "explanation": "La probabilidad condicional se interpreta sabiendo que ya ocurrio D."
}
```

### `formula`

Paso para escribir o elegir una formula. Puede corregirse con opciones aceptadas normalizadas.

Campos:

```json
{
  "kind": "formula",
  "title": "Escribe la formula de probabilidad total",
  "prompt": "Escribe P(D) usando A y B.",
  "accepted": [
    "P(D)=P(A)P(D|A)+P(B)P(D|B)",
    "P(D)=P(D|A)P(A)+P(D|B)P(B)"
  ],
  "hint": "Suma los casos segun la particion A/B.",
  "explanation": "A y B forman una particion del origen de la pieza."
}
```

## Modelo en Supabase

Opcion recomendada: reutilizar `course_items` y agregar una columna JSONB.

Nueva columna:

```sql
alter table public.course_items
  add column if not exists steps jsonb not null default '[]'::jsonb;
```

Actualizar constraint de `type` para aceptar:

```text
guided_steps
```

Estructura de item:

```json
{
  "id": "est-dev-bayes-01",
  "course_id": "estadistica-aplicada",
  "module_id": "estadistica-desarrollo",
  "type": "guided_steps",
  "title": "Bayes paso a paso",
  "level": 3,
  "statement_html": "<p>...</p>",
  "hint": "Divide el problema en probabilidad total y Bayes.",
  "steps": [...]
}
```

## Cambios de UI

Cuando `type === "guided_steps"`:

- Ocultar editor de codigo.
- Ocultar opciones globales de quiz.
- Mostrar un panel de pasos.
- Cada paso debe mostrar:
  - Numero de paso.
  - Titulo.
  - Prompt o contenido.
  - Input correspondiente al `kind`.
  - Boton `Comprobar paso`.
  - Pista desplegable.
  - Explicacion despues de responder.
- Bloquear el siguiente paso hasta aprobar el actual.
- Al completar todos los pasos, marcar el item como completado.

## Estados esperados

- `pending`: paso aun no respondido.
- `correct`: paso respondido correctamente.
- `incorrect`: ultimo intento incorrecto.
- `revealed`: paso mostrado como resuelto por el sistema, si se agrega esa funcion mas adelante.

## Correccion

### Numerica

Aceptar:

- Punto o coma decimal.
- Porcentaje si el paso lo permite.
- Tolerancia absoluta configurable.

Ejemplo:

```text
answer = 0.029
tolerance = 0.001
```

Acepta `0.029`, `0,029`, `0.03`.

### Alternativa

Comparar `answer` con el `id` seleccionado.

### Verdadero/falso

Comparar booleano normalizado.

### Texto corto

Primera version simple:

- Convertir a minusculas.
- Quitar tildes.
- Validar que aparezcan las palabras clave requeridas.

No debe pretender evaluar redaccion compleja en la primera version.

### Formula

Primera version simple:

- Normalizar espacios.
- Convertir a minusculas.
- Aceptar equivalencias escritas en `accepted`.

Version futura:

- Parser simbolico basico para equivalencias algebraicas.

## Progreso

Primera version:

- Guardar completado a nivel de item cuando todos los pasos estan correctos.
- Guardar estado local del intento en `localStorage`.

Version futura:

- Guardar progreso por paso en Supabase para continuar desde otro dispositivo.
- Tabla sugerida:

```sql
create table public.step_progress (
  user_id uuid not null references auth.users(id) on delete cascade,
  item_id text not null references public.course_items(id) on delete cascade,
  step_index integer not null,
  answer jsonb,
  is_correct boolean not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, item_id, step_index)
);
```

## Admin

El panel admin debe permitir editar `steps` como JSON en una primera version.

Campos minimos:

- `type = guided_steps`
- `statement_html`
- `steps` JSON
- `hint`
- `level`
- `sort_order`
- `is_published`

Version futura:

- Constructor visual de pasos.
- Reordenar pasos con drag and drop.
- Preview de correccion.

## Modulo sugerido para estadistica

Crear modulo:

```text
estadistica-desarrollo
```

Titulo:

```text
Ejercicios paso a paso
```

Descripcion:

```text
Problemas guiados para practicar formulas, calculos e interpretacion.
```

## Casos iniciales recomendados

1. Bayes con maquinas y defectos.
2. Probabilidad total con proveedores.
3. Sensibilidad, especificidad y valor predictivo positivo.
4. Conteo con restricciones.
5. Binomial: calcular esperanza, varianza y una probabilidad puntual.
6. Intervalo de confianza para una media.
7. Test de hipotesis con p-valor.
8. Interpretacion de pendiente en regresion.

## Criterios de aceptacion

- La app carga items `guided_steps` desde Supabase.
- Un usuario sin login puede resolver pasos en el dispositivo.
- Un usuario con login conserva completado del item en Supabase.
- El siguiente paso no aparece como activo hasta aprobar el paso actual.
- Los pasos numericos aceptan coma decimal.
- Al terminar todos los pasos, se marca el ejercicio como completado y se desbloquea el siguiente.
- El admin puede crear o editar un item `guided_steps` usando JSON.

## Fuera de alcance para primera version

- Correccion semantica avanzada con IA.
- Parser algebraico completo.
- Rubricas con puntaje parcial.
- Revision docente manual.
- Analitica por paso en dashboard.

## Plan de implementacion

1. Migracion Supabase:
   - Agregar `guided_steps` al constraint de `course_items.type`.
   - Agregar columna `steps jsonb`.
   - Crear modulo `estadistica-desarrollo`.

2. Cliente Supabase:
   - Traer `steps` en `CursosRemotos.cargarPublicados()`.
   - Normalizar `steps` en cada ejercicio.

3. Frontend:
   - Detectar `type === "guided_steps"`.
   - Renderizar panel de pasos.
   - Implementar correccion por `kind`.
   - Guardar avance local por item.

4. Progreso:
   - Al completar todos los pasos, llamar `marcarCompletado`.
   - Mantener compatibilidad con progreso actual.

5. Admin:
   - Incluir `steps` en `save_item`.
   - Mostrar campo JSON editable.

6. Seed inicial:
   - Agregar 5 a 8 ejercicios guiados de estadistica.

7. QA:
   - Probar invitado sin login.
   - Probar usuario con Google login.
   - Probar carga publica desde Supabase.
   - Probar desbloqueo progresivo.
