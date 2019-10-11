import cv2
import numpy as np
# serializer import/export
import joblib

img = cv2.imread('resource/number.png')
img = cv2.resize(img,(28,28))
img = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
img = np.invert(img)

img = img/255

filename = input(
    "Enter classifier to use: ")

classifier = joblib.load("resource/" + filename)
print('File used:', filename)

#predicted = classifier.predict(img)
#print("Valor predicho:", predicted)