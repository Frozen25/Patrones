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
from .mnist_helpers import *

# Let's have a look at the random 16 images,
# We have to reshape each data row, from flat array of 784 int to 28x28 2D array

# ---------------- classification begins -----------------


def create_dataset(test_percentage, seed):
    '''Function that gets the dataset from mnist and divides the set between train and test.

    Parameters
    ----------

    test_percentage: test_size percentage to divide from all the data.

    seed: seed used to generate a random division.

    Returns
    ----------

    X_train: dataset to train the SVM.

    X_test: datatset to test the SVM.

    Y_train: dataset of the results to train the SVM.

    Y_test: dataset of the test result to test.
    '''

    # it creates mldata folder in your root project folder
    mnist = fetch_openml('mnist_784')

    # minist object contains: data, COL_NAMES, DESCR, target fields
    # you can check it by running
    mnist.keys()

    # data field is 70k x 784 array, each row represents pixels from 28x28=784 image
    images = mnist.data
    targets = mnist.target

    # pick random indexes from 0 to size of our dataset
    # // show_some_digits(images, targets)

    # full dataset classification
    X_data = images/255.0  # scale data for [0,255] -> [0,1]
    Y = targets

    # split data to train and test
    X_train, X_test, Y_train, Y_test = train_test_split(
        X_data, Y, test_size=test_percentage, random_state=seed)

    return X_train, X_test, Y_train, Y_test


################ Classifier with good params ###########
def custom_svm(X_train, Y_train):
    '''Function that starts input request to create a custom SVM.

    Parameters
    ----------

    X_train: dataset used for training the SVM

    Y_traing: labels of the dataset used for training the SVM
    '''

    # Create a classifier: a support vector classifier
    param_kernel = input(
        "Enter a kernel type (default=‘rbf’, ‘linear’, ‘poly’, ‘sigmoid’): ")
    if not param_kernel:
        param_kernel = 'rbf'

    try:
        param_degree = int(input("Enter the degree parameter (default=3): "))
    except ValueError:
        param_degree = 3

    try:
        param_C = int(input("Enter the penalty parameter (default=5): "))
    except ValueError:
        param_C = 5

    try:
        param_gamma = float(
            input("Enter the gamma parameter (default=0.05): "))
    except ValueError:
        param_gamma = 0.05

    try:
        param_tolerance = float(
            input("Enter the tolerance parameter (default=1e-3): "))
    except ValueError:
        param_tolerance = 1e-3

    try:
        param_max_iter = int(
            input("Enter the max iteration parameter (default=-1): "))
    except ValueError:
        param_max_iter = -1

    train_kernel(param_kernel, param_degree, param_C, param_gamma,
                 param_tolerance, param_max_iter, X_train, Y_train)


def train_kernel(X_train, Y_train, param_kernel, param_degree, param_C, param_gamma,
                 param_tolerance=1e-3, param_max_iter=-1):
    '''Function that, with the given parameters, train a SVM.
    Then saves the dataset with a `filename` according to the input parameters.

    Parameters
    ----------
    param_kernel: Specifies the kernel type to be used in the algorithm.

    param_degree: Degree of the polynomial kernel function.

    param_C: Penalty parameter C of the error term.

    param_gamma: Kernel coefficient for ‘rbf’, ‘poly’ and ‘sigmoid’.

    param_tolerance: Tolerance for stopping criterion.

    param_max_iter: Hard limit on iterations within solver.

    X_train: dataset used for training the SVM

    Y_traing: labels of the dataset used for training the SVM

    Returns
    ----------
    The SVM classifier already trained
    '''

    classifier = svm.SVC(kernel=param_kernel, C=param_C, gamma=param_gamma,
                         degree=param_degree, tol=param_tolerance, max_iter=param_max_iter)

    # Prints info of the kernel trained
    print('\nClassifier info:\n',
          '\t' + 'Kernal: ' + param_kernel + '\n',
          '\t' + 'Degree: ' + str(param_degree) + '\n',
          '\t' + 'Cost: ' + str(param_C) + '\n',
          '\t' + 'Gamma: ' + str(param_gamma) + '\n',
          '\t' + 'Tolerance: ' + str(param_tolerance) + '\n',
          '\t' + 'Max_Iter: ' + str(param_max_iter) + '\n')

    # We learn the digits on train part
    start_time = dt.datetime.now()
    print('Start learning at {}'.format(str(start_time)))
    classifier.fit(X_train, Y_train)
    end_time = dt.datetime.now()
    print('Stop learning {}'.format(str(end_time)))
    elapsed_time = end_time - start_time
    print('Elapsed learning {}'.format(str(elapsed_time)))

    # save the model to disk
    filename = 'resources/svm'
    filename += '_' + param_kernel
    filename += '_' + str(param_degree)
    filename += '_' + str(param_C)
    filename += '_' + str(param_gamma)
    filename += '_' + str(param_tolerance)
    filename += '_' + str(param_max_iter)
    filename += '.sav'
    joblib.dump(classifier, filename)
    print('\nFile save:', filename)

    return classifier


def test_classifier(X_test, Y_test, classifier):
    '''Function that test the SVM with a X and Y for testing.
    Also gets the confusion matrix of the results and derivated parameters.

    Parameters
    ----------
    X_test: test data.

    Y_test: results of the test data.

    classifier: train SVM to test.
    '''

    expected = Y_test
    predicted = classifier.predict(X_test)

    # pick random indexes from 0 to size of our predicted dataset
    # // show_some_digits(X_test, predicted, title_text="Predicted {}")

    print("\nClassification report for classifier %s:\n%s"
          % (classifier, metrics.classification_report(expected, predicted)))

    cm = metrics.confusion_matrix(expected, predicted)
    print("Confusion matrix:\n%s" % cm)

    # plots a heatmap of the confusion matrix
    # // plot_confusion_matrix(cm)

    print("\nAccuracy={}".format(metrics.accuracy_score(expected, predicted)))
    print("\n")
