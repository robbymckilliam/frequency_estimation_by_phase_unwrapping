cd code/data
mpost plot.mp
cd ../..

pdflatex lsuwrapping.tex
bibtex lsuwrapping.aux
pdflatex lsuwrapping.tex
pdflatex lsuwrapping.tex
