cd fig
scala -nocompdaemon -cp PubSim.jar:Jama-1.0.2.jar:flanagan.jar:colt.jar:RngPack.jar sim.scala
scala -nocompdaemon -cp PubSim.jar:Jama-1.0.2.jar:flanagan.jar:colt.jar:RngPack.jar clts.scala
mpost -interaction=nonstopmode plot.mp
cd ..

pdflatex lsuwrapping.tex
pdflatex lsuwrapping.tex
bibtex lsuwrapping.tex
bibtex lsuwrapping.tex
pdflatex lsuwrapping.tex
