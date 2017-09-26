import pygame
import random
import math

pygame.init()
screen_width=800
screen_height=800

screen = pygame.display.set_mode([screen_width, screen_height])
pygame.mouse.set_cursor(*pygame.cursors.broken_x)
WHITE = (0, 0, 0)
all_sprites_list = pygame.sprite.Group()
sprites = []
fishNum = 10
fishInc = 5
done = False
predator = False
detectionRadius = 30
#3, 1, 100, 1, 250

sweight = 0.55
aweight = 0.05
cweight = 0.05
mweight = 0.35
speed = 2

class Ocean(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        self.image = pygame.image.load("Ocean.png").convert()
        self.image.set_colorkey(WHITE)
        self.image = pygame.transform.scale(self.image, (screen_width,screen_height))
        self.rect = self.image.get_rect()
        self.rect.x = 0
        self.rect.y = 0

class Sunfish(pygame.sprite.Sprite):
    def __init__(self, posx, posy, vex, vey):
        self.x = posx
        self.y = posy
        self.vx = vex
        self.vy = vey
        pygame.sprite.Sprite.__init__(self)
        self.image = pygame.image.load("Mola1R.png").convert()
        self.image.set_colorkey(WHITE)
        self.rect = self.image.get_rect()

    def Alignment(self):
        count = 0
        velocity = [0] * 2
        
        for i in range(len(sprites)):
            if i != sprites.index(self):
                if (getDist(self.x, self.y, sprites[i].x, sprites[i].y) < detectionRadius):
                    count += 1.0
                    velocity[0] += sprites[i].vx
                    velocity[1] += sprites[i].vy
        if count != 0:
            velocity[0] /= count
            velocity[1] /= count
        velocity = normalize(velocity)
        return velocity
        
    def Cohesion(self):
        count = 0
        velocity = [0]*2
        
        for i in range(len(sprites)):
            if i != sprites.index(self):
                if (getDist(self.x, self.y, sprites[i].x, sprites[i].y) < detectionRadius):
                    count += 1.0
                    velocity[0] += sprites[i].x
                    velocity[1] += sprites[i].y
        if count != 0:
            velocity[0] /= count
            velocity[1] /= count
        velocity[0] = self.x - velocity[0]
        velocity[1] = self.y - velocity[1]
        velocity = normalize(velocity)
        return velocity
        
        
    def Separation(self):
        count = 0
        velocity = [0]*2
        
        for i in range(len(sprites)):
            if i != sprites.index(self):
                if (getDist(self.x, self.y, sprites[i].x, sprites[i].y) < detectionRadius * 1.5):
                    count += 1.0
                    velocity[0] += sprites[i].x - self.x
                    velocity[1] += sprites[i].y - self.y
        if count != 0:
            velocity[0] /= count
            velocity[1] /= count
        velocity = normalize(velocity)
        velocity[0] *= -1
        velocity[1] *= -1
        return velocity

    def FollowMouse(self):
        velocity = [0]*2

        if(getDist(self.x,self.y,pygame.mouse.get_pos()[0],pygame.mouse.get_pos()[1]) < detectionRadius*15):
            if(predator):
                velocity[0] += (sprites[i].x - pygame.mouse.get_pos()[0])
                velocity[1] += (sprites[i].y - pygame.mouse.get_pos()[1])
            else:
                velocity[0] += (pygame.mouse.get_pos()[0] - self.x)
                velocity[1] += (pygame.mouse.get_pos()[1] - self.y)
        velocity = normalize(velocity)
        return normalize(velocity)

    
    def update(self):
        vector = [0] * 2
        
        self.vx = self.Alignment()[0] * aweight + self.Separation()[0] * sweight + self.Cohesion()[0] * cweight+ self.FollowMouse()[0] * mweight
        self.vy = self.Alignment()[1] * aweight + self.Separation()[1] * sweight + self.Cohesion()[1] * cweight + self.FollowMouse()[1] * mweight
        
        vector[0] = self.vx
        vector[1] = self.vy
        vector = normalize(vector)
            
        self.x += vector[0]*speed
        self.y += vector[1]*speed
    
        if self.x > screen_width:
            self.x = 0
        if self.x < 0:
            self.x = screen_width
        if self.y > screen_height:
            self.y = 0
        if self.y < 0:
            self.y = screen_height
            
        self.rect.x = self.x
        self.rect.y = self.y
        angle=0
        pos = pygame.mouse.get_pos()
        if self.vx!=0 and (getDist(self.x,self.y,pygame.mouse.get_pos()[0],pygame.mouse.get_pos()[1]) < detectionRadius*10):
            angle = math.atan2((self.rect.y - pos[1]), (pos[0] - self.rect.x))*180 / math.pi
            #print angle
        elif self.vx!=0:
            angle = math.atan2((self.vy), (self.vx))*180 / math.pi
            angle=angle*-1
        if (angle>0 and angle<90) or (angle<0 and angle>-90):
            self.image = pygame.image.load("Mola1R.png").convert()
        if (angle>90 and angle<180) or (angle<-90 and angle>-180):
            self.image = pygame.image.load("Mola2R.png").convert()
            angle=angle-180
        self.image = pygame.transform.rotate(self.image, angle)
        self.image.set_colorkey(WHITE)


def getDist(x1, y1, x2, y2):
      return math.sqrt((x1-x2)**2 + (y1-y2)**2)

def normalize(vel):
    mag = math.sqrt(vel[0]**2 + vel[1]**2)
    if(mag != 0):
        vel[0] = (vel[0]/mag)
        vel[1] = (vel[1]/mag)
    return vel

for i in range(fishNum):
    fish = Sunfish(random.random()*750,random.random()*750,random.random(),random.random())
    sprites.append(fish)
    fish.rect.x = fish.x
    fish.rect.y = fish.y
    all_sprites_list.add(fish)
    
background = Ocean()
backgroundl = pygame.sprite.Group()
backgroundl.add(background)
clock = pygame.time.Clock()

while not done:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True
        if event.type == pygame.MOUSEBUTTONDOWN:
            for i in range(fishInc):
                fish = Sunfish(random.random()*750,random.random()*750,random.random(),random.random())
                sprites.append(fish)
                fish.rect.x = fish.x
                fish.rect.y = fish.y
                all_sprites_list.add(fish)
    
        
    for i in range(len(sprites)):
        sprites[i].update()
    screen.fill(WHITE)
    backgroundl.draw(screen)  
    all_sprites_list.draw(screen)
    clock.tick(60)
    pygame.display.flip()
 
pygame.quit()
