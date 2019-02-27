
Wave wave = new Wave(250,400,3,10,240);
PVector[] starPositions = new PVector[50];
float alpha = 255;
int twinkleIndex = 0;
String status = "pickNew";

void setup() {
    size(640,640);
    noStroke();
    for (int i = 0; i < 50; i++) {
        starPositions[i] = new PVector(random(640),random(450));
    }
}

void draw() {
    background(0,25,80);

    switch(status) {
        case "dimming":
            alpha -= 15;
            if (alpha == 0) 
                status = "brightening";
            break;
        case "brightening":
            alpha += 15;
            if (alpha == 255)
                status = "pickNew";
            break;
        case "pickNew":
            twinkleIndex = (int)random(50);
            status = "dimming";
            break;
    }

    for (int i = 0; i < 50; i++) { // draw stars
        fill(255);
        if (i == twinkleIndex)
            fill(255,alpha);
        ellipse(starPositions[i].x,starPositions[i].y,2,2);
    }

    fill(100); // crag
    triangle(0,height,0,300,130,300);

    fill(230);  // moon
    ellipse(590,50,50,50);
    fill(200); // crater
    ellipse(585,53,18,18);

    drawLightHouse();
    wave.Update();

    for (float i = 0; i < 20; i++) {        // lightbeam --> R
        float alpha = map(i*i,0,400,50,0);
        float radius = 10 + 5*i;
        alpha -= abs(map(frameCount % 480,0,480,-60,60)) - 10;
        fill(255,255,200,alpha);
        ellipse(70 + i*i,65,radius,radius);
    }

    // saveFrame("frames/frame" + frameCount % 480 + ".png");
    // print("frame ");
    // print(frameCount % 480);
    // println(" saved");
}

void drawLightHouse() {
    for (int i = 0; i < 4; i++) { // red/white part
        if (i%2 == 0) {
            fill(200,0,0);
        } else {
            fill(200);
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

void twinkleStar() {
    
}