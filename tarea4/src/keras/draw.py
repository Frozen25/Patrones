import tkinter
from tkinter import *
import PIL
from PIL import Image, ImageDraw


def save():    
    filename = 'number.png'   # image_number increments by 1 at every save
    image2 = image1.resize((28, 28),2) #segundo parámetro es 2 para bilineal o 3 para bicubico
    image2.save(filename)
    
def activate_paint(e):
    global lastx, lasty
    cv.bind('<B1-Motion>', paint)
    lastx, lasty = e.x, e.y

def paint(e):
    global lastx, lasty
    x, y = e.x, e.y
    cv.create_oval((lastx, lasty, x, y), width=15)
    #  --- PIL
    draw.line((lastx, lasty, x, y), fill='black', width=15)
    lastx, lasty = x, y

root = Tk()
lastx, lasty = None, None
cv = Canvas(root, width=200, height=200, bg='white')
# --- PIL
image1 = PIL.Image.new('L', (200, 200), 'white')
draw = ImageDraw.Draw(image1)
#image2 = image1.resize((28,28),resample=1)
cv.bind('<1>', activate_paint)
cv.pack(expand=YES, fill=BOTH)

btn_save = Button(text="save", command=save)
btn_save.pack()

root.mainloop()