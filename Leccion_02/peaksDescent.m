#!/usr/bin/octave

clear ; close all ; clc;
pkg load optim;

figure(1);
# We will be using the octave peaks function (lots of local extrema)
peaks;
hold on

figure(2);
[xx,yy,zz]=peaks();
contour(xx,yy,zz);
hold on

# Set here a learning rate
learningRate = 0.05

f = @(x) [3*(1-x(1))^2*exp(-x(1)^2 - (x(2)+1)^2) - 10*(x(1)/5 - x(1)^3 - x(2)^5)*exp(-x(1)^2-x(2)^2) - 1/3*exp(-(x(1)+1)^2 - x(2)^2)];

while(1)

  printf("Click on countours to set a starting point\n");
  fflush(stdout);

  figure(2);
  
  [x_init,y_init,buttons] = ginput(1);
  youAreHere = [x_init y_init];
  plotoffset=0.3;
  z = f(youAreHere) + plotoffset;

  plot([x_init],[y_init],"*r");

  printf("Init at (%g,%g)=%g\n",x_init,y_init,z-plotoffset);
  fflush(stdout);

  i = 0;

  figure 1
  while (i <= 20)
    figure(1);
    plot3(youAreHere(1),youAreHere(2),z,"r+","linewidth",5,"markersize",5);
    
    GradientsJacobian = jacobs(youAreHere, f);

    GradientsJacobian;
    
    newYou(1) = youAreHere(1) - ( learningRate * GradientsJacobian(1));
    newYou(2) = youAreHere(2) - ( learningRate * GradientsJacobian(2));
    newz = f(newYou) + plotoffset;

    plot3([youAreHere(1) newYou(1)],
          [youAreHere(2) newYou(2)],
          [z newz],"k-","linewidth",5);

    figure(2);
    plot([youAreHere(1) newYou(1)],[youAreHere(2) newYou(2)],"k-");
    plot([newYou(1)],[newYou(2)],"or");

    eps=norm(newYou-youAreHere);
    if (eps<0.01) break; endif
    
    youAreHere = newYou;
    z=newz;

    fflush(stdout);
    b = waitforbuttonpress ();
    i=i+1;
  endwhile;
endwhile;
