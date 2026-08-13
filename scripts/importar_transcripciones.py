#!/usr/bin/env python3
"""Importa a Supabase las transcripciones generadas por el worker de Granolazo.

`learnforce-granolazo-transcribe.py` deja un `.md` por clase con frontmatter
(`lesson_id`, `course`, `module`, ...) y el texto plano debajo. Este script los
carga a `course_lesson_transcripts`, sube el `.md` al bucket privado, marca
`has_transcript` y reconstruye el indice de busqueda.

Ver docs/subtitulos-hotmart-vimeo.md para el pipeline completo.

La service_role key se pide a la Management API con el PAT y nunca se imprime.

Uso:

    export SUPABASE_ACCESS_TOKEN="$SUPABASE_PROGRA_UAI_PAT"
    python scripts/importar_transcripciones.py \\
        --dir tmp/learnforce-transcripts \\
        --project-ref bipsvhxsvfzfwzufucfg

    # ver que haria, sin escribir nada
    python scripts/importar_transcripciones.py --dir ... --project-ref ... --dry-run
"""

from __future__ import annotations

import argparse
import os
import sys
from pathlib import Path

import requests

BUCKET = "imperio-agentico-content"
IDIOMA = "es"


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


def leer_transcripcion(ruta: Path) -> dict | None:
    """Separa el frontmatter del cuerpo. Devuelve None si el archivo no calza."""
    texto = ruta.read_text(encoding="utf-8")
    if not texto.startswith("---"):
        return None
    _, frontmatter, cuerpo = texto.split("---", 2)

    meta: dict[str, str] = {}
    for linea in frontmatter.strip().splitlines():
        if ":" not in linea:
            continue
        clave, valor = linea.split(":", 1)
        meta[clave.strip()] = valor.strip().strip('"')

    if not meta.get("lesson_id"):
        return None

    # El cuerpo arranca con "# Titulo"; el texto util viene despues.
    lineas = [l for l in cuerpo.strip().splitlines() if not l.startswith("# ")]
    return {
        "lesson_id": meta["lesson_id"],
        "course_id": meta.get("course", ""),
        "texto": "\n".join(lineas).strip(),
        "archivo": ruta,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--dir", required=True, help="carpeta con los .md del worker")
    parser.add_argument("--project-ref", required=True)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    archivos = sorted(Path(args.dir).expanduser().rglob("*.md"))
    transcripciones = [t for t in (leer_transcripcion(f) for f in archivos) if t]
    vacias = [t for t in transcripciones if not t["texto"]]
    transcripciones = [t for t in transcripciones if t["texto"]]

    print(f"archivos .md: {len(archivos)} | con lesson_id y texto: {len(transcripciones)} | vacias: {len(vacias)}")
    cursos = sorted({t["course_id"] for t in transcripciones})
    print(f"cursos: {', '.join(cursos)}")
    if not transcripciones:
        return 1

    key = service_key(args.project_ref)
    base = f"https://{args.project_ref}.supabase.co"
    sesion = requests.Session()
    sesion.headers.update({"apikey": key, "Authorization": f"Bearer {key}"})

    # Las clases tienen que existir: la FK falla si no, y el mensaje seria opaco.
    ids = [t["lesson_id"] for t in transcripciones]
    existen = set()
    for i in range(0, len(ids), 50):
        lote = ids[i:i + 50]
        r = sesion.get(
            f"{base}/rest/v1/course_lessons",
            params={"select": "id", "id": f"in.({','.join(lote)})"},
            timeout=30,
        )
        r.raise_for_status()
        existen.update(x["id"] for x in r.json())
    huerfanas = [t for t in transcripciones if t["lesson_id"] not in existen]
    if huerfanas:
        print(f"\nAVISO: {len(huerfanas)} transcripciones sin clase en la base, se omiten:")
        for t in huerfanas[:5]:
            print(f"   {t['lesson_id']}  ({t['archivo'].name})")
        transcripciones = [t for t in transcripciones if t["lesson_id"] in existen]

    if args.dry_run:
        print(f"\n[dry-run] importaria {len(transcripciones)} transcripciones")
        return 0

    filas = []
    for t in transcripciones:
        destino = f"transcripts/{t['course_id']}/{t['lesson_id']}.md"
        subida = sesion.post(
            f"{base}/storage/v1/object/{BUCKET}/{destino}",
            headers={"Content-Type": "text/markdown", "x-upsert": "true"},
            data=t["archivo"].read_bytes(),
            timeout=60,
        )
        if subida.status_code >= 300:
            print(f"  storage {t['lesson_id']}: HTTP {subida.status_code} {subida.text[:100]}")
        filas.append({
            "id": f"{t['lesson_id']}-{IDIOMA}",
            "lesson_id": t["lesson_id"],
            "language": IDIOMA,
            "transcript_text": t["texto"],
            "storage_path": destino,
            "sort_order": 0,
        })

    r = sesion.post(
        f"{base}/rest/v1/course_lesson_transcripts",
        headers={"Content-Type": "application/json", "Prefer": "resolution=merge-duplicates,return=minimal"},
        params={"on_conflict": "lesson_id,language"},
        json=filas,
        timeout=180,
    )
    if r.status_code >= 300:
        raise SystemExit(f"Error al insertar transcripciones: HTTP {r.status_code} {r.text[:400]}")
    print(f"transcripciones cargadas: {len(filas)}")

    # El frontend usa este flag para mostrar la pestaña de transcripcion.
    marcados = 0
    for i in range(0, len(filas), 50):
        lote = [f["lesson_id"] for f in filas[i:i + 50]]
        r = sesion.patch(
            f"{base}/rest/v1/course_lessons",
            headers={"Content-Type": "application/json", "Prefer": "return=representation"},
            params={"id": f"in.({','.join(lote)})", "select": "id"},
            json={"has_transcript": True},
            timeout=60,
        )
        r.raise_for_status()
        marcados += len(r.json())
    print(f"clases marcadas con has_transcript: {marcados}")

    # Sin esto las transcripciones no aparecen en la busqueda.
    for curso in cursos:
        r = sesion.post(
            f"{base}/rest/v1/rpc/rebuild_course_search_documents",
            headers={"Content-Type": "application/json"},
            json={"p_course_ids": [curso]},
            timeout=300,
        )
        estado = "ok" if r.status_code < 300 else f"HTTP {r.status_code} {r.text[:120]}"
        print(f"indice reconstruido [{curso}]: {estado}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
