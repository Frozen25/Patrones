from misc.svm_train_test import *

# Creates a dataset
X_train, X_test, Y_train, Y_test = create_dataset(0.33, 42)

# Trains all the types of kernel with the same dataset
classifier_poly = train_kernel(X_train, Y_train, 'poly', 3, 5, 0.05)
classifier_linear = train_kernel(X_train, Y_train ,'linear', 3, 5, 0.05)
classifier_rbf = train_kernel(X_train, Y_train ,'rbf', 3, 5, 0.05)
classifier_sigmoid = train_kernel(X_train, Y_train, 'sigmoid', 3, 5, 0.05)

# Different degrees
classifier_poly1 = train_kernel(X_train, Y_train, 'poly', 1, 5, 0.05)
classifier_poly2 = train_kernel(X_train, Y_train, 'poly', 5, 5, 0.05)
classifier_poly3 = train_kernel(X_train, Y_train, 'poly', 10, 5, 0.05)
classifier_poly4 = train_kernel(X_train, Y_train, 'poly', 25, 5, 0.05)

# Different penalties
classifier_poly5 = train_kernel(X_train, Y_train, 'poly', 3, 0.001, 0.05)
classifier_poly6 = train_kernel(X_train, Y_train, 'poly', 3, 50, 0.05)
classifier_poly7 = train_kernel(X_train, Y_train, 'poly', 3, 500, 0.05)
classifier_poly8 = train_kernel(X_train, Y_train, 'poly', 3, 5000, 0.05)

# Different gammas
classifier_poly9 = train_kernel(X_train, Y_train, 'poly', 3, 5, 0.005)
classifier_poly10 = train_kernel(X_train, Y_train, 'poly', 3, 5, 0.1)
classifier_poly11 = train_kernel(X_train, Y_train, 'poly', 3, 5, 1)
classifier_poly12 = train_kernel(X_train, Y_train, 'poly', 3, 5, 10)

# Test the trained SVM with the same test dataset
test_classifier(X_test, Y_test, classifier_poly)
test_classifier(X_test, Y_test, classifier_linear)
test_classifier(X_test, Y_test, classifier_rbf)
test_classifier(X_test, Y_test, classifier_sigmoid)

test_classifier(X_test, Y_test, classifier_poly1)
test_classifier(X_test, Y_test, classifier_poly2)
test_classifier(X_test, Y_test, classifier_poly3)
test_classifier(X_test, Y_test, classifier_poly4)

test_classifier(X_test, Y_test, classifier_poly5)
test_classifier(X_test, Y_test, classifier_poly6)
test_classifier(X_test, Y_test, classifier_poly7)
test_classifier(X_test, Y_test, classifier_poly8)

test_classifier(X_test, Y_test, classifier_poly9)
test_classifier(X_test, Y_test, classifier_poly10)
test_classifier(X_test, Y_test, classifier_poly11)
test_classifier(X_test, Y_test, classifier_poly12)