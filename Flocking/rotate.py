import pygame
import math
import time
pygame.init()
class Ship(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        self.imageMaster = pygame.image.load("Mola1R.png").convert()
        self.imageMaster = self.imageMaster.convert()
        self.image = self.imageMaster
        self.rect = self.image.get_rect()
        self.rect.center = (320, 240)
        self.dir = 0

    def update(self):
        oldCenter = self.rect.center
        pos = pygame.mouse.get_pos()
        angle = math.atan2((self.rect.y - pos[1]), (pos[0] - self.rect.x))*180 / math.pi 
        print angle
        if (angle>0 and angle<90) or (angle<0 and angle>-90):
            self.image = pygame.image.load("Mola1R.png").convert()
        if (angle>90 and angle<180) or (angle<-90 and angle>-180):
            self.image = pygame.image.load("Mola2R.png").convert()
            angle=angle-180
        self.rect = self.image.get_rect()
        self.rect.center = oldCenter
        self.image = pygame.transform.rotate(self.image, angle)
        self.rect = self.image.get_rect()
        self.rect.center = oldCenter
        angle2 = math.atan2((pos[1] - self.rect.y), (pos[0] - self.rect.x))
        dis = math.sqrt(math.pow(pos[0] - self.rect.x, 2) + math.pow(pos[0] - self.rect.x, 2))
        self.rect.x+=(pos[0] - self.rect.x)*0.1 + 2*math.sin(angle2)
        self.rect.y+=(pos[1] - self.rect.y)*0.1 + 2*math.cos(angle2)
       

        
def main():
    
    spriteOffsety = []
    spriteOffsetx = []
    screen = pygame.display.set_mode((640, 480))
    pygame.display.set_caption("Rotate a sprite")
    
    background = pygame.Surface(screen.get_size())
    background.fill((0, 0, 0))
    ship = Ship()
    allSprites = pygame.sprite.Group(ship)
    
    clock = pygame.time.Clock()
    keepGoing = True
    while keepGoing:
        clock.tick(30)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                keepGoing = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_LEFT:
                    ship.turnLeft()
                elif event.key == pygame.K_RIGHT:
                    ship.turnRight()
        
        allSprites.clear(screen, background)
        allSprites.update()
        allSprites.draw(screen)
        
        pygame.display.flip()
        time.sleep(0.01)
if __name__ == "__main__":
    main()

pygame.quit()
