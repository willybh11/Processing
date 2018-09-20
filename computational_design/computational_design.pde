
Line L = new Line(500,500);
int lastX = 500;

void setup() {
  size(1000,1000);
}

void draw() {
  
  L.steps += mouseX-lastX;
  L.move();
  
  lastX = mouseX;
}
