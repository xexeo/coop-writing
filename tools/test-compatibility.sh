#!/usr/bin/env bash
set -euo pipefail

ENGINE="${1:-pdflatex}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

case "$ENGINE" in
  pdflatex) LATEXMK=(-pdf) ;;
  lualatex) LATEXMK=(-lualatex) ;;
  *) echo "Unsupported engine: $ENGINE" >&2; exit 2 ;;
esac

OUT="$ROOT/build/compatibility/$ENGINE"
rm -rf "$OUT"
mkdir -p "$OUT"

compile_tex() {
  local name="$1" class="$2" texinputs="${3:-}" extra="${4:-}"
  local dir="$OUT/$name"
  mkdir -p "$dir"
  if [[ "$class" == "beamer" ]]; then
    cat > "$dir/test.tex" <<EOF
\\documentclass$extra{$class}
\\usepackage[mode=editing,bookmarks=false]{coop-writing}
\\begin{document}
\\begin{frame}{UTF-8: Xexéo -- revisão}
\\cwsetup{layout=inline,warnings=false}
\\cwnamedef{alice}{teal}{Alice}
\\alice[id=c1,layout=inline]{Comment with café and revisão.}
\\aliceswap[id=ch1,status=accepted]{old}{new}
\\todo{short todo}
\\cwanon{Geraldo Xexéo}
\\end{frame}
\\end{document}
EOF
  else
    cat > "$dir/test.tex" <<EOF
\\documentclass$extra{$class}
\\usepackage[mode=editing,bookmarks=false]{coop-writing}
\\begin{document}
\\cwsetup{layout=inline,warnings=false}
\\section{\\cwheadingcomment{UTF-8: Xexéo -- revisão}{heading comment}}
\\cwnamedef{alice}{teal}{Alice}
\\alice[id=c1,layout=inline]{Comment with café and revisão.}
\\alice[id=c2,layout=inline]{Second comment.}
\\aliceswap[id=ch1,status=accepted]{old}{new}
\\todo{short todo}
\\todo[inline]{inline todo}
\\begin{cwdraft}Draft body.\\end{cwdraft}
\\cwanon{Geraldo Xexéo}
\\cwplaceholder[id=p1,subtype=figure]{Missing figure}
\\begin{thebibliography}{1}
\\bibitem{x} X. Example reference.
\\end{thebibliography}
\\end{document}
EOF
  fi
  (
    cd "$dir"
    TEXINPUTS="$ROOT:${texinputs}:" latexmk "${LATEXMK[@]}" -interaction=nonstopmode -halt-on-error -file-line-error test.tex
  )
  echo "PASS $name ($ENGINE)"
}

test_installed_class() {
  local name="$1" class="$2" extra="${3:-}"
  if kpsewhich "$class.cls" >/dev/null 2>&1; then
    compile_tex "$name" "$class" "" "$extra"
  else
    echo "SKIP $name: $class.cls not installed"
  fi
}

# Level B: tested when the current TeX Live image contains the class.
test_installed_class ieee IEEEtran
test_installed_class acm acmart
test_installed_class elsevier elsarticle
test_installed_class elsevier-cas cas-sc
test_installed_class springer-lncs llncs
test_installed_class springer-nature sn-jnl
test_installed_class mdpi mdpi
test_installed_class revtex revtex4-2
test_installed_class beamer beamer
test_installed_class iosart iosart2x

# Historical SBC template retained in tests/BugSBC.  If extraction exposed a
# style/class, compile with its directory in TEXINPUTS; otherwise the hyperref
# non-autoload regression test covers the original bibliography conflict.
if find "$ROOT/vendor/sbc" -type f \( -name 'sbc-template.sty' -o -name 'sbc-template.cls' \) -print -quit 2>/dev/null | grep -q .; then
  sbcdir="$(dirname "$(find "$ROOT/vendor/sbc" -type f \( -name 'sbc-template.sty' -o -name 'sbc-template.cls' \) -print -quit)")"
  if [[ -f "$sbcdir/sbc-template.cls" ]]; then
    compile_tex sbc sbc-template "$sbcdir//"
  else
    dir="$OUT/sbc"; mkdir -p "$dir"
    cat > "$dir/test.tex" <<'EOF'
\documentclass{article}
\usepackage{sbc-template}
\usepackage[mode=editing,bookmarks=false]{coop-writing}
\begin{document}
\cwsetup{layout=inline,warnings=false}
UTF-8: Xexéo. \cwitem[id=sbc-1]{SBC comment.}
\begin{thebibliography}{1}\bibitem{x} X.\end{thebibliography}
\end{document}
EOF
    (cd "$dir"; TEXINPUTS="$ROOT:$sbcdir//:" latexmk "${LATEXMK[@]}" -interaction=nonstopmode -halt-on-error -file-line-error test.tex)
    echo "PASS sbc ($ENGINE)"
  fi
else
  echo "SKIP sbc full template: no extracted style/class found; root cause covered by hyperref regression"
fi

# Level C: canonical institutional classes fetched by the workflow.
[[ -d "$ROOT/vendor/coppetex-v5/src" ]] && compile_tex coppe-v5 coppe "$ROOT/vendor/coppetex-v5/src//"
[[ -d "$ROOT/vendor/ufrj/src" ]] && compile_tex ufrj ufrj "$ROOT/vendor/ufrj/src//"
[[ -d "$ROOT/vendor/coppetex-v5/src" && -f "$ROOT/vendor/coppetex-v5/src/poli.cls" ]] && compile_tex poli-v5 poli "$ROOT/vendor/coppetex-v5/src//" "[grad]"
[[ -d "$ROOT/vendor/politex/src" ]] && compile_tex politex-current coppe "$ROOT/vendor/politex/src//"

echo "Compatibility matrix completed for $ENGINE"
