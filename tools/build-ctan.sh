#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PACKAGE="coop-writing"
VERSION="$(sed -n 's/^%<package>\\def\\cw@version{v\([^}]*\)}.*/\1/p' coop-writing.dtx | head -n 1)"

if [[ -z "$VERSION" ]]; then
  echo "Could not determine package version from coop-writing.dtx" >&2
  exit 1
fi

OUTROOT="$ROOT/ctan-submission"
OUT="$OUTROOT/$PACKAGE"
ZIP="$OUTROOT/$PACKAGE-$VERSION.zip"

required=(
  README.md
  changes.md
  new.md
  LICENSE
  coop-writing.dtx
  coop-writing.ins
  coop-writing.bib
  coop-writing.pdf
  quickref-en-us.tex
  quickref-en-us.pdf
  quickref-pt-br.tex
  quickref-pt-br.pdf
  max-example-en-us.tex
  max-example-en-us.pdf
  max-exemplo-pt-br.tex
  max-exemplo-pt-br.pdf
  images/overleaffileurl.png
  images/editorialnotes.png
  example-fragments/editing-include.tex
  example-fragments/editing-input.tex
  example-fragments/submit-include.tex
  example-fragments/submit-input.tex
  example-fragments/publish-include.tex
  example-fragments/publish-input.tex
)

for f in "${required[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "Missing required CTAN source/artifact: $f" >&2
    exit 1
  fi
done

rm -rf "$OUT" "$OUTROOT"/"$PACKAGE"-*.zip
mkdir -p "$OUT/images" "$OUT/example-fragments"

cp README.md changes.md new.md LICENSE coop-writing.dtx coop-writing.ins coop-writing.bib coop-writing.pdf "$OUT/"
cp quickref-en-us.tex quickref-en-us.pdf quickref-pt-br.tex quickref-pt-br.pdf "$OUT/"
cp max-example-en-us.tex max-example-en-us.pdf max-exemplo-pt-br.tex max-exemplo-pt-br.pdf "$OUT/"
cp images/overleaffileurl.png images/editorialnotes.png "$OUT/images/"
cp example-fragments/*.tex "$OUT/example-fragments/"

# CTAN asks submitters not to include straightforward generated package files
# when the .dtx/.ins pair is present. coop-writing.sty is therefore excluded.
if find "$OUT" -type f \( -name '*.aux' -o -name '*.log' -o -name '*.bcf' -o -name '*.blg' -o -name '*.run.xml' -o -name '*.idx' -o -name '*.ind' -o -name '*.ilg' -o -name '*.toc' -o -name '*.out' -o -name '*.fls' -o -name '*.fdb_latexmk' -o -name '*.sty' \) | grep -q .; then
  echo "Unexpected generated/build files found in CTAN directory:" >&2
  find "$OUT" -type f \( -name '*.aux' -o -name '*.log' -o -name '*.bcf' -o -name '*.blg' -o -name '*.run.xml' -o -name '*.idx' -o -name '*.ind' -o -name '*.ilg' -o -name '*.toc' -o -name '*.out' -o -name '*.fls' -o -name '*.fdb_latexmk' -o -name '*.sty' \) >&2
  exit 1
fi

(
  cd "$OUTROOT"
  zip -q -r "$PACKAGE-$VERSION.zip" "$PACKAGE"
)

# Archive structure and mandatory CTAN files.
unzip -Z1 "$ZIP" | grep -qx "$PACKAGE/README.md"
unzip -Z1 "$ZIP" | grep -qx "$PACKAGE/coop-writing.pdf"
unzip -Z1 "$ZIP" | grep -qx "$PACKAGE/coop-writing.dtx"
unzip -Z1 "$ZIP" | grep -qx "$PACKAGE/coop-writing.ins"

if unzip -Z1 "$ZIP" | grep -Eq '\.(aux|log|bcf|blg|run\.xml|idx|ind|ilg|toc|out|fls|fdb_latexmk|sty)$'; then
  echo "Archive contains forbidden generated/build files." >&2
  exit 1
fi

echo "Prepared $ZIP"
unzip -l "$ZIP"
