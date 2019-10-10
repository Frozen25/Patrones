import tensorflow as tf
import matplotlib.pyplot as plt
import numpy as np
#print( tf.__version__)

mnist = tf.keras.datasets.mnist
(x_train, y_train),(x_test, y_test) = mnist.load_data()  #default trainin and testing sets

x_train = tf.keras.utils.normalize(x_train, axis=1)
x_test = tf.keras.utils.normalize(x_test, axis=1)




try:
  new_model = tf.keras.models.load_model('epic_num_reader.model')  
except:
  model = tf.keras.models.Sequential()
  model.add(tf.keras.layers.Flatten())
  model.add(tf.keras.layers.Dense(128, activation=tf.nn.relu))
  model.add(tf.keras.layers.Dense(128, activation=tf.nn.relu))
  model.add(tf.keras.layers.Dense(128, activation=tf.nn.softmax))
  model.compile(optimizer='adam', loss='sparse_categorical_crossentropy',metrics=['accuracy'])
  model.fit(x_train, y_train, epochs=3)
  #saving model
  model.save('epic_num_reader.model')
  new_model = tf.keras.models.load_model('epic_num_reader.model')  

#evaluating training with testing
val_loss, val_acc = new_model.evaluate(x_test, y_test)
print(val_loss)
print(val_acc)


prediction = new_model.predict([x_test[0:1]])  #argument must be a list inside a list, a range returns a list

print(np.argmax(prediction))

plt.imshow(x_test[0],cmap=plt.cm.binary)
plt.show()