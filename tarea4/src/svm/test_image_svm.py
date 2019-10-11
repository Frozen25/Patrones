# Importa PIL para el manejo de la imagen
import PIL
from PIL import Image, ImageDraw, ImageOps
import numpy as np
# Importa joblib para cargar SVM
import joblib

# Ejemplo: svm_poly_5_3_0.05_0.001_-1.sav
filename = input(
    "Enter classifier to use: ")

classifier = joblib.load("resource/" + filename)
print('File used:', filename)

cont = True
while cont:

    im2 = PIL.Image.open("resource/number.png")

    convim2 = im2.convert('L')  # Lineal en escala de grises (normaliza datos)

    cim2 = PIL.ImageOps.invert(convim2)

    data2 = np.array(cim2)

    dataT2 = np.reshape(data2, (1, 784))

    predicted = classifier.predict(dataT2)

    print("Valor predicho:", predicted)

    inputContinue = input("Scan again? (0-1): ")
    if(inputContinue != '1'):
        cont = False
