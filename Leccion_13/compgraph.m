#!/usr/bin/octave-cli

1;

## Capas:
l1a=fullyconnected();
l1b=sigmoide();
l2a=fullyconnected();
l2b=sigmoide();

## Forward prop

x=[1 2 3 4]';
W1=[0.1 0.3 -0.1 0;-0.2 0.5 0.2 0.1; 1 0 0.1 -0.3; 0.5 0.6 0.8 -0.9];
W2=[0.1 -0.1 0.2 0.3;-0.4 -0.5 0.1 0.2];

y1a=l1a.forward(W1,x);
y1b=l1b.forward(y1a);
y2a=l2a.forward(W2,y1b);
y2b=l2b.forward(y2a);

## Backprop.

l2b.backward([1 1]'); # asumiendo que esto es el final
l2a.backward(l2b.gradient);
l1b.backward(l2a.gradientX);
l1a.backward(l1b.gradient);

l1a.gradientW
l1a.gradientX
