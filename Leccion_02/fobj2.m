#!/usr/bin/octave-cli --persist

# --------------------------------------------------------------------
# Interactive mode, showing the contours and the corresponding line
#
# Implementation of J and gradJ for the particular 1D case
# --------------------------------------------------------------------

# Data stored each sample in a row, where the last row is the label
D=load("escazu.dat");

# Rescue for now just the area and price columns
A=[D(:,1) D(:,4)];

# Objective function of the parameters theta, requires also the data A
# First create a matrix without the square, where the j-column has
# theta_0 + theta_1*x_1^(j)-y^(j).  Then, square all elements of that matrix
# and finally add up all elements in each row
function res=J(theta,A)
  res=0.5*sum((theta(:,1)*ones(1,rows(A)) +
               theta(:,2)*A(:,1)' -
               ones(rows(theta),1)*A(:,2)').^2,2);
endfunction;

# Gradient of J.
# Analytical solution.
#
# Here assuming that theta has two components only
# For each theta pair (assumed in a row of the theta matrix) it will
# compute also a row with the gradient: the first column is the partial
# derivative w.r.t theta_0 and the second w.r.t theta_1
function res=gradJ(theta,A)
  # Compute the matrix as in J
  B=(theta(:,1)*ones(1,rows(A)) +
     theta(:,2)*A(:,1)' -
     ones(rows(theta),1)*A(:,2)');
  res=[sum(B,2),sum(B.*(ones(rows(theta),1)*A(:,1)'),2)];
endfunction;

# Gradient of J.
# Numerical solution.
#
# Here assuming that theta has two components only
# For each theta pair (assumed in a row of the theta matrix) it will
# compute also a row with the gradient: the first column is the partial
# derivative w.r.t theta_0 and the second w.r.t theta_1
function resn=gradJn(theta,A)
  # Centered derivatives
  delta=1e-2;
  dx=delta*600;
  dy=delta*2;

  Jtx=(J(theta+ones(rows(theta),1)*[dx,0],A)-J(theta-ones(rows(theta),1)*[dx,0],A))/(2*dx);
  Jty=(J(theta+ones(rows(theta),1)*[0,dy],A)-J(theta-ones(rows(theta),1)*[0,dy],A))/(2*dy);
  
  resn=[Jtx,Jty];
endfunction


th0=-300:10:600;
th1=-0.5:0.005:2;

#th0=-200:50:400;
#th1=0.0:0.5:2;


[tt0,tt1] = meshgrid(th0,th1);

theta=[tt0(:) tt1(:)];
jj=reshape(J(theta,A),size(tt0));

# plot the contours in 2D

figure(1);
hold off;

levels= 4.11e+4*(1.3.^[-3:1:20]);

#g=gradJ(theta,A);

#gjx=reshape(g(:,1),size(tt0));
#gjy=reshape(g(:,2),size(tt1));

%quiver(tt0,tt1,gjx,gjy,0.005);

figure(1);
hold off;

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
  g=gradJ(t,A);

  hold off;
  
  contour(tt0,tt1,jj,levels);
  xlabel("theta0");
  ylabel("theta1");

  hold on;
  printf("Error at J(%g,%g)=%g\n",x,y,J(t,A));

  printf("  Gradient(%g,%g)=[%g,%g]\n",x,y,g(1),g(2));
  fflush(stdout);

  plot([x],[y],"*r");

  figure(2);
  hold off;
  plot(A(:,1),A(:,2),"*b");
  hold on;
  xx=80:100:620;
  yy=x+y*xx;
  plot(xx,yy,'k',"linewidth",3);

  axis([80,620,180,820]);
  
endwhile;

for i=[1:50]
  g = gradJ(t,A)/absg;
  t = t - alpha * g;
  plot([t(1)],[t(2)],"ob");
endfor


