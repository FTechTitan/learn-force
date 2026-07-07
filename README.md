# 🐍 Python de a poco · progra-UAI

Webapp para cursos configurables desde Supabase. El curso original de
**Python de a poco** usa ejercicios de menos a más que se **corrigen
automáticamente** dentro del navegador.

El código del alumno corre con **Pyodide** (Python compilado a WebAssembly), así
que todo funciona como sitio **100% estático** — ideal para Cloudflare Pages.

## Cómo funciona

- **Cursos desde Supabase**: el catálogo, módulos, ejercicios y preguntas se
  leen desde `public.courses`, `public.course_modules` y `public.course_items`.
- **Módulos progresivos**: cada ejercicio se desbloquea al completar el anterior.
- **Editor de código** (CodeMirror) con resaltado de sintaxis.
- **Ejecutar** ▶️ — corre tu código; `input()` se pide en una ventanita o desde
  el cuadro de "entrada manual".
- **Comprobar** ✅ — corre casos de prueba y te dice si pasás todos.
- **Progreso guardado** en el navegador (`localStorage`).

## Estructura

```
index.html        Estructura de la página
css/styles.css    Estilos
js/runner.js      Motor Pyodide (ejecuta Python + corrige)
js/app.js         Interfaz: catálogo, sidebar, progreso, editor
material/         Guías originales del curso (PDF/DOCX, fuente de los ejercicios)
```

## Correr localmente

Es estático, así que basta cualquier servidor HTTP:

```bash
python3 -m http.server 8000
# abrir http://localhost:8000
```

> Tiene que servirse por HTTP (no abrir el `index.html` con `file://`), porque
> Pyodide descarga sus archivos por red.

## Agregar más cursos o ejercicios

Usá el panel admin o inserta datos en Supabase. Cada item de código usa esta
estructura en `course_items`:

```json
{
  id: "cond-06",
  "type": "code",
  "title": "Mi ejercicio",
  "level": 2,
  "statement_html": "<p>...</p>",
  "hint": "...",
  "starter": "edad = int(input())\n",
  "tests": [
    { "stdin": ["15"], "expect": ["menor de edad"] }
  ]
}
```

La corrección verifica que la **salida contenga** cada string de `expect`, en
orden, ignorando mayúsculas/acentos y espacios extra.

## Deploy a Cloudflare Pages

Proyecto estático sin build:

- **Build command**: *(vacío)*
- **Build output directory**: `/` (raíz)

Conectá el repo de GitHub al proyecto de CF Pages para que cada push a `main`
publique automáticamente.

---

Fuente de los ejercicios: guías del curso de Programación (UAI), en `material/`.
