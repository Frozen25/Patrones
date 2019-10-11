import tkinter
from tkinter import *
import PIL
from PIL import Image, ImageDraw, ImageOps
import tensorflow as tf
import matplotlib.pyplot as plt
import numpy as np
from keras.utils import np_utils
from sklearn import metrics


mnist = tf.keras.datasets.mnist #load mnist data
(x_train, y_train),(x_test, y_test) = mnist.load_data()  #default trainin and testing sets
#normalize data
x_train = tf.keras.utils.normalize(x_train, axis=1)
x_test = tf.keras.utils.normalize(x_test, axis=1)

new_model = tf.keras.models.load_model('resources/epic_num_reader.model')  #load model if exists

def testdata():
  #evaluating training with testing
  val_loss, val_acc = new_model.evaluate(x_test, y_test)
  print("\n")
  print("Loss: ", val_loss)
  print("Acc: ", val_acc)

  Y_pred = new_model.predict([x_test])
  y_pred = np.argmax(Y_pred, axis=1)
  cm = metrics.confusion_matrix(y_test, y_pred)
  print("Confusion matrix:\n%s" % cm)

testdata()
print("\n")


##############################
size = 200

def printprob(l):
  print("printing probabilities: ")
  length = len(l)
  line = "\t"
  for i in range(length):
    line += "| " + str(i)
  print(line)
  line = "\t"
  for num in l:
    each = int(num*100)
    line +=(f"|{each:02d}")
  print(line+"\n")

def save():    
  filename = 'resources/number.png'  
  image2 = image1.resize((28, 28),2) #segundo parámetro es 2 para bilineal o 3 para bicubico
  image2.save(filename)
  ########################################
  image = PIL.Image.open('resources/number.png')
  imageGrey = image.convert('L')
  imgInv = PIL.ImageOps.invert(imageGrey)
  imgA = np.array(imgInv)
  imgNorm = imgA / 255
  #plt.imshow(imgNorm,cmap=plt.cm.binary)
  #plt.show()
  imgNorm = tf.keras.utils.normalize([imgNorm], axis=1)  
  pr = new_model.predict([imgNorm])
  print("predicted: ",np.argmax(pr[0]))
  printprob(pr[0])

  
def reset():
  global size
  cv.delete("all")
  draw.rectangle((0, 0, size, size), fill=(255))

def activate_paint(e):
  global lastx, lasty
  cv.bind('<B1-Motion>', paint)
  lastx, lasty = e.x, e.y

def paint(e):
  global lastx, lasty
  thickness = 20
  x, y = e.x, e.y
  cv.create_oval((lastx, lasty, x, y), width=thickness)   
  #  --- PIL
  draw.line((lastx, lasty, x, y), fill='black', width=thickness)
  lastx, lasty = x, y

root = Tk()
lastx, lasty = None, None
cv = Canvas(root, width=size, height=size, bg='white')
# --- PIL
image1 = PIL.Image.new(mode='L', size=(size, size), color='white') # L = escala de grises
draw = ImageDraw.Draw(image1)
cv.bind('<1>', activate_paint)
cv.pack(expand=YES, fill=BOTH)

btn_save = Button(text="Predict", command=save)
btn_save.pack()
btn_reset = Button(text="Clear", command=reset)
btn_reset.pack()
root.mainloop()