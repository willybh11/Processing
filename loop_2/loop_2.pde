
float angle1;
PVector origin = new PVector(400, 0);

String state = "down";

void setup() {
  size(400, 400);
  noStroke();
}

void draw() {
  background(255);

  for (int i = 350; i >= 50; i -= 50) {    

    fill(100); 
    rect(i, 400-i, 50, i);
  }
  translate(origin.x, origin.y);

  if (state == "down") {
    if (frameCount % 60 <= 30) {
      angle1 = -radians(frameCount % 60 * 6 + 90);
    } else if (frameCount % 60 == 59) {
      origin.add(new PVector(-50, 50));
      if (origin.x == 0) {
        state = "up";
        origin.x += 50;
      }
    }
  } else if (state == "up") {
    if (frameCount % 60 <= 30) {
      angle1 = -radians(frameCount % 60 * 6 - 90);
    } else if (frameCount % 60 == 59 || frameCount % 120 == 89) {
      origin.add(new PVector(+50, -50));
      if (origin.x == 400) {
        state = "down";
        origin.x -= 50;
      }
    }
  }
  rotate(angle1);
  fill(255, 0, 0);
  rect(0, 0, 50, 50);
}
