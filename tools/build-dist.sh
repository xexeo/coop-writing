#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

for f in README.md coop-writing.dtx coop-writing.ins coop-writing.sty coop-writing.pdf; do
  [[ -f "$f" ]] || { echo "Missing generated distribution input: $f" >&2; exit 1; }
done

rm -rf dist
mkdir -p dist
cp README.md coop-writing.dtx coop-writing.ins coop-writing.sty coop-writing.pdf dist/

# The distributed style must be exactly the style generated from the canonical
# documented source in this workflow.
cmp -s coop-writing.sty dist/coop-writing.sty
grep -Fq '\def\cw@version{v1.8}' dist/coop-writing.sty

echo "Prepared dist/ from canonical dtx/ins outputs."
