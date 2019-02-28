
int frame;
float rectPos1 = 0;
float rectPos2 = 0;

float bigSize = 540;

PVector coords[] = {
  new PVector(135, 135), 
  new PVector(135, 505), 
  new PVector(505, 135), 
  new PVector(505, 505)};

void setup() {
  size(640, 640);
  rectMode(CENTER);
  noStroke();
}

void draw() {
  background(0);
  frame = frameCount % 150;

  if (frame == 149) {
    rectPos1 = 0;
    rectPos2 = 0;
    coords[0] = new PVector(135, 135);
    coords[1] = new PVector(135, 505);
    coords[2] = new PVector(505, 135);
    coords[3] = new PVector(505, 505);
    bigSize = 540;
  }

  fill(255);
  rect(640, height/2, -rectPos1, 100);
  rect(width/2, 640, 100, -rectPos2);

  if (frame < 30) {
    rectPos1 += 2*640./30;
  } else if (frame < 60) {
    rectPos2 += 2*640./30;
  } else if (frame < 90) {
    background(255);
    for (int i = 0; i < 4; i++) {
      pushMatrix();
      fill(0);
      translate(coords[i].x, coords[i].y);
      rotate(radians(frame%30 * 90/30));
      rect(0, 0, 270, 270);
      popMatrix();
    }
    fill(255);
  } else if (frame < 120) {
    background(255);
    coords[0].x += (50./30);
    coords[0].y += (50./30);
    coords[1].x += (50./30);
    coords[1].y -= (50./30);
    coords[2].x -= (50./30);
    coords[2].y += (50./30);
    coords[3].x -= (50./30);
    coords[3].y -= (50./30);
    fill(0);
    for (int i = 0; i < 4; i++) {
      pushMatrix();
      translate(coords[i].x, coords[i].y);
      rect(0, 0, 270, 270);
      popMatrix();
    }
  } else if (frame < 149) {
    background(255);
    bigSize += 100/30;
    pushMatrix();
    translate(width/2, height/2);
    fill(0);
    rect(0, 0, bigSize, bigSize);
    popMatrix();
  }
  
  // saveFrame("frames/frame" + frame + ".jpg");
}
