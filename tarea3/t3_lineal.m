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

function res = thetas(X,y)
  In = inv(X' * X );
  res = In * X' * y;
endfunction

hold on;
# Paint on a second figure the corresponding line
figure(1);
hold off;
plot(Xo(:,2),Yo,"*b");
hold on;

# The line back in the samples
areas=linspace(min(Xo(:,2)),max(Xo(:,2)),5);

ts = thetas(X,Y);
u0=ts(1,1);
u1=ts(2,1);
printf("Theta = (%g,%g)\n",u0,u1);

prices=u1*imy*mx*areas + (imy*u1*bx + imy*u0+iby);

plot(areas,prices,'r',"linewidth",4);

axis([minArea maxArea minPrice maxPrice]);  
