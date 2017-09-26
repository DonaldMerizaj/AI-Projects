import pygame 
import random
import math
pygame.init()
screen_width=600
screen_height=600
screen = pygame.display.set_mode([screen_width, screen_height])
WHITE = (0, 0, 0)
all_sprites_list = pygame.sprite.Group()
sprites = []
spriteOffsety = []
spriteOffsetx = []
x = pygame.mouse.get_pos()[0]
y = pygame.mouse.get_pos()[1]
class Fish(pygame.sprite.Sprite):
    def __init__(self):
 
    # parent class constructor
        pygame.sprite.Sprite.__init__(self)
 
    # Load the image
        self.image = pygame.image.load("Mola1R.png").convert()
        self.image.set_colorkey(WHITE)
    # Update the position of this object by setting the value of rect.x and rect.y
        self.rect = self.image.get_rect()

for i in range(1):
    fish = Fish()
    spriteOffsetx.append(random.randrange(150))
    spriteOffsety.append(random.randrange(150))
    
    
    # random location
    fish.rect.x = random.randrange(screen_width-50)
    fish.rect.y = random.randrange(screen_height-50)
    
    # add to sprite list
    all_sprites_list.add(fish)
    sprites.append(fish)



# Loop until close is clicked
done = False
 
# manage how fast the screen updates
clock = pygame.time.Clock()
 
 
# -------- Main Program Loop -----------
while not done:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True
            
    for i in range(len(sprites)):
        sprites[i].rect.x = x+spriteOffsetx[i]
        sprites[i].rect.y = y+spriteOffsety[i]
        angle=50;
        if angle>90:
            sprites[i].image = pygame.transform.flip(sprites[i].image, False, True)
        sprites[i].image = pygame.transform.rotate(sprites[i].image, angle)


    # Clear the screen
    screen.fill(WHITE)

    all_sprites_list.draw(screen)
    # Limit to 60 frames per second
    clock.tick(60)
 
    # update the screen
    pygame.display.flip()
    x = pygame.mouse.get_pos()[0]
    y = pygame.mouse.get_pos()[1]

pygame.quit()
