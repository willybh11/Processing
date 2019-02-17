int px, py; // periods of the two waves
float cx, cy, x, y, theta, rx, ry, inc;
color fg, bg; 
float[][] points;

void setup() {
    size(800, 800);
    textFont(createFont("Courier", 12));
    smooth();
    ellipseMode(CENTER);
    rectMode(CENTER);
    rx = (float)(width) / 5;
    ry = (float)(height) / 5;
    cx = 1.5 * rx;
    cy = height - cx;
    theta = 0;
    inc = 0.025;
    fg = color(50,0,0);
    bg = color(0);
    points = new float[80][2];
    for (int i = 0; i < points.length; i++) {
        points[i][0] = 0;
        points[i][1] = 0;
    }
}

void draw() {
    px = (int) map(mouseX, 0, width, 1, 10);
    py = (int) map(mouseY, 0, height, 1, 10);
    theta += inc; // incremento the angle

    // compute the x and y for lissajous
    x = cos(theta * py) * rx; 
    y = sin(theta * px) * ry; 

    background(255);
    drawGrid(cx, cy, rx, ry); 
    drawGrid(cx, cy - 2 * ry, rx, ry);
    drawGrid(cx + 2 * rx, cy, rx, ry);
    drawDiag(cx, cy);

    drawSin(cx + rx, cy); 
    drawCos(cx, cy - ry); 
    lissajous(cx, cy);

    //Draw Intercepts
    pushMatrix();
    translate(cx, cy);
    stroke(255,100,0);
    line(x, y, rx, y);
    line(x, y, x, -ry);
    popMatrix();

    fill(fg);
    textSize(16);
    text("x = cos(" + px + "*t)r, y = sin(" + py + "*t)r", 2.6 * rx, 1.3*rx);
    textSize(48);
    text("Lissajous", 2.6 * rx, cx * 0.6);
}

void drawGrid(float xpos, float ypos, float rx, float ry) {
    pushMatrix();
    translate(xpos, ypos);
    noFill();
    stroke(bg, 100);
    strokeWeight(width/200);
    rect(0, 0, 2 * rx, 2 * ry);
    line(-1.1 * rx, 0, 1.1 * rx, 0);
    line(0, -1.1 * ry, 0, 1.1 * ry);
    //ellipse(0, 0, 2*r, 2*r);
    stroke(bg, 20);
    for (int i = int(-ry); i < ry; i += int(ry / 10)) {
        line(-rx, i, rx, i);
    }
    popMatrix();
}

void drawDiag(float xpos, float ypos) {
    pushMatrix();
    translate(xpos, ypos);
    noFill();
    stroke(fg);
    line(0, 0, x, y);
    fill(fg);
    ellipse(x, y, rx / 30, rx / 30); 
    popMatrix();
    strokeWeight(width/200);
}

void drawSin(float xpos, float ypos) {
    stroke(fg, 170);
    pushMatrix();
    translate(xpos, ypos);
    stroke(fg);
    noFill();
    beginShape();
    for (float i = 0; i < 2 * rx; i++) {
        y = sin(theta * px + (i / (ry / PI))) * ry;
        vertex(i, y);
    }
    endShape();
    popMatrix();
}

void drawCos(float xpos, float ypos) {
    stroke(fg, 170);
    pushMatrix();
    translate(xpos, ypos);
    stroke(fg);
    noFill();
    beginShape();
    for (float i = 0; i < 2 * ry; i++) 
        vertex(cos(theta * py + (i / (rx / PI))) * rx, i - 2 * ry);
    endShape();
    popMatrix();
}

void lissajous(float xpos, float ypos) {
    pushMatrix();
    translate(xpos, ypos);
    beginShape();
    for (float i = 0; i < TWO_PI; i += TWO_PI / 1000) {
        stroke(fg, 130);
        vertex(rx * cos(py * i), ry * sin(px * i));
    }
    endShape();
    popMatrix();
}
