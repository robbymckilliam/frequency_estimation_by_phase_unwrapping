cd fig
mpost plot.mp
cd ..

pdflatex lsuwrapping.tex
pdflatex lsuwrapping.tex
bibtex lsuwrapping.tex
bibtex lsuwrapping.tex
pdflatex lsuwrapping.tex
