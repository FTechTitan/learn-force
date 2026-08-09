#!/usr/bin/env python3
"""Merge agent-reviewed lesson descriptions into one idempotent SQL migration."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


GENERIC_PATTERNS = (
    "aprende los conceptos, herramientas y pasos",
    "descripción pendiente",
    "actividad práctica del módulo",
)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("output", type=Path)
    parser.add_argument("inputs", nargs="+", type=Path)
    parser.add_argument("--expected", type=int, default=777)
    args = parser.parse_args()

    summaries: dict[str, str] = {}
    for path in args.inputs:
        rows = json.loads(path.read_text(encoding="utf-8-sig"))
        if not isinstance(rows, dict):
            raise ValueError(f"{path} must contain an object")
        overlap = set(summaries).intersection(rows)
        if overlap:
            raise ValueError(f"Duplicate lesson ids in {path}: {sorted(overlap)[:3]}")
        summaries.update({str(key): re.sub(r"\s+", " ", str(value)).strip() for key, value in rows.items()})

    if len(summaries) != args.expected:
        raise ValueError(f"Expected {args.expected} summaries, got {len(summaries)}")
    for lesson_id, summary in summaries.items():
        if not re.fullmatch(r"imperio-lesson-[0-9a-f]{24}", lesson_id):
            raise ValueError(f"Invalid lesson id: {lesson_id}")
        if not 35 <= len(summary) <= 280:
            raise ValueError(f"Invalid summary length ({len(summary)}) for {lesson_id}")
        if any(pattern in summary.casefold() for pattern in GENERIC_PATTERNS):
            raise ValueError(f"Generic summary for {lesson_id}: {summary}")

    payload = json.dumps(
        [{"id": lesson_id, "summary": summary} for lesson_id, summary in sorted(summaries.items())],
        ensure_ascii=False,
        separators=(",", ":"),
    ).replace("'", "''")
    sql = f"""-- Descripciones editoriales generadas tras analizar Markdown y transcripciones reales.
with reviewed as (
  select * from jsonb_to_recordset('{payload}'::jsonb) as x(id text, summary text)
)
update public.course_lessons lesson
set summary = reviewed.summary,
    updated_at = now()
from reviewed
where lesson.id = reviewed.id
  and lesson.course_id = 'imperio-agentico';

do $$
declare actual integer;
begin
  select count(*) into actual
  from public.course_lessons
  where course_id = 'imperio-agentico'
    and lesson_kind = 'lesson'
    and summary <> '';
  if actual <> {args.expected} then
    raise exception 'Expected {args.expected} reviewed summaries, found %', actual;
  end if;
end $$;
"""
    args.output.write_text(sql, encoding="utf-8", newline="\n")
    print(json.dumps({"output": str(args.output), "summaries": len(summaries)}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
