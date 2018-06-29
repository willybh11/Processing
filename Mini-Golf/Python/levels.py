
def drawLevel(level,colors):
    if level == 1:
        fill(colors['obstacle'])
        rect(390, 240, 220, 520)
        fill(colors['lightGrass'])
        rect(400, 250, 200, 500)
        fill(colors['hole'])
        ellipse(500, 300, 35, 35)
    elif level == 2:
        fill(colors['obstacle'])
        rect(240, 190, 520, 620)
        fill(colors['lightGrass'])
        rect(250, 200, 500, 600)
        fill(colors['obstacle'])
        rect(400, 450, 200, 100, 10)
        fill(colors['hole'])
        ellipse(500, 300, 35, 35)
    elif level == 3:
        fill(colors['obstacle'])
        rect(390, 240, 220, 520)
        fill(colors['lightGrass'])
        rect(400, 250, 200, 500)
        fill(colors['heavyGrass'])
        rect(400, 350, 200, 300)
        fill(colors['hole'])
        ellipse(500, 300, 35, 35)
        
