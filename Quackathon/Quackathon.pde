
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

  frame = frameCount % 600; // ten second loop
  translate(width/2, height/2);
  background(255);

  if (frame > 120) { // white circle tightens
    int subframe = frame - 120;
    float offset = max(0,pow(1.03,-(subframe-240)));

    background(0);
    fill(236, 0, 140);
    ellipse(0, 0, width+offset, height+offset);
    fill(159, 31, 99);
    ellipse(0, 0, 1200+offset, 1200+offset);
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
  
  //saveFrame("frames/frame"+ frameCount % 600 + ".png");
}
