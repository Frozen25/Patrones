# Importa PIL para el manejo de la imagen
import PIL
from PIL import Image, ImageDraw, ImageOps
import tkinter
from tkinter import *
import numpy as np
import joblib
import cv2

# + Cargador del SVM
filename = input(
    "Enter classifier to use: ")

# Ejemplo: svm_poly_5_3_0.05_0.001_-1.sav
classifier = joblib.load("resources/" + filename)
print('File used:', filename)


def save():
    filename = 'resources/number.png'
    # segundo parámetro es 2 para bilineal o 3 para bicubico
    image2 = image1.resize((28, 28), 2)
    image2.save(filename)
    predict()


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


def predict():
    global classifier

    im2 = PIL.Image.open("resources/number.png")

    convim2 = im2.convert('L')  # Lineal en escala de grises (normaliza datos)

    cim2 = PIL.ImageOps.invert(convim2)

    data2 = np.array(cim2)

    dataT2 = np.reshape(data2, (1, 784))

    predicted = classifier.predict(dataT2)

    print("Valor predicho:", predicted)


# + Main del archivo
size = 200

root = Tk()
lastx, lasty = None, None
cv = Canvas(root, width=size, height=size, bg='white')
# --- PIL
image1 = PIL.Image.new(mode='L', size=(size, size),
                       color='white')  # L = escala de grises
draw = ImageDraw.Draw(image1)
cv.bind('<1>', activate_paint)
cv.pack(expand=YES, fill=BOTH)

btn_save = Button(text="save", command=save)
btn_save.pack()
btn_reset = Button(text="reset", command=reset)
btn_reset.pack()
root.mainloop()
