
PVector pos = new PVector(0,0);

void setup() {
  size(500,500);
}

void draw() {
  int radius = 60;
  background(255);
  
  if (mousePressed && abs(mouseX - pos.x) < radius && abs(mouseY - pos.y) < radius) {
   pos.x = mouseX;
   pos.y = mouseY;
  }
  
  fill(0);
  ellipse(pos.x,pos.y,radius,radius);
  
}
