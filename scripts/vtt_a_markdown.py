#!/usr/bin/env python3
"""Convierte los .vtt de Vimeo al formato .md que consume importar_transcripciones.py.

Los subtitulos que se bajan con `hotmart_subtitulos.py bajar` se llaman
`<vimeo_id>.es-x-autogen.vtt`. Para importarlos hay que saber a que clase
corresponden, y el puente es el manifiesto del importador de cursos: su campo
`original_filename` trae el id de Vimeo entre corchetes y su `order` coincide con
el `sort_order` de la clase en Supabase.

Uso:

    python scripts/vtt_a_markdown.py \\
        --vtt-dir tmp/pmp-subtitulos \\
        --manifest tmp/course-import/poderosa-maquina-pacientes/manifest.json \\
        --course poderosa-maquina-pacientes \\
        --lecciones tmp/lecciones.json \\
        --out tmp/vtt-markdown

`--lecciones` es un JSON con [{"sort_order": n, "id": "catalog-lesson-..."}, ...]
tal como lo devuelve `supabase db query` sobre course_lessons.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

MARCA_TIEMPO = re.compile(r"^\d{2}:\d{2}:\d{2}\.\d{3}\s*-->")
SOLO_NUMERO = re.compile(r"^\d+$")
ID_VIMEO = re.compile(r"\[(\d+)\]")


def vtt_a_texto(ruta: Path) -> str:
    """Saca cabecera, numeros de cue y marcas de tiempo; deja el texto corrido.

    Los autogenerados de Vimeo repiten la misma linea entre cues contiguos, asi
    que se descartan las repeticiones consecutivas.
    """
    lineas: list[str] = []
    for cruda in ruta.read_text(encoding="utf-8", errors="replace").splitlines():
        linea = cruda.strip()
        if not linea or linea.startswith("WEBVTT") or linea.startswith("NOTE"):
            continue
        if SOLO_NUMERO.match(linea) or MARCA_TIEMPO.match(linea):
            continue
        linea = re.sub(r"<[^>]+>", "", linea)  # tags de karaoke
        if lineas and lineas[-1] == linea:
            continue
        lineas.append(linea)
    return " ".join(lineas).strip()


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--vtt-dir", required=True)
    parser.add_argument("--manifest", required=True)
    parser.add_argument("--course", required=True)
    parser.add_argument("--lecciones", required=True)
    parser.add_argument("--out", required=True)
    args = parser.parse_args()

    manifest = json.loads(Path(args.manifest).read_text(encoding="utf-8"))["lessons"]
    lecciones = json.loads(Path(args.lecciones).read_text(encoding="utf-8"))
    por_orden = {int(l["sort_order"]): l["id"] for l in lecciones}

    # vimeo_id -> (lesson_id, titulo)
    puente: dict[str, tuple[str, str]] = {}
    for entrada in manifest:
        encontrado = ID_VIMEO.search(entrada.get("original_filename") or "")
        lesson_id = por_orden.get(entrada.get("order"))
        if encontrado and lesson_id:
            puente[encontrado.group(1)] = (lesson_id, entrada.get("title", ""))

    destino = Path(args.out)
    destino.mkdir(parents=True, exist_ok=True)

    escritos = sin_puente = vacios = 0
    for vtt in sorted(Path(args.vtt_dir).glob("*.vtt")):
        vimeo_id = vtt.name.split(".")[0]
        if vimeo_id not in puente:
            sin_puente += 1
            continue
        lesson_id, titulo = puente[vimeo_id]
        texto = vtt_a_texto(vtt)
        if not texto:
            vacios += 1
            continue
        (destino / f"{lesson_id}.md").write_text(
            "---\n"
            f"course: {args.course}\n"
            f"lesson_id: {lesson_id}\n"
            f'title: "{titulo}"\n'
            f"vimeo_id: {vimeo_id}\n"
            "provider: vimeo-es-x-autogen\n"
            "---\n\n"
            f"# {titulo}\n\n{texto}\n",
            encoding="utf-8",
        )
        escritos += 1

    print(f"vtt convertidos: {escritos} | sin clase asociada: {sin_puente} | vacios: {vacios}")
    print(f"salida: {destino}")
    return 0 if escritos else 1


if __name__ == "__main__":
    sys.exit(main())
