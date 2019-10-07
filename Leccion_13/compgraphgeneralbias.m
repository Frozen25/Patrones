#!/usr/bin/octave-cli

1;

## Capas:
l1a=fullyconnected();
l1b=sigmoide();
l2a=fullyconnected();
l2b=sigmoide();

## Forward prop

x=[ 3 4]';

neuronas1 = 4;
clases = 2;

W1 = rand(neuronas1,rows(x)+1);
W2 = rand(clases,neuronas1+1);


y1a=l1a.forward(W1,x);
y1b=l1b.forward(y1a);
y2a=l2a.forward(W2,y1b);
y2b=l2b.forward(y2a);

salida=ones(clases,1);

## Backprop.

l2b.backward(salida); # asumiendo que esto es el final
l2a.backward(l2b.gradient);
l1b.backward(l2a.gradientX);
l1a.backward(l1b.gradient);

l1a.gradientW
l1a.gradientX
