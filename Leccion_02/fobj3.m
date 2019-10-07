#!/usr/bin/octave-cli --persist

# --------------------------------------------------------------------
# Interactive mode, showing the contours and the corresponding line
#
# Implementation of J and gradJ for the general linear case
# --------------------------------------------------------------------


pkg load optim;

# Data stored each sample in a row, where the last row is the label
D=load("escazu.dat");

# Construct the design matrix
X=[ones(rows(D),1),D(:,1)];

# The outputs vector
Y=D(:,4);

# Objective function of the parameters theta, requires also the data A
# First create a matrix without the square, where the j-column has
# theta_0 + theta_1*x_1^(j)-y^(j).  Then, square all elements of that matrix
# and finally add up all elements in each row
function res=J(theta,X,Y)
  D=(X*theta'-Y*ones(1,rows(theta)));
  res=0.5*sum(D.*D,1)';
endfunction;

# Gradient of J.
# Analytical solution.
#
# Here assuming that theta has two components only
# For each theta pair (assumed in a row of the theta matrix) it will
# compute also a row with the gradient: the first column is the partial
# derivative w.r.t theta_0 and the second w.r.t theta_1
function res=gradJ(theta,X,Y)
  res=(X'*(X*theta'-Y*ones(1,rows(theta))))';
endfunction;

# Gradient of J.
# Numerical solution.
#
# Here assuming that theta has two components only
# For each theta pair (assumed in a row of the theta matrix) it will
# compute also a row with the gradient: the first column is the partial
# derivative w.r.t theta_0 and the second w.r.t theta_1
function resn=gradJn(theta,X,Y)
  # Centered derivatives
  delta=1e-2;
  dx=delta*600;
  dy=delta*2;

  Jtx=(J(theta+ones(rows(theta),1)*[dx,0],X,Y)-J(theta-ones(rows(theta),1)*[dx,0],X,Y))/(2*dx);
  Jty=(J(theta+ones(rows(theta),1)*[0,dy],X,Y)-J(theta-ones(rows(theta),1)*[0,dy],X,Y))/(2*dy);
  
  resn=[Jtx,Jty];
endfunction


th0=-300:10:600;
th1=-0.5:0.005:2;

#th0=-200:50:400;
#th1=0.0:0.5:2;

[tt0,tt1] = meshgrid(th0,th1);

theta=[tt0(:) tt1(:)];
jj=reshape(J(theta,X,Y),size(tt0));

# plot the contours in 2D

figure(1);
hold off;

levels= 4.11e+4*(1.3.^[-3:1:20]);

contour(tt0,tt1,jj,levels);
xlabel("theta0");
ylabel("theta1");

while(1)
  hold on;
 
  printf("Click on countours to set a starting point\n");
  fflush(stdout);

  figure(1);
  [x,y,buttons] = ginput(1);
  t=[x,y];
  g=gradJ(t,X,Y);

  hold off;
  
  contour(tt0,tt1,jj,levels);
  xlabel("theta0");
  ylabel("theta1");

  hold on;
  printf("Error at J(%g,%g)=%g\n",x,y,J(t,X,Y));

  printf("  Gradient(%g,%g)=[%g,%g]\n",x,y,g(1),g(2));
  fflush(stdout);

  plot([x],[y],"*r");

  figure(2);
  hold off;
  plot(X(:,2),Y,"*b");
  hold on;
  xx=80:100:620;
  yy=x+y*xx;
  plot(xx,yy,'k',"linewidth",3);

  axis([80,620,180,820]);  
endwhile;

alpha=0.0000001;
hold on;


t=[200,1];
for i=[1:50]
  g = gradJ(t,X,Y);
  t = t - alpha * g;
  plot([t(1)],[t(2)],"ob");
endfor


g=gradJ(theta,X,Y);

gjx=reshape(g(:,1),size(tt0));
gjy=reshape(g(:,2),size(tt1));

%quiver(tt0,tt1,gjx,gjy,0.005);
