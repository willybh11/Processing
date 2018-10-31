//I wish i made this, found it online

void setup() {
  size(640, 640);
  noStroke();
}

void draw() {
  background(1, 26, 38);
  translate(width/2, height/2);
  scale(1.5);
  fill(130+sin(radians(frameCount))*90, 161, 191-sin(radians(frameCount))*191);
  for (int q = 0; q < 360; q+=90) {
    pushMatrix();
    translate(sin(radians(q+45))*25, cos(radians(q+45))*25);
    rotate(radians(-q-45));
    beginShape();
    for (int i = 0; i < 360; i+=3) {
      float angle = 100+cos(radians(frameCount))*20;
      float x = pow(sin(radians(i)), 6+sin(radians(frameCount))*5)*-cos(radians(i))*angle;
      float y = cos(radians(i))*cos(radians(i))*angle;
      vertex(x, y);
    }
    endShape();
    popMatrix();
  }
}
