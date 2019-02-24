
Wave wave = new Wave(0,400,1.5,10);
PVector[] starPositions = new PVector[50];

void setup() {
    size(640,640);
    for (int i = 0; i < 50; i++) {
        starPositions[i] = new PVector(random(640),random(450));
    }
}

void draw() {
    background(0,25,80);

    fill(255);
    for (PVector pos : starPositions) { // stars
        ellipse(pos.x,pos.y,2,2);
    }

    fill(100); // cliff face
    triangle(0,height,0,300,130,300);

    fill(230);  // moon
    ellipse(590,50,50,50);

    fill(200); // crater
    ellipse(585,53,18,18);

    drawLightHouse();
    wave.Update();

    float x;
    for (float i = 0; i < 20; i++) {        // light
        float alpha = map(i*i,0,400,50,0);
        if (abs(map(frameCount % 480,0,480,-50,50)) > 10) {
            alpha -= abs(map(frameCount % 480,0,480,-50,50)) - 10;
        }
        if (frameCount % 960 < 480) {
            x = 70 + i*i;
        } else {
            x = 70 - i*i;
        }
        float radius = 10+5*i;
        fill(255,255,200,alpha);
        ellipse(x,65,radius,radius);
    }
}

void drawLightHouse() {
    for (int i = 0; i < 4; i++) { // red/white part
        if (i%2 == 0) {
            fill(255,0,0);
        } else {
            fill(255);
        }
        beginShape();
        int bottom = 300-50*i;
        int top = 300-50*(i+1);
        vertex(15+4*i,bottom);
        vertex(15+4*(i+1),top);
        vertex(115-4*(i+1),top);
        vertex(115-4*i,bottom);
        endShape();
    }

    fill(140,190,200);  // glass
    rect(40,45,50,40);

    fill(80);           // floor
    beginShape();
    vertex(30,100);
    vertex(25,85);
    vertex(105,85);
    vertex(100,100);
    endShape();

    fill(120);          // railing
    rect(30,70,5,15);
    rect(95,70,5,15);
    rect(63,70,5,15);
    rect(30,70,70,3);

    fill(80);           // roof
    rect(30,35,70,10);
    triangle(35,35,95,35,65,20);
}