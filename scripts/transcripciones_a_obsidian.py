#!/usr/bin/env python3
"""Exporta las transcripciones de un curso desde Supabase al vault del curso.

Sigue la convencion de los vaults por curso que ya existen en `C:/obsidian`
(`vault-imperio-agentico-skool`, `CAR-skool-vault`):

    <vault>/
      bruto/
        00_INDICE.md
        01_Nombre_Del_Modulo/
          01_Titulo_De_La_Clase.md
      apuntes/          (queda vacia, para notas propias)

Es idempotente: reescribe las notas existentes, asi que se puede correr de nuevo
cuando el worker termine las clases que faltan.

Uso:

    export SUPABASE_ACCESS_TOKEN="$SUPABASE_PROGRA_UAI_PAT"
    python scripts/transcripciones_a_obsidian.py \\
        --project-ref bipsvhxsvfzfwzufucfg \\
        --course poderosa-maquina-pacientes \\
        --vault "C:/obsidian/vault-poderosa-maquina-pacientes"
"""

from __future__ import annotations

import argparse
import os
import re
import sys
import unicodedata
from datetime import date
from pathlib import Path

import requests


def nombre_archivo(texto: str, largo: int = 60) -> str:
    """Convierte a la forma `Palabra_Palabra` que usan los vaults de curso."""
    sin_acentos = unicodedata.normalize("NFKD", texto).encode("ascii", "ignore").decode()
    limpio = re.sub(r"[^A-Za-z0-9]+", "_", sin_acentos).strip("_")
    return (limpio[:largo].strip("_") or "sin_titulo")


def service_key(project_ref: str) -> str:
    pat = os.environ.get("SUPABASE_ACCESS_TOKEN")
    if not pat:
        raise SystemExit("Falta SUPABASE_ACCESS_TOKEN (usá el PAT del proyecto).")
    r = requests.get(
        f"https://api.supabase.com/v1/projects/{project_ref}/api-keys?reveal=true",
        headers={"Authorization": f"Bearer {pat}"},
        timeout=30,
    )
    r.raise_for_status()
    for entrada in r.json():
        if entrada.get("name") == "service_role":
            return entrada["api_key"]
    raise SystemExit("La Management API no devolvió la service_role key.")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--project-ref", required=True)
    parser.add_argument("--course", required=True)
    parser.add_argument("--vault", required=True)
    parser.add_argument("--vtt-dir", help="carpeta de .md venidos de subtitulos, para marcar la fuente")
    args = parser.parse_args()

    key = service_key(args.project_ref)
    base = f"https://{args.project_ref}.supabase.co/rest/v1"
    sesion = requests.Session()
    sesion.headers.update({"apikey": key, "Authorization": f"Bearer {key}"})

    curso = sesion.get(
        f"{base}/courses",
        params={"select": "id,title,subtitle,description", "id": f"eq.{args.course}"},
        timeout=30,
    )
    curso.raise_for_status()
    curso = curso.json()[0]

    modulos = sesion.get(
        f"{base}/course_modules",
        params={"select": "id,title,intro,sort_order", "course_id": f"eq.{args.course}", "order": "sort_order"},
        timeout=30,
    )
    modulos.raise_for_status()
    modulos = modulos.json()

    clases = sesion.get(
        f"{base}/course_lessons",
        params={
            "select": "id,module_id,title,sort_order,course_lesson_transcripts(transcript_text)",
            "course_id": f"eq.{args.course}",
            "order": "sort_order",
        },
        timeout=60,
    )
    clases.raise_for_status()
    clases = clases.json()

    desde_vtt = set()
    if args.vtt_dir and Path(args.vtt_dir).is_dir():
        desde_vtt = {p.stem for p in Path(args.vtt_dir).glob("*.md")}

    vault = Path(args.vault).expanduser()
    bruto = vault / "bruto"
    bruto.mkdir(parents=True, exist_ok=True)
    (vault / "apuntes").mkdir(exist_ok=True)
    hoy = date.today().isoformat()

    escritas = sin_texto = 0
    indice = [
        f"# {curso['title']}\n",
        f"{curso.get('description') or ''}\n",
        f"Transcripciones automáticas exportadas desde LearnForce el {hoy}.",
        "La mayoría viene de Whisper sobre el video original; algunas, de los subtítulos",
        "autogenerados de Vimeo. Cada nota indica su fuente en el frontmatter.\n",
    ]

    for orden, modulo in enumerate(modulos, start=1):
        propias = [c for c in clases if c["module_id"] == modulo["id"]]
        if not propias:
            continue
        carpeta = bruto / f"{orden:02d}_{nombre_archivo(modulo['title'])}"
        carpeta.mkdir(exist_ok=True)

        con_texto = sum(1 for c in propias if c.get("course_lesson_transcripts"))
        indice.append(f"\n## {modulo['title']}\n")
        if modulo.get("intro"):
            indice.append(f"{modulo['intro']}\n")
        indice.append(f"*{con_texto} de {len(propias)} clases con transcripción.*\n")

        for numero, clase in enumerate(propias, start=1):
            transcripciones = clase.get("course_lesson_transcripts") or []
            texto = transcripciones[0]["transcript_text"] if transcripciones else ""
            stem = f"{numero:02d}_{nombre_archivo(clase['title'])}"
            ruta_rel = f"{carpeta.name}/{stem}"

            if not texto:
                sin_texto += 1
                indice.append(f"- {clase['title']} — *sin transcripción todavía*")
                continue

            fuente = "subtítulos autogenerados de Vimeo" if clase["id"] in desde_vtt else "Whisper (faster-whisper medium)"
            (carpeta / f"{stem}.md").write_text(
                "---\n"
                f"curso: {curso['title']}\n"
                f"modulo: {modulo['title']}\n"
                f"lesson_id: {clase['id']}\n"
                f"fuente: {fuente}\n"
                f"exportado: {hoy}\n"
                "---\n\n"
                f"# {clase['title']}\n\n"
                f"> Transcripción automática ({fuente}). Puede tener errores de puntuación y nombres propios.\n\n"
                f"{texto}\n",
                encoding="utf-8",
            )
            escritas += 1
            indice.append(f"- [[{ruta_rel}|{clase['title']}]]")

    (bruto / "00_INDICE.md").write_text("\n".join(indice) + "\n", encoding="utf-8")

    print(f"notas escritas: {escritas} | clases sin transcripción: {sin_texto}")
    print(f"vault: {vault}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
