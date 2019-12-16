
int frame;
PImage logo;
PImage leftArrow;
PImage rightArrow;

void setup() {
  size(1400, 1400);
  imageMode(CENTER);
  noStroke();

  logo = loadImage("logo.png");
  leftArrow = loadImage("leftArrow.png");
  rightArrow = loadImage("rightArrow.png");
}

void draw() {

  frame = frameCount % 900; // twenty second loop
  translate(width/2, height/2);
  background(255);

  if (frame > 120) { // white circle tightens
    int subframe = frame - 120;
    float offset = max(0, pow(1.03, -(subframe-240)));
    float miniOffset = 25*sin(map(frame % 180, 0, 180, 0, 2*PI));

    background(0);
    fill(236, 0, 140);
    ellipse(0, 0, width+offset, height+offset);
    fill(159, 31, 99);
    ellipse(0, 0, 1200+offset+miniOffset, 1200+offset+miniOffset);
    fill(255);
    ellipse(0, 0, 1000+offset, 1000+offset);
  }

  image(logo, 0, 0);

  if (frame < 120) { // arrows slide away
    int subframe = frame - 60;
    float pos;
    if (frame < 60) {
      pos = 0;
    } else {
      pos = 0.01*subframe*subframe*subframe;
    }


    fill(255);
    rect(pos, -height/2, width/2-pos, height);
    rect(-width/2, -height/2, width/2 - pos, height);

    image(leftArrow, -leftArrow.width/2 - pos, 0);
    image(rightArrow, leftArrow.width/2 + pos, 0);
  }

  if (frame > 845) { // arrows slide back in
    int subframe = frame - 845; // yes, this is negative
    float pos = width/2 - 0.005*subframe*subframe*subframe;//0.01*pow(subframe,-3);
    pos = min(width/2 + leftArrow.width/2, pos);

    fill(255);
    rect(pos, -height/2, width/2-pos, height);
    rect(-width/2, -height/2, width/2 - pos, height);

    image(rightArrow, -leftArrow.width/2 - pos, 0);
    image(leftArrow, leftArrow.width/2 + pos, 0);
  }

  if (frame > 824) {
    saveFrame("frames/frame"+ frameCount % 900 + ".png");
  }
}
