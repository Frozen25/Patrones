from misc.svm_train_test import *

# Creates a dataset
X_train, X_test, Y_train, Y_test = create_dataset(0.33, 42)

# Trains all the types of kernel
classifier_poly = train_kernel('poly', 5, 3, 0.05, 1e-3, -1, X_train, Y_train)
classifier_linear = train_kernel('linear', 5, 3, 0.05, 1e-3, -1, X_train, Y_train)
classifier_rbf = train_kernel('rbf', 5, 3, 0.05, 1e-3, -1, X_train, Y_train)
classifier_sigmoid = train_kernel('sigmoid', 5, 3, 0.05, 1e-3, -1, X_train, Y_train)

# Test the trained SVM with the test dataset
test_classifier(X_train, Y_train, classifier_poly)
test_classifier(X_train, Y_train, classifier_linear)
test_classifier(X_train, Y_train, classifier_rbf)
test_classifier(X_train, Y_train, classifier_sigmoid)