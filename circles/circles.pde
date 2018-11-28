
int size = 50;
int offset;

void setup() {
  size(400, 400);
  noStroke();
}

void draw() {

  if (frameCount%120 < 60) {
    background(0);
    fill(255);
    offset = 0;
  } else {
    background(255);
    fill(0);
    offset = 25;
  }

  //size = frameCount%60 + 5;

  for (int x = 0; x < 9; x++) {
    for (int y = 0; y < 9; y++) {

      size = (frameCount+x+y)%60 + 5;


      ellipse(x*50+offset, y*50+offset, size, size);
    }
  }
}
