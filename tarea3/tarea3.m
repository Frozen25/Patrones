#!/usr/bin/octave-cli --persist

# --------------------------------------------------------------------
# Interactive mode, showing the contours and the corresponding line
#
# WITH NORMALIZATION AND data CENTERING
#
# Implementation of J and gradientJ for the general linear case
# --------------------------------------------------------------------

pkg load optim;

# data stored each sample in a row, where the last row is the label

load quasar_train.csv;
lambdas = quasar_train(1, :)';
train_qso = quasar_train(2:end, :);
load quasar_test.csv;
test_qso = quasar_test(2:end, :);



data=[lambdas train_qso(1,:)'];

# Construct the design matrix with the original data
data_X=[ones(rows(data),1),data(:,1)];

# The outputs vector with the original data
data_Y=data(:,2);

# The slope for the data normalization
min_X = min(data_X(:,2));
max_X = max(data_X(:,2));
mx = 2/(max_X-min_X);
bx = 1-mx*max_X;

NM=[1 bx; 0 mx];
x_normalized = data_X*NM; # Normalized data to interval -1 to 1

# Normalize also the output
min_Y=min(data_Y);
max_Y=max(data_Y);
my = 2/(max_Y-min_Y);
by = 1-my*max_Y;

y_normalized = my*data_Y + by;

###############################################
function result = thetas(X,W,y)
  In = inv(X' * W * X );
  result = In * X' * W * y;
endfunction


###############################################

# For the inverse mapping we need these:
imy = 1/my;
iby = -by/my;

#Local regression calc
tau = 5;

theta = [];

for (i=[1:rows(data)])                                    %Obtains the regression for each point
  w = exp(-((data_X(i,2)-data_X(:,2)).^2)./(2*tau*tau));      %Calculates the weight of all the points
  w_diag = diag(w);
  theta_i = thetas(x_normalized, w_diag, y_normalized);
  theta = [theta theta_i];
endfor;
# Local regression plot
figure(1);
hold off;                                                 %Necessary to adjust the graph
plot(data_X(:,2),data_Y,"*b");                                    %Plots the raw points
hold on;                                                %Necessary to show all the elements

areas=linspace(min(data_X(:,2)),max(data_X(:,2)),5);

ts = theta(rows(theta),:);
u0=ts(1,1);
u1=ts(1,2);
printf("Theta = (%g,%g)\n",u0,u1);

prices=u1*imy*mx*areas + (imy*u1*bx + imy*u0+iby);


waitfor(gcf);                                             %Wait for the image to close to finish the execution
#endwhile;
