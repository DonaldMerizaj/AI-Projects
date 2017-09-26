import pygame
import random
import math
from pygame.locals import *
from pygame.color import THECOLORS

min_v = 1
max_v = 10
min_neighbor_radius = 25
max_neighbor_radius = 100
window = (1200, 800)
#True: bound at boundary, False: no boundary
boundary_exist = True
#True: random initial direction, False: initial toward mouse
random_initial_direction = True
particle_list = []
pygame.init()
screen = pygame.display.set_mode(window)
icon_particle = pygame.image.load('Mola1R.png').convert_alpha()
icon_leader = pygame.image.load('Mola1R.png').convert_alpha()
bg = screen.convert()
bg.fill(THECOLORS["black"])

def main():
    global bg
    clock = pygame.time.Clock()
    timer = 9999
    running = True
    generate_delay = 1
    while running:
        bg.fill(THECOLORS["black"])
        if timer >= generate_delay:
            timer = 0
            generate_delay += 1
            x = window[0]/2
            y = window[1]/2
            v = 0.0
            while v == 0.0:
                if random_initial_direction:
                    vx = random.randint(-max_v, max_v)
                    vy = random.randint(-max_v, max_v)
                else:
                    mouse_pos = pygame.mouse.get_pos()
                    vx = mouse_pos[0] - x
                    vy = mouse_pos[1] - y
                v = math.sqrt(vx*vx + vy*vy)
            random_v = random.randint(min_v, max_v)
            vx *= random_v/v
            vy *= random_v/v
            neighbor_radius = random.randint(min_neighbor_radius, max_neighbor_radius)
            particle_list.append(Particle(x, y, vx, vy, neighbor_radius, icon_particle))
        for particle in particle_list:
            particle.update_neighbors()
            #particle.set_leader()
            #following float value(>0) larger: means the degree of influence larger
            #True: all toward mouse, False: only leader toward mouse
            #particle.update_speed(particle.toward_mouse(1.0, True))
            #particle.update_speed(particle.follow_leader(0.5))
            particle.update_speed(particle.rule1(0.5))#cohesion
            particle.update_speed(particle.rule2(0.1, 1.5))#separation(bump, disperse)
            particle.update_speed(particle.rule3(0.5))#alignment
            particle.limit_speed()
            particle.update_pos()
        screen.blit(bg, (0,0))
        pygame.display.flip()
        clock.tick(30)
        timer += 1
        for event in pygame.event.get():
            if event.type == QUIT or (event.type == KEYDOWN and event.key == K_ESCAPE):
                running = False

class Particle:
    def __init__(self, x, y, vx, vy, neighbor_radius, icon_particle):
        self.leadership = False
        #self.prob = 0.1
        self.x = x#at center
        self.y = y#at center
        self.neighbor_radius = neighbor_radius
        self.icon = icon_particle
        self.width = self.icon.get_width()
        self.height = self.icon.get_height()
        self.vx = vx
        self.vy = vy
        self.initial_v = math.sqrt(vx*vx + vy*vy)
        self.neighbors = []
        self.update_neighbors()
    def toward_mouse(self, scale, all):
        if self.leadership or all:
            target = pygame.mouse.get_pos()
            dx = target[0] - self.x
            dy = target[1] - self.y
            d = math.sqrt(dx*dx + dy*dy)
            self_v = math.sqrt(self.vx*self.vx + self.vy*self.vy)
            vx = dx/d*scale
            vy = dy/d*scale
            return vx, vy
        else:
            return 0, 0
    def follow_leader(self, scale):
        leader_cur = self
        for neighbor in self.neighbors:
            if neighbor.leadership:
                leader_cur = neighbor
        vx = leader_cur.vx*scale
        vy = leader_cur.vy*scale
        return vx, vy
    def rule1(self, scale):#cohesion: toward the centre pos of neighbors
        if len(self.neighbors) == 0:
            return 0, 0
        else:
            neighbor_x = 0.0
            neighbor_y = 0.0
            for particle in self.neighbors:
                neighbor_x += particle.x
                neighbor_y += particle.y
            if len(self.neighbors) > 0:
                neighbor_x /= len(self.neighbors)
                neighbor_y /= len(self.neighbors)
            vx = (neighbor_x - self.x)/50.0*scale
            vy = (neighbor_y - self.y)/50.0*scale
            return vx, vy
    def rule2(self, bump_scale, disperse_scale):#separation: avoid collision
        vx = 0.0
        vy = 0.0
        n = 0
        for particle in particle_list:
            if particle is not self:
                dx = particle.x - self.x
                dy = particle.y - self.y
                r = (self.width + self.height + particle.width + particle.height)/4
                if math.sqrt(dx*dx + dy*dy) < r*disperse_scale:
                    vx -= particle.x - self.x
                    vy -= particle.y - self.y
                    n += 1
        if n > 0:
            vx = vx/n*bump_scale
            vy = vy/n*bump_scale
        return vx, vy
    def rule3(self, scale):#alignment: try to match velocity of neightbors
        if len(self.neighbors) == 0:
            return 0, 0
        else:
            neighbor_vx = 0.0
            neighbor_vy = 0.0
            for particle in self.neighbors:
                neighbor_vx += particle.vx
                neighbor_vy += particle.vy
            if len(self.neighbors) > 0:
                neighbor_vx /= len(self.neighbors)
                neighbor_vy /= len(self.neighbors)
            vx = (neighbor_vx - self.vx)/5.0*scale
            vy = (neighbor_vy - self.vy)/5.0*scale
            return vx, vy
    def update_speed(self, v):
        self.vx += v[0]
        self.vy += v[1]
        #v = math.sqrt(self.vx*self.vx + self.vy*self.vy)
        #self.vx *= self.initial_v/v
        #self.vy *= self.initial_v/v
    def limit_speed(self):
        v = math.sqrt(self.vx*self.vx + self.vy*self.vy)
        if v > max_v:
            self.vx *= max_v/v
            self.vy *= max_v/v
    def set_leader(self):
        if len(self.neighbors) > 0:
            leaders = []
            for neighbor in self.neighbors:
                if neighbor.leadership:
                    leaders.append(neighbor)
            if self.leadership:
                leaders.append(self)
            if len(leaders) == 0:
                a = random.randint(-1, len(self.neighbors)-1)
                if a == -1:
                    self.leadership = True
                else:
                    self.neighbors[a].leadership = True
            elif len(leaders) > 1:
                leader_cur = leaders[0]
                for i in range(1,len(leaders)):
                    if len(leader_cur.neighbors) <= len(leaders[i].neighbors):
                        leader_cur.leadership = False
                        leader_cur = leaders[i]
                    elif len(leader_cur.neighbors) > len(leaders[i].neighbors):
                        leaders[i].leadership = False
                    """
                    else:
                        if leader_cur.neighbor_radius <= leaders[i].neighbor_radius:
                            leader_cur.leadership = False
                            leader_cur = leaders[i]
                        elif leader_cur.neighbor_radius > leaders[i].neighbor_radius:
                            leaders[i].leadership = False
                    """
                #debug
                leaders = []
                for neighbor in self.neighbors:
                    if neighbor.leadership:
                        leaders.append(neighbor)
                if len(leaders) > 1:
                    print len(leaders)
                    print 'leaders'
            if self.leadership:
                self.icon = icon_leader
                self.width = self.icon.get_width()
                self.height = self.icon.get_height()
            else:
                self.icon = icon_particle
                self.width = self.icon.get_width()
                self.height = self.icon.get_height()
            for neighbor in self.neighbors:
                if neighbor.leadership:
                    neighbor.icon = icon_leader
                    neighbor.width = self.icon.get_width()
                    neighbor.height = self.icon.get_height()
                else:
                    neighbor.icon = icon_particle
                    neighbor.width = self.icon.get_width()
                    neighbor.height = self.icon.get_height()
        else:
            self.leadership = False
    def update_pos(self):
        new_x = self.x + self.vx
        new_y = self.y + self.vy
        if boundary_exist:
            if new_x >= window[0] - self.width/2 or new_x < self.width/2:
                self.vx *= -1
            else:
                self.x = new_x
            if new_y >= window[1] - self.height/2 or new_y < self.height/2:
                self.vy *= -1
            else:
                self.y = new_y
        else:
            if new_x >= window[0] - self.width/2:
                new_x -= window[0] - self.width
            elif new_x < self.width/2:
                new_x += window[0] - self.width
            self.x = new_x
            if new_y >= window[1] - self.height/2:
                new_y -= window[1] - self.height
            elif new_y < self.height/2:
                new_y += window[1] - self.height
            self.y = new_y
        angle = math.degrees(math.atan2(-self.vy, self.vx));
        if (angle>0 and angle<90) or (angle<0 and angle>-90):
            self.image = pygame.image.load("Mola1R.png").convert()
        if (angle>90 and angle<180) or (angle<-90 and angle>-180):
            self.image = pygame.image.load("Mola2R.png").convert()
            angle=angle-180
        self.image = pygame.transform.rotate(self.image, angle)
        global bg
        bg.blit(rotated_icon, (self.x - self.width/2, self.y - self.height/2))
    def update_neighbors(self):
        self.neighbors = []
        for particle in particle_list:
            if particle is not self:
                px = particle.x
                py = particle.y
                x1 = self.x - self.neighbor_radius
                x2 = self.x + self.neighbor_radius
                y1 = self.y - self.neighbor_radius
                y2 = self.y + self.neighbor_radius
                if x1 < px and px < x2 and y1 < py and py < y2:
                    self.neighbors.append(particle)

if __name__ ==  '__main__': main()
pygame.quit()
