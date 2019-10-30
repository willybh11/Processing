
// Constants
int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2;


void setup() {
    size(1920,1080);

    b1 = color(255);
    b2 = color(0);
    c1 = color(204,102,0);
    c2 = color(0,102,153);

    noLoop();
}

void draw() {
    // background(0);
    setGradient(0, 0, width, height/2, color(21,82,74), color(115,115,115), Y_AXIS);
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis) {

    noFill();

    if (axis == Y_AXIS) { // Top to bottom gradient
        for (int i = y; i <= y+h; i++) {
            float inter = map(i, y, y+h, 0, 1);
            color c = lerpColor(c1, c2, inter);
            stroke(c);
            line(x, i, x+w, i);
        }
    }

    else if (axis == X_AXIS) { // Left to right gradient
        for (int i = x; i < x+w; i++) {
            float inter = map(i, x, x+w, 0, 1);
            color c = lerpColor(c1, c2, inter);
            stroke(c);
            line(i, y, i, y+h);
        }
    }
}

void keyPressed() {
    if (key == CODED) {

    } else {
        switch(key) {
            case 'q':
            case 'Q':
                exit();
        }
    }
}