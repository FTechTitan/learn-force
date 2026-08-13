#!/usr/bin/env python3
"""Transcribe con OpenAI las clases de un curso que aun no tienen transcripcion.

Es el camino rapido cuando el video no tiene subtitulos en Vimeo y el worker
local de Whisper es demasiado lento (va a ~3x tiempo real). Ver la skill
`transcribe-audio`, modo OpenAI.

Toma los mp4 que ya estan en `tmp/course-import/<curso>/videos/`, extrae el
audio con ffmpeg a MP3 mono liviano, lo parte en bloques (el endpoint acepta
25 MB por request), transcribe cada bloque y escribe un `.md` por clase con el
mismo frontmatter que produce el worker, listo para `importar_transcripciones.py`.

La API key se lee del Belt en memoria y nunca se imprime ni se guarda en disco.

Uso:

    python scripts/transcribir_openai.py \\
        --project-ref bipsvhxsvfzfwzufucfg \\
        --course poderosa-maquina-pacientes \\
        --out tmp/openai-transcripts
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

import requests

MODELO = "gpt-4o-transcribe"
BLOQUE_SEGUNDOS = 600  # 10 min por request
ID_VIMEO = re.compile(r"\[(\d+)\]")


def claves_openai() -> list[tuple[str, str]]:
    """Candidatas del Belt, como (nombre_item, key). No se imprimen ni se guardan.

    Devuelve TODAS las candidatas, no una sola: una key puede responder 200 en
    /v1/models y aun asi dar 403 en audio, porque las keys por proyecto se
    restringen por endpoint. Validar contra el endpoint que se va a usar.
    """
    sesion = subprocess.check_output(
        ["python", str(Path.home() / ".claude/scripts/bw-unlock.py")], text=True
    ).strip()
    items = json.loads(subprocess.check_output(
        ["bw", "list", "items", "--search", "openai", "--session", sesion], text=True
    ))
    candidatas: list[tuple[str, str]] = []
    vistas = set()
    for item in items:
        login = item.get("login") or {}
        partes = [login.get("password"), login.get("username"), item.get("notes")]
        partes += [f.get("value") for f in (item.get("fields") or [])]
        blob = "\n".join(p for p in partes if isinstance(p, str))
        for k in re.findall(r"sk-(?:proj-)?[A-Za-z0-9_\-]{20,}", blob):
            if k in vistas:
                continue
            vistas.add(k)
            candidatas.append((item.get("name") or "?", k))
    if not candidatas:
        raise SystemExit("No encontré ninguna key de OpenAI en el Belt.")
    return candidatas


def service_key(project_ref: str) -> str:
    pat = os.environ.get("SUPABASE_ACCESS_TOKEN")
    if not pat:
        raise SystemExit("Falta SUPABASE_ACCESS_TOKEN.")
    r = requests.get(
        f"https://api.supabase.com/v1/projects/{project_ref}/api-keys?reveal=true",
        headers={"Authorization": f"Bearer {pat}"}, timeout=30,
    )
    r.raise_for_status()
    for entrada in r.json():
        if entrada.get("name") == "service_role":
            return entrada["api_key"]
    raise SystemExit("La Management API no devolvió la service_role key.")


def pendientes(project_ref: str, course: str) -> list[dict]:
    """Clases publicadas del curso que todavia no tienen transcripcion."""
    key = service_key(project_ref)
    base = f"https://{project_ref}.supabase.co/rest/v1"
    cab = {"apikey": key, "Authorization": f"Bearer {key}"}
    clases = requests.get(f"{base}/course_lessons", headers=cab, params={
        "select": "id,title,sort_order,module_id,course_lesson_transcripts(id)",
        "course_id": f"eq.{course}", "order": "sort_order",
    }, timeout=60)
    clases.raise_for_status()
    return [c for c in clases.json() if not c.get("course_lesson_transcripts")]


def transcribir_audio(ruta: Path, candidatas: list[tuple[str, str]], estado: dict) -> str:
    """Transcribe un bloque, probando candidatas hasta dar con una autorizada.

    Recuerda en `estado` la key que funciono, para no reintentar en cada bloque.
    """
    orden = ([estado["key"]] if estado.get("key") else []) + [
        k for _, k in candidatas if k != estado.get("key")
    ]
    ultimo = None
    for k in orden:
        with ruta.open("rb") as f:
            r = requests.post(
                "https://api.openai.com/v1/audio/transcriptions",
                headers={"Authorization": f"Bearer {k}"},
                data={"model": MODELO, "response_format": "text", "language": "es"},
                files={"file": (ruta.name, f, "audio/mpeg")},
                timeout=900,
            )
        if r.status_code == 200:
            if estado.get("key") != k:
                nombre = next((n for n, c in candidatas if c == k), "?")
                print(f"        key autorizada para audio: {nombre}", flush=True)
                estado["key"] = k
            return r.text.strip()
        if r.status_code in (401, 403):
            continue  # sin permiso sobre audio: probamos la siguiente
        ultimo = f"HTTP {r.status_code} {r.text[:120]}"
        break
    raise RuntimeError(ultimo or "ninguna key del Belt tiene permiso sobre /audio/transcriptions")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--project-ref", required=True)
    parser.add_argument("--course", required=True)
    parser.add_argument("--out", required=True)
    args = parser.parse_args()

    faltan = pendientes(args.project_ref, args.course)
    print(f"clases sin transcripción: {len(faltan)}", flush=True)
    if not faltan:
        return 0

    manifest = json.loads(
        Path(f"tmp/course-import/{args.course}/manifest.json").read_text(encoding="utf-8")
    )["lessons"]
    por_orden = {l["order"]: l for l in manifest}

    candidatas = claves_openai()
    estado: dict = {}
    print(f"keys candidatas en el Belt: {len(candidatas)}", flush=True)
    destino = Path(args.out)
    destino.mkdir(parents=True, exist_ok=True)

    hechas = fallidas = 0
    for clase in faltan:
        entrada = por_orden.get(clase["sort_order"]) or {}
        video = entrada.get("local_video_file")
        if not video or not Path(video).exists():
            # El manifiesto guarda rutas del equipo donde se descargó; probamos local.
            nombre = entrada.get("original_filename") or ""
            candidato = Path(f"tmp/course-import/{args.course}/videos")
            encontrado = None
            marca = ID_VIMEO.search(nombre)
            if marca:
                for p in candidato.glob(f"*{marca.group(1)}*.mp4"):
                    encontrado = p
                    break
            video = str(encontrado) if encontrado else None
        if not video:
            print(f"  [{clase['sort_order']}] sin archivo de video, se omite", flush=True)
            fallidas += 1
            continue

        print(f"  [{clase['sort_order']}] {clase['title'][:45]}", flush=True)
        with tempfile.TemporaryDirectory() as tmpdir:
            patron = str(Path(tmpdir) / "bloque_%03d.mp3")
            subprocess.run([
                "ffmpeg", "-y", "-hide_banner", "-loglevel", "error", "-i", str(video),
                "-vn", "-ac", "1", "-ar", "16000", "-b:a", "32k",
                "-f", "segment", "-segment_time", str(BLOQUE_SEGUNDOS), patron,
            ], check=True)
            bloques = sorted(Path(tmpdir).glob("bloque_*.mp3"))
            print(f"        {len(bloques)} bloque(s)", flush=True)
            try:
                texto = " ".join(transcribir_audio(b, candidatas, estado) for b in bloques).strip()
            except Exception as e:
                print(f"        ERROR: {str(e)[:120]}", flush=True)
                fallidas += 1
                continue

        (destino / f"{clase['id']}.md").write_text(
            "---\n"
            f"course: {args.course}\n"
            f"module: {clase['module_id']}\n"
            f"lesson_id: {clase['id']}\n"
            f'title: "{clase["title"]}"\n'
            f"provider: openai-{MODELO}\n"
            "---\n\n"
            f"# {clase['title']}\n\n{texto}\n",
            encoding="utf-8",
        )
        hechas += 1
        print(f"        {len(texto)} caracteres", flush=True)

    print(f"\ntranscritas: {hechas} | fallidas: {fallidas} | salida: {destino}")
    return 0 if hechas else 1


if __name__ == "__main__":
    sys.exit(main())
