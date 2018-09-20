
final static int speed = 2; // seconds per loop

void setup() {
  size(400, 400);
  noStroke();
}

void draw() {   
  translate(200, 200);

  for (int i = 0; i < 12; i++) { // background
    fill(240-20*i); //change 20 to 100 for wacky yellow (why is this?)
    ellipse(0, 0, 540-40*i, 540-40*i);
  }  
  for (int d = 270; d >= 10; d -= 20) { // circle of circles
    rotate(radians(frameCount % (speed * 60) * 90/(speed * 60)));
    fill(min(270-d, 255)); // this can be easily modified for rgb
    for (int i = -1; i < 2; i += 2) {   // individual circles
      ellipse(0, d*i, d/1.5, d/1.5);
      ellipse(d*i, 0, d/1.5, d/1.5);
    }
  }
}
