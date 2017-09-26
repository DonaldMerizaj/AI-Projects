import pygame


class Sunfish:
    def __init__(self, posx, posy, vector):
        self.x = posx
        self.y = posy
        self.v = vector

    def Separate(self):
        x = 1
    def Align(self):
        x = 1
    def getAvgPos(self):
        for i in range(10):
            if (getDist(self.x, self.y, Sunfishes[i].x, Sunfishes[i].y) < 50):
                tx += Sunfishes[i].x
                ty += Sunfishes[i].y
                x /= 10.0
                y /= 10.0
    

class Vector:
    def __init__(self, magx, magy, direction):
        self.x = magx
        self.y = magy
        self.d = direction
    def AddV(self, vector2):
        x = self.x+vector2.x
        y = self.y+vector2.y
        retv = Vector(x,y,atan(y/x))

    
    
def getDist(x1, y1, x2, y2):
        return sqrt((x1-x2) + (y1-y2))

Sunfishes = [Sunfish(0,0,Vector(0,0,0))] * 10
