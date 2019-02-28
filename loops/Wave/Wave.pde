
ArrayList<Point> points = new ArrayList<Point>();
Point priority;
int current = 0;

float dispersal = 3.5; //.5 min | 1.5 & 3.5 look good

void setup() {
  size(640, 640);

  for (float yCoord = 300; yCoord <= 600; yCoord += 50) {
    for (float delay = (-20*dispersal); delay < 64*dispersal + (20*dispersal); delay++) {
      points.add(new Point(delay, delay*20/dispersal, yCoord, 100-((yCoord-300)/3.3)));
    }
  }
  assignPriority();
}

void draw() {
  background(255);

  for (Point point : points) {
    point.Update(false);
  }
  priority.Update(true);
  //saveFrame("frames/frame" + frameCount%120 + ".jpg");
}

void keyPressed() {
  if (keyCode == UP)    current--;
  if (keyCode == DOWN)  current++;

  current = min(max(current, 0), 6);
  assignPriority();
}

void assignPriority() {
  for (Point point : points) {
    if ((point.delay == 16*dispersal) && (point.origin.y - 300 == current * 50)) {
      priority = point;
    }
  }
}
