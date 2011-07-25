prologues := 2;
input graph;
input sarith;

picture ORIGINAL_PICTURE;
ORIGINAL_PICTURE := currentpicture;

picture dd; dd :=
dashpattern(on 4bp off 2bp on 1bp off 2bp);

picture diamond;
draw unitsquare shifted(-0.5,-0.5) scaled 0.17cm rotated 45;
diamond := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture square;
draw unitsquare shifted(-0.5,-0.5) scaled 0.17cm;
square := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture circle; 
draw fullcircle scaled 0.17cm;
circle := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture cross; 
draw (-0.09cm,0.0)--(0.09cm,0.0);
draw (0,-0.09cm)--(0,0.09cm);
cross := currentpicture; currentpicture := ORIGINAL_PICTURE;

picture times; times := cross rotated 45;

picture legend;
sx = 0.2cm;
sh = 0.2cm;
ups = 0.35cm;

label.rt(btex Asymptotic variance etex, (1cm,sh));
draw (sx,sh)--(1cm,sh) dashed dd;

label.rt(btex CRB etex, (1cm,sh + ups));
draw (sx,sh + ups)--(1cm,sh + ups) dashed evenly;

label.rt(btex Quinn-Fernandes etex, (1cm,sh + 2*ups));
draw (sx,sh + 2*ups)--(1cm,sh + 2*ups) withcolor(0.6,0.6,0.6);
draw square shifted 1/2[(sx,sh + 2*ups),(1cm,sh + 2*ups)];

label.rt(btex Periodogram etex, (1cm,sh + 3*ups));
draw (sx,sh + 3*ups)--(1cm,sh + 3*ups) withcolor(0.6,0.6,0.6);
draw circle shifted 1/2[(sx,sh + 3*ups),(1cm,sh + 3*ups)];

label.rt(btex LSPUE etex, (1cm,sh + 4*ups));
draw (sx,sh + 4*ups)--(1cm,sh + 4*ups) withcolor(0.6,0.6,0.6);
draw cross shifted 1/2[(sx,sh + 4*ups),(1cm,sh + 4*ups)];

label.rt(btex PSCFD etex, (1cm,sh + 5*ups));
draw (sx,sh + 5*ups)--(1cm,sh + 5*ups) withcolor(0.6,0.6,0.6);
draw diamond shifted 1/2[(sx,sh + 5*ups),(1cm,sh + 5*ups)];

label.rt(btex Kays etex, (1cm,sh + 6*ups));
draw (sx,sh + 6*ups)--(1cm,sh + 6*ups) withcolor(0.6,0.6,0.6);
%draw times shifted 1/2[(sx,sh + 6*ups),(1cm,sh + 6*ups)];

legend := currentpicture; currentpicture := ORIGINAL_PICTURE;


beginfig(1);
draw begingraph(10cm, 9cm);
 setcoords(linear,log);
 glabel.bot(btex SNR (dB) etex, OUT);
 glabel.lft(btex MSE etex, OUT) rotated 90 shifted(-0.3cm, 1.0cm);

gdraw "simulator.fes.PeriodogramFFTEstimator16"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PeriodogramFFTEstimator16"  plot(circle);
gdraw "simulator.fes.QuinnFernades16"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.QuinnFernades16"  plot(square);
gdraw "simulator.fes.KaysEstimator16"  withcolor(0.6,0.6,0.6);
%gdraw "simulator.fes.KaysEstimator16"  plot(times);
gdraw "simulator.fes.SamplingLatticeEstimator16"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.SamplingLatticeEstimator16"  plot(cross);
gdraw "simulator.fes.PSCFDEstimator16"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PSCFDEstimator16"  plot(diamond);
gdraw "crb16.txt"  dashed evenly;
gdraw "asymp16.txt"  dashed dd;
endgraph;

draw(legend);

endfig;

beginfig(2);
draw begingraph(10cm, 9cm);
 setcoords(linear,log);
 glabel.bot(btex SNR (dB) etex, OUT);
 glabel.lft(btex MSE etex, OUT) rotated 90 shifted(-0.3cm, 1.0cm);

gdraw "simulator.fes.PeriodogramFFTEstimator64"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PeriodogramFFTEstimator64"  plot(circle);
gdraw "simulator.fes.QuinnFernades64"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.QuinnFernades64"  plot(square);
gdraw "simulator.fes.KaysEstimator64"  withcolor(0.6,0.6,0.6);
%gdraw "simulator.fes.KaysEstimator64"  plot(times);
gdraw "simulator.fes.SamplingLatticeEstimator64"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.SamplingLatticeEstimator64"  plot(cross);
gdraw "simulator.fes.PSCFDEstimator64"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PSCFDEstimator64"  plot(diamond);
gdraw "crb64.txt"  dashed evenly;
gdraw "asymp64.txt"  dashed dd;
endgraph;

draw(legend);

endfig;

beginfig(3);
draw begingraph(10cm, 9cm);
 setcoords(linear,log);
 glabel.bot(btex SNR (dB) etex, OUT);
 glabel.lft(btex MSE etex, OUT) rotated 90 shifted(-0.3cm, 1.0cm);

gdraw "simulator.fes.PeriodogramFFTEstimator256"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PeriodogramFFTEstimator256"  plot(circle);
gdraw "simulator.fes.QuinnFernades256"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.QuinnFernades256"  plot(square);
gdraw "simulator.fes.KaysEstimator256"  withcolor(0.6,0.6,0.6);
%gdraw "simulator.fes.KaysEstimator256"  plot(times);
gdraw "simulator.fes.SamplingLatticeEstimator256"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.SamplingLatticeEstimator256"  plot(cross);
gdraw "simulator.fes.PSCFDEstimator256"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PSCFDEstimator256"  plot(diamond);
gdraw "crb256.txt"  dashed evenly;
gdraw "asymp256.txt"  dashed dd;
endgraph;

draw(legend);

endfig;

beginfig(4);
draw begingraph(10cm, 9cm);
 setcoords(linear,log);
 glabel.bot(btex SNR (dB) etex, OUT);
 glabel.lft(btex MSE etex, OUT) rotated 90 shifted(-0.3cm, 1.0cm);

gdraw "simulator.fes.PeriodogramFFTEstimator512"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PeriodogramFFTEstimator512"  plot(circle);
gdraw "simulator.fes.QuinnFernades512"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.QuinnFernades512"  plot(square);
gdraw "simulator.fes.KaysEstimator512"  withcolor(0.6,0.6,0.6);
%gdraw "simulator.fes.KaysEstimator512"  plot(times);
gdraw "simulator.fes.SamplingLatticeEstimator512"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.SamplingLatticeEstimator512"  plot(cross);
gdraw "simulator.fes.PSCFDEstimator512"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PSCFDEstimator512"  plot(diamond);
gdraw "crb512.txt"  dashed evenly;
gdraw "asymp512.txt"  dashed dd;
endgraph;

draw(legend);

endfig;

beginfig(5);
draw begingraph(10cm, 9cm);
 setcoords(linear,log);
 glabel.bot(btex SNR (dB) etex, OUT);
 glabel.lft(btex MSE etex, OUT) rotated 90 shifted(-0.3cm, 1.0cm);

gdraw "simulator.fes.PeriodogramFFTEstimator1024"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PeriodogramFFTEstimator1024"  plot(circle);
gdraw "simulator.fes.QuinnFernades1024"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.QuinnFernades1024"  plot(square);
gdraw "simulator.fes.KaysEstimator1024"  withcolor(0.6,0.6,0.6);
%gdraw "simulator.fes.KaysEstimator1024"  plot(times);
gdraw "simulator.fes.SamplingLatticeEstimator1024"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.SamplingLatticeEstimator1024"  plot(cross);
gdraw "simulator.fes.PSCFDEstimator1024"  withcolor(0.6,0.6,0.6);
gdraw "simulator.fes.PSCFDEstimator1024"  plot(diamond);
gdraw "crb1024.txt"  dashed evenly;
gdraw "asymp1024.txt"  dashed dd;
endgraph;

draw(legend);

endfig;



end;
