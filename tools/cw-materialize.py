#!/usr/bin/env python3
"""Materialize semantic \\cwchange decisions into a clean UTF-8 TeX source.

The input is never overwritten. Decisions may come from IDs, authors, the
command's status key, or a default policy. --dry-run prints a unified diff.
"""
from __future__ import annotations
import argparse, difflib, re
from dataclasses import dataclass
from pathlib import Path

@dataclass
class Change:
    start: int
    end: int
    options: str
    old: str
    new: str
    id: str | None
    author: str | None
    status: str | None

def escaped(text: str, pos: int) -> bool:
    n = 0; pos -= 1
    while pos >= 0 and text[pos] == "\\":
        n += 1; pos -= 1
    return n % 2 == 1

def commented(text: str, pos: int) -> bool:
    line = text.rfind("\n", 0, pos) + 1
    i = line
    while i < pos:
        if text[i] == "%" and not escaped(text, i):
            return True
        i += 1
    return False

def balanced(text: str, pos: int, opener: str, closer: str):
    if pos >= len(text) or text[pos] != opener:
        raise ValueError(f"expected {opener!r} at offset {pos}")
    depth = 1; i = pos + 1
    while i < len(text):
        ch = text[i]
        if ch == "%" and not escaped(text, i):
            j = text.find("\n", i)
            i = len(text) if j < 0 else j + 1
            continue
        if ch == opener and not escaped(text, i): depth += 1
        elif ch == closer and not escaped(text, i):
            depth -= 1
            if depth == 0: return text[pos + 1:i], i + 1
        i += 1
    raise ValueError(f"unbalanced {opener}{closer} starting at offset {pos}")

def skip_space(text: str, pos: int) -> int:
    while pos < len(text) and text[pos].isspace(): pos += 1
    return pos

def key(options: str, name: str):
    m = re.search(r"(?:^|,)\s*" + re.escape(name) + r"\s*=\s*(?:\{([^{}]*)\}|([^,]+))", options)
    if not m: return None
    return (m.group(1) if m.group(1) is not None else m.group(2)).strip()

def changes(text: str):
    token = r"\cwchange"; pos = 0
    while True:
        start = text.find(token, pos)
        if start < 0: break
        pos = start + len(token)
        if escaped(text, start) or commented(text, start): continue
        p = skip_space(text, pos); options = ""
        if p < len(text) and text[p] == "[":
            options, p = balanced(text, p, "[", "]")
            p = skip_space(text, p)
        old, p = balanced(text, p, "{", "}")
        p = skip_space(text, p)
        new, end = balanced(text, p, "{", "}")
        yield Change(start, end, options, old, new, key(options,"id"), key(options,"author"), key(options,"status"))
        pos = end

def decide(ch: Change, args):
    if ch.id in args.accept: return "accept"
    if ch.id in args.reject: return "reject"
    if ch.author in args.accept_author: return "accept"
    if ch.author in args.reject_author: return "reject"
    if ch.status == "accepted": return "accept"
    if ch.status == "rejected": return "reject"
    return args.default

def materialize(text: str, args):
    out=[]; last=0; count={"accept":0,"reject":0,"keep":0}
    for ch in changes(text):
        action=decide(ch,args); count[action]+=1
        out.append(text[last:ch.start])
        out.append(ch.new if action=="accept" else ch.old if action=="reject" else text[ch.start:ch.end])
        last=ch.end
    out.append(text[last:])
    return "".join(out), count

def main() -> int:
    p=argparse.ArgumentParser()
    p.add_argument("input", type=Path)
    p.add_argument("-o","--output", type=Path)
    p.add_argument("--accept", action="append", default=[])
    p.add_argument("--reject", action="append", default=[])
    p.add_argument("--accept-author", action="append", default=[])
    p.add_argument("--reject-author", action="append", default=[])
    p.add_argument("--default", choices=["keep","accept","reject"], default="keep")
    p.add_argument("--dry-run", action="store_true")
    p.add_argument("--force", action="store_true")
    args=p.parse_args()
    src=args.input.read_text(encoding="utf-8")
    dst, count=materialize(src,args)
    if args.dry_run:
        print("".join(difflib.unified_diff(src.splitlines(True),dst.splitlines(True),
              fromfile=str(args.input),tofile=str(args.output or (str(args.input)+".materialized")))),end="")
    else:
        if args.output is None:
            p.error("--output is required unless --dry-run is used")
        if args.output.resolve()==args.input.resolve():
            p.error("refusing to overwrite the input file")
        if args.output.exists() and not args.force:
            p.error(f"{args.output} exists; use --force to replace it")
        args.output.write_text(dst,encoding="utf-8")
    print(f"cw-materialize: accepted={count['accept']} rejected={count['reject']} kept={count['keep']}", file=__import__("sys").stderr)
    return 0

if __name__=="__main__":
    raise SystemExit(main())
