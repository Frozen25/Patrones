#!/usr/bin/octave-cli --persist

# --------------------------------------------------------------------
# Interactive mode, showing the contours and the corresponding line
#
# WITH NORMALIZATION AND DATA CENTERING
#
# Implementation of J and gradJ for the general linear case
# --------------------------------------------------------------------

pkg load optim;

# Data stored each sample in a row, where the last row is the label
D=load("escazu32.dat");

# Construct the design matrix with the original data
Xo=[ones(rows(D),1),D(:,1)];

# The outputs vector with the original data
Yo=D(:,4);

# The slope for the data normalization
minArea = min(Xo(:,2));
maxArea = max(Xo(:,2));
mx = 2/(maxArea-minArea);
bx = 1-mx*maxArea;

NM=[1 bx; 0 mx];
X=Xo*NM; # Normalized data to interval -1 to 1
X=[X X(:,2).^2];

# Normalize also the output
minPrice=min(Yo);
maxPrice=max(Yo);
my = 2/(maxPrice-minPrice);
by = 1-my*maxPrice;

Y = my*Yo + by;

# For the inverse mapping we need these:
imy = 1/my;
iby = -by/my;

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
function resn=gradJn(theta,X,Y)
  # Centered derivatives
  delta=1e-2;
  dx=delta*600;
  dy=delta*2;

  Jtx=(J(theta+ones(rows(theta),1)*[dx,0],X,Y)-J(theta-ones(rows(theta),1)*[dx,0],X,Y))/(2*dx);
  Jty=(J(theta+ones(rows(theta),1)*[0,dy],X,Y)-J(theta-ones(rows(theta),1)*[0,dy],X,Y))/(2*dy);
  
  resn=[Jtx,Jty];
endfunction


# Select the grid to plot the contours and gradients
th0=-0.5:0.05:2;
th1=-0.5:0.05:2;
th2=-0.5:0.05:2;


theta=[th0(:) th1(:) th2(:)];


# Precompute the gradient for the chosen grid
g=gradJ(theta,X,Y);

# Learning rate
alpha = 0.01;




printf("Insert the starting point x, y, z\n");
fflush(stdout);

figure(1);
xlabel("theta0");
ylabel("theta1");
zlabel("theta2");
hold on;
# Wait for mouse click and get the point (t0,t1) in the plot coordinate sys.
#[t0,t1] = ginput(1);
#t0 = -1;
#t1 = -0.2;
#t2 = -0.3;
t0 = input("x = ")
t1 = input("y = ")
t2 = input("z = ")


t=[t0,t1,t2];
gt=gradJ(t,X,Y);
    
# Print some information on the clicked starting point
printf("J(%g,%g)=%g\n",t0,t1,J(t,X,Y));
printf("  GradJ(%g,%g)=[%g,%g]\n",t0,t1,gt(1),gt(2));
fflush(stdout);

# Perform the gradient descent
ts=t; # sequence of t's
errorJ = zeros(1, 2);

#Saves the X and Y values for the future calculations of errorJ
errorX = X;
errorY = Y;

j=0;
for i=[1:500] # max 100 iterations
  tc = ts(rows(ts),:); # Current position
  sample=round(unifrnd(1,rows(X))); # Use one random sample
  gn = gradJ(tc,X(sample,:),Y(sample));  # Gradient at current position
  tn = tc - alpha * gn;# Next position
  ts = [ts;tn];
  
  errorJ = [errorJ;i J(tc,X,Y)];

  if (norm(tc-tn)<0.005)
    j=j+1;
    if (j>5)
      break;
    endif;
  else
    j=0;
  endif;
endfor


# Draw the trajectory
plot3(ts(:,1),ts(:,2),ts(:,3),"k-");
plot3(ts(:,1),ts(:,2),ts(:,3),"ob");

# Paint on a second figure the corresponding line
figure(2);

hold on;

plot(Xo(:,2),Yo,"*b");
xlabel("areas");
ylabel("precios");

areas=100:600;
areanorm = mx*areas+bx;

x=[ones(length(areanorm),1) areanorm' areanorm'.^2];
Y = x*t';

precios = imy*Y+iby;

plot(areas,precios,'k',"linewidth",3);


# and now with the intermediate versions
for (i=[2:rows(ts)])  
  Y = x*ts(i,:)';
  precios = imy*Y+iby;
  plot(areas,precios,'r',"linewidth",1);
endfor;
plot(areas,precios,'g',"linewidth",3);

############ Error for multiples alphas
function errorJ=alphaError(alpha,t,X,Y)
  ts=t; # sequence of t's
  errorJ = zeros(1, 2);

  j=0;
  for i=[1:500] # max 100 iterations
    tc = ts(rows(ts),:); # Current position
    sample=round(unifrnd(1,rows(X))); # Use one random sample
    gn = gradJ(tc,X(sample,:),Y(sample));  # Gradient at current position
    tn = tc - alpha * gn;# Next position
    ts = [ts;tn];
    
    errorJ = [errorJ;i J(tc,X,Y)];

    if (norm(tc-tn)<0.005)
      j=j+1;
      if (j>5)
        break;
      endif;
    else
      j=0;
    endif;
  endfor
  
endfunction

# Paint on a second figure the corresponding line
figure(3);
hold on;
xlabel("iterations");
ylabel("error");

#alpha=0.02
plot(errorJ(2:rows(errorJ),1),errorJ(2:rows(errorJ),2),'k;alpha=0.02;',"linewidth",3);
#alpha=0.001
errorJ=alphaError(0.001,t,errorX,errorY);
plot(errorJ(2:rows(errorJ),1),errorJ(2:rows(errorJ),2),'r;alpha=0.001;',"linewidth",3);
#alpha=0.005
errorJ=alphaError(0.005,t,errorX,errorY);
plot(errorJ(2:rows(errorJ),1),errorJ(2:rows(errorJ),2),'g;alpha=0.005;',"linewidth",3);
#alpha=0.01
errorJ=alphaError(0.01,t,errorX,errorY);
plot(errorJ(2:rows(errorJ),1),errorJ(2:rows(errorJ),2),'b;alpha=0.01;',"linewidth",3);
#alpha=0.045
errorJ=alphaError(0.045,t,errorX,errorY);
plot(errorJ(2:rows(errorJ),1),errorJ(2:rows(errorJ),2),'m;alpha=0.045;',"linewidth",3);