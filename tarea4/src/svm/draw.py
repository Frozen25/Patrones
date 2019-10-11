import tkinter
from tkinter import *
import PIL
from PIL import Image, ImageDraw
import cv2

size = 200


def save():
    filename = 'resource/number.png'
    # segundo parámetro es 2 para bilineal o 3 para bicubico
    image2 = image1.resize((28, 28), 2)
    image2.save(filename)


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
