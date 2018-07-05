
from transitions import endTransition,resetTransition
from levels import drawLevel
import not_functions as data


ET = endTransition()
RT = resetTransition()
vel = PVector(0, 0)
pos = PVector(500, 700)

def setup():
    size(1000, 1000)
    noStroke()
    noCursor()
    textAlign(LEFT)

def draw():
    drawLevel(data.lvl, data.colors)
    move()
    collisions()
    friction()
    winCheck()
    transitions()
    drawBall()
    drawScores()
    drawButtons()
    buttonPressCheck()
    mouseAction()
    clubBoxCheck()
    drawCursor()

def clubBoxCheck():
    data.inClubBox = get(mouseX, mouseY) in [data.colors['club_tool'], data.colors['club_text']]

def mouseAction():
    if data.tool == 'club': drawClub()
    if data.tool == 'info': drawTooltip()

def drawTooltip():
    
    for c in data.colors.keys():
        if data.colors[c] == get(mouseX, mouseY):
            tooltip = data.tooltips[c]
            break

    offsetX = -200 * (mouseX + 200 > 1000)
    offsetY = - 80 * (mouseY - 80 > 0)

    try:    data.lastTooltip = tooltip
    except: tooltip = data.lastTooltip

    textSize(25)
    textAlign(CENTER)
    fill(255)
    
    rect(mouseX + offsetX, mouseY + offsetY, 200, 80, 15)
    fill(50)
    text(tooltip, mouseX + 100 + offsetX, mouseY + 30 + offsetY)



def drawButtons():
    fill(data.colors['reset'])
    rect(830, 20, 150, 150, 30)
    
    fill(data.colors['info_tool'])
    if data.tool == 'info':
        stroke(data.colors['highlight'])
        strokeWeight(4)
    rect(830, 190, 150, 150, 30)
    
    fill(data.colors['club_tool'])
    if data.tool == 'club':
        stroke(data.colors['highlight'])
        strokeWeight(4)
    else:
        noStroke()
        
    rect(830, 360, 150, 150, 30)
    noStroke()
    
    textAlign(CENTER)
        
    fill(data.colors['reset_text'])
    textSize(30)
    text("(press 'r')", 905, 130) 
    textSize(45)
    text("RESET", 905, 90)
    
    fill(data.colors['info_text'])
    text("INFO\nTOOL", 905, 250)

    fill(data.colors['club_text'])
    text("CLUB\nTOOL", 905, 420)


def drawCursor():
    fill(0)
    stroke(data.colors[data.tool + '_tool'])
    strokeWeight(3)
    ellipse(mouseX, mouseY, 10, 10)
    noStroke()

def drawScores():
    textAlign(LEFT)
    fill(data.colors['scoreBG'])
    if data.attempts[data.lvl - 1] <  10: rect(20, 20, 280, 150, 30)
    if data.attempts[data.lvl - 1] >= 10: rect(20, 20, 340, 150, 30)
    fill(data.colors['score_text'])
    output = ''.join(['#', str(data.lvl), ':', str(data.attempts[data.lvl - 1])])
    textSize(120)
    text(output, 20, 140)

    for i in range(data.lvl - 1):       # i counts backwards
        n = len(data.attempts) - 1 - i  # n counts forwards
        fill(255, 212, 36)
        if data.attempts[i] <  10: rect(20, 90 + (100 * n), 135, 80, 20)
        if data.attempts[i] >= 10: rect(20, 90 + (100 * n), 170, 80, 20)
        fill(data.colors['score_text'])
        textSize(60)
        output = ''.join(['#', str(i + 1), ':', str(data.attempts[i])])
        text(output, 20, 150 + (100 * n))


def mouseReleased():
    if not data.swung and not data.inClubBox and data.tool == 'club' and int(vel.x) == 0 and int(vel.y) == 0:
        vel.x += (pos.x - mouseX) / 15
        vel.y += (pos.y - mouseY) / 15
        data.swung = True
        data.attempts[-1] += 1

def buttonPressCheck():
    if mousePressed:
        if get(mouseX, mouseY) in [data.colors['reset'],     color(51)]: RT.ongoing = True
        if get(mouseX, mouseY) in [data.colors['info_tool'], color(52)]: data.tool = 'info'
        if get(mouseX, mouseY) in [data.colors['club_tool'], color(49)]: data.tool = 'club'

def keyPressed():
    if key == 'r': RT.ongoing = True

def transitions():

    if RT.ongoing:
        if data.swung:
            data.swung = False
            vel.x = 0
            vel.y = 0
            RT.oldPos.x = pos.x
            RT.oldPos.y = pos.y
            pos.x = -100
            pos.y = -100

        if RT.radius1 > 0:
            fill(data.colors['ball'], RT.opacity1)
            ellipse(RT.oldPos.x, RT.oldPos.y, RT.radius1, RT.radius1)

            RT.opacity1 -= 255 / 15
            RT.radius1 -= 1.4

        if RT.radius2 > 25:

            fill(data.colors['ball'], RT.opacity2)
            ellipse(500, 700, RT.radius2, RT.radius2)

            RT.opacity2 += 255 / 15
            RT.radius2 -= 100 / 15

        if RT.radius2 <= 25:
            pos.x = 500
            pos.y = 700
            RT.reset()

    if ET.ongoing:
        fill(data.colors['ball'], ET.opacity)
        ellipse(ET.oldPos.x, ET.oldPos.y, ET.radius, ET.radius)
        if ET.radius > 2000:
            if not ET.switched:
                ET.switched = True
                data.attempts.append(0)
                data.lvl += 1
                pos.x = 500
                pos.y = 700
                data.swung = False
            ET.opacity -= 5
        if ET.radius < 2000:
            ET.radius *= 1.1
        if ET.opacity <= 0:
            ET.reset()


def drawBall():
    fill(data.colors['ball'])
    ellipse(pos.x, pos.y, data.ballSize, data.ballSize)

def winCheck():
    if get(int(pos.x), int(pos.y)) == data.colors['hole']:
        ET.ongoing = True
        ET.oldPos = PVector(pos.x, pos.y)
        vel.x = 0
        vel.y = 0

def move():
    pos.add(vel)

def collisions():
    if get(int(pos.x - data.ballSize / 2), int(pos.y)) in [data.colors['obstacle'], data.colors['bg']]:
        pos.x += 5
        vel.x = abs(vel.x) * 0.6
    if get(int(pos.x + data.ballSize / 2), int(pos.y)) in [data.colors['obstacle'], data.colors['bg']]:
        pos.x -= 5
        vel.x = -abs(vel.x) * 0.6
    if get(int(pos.x), int(pos.y - data.ballSize / 2)) in [data.colors['obstacle'], data.colors['bg']]:
        pos.y += 5
        vel.y = abs(vel.y) * 0.6
    if get(int(pos.x), int(pos.y + data.ballSize / 2)) in [data.colors['obstacle'], data.colors['bg']]:
        pos.y -= 5
        vel.y = -abs(vel.y) * 0.6


def drawClub():
    if mousePressed:                                                                         # mouse must be down
        if get(mouseX, mouseY) not in [data.colors['club_tool'], data.colors['club_text']]:  # mouse must not be over club button 
            if not (get(mouseX, mouseY) in [data.colors['reset'], 51]):                      # mouse must not be over reset button
                if not data.swung:                                                           # must not have already swung
                    if int(vel.x) == 0 and int(vel.y) == 0:                                  # ball must be still
                        #if pos.x > 0:

                        for curPoint in range(1, 30):
                            target = PVector(pos.x + ((pos.x - mouseX) / (5)) * curPoint, pos.y + ((pos.y - mouseY) / (5)) * curPoint)
                            if get(int(target.x), int(target.y)) != data.colors['ball']: # else: DONT BREAK
                                if get(int(target.x), int(target.y)) not in [data.colors['obstacle'], data.colors['bg']]: # else: DO break
                                    fill(0, 80 - 4 * curPoint)
                                    ellipse(target.x, target.y, 10, 10)
                                else: break
                
                        strokeWeight(5)
                        stroke(255)
                        line(mouseX, mouseY, pos.x, pos.y)
                        noStroke()

def friction():
    if get(int(pos.x), int(pos.y)) == data.colors['lightGrass']:
        vel.mult(0.98)
    if get(int(pos.x), int(pos.y)) == data.colors['heavyGrass']:
        vel.mult(0.95)
    if get(int(pos.x), int(pos.y)) == data.colors['right']:
        vel.mult(0.98)
        vel.x += 1
    if get(int(pos.x), int(pos.y)) == data.colors['left']:
        vel.mult(0.98)
        vel.x -= 1
    if get(int(pos.x), int(pos.y)) == data.colors['up']:
        vel.mult(0.98)
        vel.y -= 1
    if get(int(pos.x), int(pos.y)) == data.colors['down']:
        vel.mult(0.98)
        vel.y += 1
