import pygame 
import random
import math
import Tkinter as tk


pygame.init()
screen_width=600
screen_height=600
screen = pygame.display.set_mode([screen_width, screen_height],0,32)
WHITE = (0, 0, 0)
all_sprites_list = pygame.sprite.Group()


class Fish(pygame.sprite.Sprite):
    def __init__(self):
 
    # parent class constructor
        pygame.sprite.Sprite.__init__(self)
 
    # Load the image
        self.image = pygame.image.load("Mola1R.png").convert()
        self.image.set_colorkey(WHITE)
    # Update the position of this object by setting the value of rect.x and rect.y
        self.rect = self.image.get_rect()

for i in range(10):
    fish = Fish()
    # random location
    fish.rect.x = 100
    fish.rect.y = 100
 
    # add to sprite list
    all_sprites_list.add(fish)

player = Fish()
all_sprites_list.add(player)
player.rect.x = 100
player.rect.y = 100


# Loop until close is clicked
done = False
 
# manage how fast the screen updates
clock = pygame.time.Clock()
 
 
# -------- Main Program Loop -----------
while not done:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True
    player.rect.x = 10 
    player.rect.y = 10

   
    pos = pygame.mouse.get_pos()
    if player.rect.x > pos[0]:
        angle = math.atan2((pos[1] - player.rect.y), (player.rect.x - pos[0])) / math.pi *2
            
    if player.rect.x < pos[1]:
        angle = math.atan2((pos[1] - player.rect.y), (player.rect.x - pos[0])) / math.pi *3
    
    rect = fish.image.get_rect(center=(400,300))
    fish.rect.x = 10
    fish.rect.y = 10 
    player.image = pygame.transform.rotate(screen,angle)
    screen.blit(screen,rect)

    for fish in all_sprites_list:
        fish.rect.x = 10
        fish.rect.y = 10

    # Clear the screen
    screen.fill(WHITE)

    all_sprites_list.draw(screen)
    # Limit to 60 frames per second
    clock.tick(30)
 
    # update the screen
    pygame.display.flip()
 
pygame.quit()



