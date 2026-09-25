#!/usr/bin/env python3
"""Convert coop-writing TSV metadata export to UTF-8 JSON."""
from __future__ import annotations
import argparse, csv, json
from pathlib import Path

def read_metadata(path: Path):
    with path.open("r", encoding="utf-8", newline="") as f:
        lines = [line for line in f if not line.startswith("#")]
    if not lines:
        return []
    return list(csv.DictReader(lines, delimiter="\t"))

def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("input", type=Path)
    p.add_argument("-o", "--output", type=Path)
    p.add_argument("--indent", type=int, default=2)
    args = p.parse_args()
    data = read_metadata(args.input)
    payload = json.dumps(data, ensure_ascii=False, indent=args.indent) + "\n"
    if args.output:
        args.output.write_text(payload, encoding="utf-8")
    else:
        print(payload, end="")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
