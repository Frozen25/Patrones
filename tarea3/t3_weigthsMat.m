#!/usr/bin/octave-cli --persist

# --------------------------------------------------------------------
# Interactive mode, showing the contours and the corresponding line
#
# WITH NORMALIZATION AND DATA CENTERING
#
# Implementation of J and gradJ for the general linear case
# --------------------------------------------------------------------

pkg load optim;


load quasar_train.csv;
lambdas = quasar_train(1, :)';
train_qso = quasar_train(2:end, :);
load quasar_test.csv;
test_qso = quasar_test(2:end, :);


# Data stored each sample in a row, where the last row is the label


# Construct the design matrix with the original data
Xo=[ones(rows(lambdas),1),lambdas];

# The outputs vector with the original data
Yo=test_qso(1,:)';

# The slope for the data normalization
minArea = min(Xo(:,2));
maxArea = max(Xo(:,2));
mx = 2/(maxArea-minArea);
bx = 1-mx*maxArea;

NM=[1 bx; 0 mx];
X=Xo*NM; # Normalized data to interval -1 to 1

# Normalize also the output
minPrice=min(Yo);
maxPrice=max(Yo);
my = 2/(maxPrice-minPrice);
by = 1-my*maxPrice;

Y = my*Yo + by;

# For the inverse mapping we need these:
imy = 1/my;
iby = -by/my;

tau = 5;

function res = fw(current,X,tau)
	Norm = norm(X-X(current,:));
	res = exp(-1.*Norm*Norm./(2*tau*tau));
endfunction;


function res = thetas(X,W,y)
  In = inv(X' * W * X );
  res = In * X' * W * y;
endfunction

ts = [];



gW = zeros(rows(X),rows(X));
for(i=[1:rows(X)])
  for(j=[1:rows(X)])
    Norm = norm(X(j,:)-X(i,:));
    gW(j,j) = exp(-1.*Norm*Norm./(2*tau*tau))
  endfor
  tc = thetas(X,gW,Y);
  ts = [ts tc];
  #if(i==1)
  #  newX = [1140:Xo(i,2)];
  #else
  #  newX = [Xo(i-1,2):X(i,2)];
  #endif
  
endfor


function res=J(theta,X,Y)
  D=(X*theta'-Y*ones(1,rows(theta)));
  res=0.5*sum(D.*D,1)';
endfunction;

function res=gradJ(theta,X,Y)
  res=(X'*(X*theta'-Y*ones(1,rows(theta))))';
endfunction;

# Select the grid to plot the contours and gradients
th0=-1:0.05:1;
th1=-0.5:0.05:2;
[tt0,tt1] = meshgrid(th0,th1);

theta=[tt0(:) tt1(:)];
jj=reshape(J(theta,X,Y),size(tt0));

# Precompute the gradient for the chosen grid
g=gradJ(theta,X,Y);
gjx=reshape(g(:,1),size(tt0));
gjy=reshape(g(:,2),size(tt1));

## show the surface
figure(3);
hold off;
surf(tt0,tt1,jj);
xlabel("theta_0");
ylabel("theta_1");

# plot the contours in 2D
figure(1);
hold off;

contour(tt0,tt1,jj);
xlabel("theta_0");
ylabel("theta_1");

# Learning rate
alpha = 0.005;


while(1)
  hold on;
 
  printf("Click on countours to set a starting point\n");
  fflush(stdout);

  figure(1);

  # Wait for mouse click and get the point (t0,t1) in the plot coordinate sys.
  [t0,t1,buttons] = ginput(1);
  t=[t0,t1];
  gt=gradJ(t,X,Y);

  # Clean the previous plot 
  hold off;

  # Paint first the contour lines
  contour(tt0,tt1,jj);
  hold on;

  # Add the gradient
  quiver(tt0,tt1,gjx,gjy,0.7);

  xlabel("theta0");
  ylabel("theta1");
 
  # Print some information on the clicked starting point
  printf("J(%g,%g)=%g\n",t0,t1,J(t,X,Y));
  printf("  GradJ(%g,%g)=[%g,%g]\n",t0,t1,gt(1),gt(2));
  fflush(stdout);

  # Show the clicked point
  plot([t0],[t1],"*r");

  # Draw the trajectory
  plot(ts(:,1),ts(:,2),"k-");
  plot(ts(:,1),ts(:,2),"ob");

  # Paint on a second figure the corresponding line
  figure(2);
  hold off;
  plot(Xo(:,2),Yo,"*b");
  hold on;
  
  # The line back in the samples
  areas=linspace(min(Xo(:,2)),max(Xo(:,2)),5);

  # We have to de-normalize the normalized estimation
  prices=t1*imy*mx*areas + (imy*t1*bx + imy*t0+iby);
  plot(areas,prices,'k',"linewidth",3);

  # and now with the intermediate versions
  for (i=[2:rows(ts)])
    u0=ts(i,1);
    u1=ts(i,2);
    
    prices=u1*imy*mx*areas + (imy*u1*bx + imy*u0+iby);
    plot(areas,prices,'g',"linewidth",1);
  endfor;
  plot(areas,prices,'r',"linewidth",4);

	ts(rows(ts),:);
  
  axis([minArea maxArea minPrice maxPrice]);  
endwhile;
