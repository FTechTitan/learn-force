#!/usr/bin/env python3
"""Import one Emprende Go (Skool) course into techforce learn.

Adapted from import_imperio_vault.py for a vault with NO module-subfolder
nesting: one top-level folder under bruto/ = one course, its 01_-prefixed
file = the module overview, and every other .md = a lesson. Videos are kept
as external Drive links (parsed from the "Drive: <url>" line already
inserted in each lesson) -- the front end embeds them via urlEmbedMedia()
(js/app.js), it does not need a re-hosted file.

Dry-run is the default. --apply writes SQL via `supabase db query --linked`
and uploads transcripts/resources via `supabase storage cp --linked`.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import mimetypes
import os
import re
import subprocess
import sys
import unicodedata
from pathlib import Path

BUCKET = "emprendego-content"

RESOURCE_RE = re.compile(r"\[\[attachments/(?P<path>[^\]|]+)(?:\|(?P<label>[^\]]+))?\]\]")
VIDEO_SECTION_RE = re.compile(r"\n##\s+[^\n]*Video\s*\n.*?(?=\n##\s+|\Z)", re.IGNORECASE | re.DOTALL)
DRIVE_LINE_RE = re.compile(r"Drive:\s*(https?://\S+)", re.IGNORECASE)
DURATION_LINE_RE = re.compile(r"duraci[oó]n:\s*([0-9:]+)", re.IGNORECASE)
SRT_BLOCK_RE = re.compile(
    r"(?:^|\n)\d+\s*\n"
    r"(?P<start>\d{2}:\d{2}:\d{2})[,.]\d{3}\s+-->[^\n]*\n"
    r"(?P<text>.*?)(?=\n\s*\n|\Z)",
    re.DOTALL,
)
LANG_SUFFIX_RE = re.compile(r"\.([a-zA-Z-]+)\.srt$", re.IGNORECASE)


def slug(value: str) -> str:
    value = unicodedata.normalize("NFKD", value)
    value = "".join(ch for ch in value if not unicodedata.combining(ch))
    value = re.sub(r"[^a-zA-Z0-9]+", "-", value).strip("-").lower()
    return value


def stable_id(prefix: str, value: str) -> str:
    digest = hashlib.sha256(value.encode("utf-8")).hexdigest()[:24]
    return f"{prefix}-{digest}"


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def parse_lesson(path: Path):
    raw = path.read_text(encoding="utf-8-sig")
    first_heading = re.search(r"^#\s+(.+?)\s*$", raw, re.MULTILINE)
    title = first_heading.group(1).strip() if first_heading else path.stem
    drive_match = DRIVE_LINE_RE.search(raw)
    duration_match = DURATION_LINE_RE.search(raw)
    refs = [
        (m.group("path"), (m.group("label") or Path(m.group("path")).name).strip())
        for m in RESOURCE_RE.finditer(raw)
    ]
    body = raw
    if first_heading:
        body = body[: first_heading.start()] + body[first_heading.end():]
    body = VIDEO_SECTION_RE.sub("", body).strip()
    return {
        "title": title,
        "body": body,
        "attachment_refs": refs,
        "video_url": drive_match.group(1) if drive_match else None,
        "video_duration": duration_match.group(1) if duration_match else None,
    }


def transcript_text(path: Path) -> str:
    raw = path.read_text(encoding="utf-8-sig", errors="replace").replace("\r\n", "\n")
    cues: list[str] = []
    for match in SRT_BLOCK_RE.finditer(raw):
        text = " ".join(line.strip() for line in match.group("text").splitlines() if line.strip())
        text = re.sub(r"<[^>]+>", "", text).strip()
        if text and (not cues or cues[-1] != text):
            cues.append(text)
    paragraphs: list[str] = []
    current = ""
    for cue in cues:
        current = f"{current} {cue}".strip()
        if len(current) >= 500 and re.search(r"[.!?…][\"'»)]?$", current):
            paragraphs.append(current)
            current = ""
        elif len(current) >= 900:
            paragraphs.append(current)
            current = ""
    if current:
        paragraphs.append(current)
    return "\n\n".join(paragraphs)


def lesson_summary(title: str, body: str, transcripts: list[str], limit: int = 360) -> str:
    source = body.strip() or next((t.strip() for t in transcripts if t.strip()), "")
    source = re.sub(r"^#{1,6}\s*", "", source, flags=re.MULTILINE)
    source = re.sub(r"!?\[([^]]+)\]\([^)]+\)", r"\1", source)
    source = re.sub(r"[`*_>|~-]+", " ", source)
    source = re.sub(r"\s+", " ", source).strip()
    if not source:
        return f'Aprende los conceptos, herramientas y pasos practicos de "{title}".'
    return source[:limit].rstrip() + ("…" if len(source) > limit else "")


def resource_kind(path: Path) -> str:
    ext = path.suffix.lower()
    if ext in {".json", ".xlsx", ".docx", ".html", ".txt"}:
        return "template"
    if ext == ".pdf":
        return "document"
    if ext in {".png", ".jpg", ".jpeg", ".webp", ".gif"}:
        return "image"
    if ext in {".zip", ".rar", ".7z"}:
        return "archive"
    return "resource"


def find_transcripts(course_dir: Path, stem: str) -> list[tuple[str, Path]]:
    subtitle_dir = course_dir / "subtitles"
    if not subtitle_dir.is_dir():
        return []
    found: list[tuple[str, Path]] = []
    prefix = stem + "."
    for candidate in sorted(subtitle_dir.iterdir()):
        if not candidate.is_file() or candidate.suffix.lower() != ".srt":
            continue
        if candidate.name == f"{stem}.srt":
            found.append(("und", candidate))
        elif candidate.name.startswith(prefix):
            m = LANG_SUFFIX_RE.search(candidate.name)
            lang = m.group(1) if m else "und"
            found.append((lang, candidate))
    return found


COURSE_ID = "emprendego"
COURSE_TITLE = "Emprende Go"


def build_manifest(vault: Path, course_folder: str, module_id: str, module_title: str, module_sort_order: int) -> dict:
    """Un solo curso ('emprendego') agrupa TODAS las carpetas de Emprende Go como
    modulos -- son las distintas categorias/cursos del classroom de Skool, no
    cursos independientes en techforce learn (mismo patron que imperio-agentico:
    1 curso, N modulos)."""
    course_id = COURSE_ID
    course_dir = vault / "bruto" / course_folder
    if not course_dir.is_dir():
        raise RuntimeError(f"No existe la carpeta del curso: {course_dir}")

    md_files = sorted(course_dir.glob("*.md"), key=lambda p: p.name.casefold())
    if not md_files:
        raise RuntimeError(f"Sin archivos .md en {course_dir}")
    overview_path = next((p for p in md_files if re.match(r"^0*1[_.]", p.name)), md_files[0])
    overview = parse_lesson(overview_path)

    module = {
        "id": module_id,
        "course_id": course_id,
        "title": module_title,
        "emoji": "🎬",
        "sort_order": module_sort_order,
        "is_published": True,
        "overview_markdown": overview["body"],
    }

    lessons, contents, transcripts, resources = [], [], [], []
    upload_files: dict[str, Path] = {}
    lesson_order = 0

    for lesson_path in md_files:
        if lesson_path == overview_path:
            continue
        lesson_order += 1
        relative = lesson_path.relative_to(vault / "bruto").as_posix()
        lesson_id = stable_id("emprendego-lesson", relative)
        parsed = parse_lesson(lesson_path)
        lesson_transcripts = find_transcripts(course_dir, lesson_path.stem)

        transcript_bodies = []
        for t_order, (language, transcript) in enumerate(lesson_transcripts, start=1):
            transcript_hash = sha256_file(transcript)
            storage_path = f"transcripts/{transcript_hash[:20]}/{slug(transcript.stem)}.srt"
            body_text = transcript_text(transcript)
            transcript_bodies.append(body_text)
            upload_files[storage_path] = transcript
            transcripts.append(
                {
                    "id": stable_id("emprendego-transcript", f"{relative}|{language}"),
                    "lesson_id": lesson_id,
                    "language": language,
                    "transcript_text": body_text,
                    "storage_path": storage_path,
                    "sort_order": t_order,
                }
            )

        lessons.append(
            {
                "id": lesson_id,
                "course_id": course_id,
                "module_id": module_id,
                "source_path": relative,
                "title": parsed["title"],
                "summary": lesson_summary(parsed["title"], parsed["body"], transcript_bodies),
                "lesson_kind": "section"
                if not (parsed["body"] or parsed["video_url"] or lesson_transcripts or parsed["attachment_refs"])
                else "lesson",
                "sort_order": lesson_order,
                "video_url": parsed["video_url"],
                "video_provider": None,
                "video_duration": parsed["video_duration"],
                "video_thumbnail_url": None,
                "has_transcript": bool(lesson_transcripts),
                "is_published": True,
            }
        )
        contents.append({"lesson_id": lesson_id, "body_markdown": parsed["body"]})

        for r_order, (attachment_name, label) in enumerate(parsed["attachment_refs"], start=1):
            attachment = course_dir / "attachments" / attachment_name
            if not attachment.is_file():
                raise RuntimeError(f"Falta el adjunto: {attachment}")
            content_hash = sha256_file(attachment)
            safe_name = slug(attachment.stem) or "resource"
            storage_path = f"resources/{content_hash[:20]}/{safe_name}{attachment.suffix.lower()}"
            upload_files.setdefault(storage_path, attachment)
            resources.append(
                {
                    "id": stable_id("emprendego-resource", f"{relative}|{attachment_name}|{r_order}"),
                    "lesson_id": lesson_id,
                    "title": label,
                    "kind": resource_kind(attachment),
                    "mime_type": mimetypes.guess_type(attachment.name)[0] or "application/octet-stream",
                    "storage_path": storage_path,
                    "file_size": attachment.stat().st_size,
                    "sort_order": r_order,
                    "is_published": True,
                }
            )

    return {
        "module": module,
        "lessons": lessons,
        "contents": contents,
        "transcripts": transcripts,
        "resources": resources,
        "upload_files": upload_files,
    }


def sql_literal(value: object) -> str:
    payload = json.dumps(value, ensure_ascii=False, separators=(",", ":"))
    return "'" + payload.replace("'", "''").replace("\\u0000", "") + "'::jsonb"


def _column_sql_type(rows: list[dict], column: str) -> str:
    sample = next((row[column] for row in rows if row[column] is not None), None)
    if isinstance(sample, bool):
        return "boolean"
    if isinstance(sample, int):
        return "bigint"
    return "text"


def write_sql_batches(manifest: dict, output_dir: Path) -> list[Path]:
    output_dir.mkdir(parents=True, exist_ok=True)
    for old_file in output_dir.glob("*.sql"):
        old_file.unlink()
    files: list[Path] = []
    sequence = 1

    def write_single_row(table: str, row: dict, conflict_key: str):
        nonlocal sequence
        columns = list(row)
        updates = ", ".join(f"{c}=excluded.{c}" for c in columns if c != conflict_key)
        record_types = ", ".join(f"{c} {_column_sql_type([row], c)}" for c in columns)
        select_values = ", ".join(f"x.{c}" for c in columns)
        sql_file = output_dir / f"{sequence:04d}-{table}.sql"
        sql_file.write_text(
            f"insert into public.{table} ({', '.join(columns)}) "
            f"select {select_values} from jsonb_to_recordset({sql_literal([row])}) "
            f"as x({record_types}) on conflict ({conflict_key}) do update set {updates};\n",
            encoding="utf-8",
        )
        files.append(sql_file)
        sequence += 1

    write_single_row("course_modules", manifest["module"], "id")

    specs = [
        ("course_lessons", manifest["lessons"], "id", 100),
        ("course_lesson_contents", manifest["contents"], "lesson_id", 40),
        ("course_lesson_transcripts", manifest["transcripts"], "id", 8),
        ("course_lesson_resources", manifest["resources"], "id", 100),
    ]
    for table, rows, conflict_key, batch_size in specs:
        if not rows:
            continue
        columns = list(rows[0])
        column_sql = ", ".join(columns)
        updates = ", ".join(f"{c}=excluded.{c}" for c in columns if c != conflict_key)
        record_types = ", ".join(f"{c} {_column_sql_type(rows, c)}" for c in columns)
        for start in range(0, len(rows), batch_size):
            batch = rows[start : start + batch_size]
            select_values = ", ".join(f"x.{c}" for c in columns)
            sql_file = output_dir / f"{sequence:04d}-{table}.sql"
            sql_file.write_text(
                f"insert into public.{table} ({column_sql}) "
                f"select {select_values} from jsonb_to_recordset({sql_literal(batch)}) "
                f"as x({record_types}) on conflict ({conflict_key}) do update set {updates};\n",
                encoding="utf-8",
            )
            files.append(sql_file)
            sequence += 1
    return files


def run_cli(command: list[str], cwd: Path) -> None:
    print("+ " + " ".join(command))
    subprocess.run(command, cwd=cwd, check=True)


def upload_files_individually(upload_files: dict[str, Path], repo: Path) -> None:
    """Sube cada archivo con `cp` NO recursivo, un objeto a la vez.

    NUNCA uses `cp --recursive <dir-local> ss:///bucket/<mismo-nombre>`: si el
    prefijo remoto ya tiene objetos (de una corrida anterior, incluso de OTRO
    modulo que sube a la misma carpeta "transcripts/" o "resources/"), el CLI
    trata el destino como directorio existente y anida el folder de origen
    adentro (bucket/transcripts/transcripts/...) en vez de fusionar su
    contenido. Pasó la primera vez que se corrio este script para varios
    modulos seguidos -- se detecto y corrigio a mano (ver skill
    learn-force-cargar-cursos, seccion "Errores ya cometidos").
    """
    for index, (storage_path, source) in enumerate(sorted(upload_files.items()), start=1):
        run_cli(
            ["supabase", "storage", "cp", "--experimental", "--linked", str(source), f"ss:///{BUCKET}/{storage_path}"],
            repo,
        )
        if index % 10 == 0 or index == len(upload_files):
            print(f"Subido {index}/{len(upload_files)}")


def summary_manifest(manifest: dict, vault: Path, course_folder: str) -> dict:
    total_bytes = sum(p.stat().st_size for p in manifest["upload_files"].values())
    lessons = manifest["lessons"]
    return {
        "source": str(vault / "bruto" / course_folder),
        "module_id": manifest["module"]["id"],
        "module_title": manifest["module"]["title"],
        "lessons": len(lessons),
        "lessons_with_video": sum(1 for l in lessons if l["video_url"]),
        "lessons_with_transcript": sum(1 for l in lessons if l["has_transcript"]),
        "lessons_without_video_or_transcript": [
            l["title"] for l in lessons if not l["video_url"] and not l["has_transcript"]
        ],
        "transcript_rows": len(manifest["transcripts"]),
        "resource_rows": len(manifest["resources"]),
        "storage_objects": len(manifest["upload_files"]),
        "storage_bytes": total_bytes,
    }


def ensure_course_sql() -> str:
    row = {
        "id": COURSE_ID,
        "title": COURSE_TITLE,
        "subtitle": "Comunidad Skool",
        "description": "Cursos de emprendimiento, formalizacion y tributacion importados desde la comunidad Skool Emprende Go.",
        "emoji": "🎬",
        "sort_order": 0,
        "is_published": True,
    }
    columns = list(row)
    updates = ", ".join(f"{c}=excluded.{c}" for c in columns if c != "id")
    record_types = ", ".join(f"{c} {_column_sql_type([row], c)}" for c in columns)
    select_values = ", ".join(f"x.{c}" for c in columns)
    return (
        f"insert into public.courses ({', '.join(columns)}) "
        f"select {select_values} from jsonb_to_recordset({sql_literal([row])}) "
        f"as x({record_types}) on conflict (id) do update set {updates};\n"
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--vault", type=Path, default=Path(os.getenv("EMPRENDEGO_VAULT_PATH", "C:/obsidian/vault-emprende-go-skool")))
    parser.add_argument("--course-folder", required=True, help="Nombre de la carpeta bajo bruto/, ej. Como_Contratarme_en_Mi_Propia_Empresa")
    parser.add_argument("--module-id", required=True, help="id estable para la fila course_modules, ej. emprendego-como-contratarme")
    parser.add_argument("--module-title", required=True)
    parser.add_argument("--module-sort-order", type=int, default=1)
    parser.add_argument("--apply", action="store_true", help="Escribe filas y sube archivos a Supabase")
    parser.add_argument("--skip-files", action="store_true", help="No subir objetos de Storage")
    args = parser.parse_args()

    vault = args.vault.resolve()
    manifest = build_manifest(vault, args.course_folder, args.module_id, args.module_title, args.module_sort_order)
    summary = summary_manifest(manifest, vault, args.course_folder)

    repo = Path(__file__).resolve().parents[1]
    report_path = repo / "tmp" / f"emprendego-{args.module_id}-manifest.json"
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(summary, ensure_ascii=False, indent=2))

    if not args.apply:
        print(f"DRY RUN OK. Reporte: {report_path}")
        return 0

    sql_dir = repo / "tmp" / f"emprendego-{args.module_id}-sql"
    batch_files = write_sql_batches(manifest, sql_dir)
    course_sql_file = sql_dir / "0000-courses.sql"
    course_sql_file.write_text(ensure_course_sql(), encoding="utf-8")
    sql_files = [course_sql_file] + batch_files
    for index, sql_file in enumerate(sql_files, start=1):
        run_cli(["supabase", "db", "query", "--linked", "--file", str(sql_file)], repo)
        print(f"Aplicado {index}/{len(sql_files)}")

    if not args.skip_files and manifest["upload_files"]:
        upload_files_individually(manifest["upload_files"], repo)
    print("IMPORT COMPLETE")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
