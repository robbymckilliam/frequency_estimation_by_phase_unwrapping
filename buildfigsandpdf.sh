cd fig
mpost -interaction=nonstopmode plot.mp
cd ..

pdflatex lsuwrapping.tex
bibtex lsuwrapping
pdflatex lsuwrapping.tex
pdflatex lsuwrapping.tex
