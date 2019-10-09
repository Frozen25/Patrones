# MNIST classification using Support Vector algorithm with RBF kernel
# Author: Krzysztof Sopyla <krzysztofsopyla@gmail.com>
# https://ksopyla.com
# License: MIT

# Standard scientific Python imports
import matplotlib.pyplot as plt
import numpy as np
import time
import datetime as dt
# split data to train and test
from sklearn.model_selection import train_test_split
# Import datasets, classifiers and performance metrics
from sklearn import datasets, svm, metrics
# fetch original mnist dataset
from sklearn.datasets import fetch_openml
# serializer import/export
import joblib

# import custom module
from helpers.mnist_helpers import *


# it creates mldata folder in your root project folder
mnist = fetch_openml('mnist_784')

# minist object contains: data, COL_NAMES, DESCR, target fields
# you can check it by running
mnist.keys()

# data field is 70k x 784 array, each row represents pixels from 28x28=784 image
images = mnist.data
targets = mnist.target

# Let's have a look at the random 16 images,
# We have to reshape each data row, from flat array of 784 int to 28x28 2D array

# pick  random indexes from 0 to size of our dataset
show_some_digits(images, targets)


# ---------------- classification begins -----------------
# scale data for [0,255] -> [0,1]
# sample smaller size for testing
#rand_idx = np.random.choice(images.shape[0],10000)
#X_data =images[rand_idx]/255.0
#Y      = targets[rand_idx]

# full dataset classification
X_data = images/255.0
Y = targets

# split data to train and test
X_train, X_test, y_train, y_test = train_test_split(
    X_data, Y, test_size=0.15, random_state=42)


################ Classifier with good params ###########
# Create a classifier: a support vector classifier
param_kernel = input(
    "Enter a kernel type (default=‘rbf’, ‘linear’, ‘poly’, ‘sigmoid’): ")
if not param_kernel:
    param_kernel = 'rbf'
print('Chosen:', param_kernel)

try:
    param_degree = int(input("Enter the degree parameter (default=3): "))
except ValueError:
    param_degree = 3
print('Chosen:', param_degree)

try:
    param_C = int(input("Enter the penalty parameter (default=5): "))
except ValueError:
    param_C = 5
print('Chosen:', param_C)

try:
    param_gamma = float(input("Enter the gamma parameter (default=0.05): "))
except ValueError:
    param_gamma = 0.05
print('Chosen:', param_gamma)

try:
    param_tolerance = float(
        input("Enter the tolerance parameter (default=1e-3): "))
except ValueError:
    param_tolerance = 1e-3
print('Chosen:', param_tolerance)

try:
    param_max_iter = int(
        input("Enter the max iteration parameter (default=-1): "))
except ValueError:
    param_max_iter = -1
print('Chosen:', param_max_iter)

classifier = svm.SVC(kernel=param_kernel, C=param_C, gamma=param_gamma,
                     degree=param_degree, tol=param_tolerance, max_iter=param_max_iter)

# We learn the digits on train part
start_time = dt.datetime.now()
print('Start learning at {}'.format(str(start_time)))
classifier.fit(X_train, y_train)
end_time = dt.datetime.now()
print('Stop learning {}'.format(str(end_time)))
elapsed_time = end_time - start_time
print('Elapsed learning {}'.format(str(elapsed_time)))

# save the model to disk
filename = 'svm'
filename += '_' + param_kernel
filename += '_' + str(param_degree)
filename += '_' + str(param_C)
filename += '_' + str(param_gamma)
filename += '_' + str(param_tolerance)
filename += '_' + str(param_max_iter)
filename += '.sav'
joblib.dump(classifier, filename)
print('File save:', filename)

########################################################
# Now predict the value of the test
expected = y_test
predicted = classifier.predict(X_test)

show_some_digits(X_test, predicted, title_text="Predicted {}")

print("Classification report for classifier %s:\n%s\n"
      % (classifier, metrics.classification_report(expected, predicted)))

cm = metrics.confusion_matrix(expected, predicted)
print("Confusion matrix:\n%s" % cm)

plot_confusion_matrix(cm)
 
print("Accuracy={}".format(metrics.accuracy_score(expected, predicted)))
