import tensorflow as tf
import matplotlib.pyplot as plt
import numpy as np
import cv2
#print( tf.__version__) #get version


train = input("New model? (0-1): ")
try:
  ntrain = int(train)
except:
  ntrain = 0

if(ntrain == 0):
  new_model = tf.keras.models.load_model('epic_num_reader.model')  #load model if exists
else:
  mnist = tf.keras.datasets.mnist #load mnist data
  (x_train, y_train),(x_test, y_test) = mnist.load_data()  #default trainin and testing sets
  #normalize data
  x_train = tf.keras.utils.normalize(x_train, axis=1)
  x_test = tf.keras.utils.normalize(x_test, axis=1)
  model = tf.keras.models.Sequential()
  model.add(tf.keras.layers.Flatten())    #flattens the data at the input layer
  #model.add(tf.keras.layers.Dense(10, activation=tf.nn.softmax))  #first layer 128 neurons
  model.add(tf.keras.layers.Dense(50, activation=tf.nn.relu))  #second layer 128 neurons
  model.add(tf.keras.layers.Dense(10, activation=tf.nn.softmax))  #output layer, softmax gives probability distribution
  model.compile(optimizer='adam', loss='sparse_categorical_crossentropy',metrics=['accuracy'])
  model.fit(x_train, y_train, epochs=3) #training data for 3 epochs
  #saving model
  model.save('epic_num_reader.model')
  new_model = tf.keras.models.load_model('epic_num_reader.model')  #load model trained
  #evaluating training with testing
  val_loss, val_acc = new_model.evaluate(x_test, y_test)
  print("loss and acc: ")
  print(val_loss)
  print(val_acc)

'''



prediction = new_model.predict([x_test[0:1]])  #argument must be a list inside a list, a range returns a list
print(np.argmax(prediction))
plt.imshow(x_test[0],cmap=plt.cm.binary)
plt.show()
'''

img = cv2.imread('number.png')
img = cv2.resize(img,(28,28))
img = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
img = np.invert(img)

img = img/255
img = img.astype('float64')

#plt.imshow(img,cmap=plt.cm.binary)
#plt.show()

img = tf.keras.utils.normalize([img], axis=1)
#img= np.expand_dims(img,axis=0)
print(img.shape)

pr = new_model.predict([img])
print(np.argmax(pr[0]))

nums = [0,1,2,3,4,5,6,7,8,9]
print (nums)
l = [int(x * 100) for x in pr[0]]
print(l)
