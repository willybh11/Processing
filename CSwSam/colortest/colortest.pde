color c;

void setup() {
  size(400,400);
}

void draw() {
  
  background(c);
  
  c = color(255,0,0); // red
  
  if (keyPressed) {
   c = color(0,255,0); // green
  }

}

void keyPressed() {
  //c = color(0,255,0); // green
}
