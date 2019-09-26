#!/usr/bin/octave-cli

N=20;

mu0=1;
sigma0=1;
p0=normrnd(mu0,sigma0,N,1);

mu1=2.5;
sigma1=0.7; % Note que en GDA sigma1=sigma0
p1=normrnd(mu1,sigma1,N,1);

function y=gaussian(x,mu,sigma)
  y=1/(sqrt(2*pi)*sigma)*exp(-((x-mu)/sigma).^2);
endfunction

x=-2:0.05:5;

g0=gaussian(x,mu0,sigma0);
g1=gaussian(x,mu1,sigma1);
pygivenx=g1*0.5./(g1*0.5 + g0*0.5);

hold off;
plot(x,pygivenx,'k','linewidth',1);
hold on;

plot(x,g0,'b');
plot(x,g1,'r');

plot(p0,zeros(1,N),'ob');
plot(p1,zeros(1,N),'xr');

xlabel('x');
grid on;
