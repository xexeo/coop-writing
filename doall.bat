pdflatex coop-writing.ins
pdflatex coop-writing.dtx
makeindex -s gglo.ist -o coop-writing.gls coop-writing.glo
makeindex -s gind.ist -o coop-writing.ind coop-writing.idx
pdflatex coop-writing.dtx

