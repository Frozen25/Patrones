import tensorflow as tf
import matplotlib.pyplot as plt
import numpy as np

#print( tf.__version__) #get version
import PIL
from PIL import Image
from keras.utils import np_utils
from sklearn import metrics

mnist = tf.keras.datasets.mnist #load mnist data
(x_train, y_train),(x_test, y_test) = mnist.load_data()  #default trainin and testing sets
#normalize data
x_train = tf.keras.utils.normalize(x_train, axis=1)
x_test = tf.keras.utils.normalize(x_test, axis=1)





def default():
  model = tf.keras.models.Sequential()
  model.add(tf.keras.layers.Flatten())    #flattens the data at the input layer
  model.add(tf.keras.layers.Dense(60, activation=tf.nn.relu))  #second layer 60 neurons
  model.add(tf.keras.layers.Dense(60, activation=tf.nn.sigmoid))  #second layer 60 neurons
  model.add(tf.keras.layers.Dense(10, activation=tf.nn.softmax))  #output layer, softmax gives probability distribution
  model.compile(optimizer='adam', loss='sparse_categorical_crossentropy',metrics=['accuracy'])
  model.fit(x_train, y_train, epochs=10) #training data for 3 epochs
  #saving model
  model.save('resources/num_reader.model')
  new_model = tf.keras.models.load_model('resources/num_reader.model' )  #load model trained
  
def modular():
  model = tf.keras.models.Sequential()
  model.add(tf.keras.layers.Flatten())    #flattens the data at the input layer
  layers = input("Enter amount of layers (1-100): ")
  try:
    ilayers = int(layers)
  except:
    ilayers = 2
  if (ilayers>100) or (ilayers <1):
    ilayers = 2
  for i in range(ilayers):
    mode = input("For layer " +str(i+1) +", relu or sigmoid?: ")
    neurons = input("Enter the number of neurons (1-200): ")
    try:
      ineurons = int(neurons)
    except:
      ineurons = 60
    if (ineurons>200) or (ineurons <1):
      ineurons = 60
    if (mode == "relu" ):
      model.add(tf.keras.layers.Dense(ineurons, activation=tf.nn.relu)) 
    else:
      model.add(tf.keras.layers.Dense(ineurons, activation=tf.nn.sigmoid))
  model.add(tf.keras.layers.Dense(10, activation=tf.nn.softmax))  #output layer, softmax gives probability distribution
  model.compile(optimizer='adam', loss='sparse_categorical_crossentropy',metrics=['accuracy'])
  model.fit(x_train, y_train, epochs=10) #training data for 3 epochs
  #saving model
  model.save('resources/num_reader.model')
  new_model = tf.keras.models.load_model('resources/num_reader.model' )  #load model trained



def testdata():
  new_model = tf.keras.models.load_model('resources/num_reader.model' )  #load model if exists
  #evaluating training with testing
  val_loss, val_acc = new_model.evaluate(x_test, y_test)
  print("\n")
  print("Loss: ", val_loss)
  print("Acc: ", val_acc)

  Y_pred = new_model.predict([x_test])
  y_pred = np.argmax(Y_pred, axis=1)
  cm = metrics.confusion_matrix(y_test, y_pred)
  print("Confusion matrix:\n%s" % cm)

mod = input("Default configuration? (0-1): ")

if(mod == "0"):
  modular()
else:
  default()

testdata()
  
