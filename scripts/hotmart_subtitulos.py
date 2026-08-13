#!/usr/bin/env python3
"""Recupera los subtitulos de un curso de Hotmart Club a partir de un HAR.

Los videos de estos cursos viven en Vimeo como privados: la URL pelada responde
401 y solo funciona con el hash de embed (`?h=...`) que usa Hotmart. Ese hash
sale del detalle de cada leccion en la API de Hotmart Club, que exige un
access_token; el token se extrae de un HAR de una sesion autenticada.

Ver docs/subtitulos-hotmart-vimeo.md para el contexto completo.

El token NUNCA se imprime ni se guarda en disco.

Uso:

    # 1) Mapear las lecciones a sus URLs de Vimeo con hash
    python scripts/hotmart_subtitulos.py mapear \\
        --har ~/Downloads/hotmart.com.har \\
        --product-id 3294505 \\
        --slug alumnos-la-poderosa-maquina-atraer-pacientes \\
        --out tmp/pmp-vimeo-urls.json

    # 2) Descargar los .vtt (solo subtitulos, sin video)
    python scripts/hotmart_subtitulos.py bajar \\
        --mapa tmp/pmp-vimeo-urls.json \\
        --out-dir tmp/pmp-subtitulos
"""

from __future__ import annotations

import argparse
import base64
import json
import re
import subprocess
import sys
import time
from pathlib import Path
from urllib.parse import parse_qs, urlparse

import requests

API_BASE = "https://api-club-course-consumption-gateway-ga.cb.hotmart.com"
PAUSA_SEGUNDOS = 1.5  # la guia pide pocas requests por segundo
# El embed aparece de dos formas y solo la primera sirve para descargar. No hay
# manera de anticiparlo por el `type` de la leccion: en PMP las 64 son CONTENT.
#   - con hash:  player.vimeo.com/video/<id>?h=<hash>       -> yt-dlp funciona
#   - sin hash:  player.vimeo.com/video/<id>?badge=0&...    -> 401 siempre
# Igual capturamos el id de las segundas: es el que llevan los mp4 locales en el
# nombre (`Titulo [<id>].mp4`), asi que sirve para mapear la clase a su archivo.
VIMEO_CON_HASH = re.compile(r"https?://player\.vimeo\.com/video/(\d+)[^\"'\\ ]*?[?&]h=([A-Za-z0-9]+)")
VIMEO_ID = re.compile(r"player\.vimeo\.com/video/(\d+)")


def token_desde_har(har_path: Path) -> str:
    """Saca el access_token del HAR.

    Prueba dos fuentes, porque dependen de que se haya capturado el login:
    el header Authorization de cualquier request a la API (lo mas comun al
    grabar navegando), y el id_token_hint del redirect de SSO.
    """
    har = json.loads(har_path.read_text(encoding="utf-8"))

    for entry in har["log"]["entries"]:
        for header in entry["request"].get("headers", []):
            if header.get("name", "").lower() != "authorization":
                continue
            valor = header.get("value", "")
            if valor.lower().startswith("bearer "):
                token = valor.split(" ", 1)[1].strip()
                if len(token) > 20:
                    return token

    for entry in har["log"]["entries"]:
        url = entry["request"]["url"]
        if "id_token_hint=" not in url:
            continue
        jwt = parse_qs(urlparse(url).query)["id_token_hint"][0]
        payload = jwt.split(".")[1]
        payload += "=" * (-len(payload) % 4)
        token = json.loads(base64.urlsafe_b64decode(payload)).get("access_token")
        if token:
            return token

    raise SystemExit(
        "No encontre access_token en el HAR. Al grabarlo, navegá una clase con "
        "el reproductor cargado para que queden requests a la API con Authorization."
    )


def cliente(token: str, product_id: str, slug: str) -> requests.Session:
    sesion = requests.Session()
    sesion.headers.update({
        "accept": "application/json, text/plain, */*",
        "origin": "https://hotmart.com",
        "referer": "https://hotmart.com/",
        "slug": slug,
        "x-hot-club-http": "APP_CLUB_CONSUMER_API_COURSE_CONSUMPTION_GATEWAY_INSTANCE",
        "x-product-id": str(product_id),
        "Authorization": f"Bearer {token}",
    })
    return sesion


def mapear(args: argparse.Namespace) -> int:
    token = token_desde_har(Path(args.har).expanduser())
    sesion = cliente(token, args.product_id, args.slug)

    prueba = sesion.get(f"{API_BASE}/v2/product/basic", timeout=30)
    if prueba.status_code == 401:
        raise SystemExit(
            "El token del HAR esta vencido (401). Grabá un HAR nuevo con la sesión abierta."
        )
    prueba.raise_for_status()
    print(f"producto: {prueba.json().get('name')}")

    navegacion = sesion.get(f"{API_BASE}/v1/navigation", timeout=30)
    navegacion.raise_for_status()
    modulos = navegacion.json().get("modules", [])

    paginas = [
        {"modulo": m.get("name", ""), "hash": p.get("hash"), "titulo": p.get("name", "")}
        for m in modulos
        for p in m.get("pages", [])
        if p.get("hash")
    ]
    print(f"modulos: {len(modulos)} | clases: {len(paginas)}")

    resultado = []
    for indice, pagina in enumerate(paginas, start=1):
        detalle = sesion.get(f"{API_BASE}/v2/web/lessons/{pagina['hash']}", timeout=30)
        if detalle.status_code != 200:
            print(f"  [{indice}/{len(paginas)}] {pagina['titulo'][:45]}: HTTP {detalle.status_code}")
            time.sleep(PAUSA_SEGUNDOS)
            continue

        con_hash = VIMEO_CON_HASH.search(detalle.text)
        solo_id = VIMEO_ID.search(detalle.text)
        resultado.append({
            **pagina,
            "tipo": detalle.json().get("type"),
            "vimeo_id": con_hash.group(1) if con_hash else (solo_id.group(1) if solo_id else None),
            "vimeo_url": con_hash.group(0) if con_hash else None,
            "descargable": bool(con_hash),
        })
        if con_hash:
            estado = con_hash.group(1)
        elif solo_id:
            estado = f"{solo_id.group(1)} (embed sin hash, no descargable)"
        else:
            estado = "sin video"
        print(f"  [{indice}/{len(paginas)}] {pagina['titulo'][:45]}: {estado}")
        time.sleep(PAUSA_SEGUNDOS)

    salida = Path(args.out).expanduser()
    salida.parent.mkdir(parents=True, exist_ok=True)
    salida.write_text(json.dumps(resultado, ensure_ascii=False, indent=2), encoding="utf-8")

    con_url = sum(1 for r in resultado if r["vimeo_url"])
    print(f"\n{con_url}/{len(paginas)} clases con URL de Vimeo -> {salida}")
    return 0 if con_url else 1


def bajar(args: argparse.Namespace) -> int:
    mapa = json.loads(Path(args.mapa).expanduser().read_text(encoding="utf-8"))
    destino = Path(args.out_dir).expanduser()
    destino.mkdir(parents=True, exist_ok=True)

    ok = fallos = 0
    for indice, fila in enumerate(mapa, start=1):
        if not fila.get("vimeo_url"):
            continue
        # --write-subs, NO --write-auto-subs: Vimeo los reporta como subtitulos
        # disponibles y con el flag equivocado no baja nada.
        comando = [
            "yt-dlp", "--write-subs", "--sub-langs", "es.*", "--skip-download",
            "--no-warnings", "-o", "%(id)s.%(ext)s", "-P", str(destino),
            fila["vimeo_url"],
        ]
        proceso = subprocess.run(comando, capture_output=True, text=True)
        if proceso.returncode == 0:
            ok += 1
        else:
            fallos += 1
            print(f"  [{indice}] {fila['titulo'][:45]}: {proceso.stderr.strip()[:120]}")
        time.sleep(1)

    vtts = list(destino.glob("*.vtt"))
    print(f"\nok={ok} fallos={fallos} | archivos .vtt en disco: {len(vtts)}")
    return 0 if vtts else 1


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="comando", required=True)

    p_map = sub.add_parser("mapear", help="HAR -> JSON con las URLs de Vimeo con hash")
    p_map.add_argument("--har", required=True)
    p_map.add_argument("--product-id", required=True)
    p_map.add_argument("--slug", required=True)
    p_map.add_argument("--out", required=True)
    p_map.set_defaults(func=mapear)

    p_baj = sub.add_parser("bajar", help="JSON -> archivos .vtt")
    p_baj.add_argument("--mapa", required=True)
    p_baj.add_argument("--out-dir", required=True)
    p_baj.set_defaults(func=bajar)

    args = parser.parse_args()
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
