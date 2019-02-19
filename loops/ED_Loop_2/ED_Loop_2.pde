
ArrayList<Point> points = new ArrayList<Point>();
Point priority;
int current = 0;

float dispersal = 1; //1 is original, .5 min, 10 max. 3.5 looks good

void setup() {
  size(640, 640);

  for (float i = 0; i <= 300; i += 50) {
    for (float j = (-20*dispersal); j < 64*dispersal + (20*dispersal); j++) {
      points.add(new Point(j, new PVector(j*20/dispersal, 300+i), 100-(i/3.3)));
    }
  }
  assignPriority();
}

void draw() {
  background(255);

  for (int i = 0; i < points.size(); i++) {
    points.get(i).Update("no path");
  }
  priority.Update("path");
  //saveFrame("frames/frame" + frameCount%120 + ".jpg");
}

void keyPressed() {
  if (keyCode == UP)    current--;
  if (keyCode == DOWN)  current++;

  current = min(max(current, 0), 6);
  assignPriority();
}

void assignPriority() {
  for (int i = 0; i < points.size(); i++) {
    if ((points.get(i).delay == 16*dispersal) && (points.get(i).origin.y - 300 == current * 50)) {
      priority = points.get(i);
    }
  }
}
