#!/usr/bin/env python3
"""Persiste en Supabase el contenido editorial generado por Hermes o un subagente.

Este script NO genera contenido: solo valida y escribe. La generacion de las
etapas `contenido_transcripcion` y `resumen` la hace un agente con contexto, tal
como exige la skill `granolazo-review`.

Entrada: uno o varios JSON con esta forma (uno por modulo):

    {
      "module_id": "pmp-neuromarketing-persuasion",
      "overview_md": "...",
      "lessons": [
        {"lesson_id": "catalog-lesson-...", "resumen": "...",
         "contenido_md": "...", "titulo_sugerido": null}
      ]
    }

Destinos:

    resumen       -> course_lessons.summary
    contenido_md  -> course_lesson_contents.body_markdown
    overview_md   -> course_modules.overview_markdown

La transcripcion cruda (`course_lesson_transcripts`) NUNCA se toca: es la fuente
y siempre permite regenerar.

Uso:

    export SUPABASE_ACCESS_TOKEN="$SUPABASE_PROGRA_UAI_PAT"
    python scripts/persistir_enriquecido.py --dir tmp/enriquecido \\
        --project-ref bipsvhxsvfzfwzufucfg --course poderosa-maquina-pacientes --dry-run
"""

from __future__ import annotations

import argparse
import json
import os
import sys
from pathlib import Path

import requests

MAX_RESUMEN = 320
MIN_PALABRAS_CONTENIDO = 120
MIN_PALABRAS_OVERVIEW = 50


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


def validar(paquete: dict, ruta: Path) -> list[str]:
    problemas = []
    if not paquete.get("module_id"):
        problemas.append(f"{ruta.name}: falta module_id")
    if len((paquete.get("overview_md") or "").split()) < MIN_PALABRAS_OVERVIEW:
        problemas.append(f"{ruta.name}: overview_md muy corto o vacío")
    for clase in paquete.get("lessons") or []:
        etiqueta = clase.get("lesson_id", "?")[:30]
        if not clase.get("lesson_id"):
            problemas.append(f"{ruta.name}: una clase sin lesson_id")
        resumen = (clase.get("resumen") or "").strip()
        if not resumen:
            problemas.append(f"{ruta.name}/{etiqueta}: resumen vacío")
        elif len(resumen) > MAX_RESUMEN:
            problemas.append(f"{ruta.name}/{etiqueta}: resumen de {len(resumen)} caracteres (máx {MAX_RESUMEN})")
        if len((clase.get("contenido_md") or "").split()) < MIN_PALABRAS_CONTENIDO:
            problemas.append(f"{ruta.name}/{etiqueta}: contenido_md muy corto")
    return problemas


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--dir", required=True, help="carpeta con los JSON por módulo")
    parser.add_argument("--project-ref", required=True)
    parser.add_argument("--course", required=True)
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--aplicar-titulos", action="store_true",
                        help="además escribe titulo_sugerido en course_lessons.title")
    args = parser.parse_args()

    archivos = sorted(Path(args.dir).expanduser().glob("*.json"))
    if not archivos:
        raise SystemExit(f"No hay JSON en {args.dir}")

    paquetes, problemas = [], []
    for ruta in archivos:
        paquete = json.loads(ruta.read_text(encoding="utf-8"))
        problemas.extend(validar(paquete, ruta))
        paquetes.append(paquete)

    clases = [c for p in paquetes for c in (p.get("lessons") or [])]
    titulos = [c for c in clases if c.get("titulo_sugerido")]
    print(f"módulos: {len(paquetes)} | clases: {len(clases)} | títulos sugeridos: {len(titulos)}")

    if problemas:
        print("\nPROBLEMAS DE VALIDACIÓN:")
        for p in problemas:
            print(f"  - {p}")
        if not args.dry_run:
            raise SystemExit("No se escribe nada hasta que el contenido valide.")

    if titulos:
        print("\nTítulos que el agente propone cambiar:")
        for c in titulos[:20]:
            print(f"  {c['lesson_id'][-12:]}  ->  {c['titulo_sugerido']}")
        if not args.aplicar_titulos:
            print("  (no se aplican: usá --aplicar-titulos si querés escribirlos)")

    if args.dry_run:
        print("\n[dry-run] no se escribió nada")
        return 0

    key = service_key(args.project_ref)
    base = f"https://{args.project_ref}.supabase.co/rest/v1"
    sesion = requests.Session()
    sesion.headers.update({"apikey": key, "Authorization": f"Bearer {key}"})

    for paquete in paquetes:
        r = sesion.patch(
            f"{base}/course_modules",
            headers={"Content-Type": "application/json"},
            params={"id": f"eq.{paquete['module_id']}", "course_id": f"eq.{args.course}"},
            json={"overview_markdown": paquete["overview_md"]},
            timeout=60,
        )
        r.raise_for_status()

    contenidos = [
        {"lesson_id": c["lesson_id"], "body_markdown": c["contenido_md"]}
        for c in clases
    ]
    r = sesion.post(
        f"{base}/course_lesson_contents",
        headers={"Content-Type": "application/json", "Prefer": "resolution=merge-duplicates,return=minimal"},
        params={"on_conflict": "lesson_id"},
        json=contenidos,
        timeout=180,
    )
    if r.status_code >= 300:
        raise SystemExit(f"Error al escribir contenidos: HTTP {r.status_code} {r.text[:300]}")

    for clase in clases:
        cambios = {"summary": clase["resumen"]}
        if args.aplicar_titulos and clase.get("titulo_sugerido"):
            cambios["title"] = clase["titulo_sugerido"]
        r = sesion.patch(
            f"{base}/course_lessons",
            headers={"Content-Type": "application/json"},
            params={"id": f"eq.{clase['lesson_id']}"},
            json=cambios,
            timeout=60,
        )
        r.raise_for_status()

    print(f"módulos actualizados: {len(paquetes)} | clases actualizadas: {len(clases)}")

    r = sesion.post(
        f"{base}/rpc/rebuild_course_search_documents",
        headers={"Content-Type": "application/json"},
        json={"p_course_ids": [args.course]},
        timeout=300,
    )
    print(f"índice reconstruido: {'ok' if r.status_code < 300 else r.text[:120]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
