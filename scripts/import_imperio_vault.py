#!/usr/bin/env python3
"""Audit and import the local Imperio Agentico Obsidian vault.

Dry-run is the default. Applying uses the authenticated Supabase CLI and the
linked project. Vault content is never written to tracked repository paths.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import mimetypes
import os
import re
import shutil
import subprocess
import sys
import unicodedata
from collections import defaultdict
from pathlib import Path


COURSE_ID = "imperio-agentico"
BUCKET = "imperio-agentico-content"
EXPECTED = {
    "modules": 30,
    "markdown": 932,
    "lessons": 902,
    "content_lessons": 777,
    "sections": 125,
    "videos": 420,
    "transcripts": 441,
    "attachments": 134,
    "attachment_references": 140,
}

RESOURCE_RE = re.compile(
    r"\[\[attachments/(?P<path>[^\]|]+)(?:\|(?P<label>[^\]]+))?\]\]"
)
VIDEO_SECTION_RE = re.compile(
    r"\n##\s+[^\n]*Video\s*\n.*?(?=\n##\s+|\Z)", re.IGNORECASE | re.DOTALL
)
RESOURCE_SECTION_RE = re.compile(
    r"\n##\s+Recursos\s*\n.*?(?=\n##\s+|\Z)", re.IGNORECASE | re.DOTALL
)
SRT_BLOCK_RE = re.compile(
    r"(?:^|\n)\d+\s*\n"
    r"(?P<start>\d{2}:\d{2}:\d{2})[,.]\d{3}\s+-->[^\n]*\n"
    r"(?P<text>.*?)(?=\n\s*\n|\Z)",
    re.DOTALL,
)


def slug(value: str) -> str:
    value = value.replace("Æ", "AE").replace("æ", "ae")
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


def title_and_body(path: Path) -> tuple[str, str, list[tuple[str, str]]]:
    raw = path.read_text(encoding="utf-8-sig")
    first_heading = re.search(r"^#\s+(.+?)\s*$", raw, re.MULTILINE)
    title = first_heading.group(1).strip() if first_heading else path.stem
    refs = [
        (match.group("path"), (match.group("label") or Path(match.group("path")).name).strip())
        for match in RESOURCE_RE.finditer(raw)
    ]
    body = raw
    if first_heading:
        body = body[: first_heading.start()] + body[first_heading.end() :]
    body = VIDEO_SECTION_RE.sub("", body)
    body = RESOURCE_SECTION_RE.sub("", body)
    return title, body.strip(), refs


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
    """Build a compact catalog description without loading full lesson content in the UI."""
    source = body.strip() or next((text.strip() for text in transcripts if text.strip()), "")
    source = re.sub(r"^#{1,6}\s*", "", source, flags=re.MULTILINE)
    source = re.sub(r"!?\[([^]]+)\]\([^)]+\)", r"\1", source)
    source = re.sub(r"[`*_>|~-]+", " ", source)
    source = re.sub(r"\s+", " ", source).strip()
    if not source:
        return f'Aprende los conceptos, herramientas y pasos prácticos de “{title}”.'
    return source[:limit].rstrip() + ("…" if len(source) > limit else "")


def resource_kind(path: Path) -> str:
    ext = path.suffix.lower()
    if ext in {".json", ".xlsx", ".docx", ".html", ".txt"}:
        return "template"
    if ext in {".pdf"}:
        return "document"
    if ext in {".png", ".jpg", ".jpeg", ".webp", ".gif"}:
        return "image"
    if ext in {".zip", ".rar", ".7z"}:
        return "archive"
    return "resource"


def find_transcripts(module_dir: Path, stem: str) -> list[tuple[str, Path]]:
    subtitle_dir = module_dir / "subtitles"
    found = []
    for language, suffix in (("es", ".es.srt"), ("en", ".en.srt"), ("en-orig", ".en-orig.srt"), ("und", ".srt")):
        candidate = subtitle_dir / f"{stem}{suffix}"
        if candidate.exists():
            found.append((language, candidate))
    return found


def load_videos(vault: Path) -> dict[str, dict]:
    rows = json.loads((vault / "bruto" / "videos.json").read_text(encoding="utf-8-sig"))
    return {row["file"].replace("\\", "/"): row for row in rows}


def build_manifest(vault: Path) -> dict:
    bruto = vault / "bruto"
    videos = load_videos(vault)
    modules = []
    lessons = []
    contents = []
    transcripts = []
    resources = []
    upload_files: dict[str, Path] = {}
    source_counts = defaultdict(int)
    seen_paths: set[str] = set()

    module_dirs = sorted(path for path in bruto.iterdir() if path.is_dir())
    for module_order, module_dir in enumerate(module_dirs, start=1):
        module_id = f"imperio-{slug(module_dir.name)}"
        markdown_files = sorted(module_dir.glob("*.md"), key=lambda path: path.name.casefold())
        overview = next((path for path in markdown_files if path.name.startswith("01_")), None)
        if overview is None:
            raise RuntimeError(f"Missing 01_ overview in {module_dir.name}")
        overview_title, overview_body, _ = title_and_body(overview)
        modules.append(
            {
                "id": module_id,
                "folder": module_dir.name,
                "title": overview_title,
                "overview_markdown": overview_body,
                "sort_order": module_order,
            }
        )

        lesson_order = 0
        for lesson_path in markdown_files:
            source_counts["markdown"] += 1
            if lesson_path == overview:
                continue
            lesson_order += 1
            relative = lesson_path.relative_to(bruto).as_posix()
            if relative in seen_paths:
                raise RuntimeError(f"Duplicate source path: {relative}")
            seen_paths.add(relative)
            lesson_id = stable_id("imperio-lesson", relative)
            title, body, attachment_refs = title_and_body(lesson_path)
            video = videos.get(relative)
            lesson_transcripts = find_transcripts(module_dir, lesson_path.stem)
            transcript_bodies = []
            for transcript_order, (language, transcript) in enumerate(lesson_transcripts, start=1):
                transcript_hash = sha256_file(transcript)
                transcript_path = f"transcripts/{transcript_hash[:20]}/{slug(transcript.stem)}.srt"
                transcript_body = transcript_text(transcript)
                transcript_bodies.append(transcript_body)
                upload_files[transcript_path] = transcript
                transcripts.append(
                    {
                        "id": stable_id("imperio-transcript", f"{relative}|{language}"),
                        "lesson_id": lesson_id,
                        "language": language,
                        "transcript_text": transcript_body,
                        "storage_path": transcript_path,
                        "sort_order": transcript_order,
                    }
                )
                source_counts["transcripts"] += 1

            lessons.append(
                {
                    "id": lesson_id,
                    "course_id": COURSE_ID,
                    "module_id": module_id,
                    "source_path": relative,
                    "title": title,
                    "summary": lesson_summary(title, body, transcript_bodies),
                    "lesson_kind": "section" if not (body or video or lesson_transcripts or attachment_refs) else "lesson",
                    "sort_order": lesson_order,
                    "video_url": video.get("url") if video else None,
                    "video_provider": video.get("provider") if video else None,
                    "video_duration": video.get("duration") if video else None,
                    "video_thumbnail_url": video.get("thumbnail") if video else None,
                    "has_transcript": bool(lesson_transcripts),
                    "is_published": True,
                }
            )
            contents.append(
                {
                    "lesson_id": lesson_id,
                    "body_markdown": body,
                }
            )

            for resource_order, (attachment_name, label) in enumerate(attachment_refs, start=1):
                attachment = module_dir / "attachments" / attachment_name
                if not attachment.is_file():
                    raise RuntimeError(f"Missing attachment: {attachment}")
                content_hash = sha256_file(attachment)
                safe_name = slug(attachment.stem) or "resource"
                storage_path = f"resources/{content_hash[:20]}/{safe_name}{attachment.suffix.lower()}"
                upload_files.setdefault(storage_path, attachment)
                resources.append(
                    {
                        "id": stable_id("imperio-resource", f"{relative}|{attachment_name}|{resource_order}"),
                        "lesson_id": lesson_id,
                        "title": label,
                        "kind": resource_kind(attachment),
                        "mime_type": mimetypes.guess_type(attachment.name)[0] or "application/octet-stream",
                        "storage_path": storage_path,
                        "file_size": attachment.stat().st_size,
                        "sort_order": resource_order,
                        "is_published": True,
                    }
                )
                source_counts["attachment_references"] += 1

    source_counts["modules"] = len(module_dirs)
    source_counts["lessons"] = len(lessons)
    source_counts["sections"] = sum(row["lesson_kind"] == "section" for row in lessons)
    source_counts["content_lessons"] = sum(row["lesson_kind"] == "lesson" for row in lessons)
    source_counts["videos"] = len(videos)
    source_counts["attachments"] = len(
        [path for path in bruto.rglob("*") if path.is_file() and path.parent.name == "attachments"]
    )

    video_paths_without_lessons = sorted(set(videos) - seen_paths)
    if video_paths_without_lessons:
        raise RuntimeError(f"Video rows without lessons: {video_paths_without_lessons[:5]}")
    for key, expected in EXPECTED.items():
        actual = source_counts[key]
        if actual != expected:
            raise RuntimeError(f"Coverage mismatch for {key}: expected {expected}, got {actual}")

    return {
        "modules": modules,
        "lessons": lessons,
        "contents": contents,
        "transcripts": transcripts,
        "resources": resources,
        "upload_files": upload_files,
        "counts": dict(source_counts),
    }


def sql_literal(value: object) -> str:
    payload = json.dumps(value, ensure_ascii=False, separators=(",", ":"))
    return "'" + payload.replace("'", "''").replace("\\u0000", "") + "'::jsonb"


def write_sql_batches(manifest: dict, output_dir: Path) -> list[Path]:
    output_dir.mkdir(parents=True, exist_ok=True)
    for old_file in output_dir.glob("*.sql"):
        old_file.unlink()
    files: list[Path] = []

    module_rows = [
        {
            "id": row["id"],
            "course_id": COURSE_ID,
            "title": row["title"],
            "emoji": "🎬",
            "sort_order": 1000 + row["sort_order"],
            "is_published": True,
            "overview_markdown": row["overview_markdown"],
        }
        for row in manifest["modules"]
    ]
    module_file = output_dir / "000-modules.sql"
    module_file.write_text(
        "insert into public.course_modules "
        "(id, course_id, title, emoji, sort_order, is_published, overview_markdown) "
        "select x.id, x.course_id, x.title, x.emoji, x.sort_order::integer, "
        "x.is_published::boolean, x.overview_markdown "
        f"from jsonb_to_recordset({sql_literal(module_rows)}) as x("
        "id text, course_id text, title text, emoji text, sort_order text, "
        "is_published text, overview_markdown text) "
        "on conflict (id) do update set overview_markdown = excluded.overview_markdown;\n",
        encoding="utf-8",
    )
    files.append(module_file)

    specs = [
        ("course_lessons", manifest["lessons"], "id", 100),
        ("course_lesson_contents", manifest["contents"], "lesson_id", 40),
        ("course_lesson_transcripts", manifest["transcripts"], "id", 8),
        ("course_lesson_resources", manifest["resources"], "id", 100),
    ]
    sequence = 1
    for table, rows, conflict_key, batch_size in specs:
        columns = list(rows[0])
        column_sql = ", ".join(columns)
        updates = ", ".join(
            f"{column}=excluded.{column}" for column in columns if column != conflict_key
        )
        record_types = ", ".join(f"{column} text" for column in columns)
        for start in range(0, len(rows), batch_size):
            batch = rows[start : start + batch_size]
            select_values = ", ".join(
                f"x.{column}::{('boolean' if isinstance(batch[0][column], bool) else 'bigint' if isinstance(batch[0][column], int) else 'text')}"
                for column in columns
            )
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


def stage_storage(upload_files: dict[str, Path], staging_dir: Path) -> None:
    if staging_dir.exists():
        shutil.rmtree(staging_dir)
    for storage_path, source in upload_files.items():
        destination = staging_dir / Path(storage_path)
        destination.parent.mkdir(parents=True, exist_ok=True)
        try:
            os.link(source, destination)
        except OSError:
            shutil.copy2(source, destination)


def summary_manifest(manifest: dict, vault: Path) -> dict:
    total_bytes = sum(path.stat().st_size for path in manifest["upload_files"].values())
    return {
        "source": str(vault),
        "course_id": COURSE_ID,
        "counts": manifest["counts"],
        "content_rows": len(manifest["contents"]),
        "transcript_rows": len(manifest["transcripts"]),
        "resource_relations": len(manifest["resources"]),
        "storage_objects": len(manifest["upload_files"]),
        "storage_bytes": total_bytes,
        "modules": [
            {
                "id": module["id"],
                "folder": module["folder"],
                "lessons": sum(1 for lesson in manifest["lessons"] if lesson["module_id"] == module["id"]),
            }
            for module in manifest["modules"]
        ],
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--vault", type=Path, default=Path(os.getenv("IMPERIO_AGENTICO_VAULT_PATH", "C:/obsidian/vault-imperio-agentico-skool")))
    parser.add_argument("--apply", action="store_true", help="Write rows and files to Supabase")
    parser.add_argument("--skip-files", action="store_true", help="Do not upload Storage objects")
    parser.add_argument("--details-only", action="store_true", help="Apply only transcript/resource rows, then files")
    args = parser.parse_args()

    vault = args.vault.resolve()
    if not (vault / "bruto" / "00_ÍNDICE.md").is_file():
        raise RuntimeError(f"Not an Imperio vault: {vault}")

    manifest = build_manifest(vault)
    summary = summary_manifest(manifest, vault)
    report_path = Path(__file__).resolve().parents[1] / "tmp" / "imperio-import-manifest.json"
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(summary, ensure_ascii=False, indent=2))

    if not args.apply:
        print(f"DRY RUN OK. Report: {report_path}")
        return 0

    repo = Path(__file__).resolve().parents[1]
    sql_files = write_sql_batches(manifest, repo / "tmp" / "imperio-sql")
    if args.details_only:
        sql_files = [
            path for path in sql_files
            if "course_lesson_transcripts" in path.name or "course_lesson_resources" in path.name
        ]
    for index, sql_file in enumerate(sql_files, start=1):
        run_cli(["supabase", "db", "query", "--linked", "--file", str(sql_file)], repo)
        if index % 25 == 0 or index == len(sql_files):
            print(f"Applied {index}/{len(sql_files)} SQL batches")

    if not args.skip_files:
        staging_dir = repo / "tmp" / "imperio-storage"
        stage_storage(manifest["upload_files"], staging_dir)
        for folder in ("transcripts", "resources"):
            run_cli(
                ["supabase", "storage", "cp", "--experimental", "--linked", "--recursive", "--jobs", "4", f"tmp/imperio-storage/{folder}", f"ss:///{BUCKET}/{folder}"],
                repo,
            )
    print("IMPORT COMPLETE")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
