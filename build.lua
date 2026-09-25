module = "coop-writing"

sourcefiles = {"coop-writing.dtx", "coop-writing.ins"}
unpackfiles = {"coop-writing.ins"}
installfiles = {"coop-writing.sty"}

checkengines = {"pdftex", "luatex"}
stdengine = "pdftex"
checkruns = 2
testfiledir = "testfiles"
checksuppfiles = {"*.cwe"}

typesetfiles = {"coop-writing.dtx"}
typesetexe = "pdflatex"

textfiles = {
  "README.md",
  "README-pt-br.md",
  "changes.md",
  "new.md",
  "LICENSE",
  "COMPATIBILITY.md",
  "DEPENDENCIES.md",
  "ISSUE-TEST-MATRIX.md"
}
