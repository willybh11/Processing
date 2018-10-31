int counter;


void setup() {
  size(600, 600);
  counter = 500;
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  rectMode(CENTER);
  counter += 5;
  fill(255);
  rect(0, 0, counter%500, counter%500);
  fill(0);
  rect(0,0,
  println(counter%500, counter%400);
  popMatrix();
}
