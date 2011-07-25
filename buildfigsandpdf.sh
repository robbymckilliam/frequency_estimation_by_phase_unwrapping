cd fig
mpost -interaction=nonstopmode plot.mp
cd ..

pdflatex lsuwrapping.tex
pdflatex lsuwrapping.tex
bibtex lsuwrapping.tex
pdflatex lsuwrapping.tex
bibtex lsuwrapping.tex
pdflatex lsuwrapping.tex
