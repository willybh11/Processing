
from transitions import *
from levels import *

colors = {'obstacle'  : color(90,90,90),
          'lightGrass': color(36,255,96),
          'heavyGrass': color(86,157,93),
          'ball'      : color(255),
          'hole'      : color(126,107,82),
          'bg'        : color(200), }


lvl = 1
swung = False
ballSize = 25

ET = endTransition()
RT = resetTransition()
vel = PVector(0, 0)
pos = PVector(500, 700)

def setup():
    size(1000, 1000)
    noStroke()

def draw():
    background(colors['bg'])
    drawLevel(lvl,colors)
    move()
    collisions()
    friction()
    winCheck()
    transitions()
    drawBall()    
    drawClub()

def mouseReleased():
    global swung
    if not swung and int(vel.x) == 0 and int(vel.y) == 0:
        vel.x += (pos.x - mouseX) / 15
        vel.y += (pos.y - mouseY) / 15
        swung = True

def keyPressed():
    if key == 'r':
        RT.ongoing = True

def transitions():
    
    if RT.ongoing:
        global swung
        if swung:
            swung = False
            vel.x = 0
            vel.y = 0
            RT.oldPos.x = pos.x
            RT.oldPos.y = pos.y
            pos.x = -100
            pos.y = -100
        
        if RT.radius1 > 0:
            fill(colors['ball'],RT.opacity1)
            ellipse(RT.oldPos.x,RT.oldPos.y,RT.radius1,RT.radius1)
            
            RT.opacity1 -= 255/15
            RT.radius1 -= 1.4
            
        if RT.radius2 > 25:
            
            fill(colors['ball'],RT.opacity2)
            ellipse(500,700,RT.radius2,RT.radius2)
            
            RT.opacity2 += 255/15
            RT.radius2 -= 100/15
            
        if RT.radius2 <= 25:
            pos.x = 500
            pos.y = 700
            RT.reset()
        
    
    if ET.ongoing:
        fill(colors['ball'],ET.opacity)
        ellipse(ET.oldPos.x,ET.oldPos.y,ET.radius,ET.radius)
        if ET.radius > 2000:
            if not ET.switched:
                ET.switched = True
                global lvl
                lvl += 1
                pos.x = 500
                pos.y = 700
                swung = False
            ET.opacity -= 5
        if ET.radius < 2000:
            ET.radius *= 1.1
        if ET.opacity <= 0:
            ET.reset()

        
def drawBall():
    fill(colors['ball'])
    ellipse(pos.x, pos.y, ballSize, ballSize)

def winCheck():
    if get(int(pos.x), int(pos.y)) == colors['hole']:
        ET.ongoing = True
        ET.oldPos = PVector(pos.x,pos.y)
        vel.x = 0
        vel.y = 0

def move():
    pos.x += vel.x
    pos.y += vel.y

def collisions():
    if get(int(pos.x - 13), int(pos.y)) in [colors['obstacle'], colors['bg']]:
        pos.x += 5
        vel.x = -vel.x*0.6
    if get(int(pos.x + 13), int(pos.y)) in [colors['obstacle'], colors['bg']]:
        pos.x -= 5
        vel.x = -vel.x*0.6
    if get(int(pos.x), int(pos.y - 13)) in [colors['obstacle'], colors['bg']]:
        pos.y += 5
        vel.y = -vel.y*0.6
    if get(int(pos.x), int(pos.y + 13)) in [colors['obstacle'], colors['bg']]:
        pos.y -= 5
        vel.y = -vel.y*0.6

def drawClub():
    if mousePressed and not swung and int(vel.x) == 0 and int(vel.y) == 0:
                
        for curPoint in range(1,30):
            target = PVector(pos.x+((pos.x-mouseX)/(5))*curPoint,pos.y+((pos.y-mouseY)/(5))*curPoint)
            if get(int(target.x),int(target.y)) not in [colors['obstacle'],colors['bg'],colors['ball']]:
                fill(0,80-4*curPoint)
                ellipse(target.x,target.y,10,10)
        
        strokeWeight(5)
        stroke(255)
        line(mouseX, mouseY, pos.x, pos.y)
        noStroke()

def friction():
    if get(int(pos.x), int(pos.y)) == colors['lightGrass']:
        vel.x *= 0.98
        vel.y *= 0.98
    if get(int(pos.x), int(pos.y)) == colors['heavyGrass']:
        vel.x *= 0.95
        vel.y *= 0.95
