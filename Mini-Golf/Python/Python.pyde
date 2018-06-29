
obstacle   = color(90, 90, 90)
lightGrass = color(36, 255, 96)
heavyGrass = color(86, 157, 93)
ballColor  = color(255)
holeColor  = color(126, 107, 82)
bg         = color(200)

lvl = 1
swung = False
holeBallSize = 35
ballSize = 25

vel = PVector(0, 0)
pos = PVector(500, 700)

def setup():
    size(1000, 1000)
    noStroke()

def draw():
    background(bg)
    drawLevel(lvl)
    move()
    collisions()
    friction()
    winCheck()
    drawBall()    
    drawClub()

def mouseReleased():
    global swung
    if not swung and int(vel.x) == 0 and int(vel.y) == 0:
        vel.x += (pos.x - mouseX) / 20
        vel.y += (pos.y - mouseY) / 20
        swung = True

def keyPressed():
    if key == 'r':
        reset()

def drawBall():
    fill(ballColor)
    ellipse(pos.x, pos.y, ballSize, ballSize)

def winCheck():
    if get(int(pos.x), int(pos.y)) == holeColor:
        global lvl
        reset()
        lvl += 1

def reset():
    global swung
    swung = False
    vel.x = 0
    vel.y = 0
    pos.x = 500
    pos.y = 700

def move():
    pos.x += vel.x
    pos.y += vel.y

def collisions():
    if get(int(pos.x - 13), int(pos.y)) in [obstacle, bg]:
        pos.x += 5
        vel.x = -vel.x
        vel.x *= 0.6
    if get(int(pos.x + 13), int(pos.y)) in [obstacle, bg]:
        pos.x -= 5
        vel.x = -vel.x
        vel.x *= 0.6
    if get(int(pos.x), int(pos.y - 13)) in [obstacle, bg]:
        pos.y += 5
        vel.y = -vel.y
        vel.x *= 0.6
    if get(int(pos.x), int(pos.y + 13)) in [obstacle, bg]:
        pos.y -= 5
        vel.y = -vel.y
        vel.x *= 0.6

def drawClub():
    if mousePressed and not swung and int(vel.x) == 0 and int(vel.y) == 0:
                
        for curPoint in range(1,30):
            target = PVector(pos.x+((pos.x-mouseX)/(5))*curPoint,pos.y+((pos.y-mouseY)/(5))*curPoint)
            if get(int(target.x),int(target.y)) not in [obstacle,bg,ballColor]:
                fill(0,80-4*curPoint)
                ellipse(target.x,target.y,10,10)
        
        strokeWeight(5)
        stroke(255)
        line(mouseX, mouseY, pos.x, pos.y)
        noStroke()

def friction():
    if get(int(pos.x), int(pos.y)) == lightGrass:
        vel.x *= 0.98
        vel.y *= 0.98
    if get(int(pos.x), int(pos.y)) == heavyGrass:
        vel.x *= 0.95
        vel.y *= 0.95

def drawLevel(level):
    if level == 1:
        fill(obstacle)
        rect(390, 240, 220, 520)
        fill(lightGrass)
        rect(400, 250, 200, 500)
        fill(holeColor)
        ellipse(500, 300, 35, 35)
    elif level == 2:
        fill(obstacle)
        rect(240, 190, 520, 620)
        fill(lightGrass)
        rect(250, 200, 500, 600)
        fill(obstacle)
        rect(400, 450, 200, 100, 10)
        fill(holeColor)
        ellipse(500, 300, 35, 35)
    elif level == 3:
        fill(obstacle)
        rect(390, 240, 220, 520)
        fill(lightGrass)
        rect(400, 250, 200, 500)
        fill(heavyGrass)
        rect(400, 350, 200, 200)
        fill(holeColor)
        ellipse(500, 300, 35, 35)
        
