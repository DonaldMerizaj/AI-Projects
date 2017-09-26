import time
from SimpleCV import *

cam = Camera()
bearFace = Image('Bear.png')
bearmask = Image('wBear.PNG')
while True:
    image = cam.getImage().flipHorizontal().scale(420, 340)
    faces = image.findHaarFeatures("face")
    #if there were faces found do something
    if faces:
        face = faces[-1]
        Bear = bearFace.scale(face.height(), face.width())
        bearmask = (bearmask.scale(face.height(), face.width()))
        image = image.blit(Bear, face.topLeftCorner(),alphaMask=bearmask)

    image.show()
    time.sleep(0.01)
