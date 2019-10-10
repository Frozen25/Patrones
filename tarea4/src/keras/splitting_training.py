from keras.datasets import mnist
import numpy as np
from sklearn.model_selection import train_test_split

#using sklearn to split the data

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x = np.concatenate((x_train, x_test))
y = np.concatenate((y_train, y_test))

train_size = 0.7
x_train, x_test, y_train, y_test = train_test_split(x, y, train_size=train_size, random_seed=2019)