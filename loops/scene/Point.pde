public class Point {

  public float delay;
  public PVector origin;
  private float theta;
  private float radius;
  private float speed;  // frames per loop
  private color col;

  public Point(float newDelay, float x, float y, float newRadius, float newSpeed) {
    delay = newDelay;
    origin = new PVector(x,y);
    radius = newRadius;
    speed = newSpeed;
      if (random(100) <= 2) {
        col = color(0,50,150);
      } else {
        col = color(0,50,130);
      }
  }

  void Update() {
    theta = (2*PI) * (((frameCount + delay) % speed) / speed);

    fill(col);
    ellipse(radius*sin(theta) + origin.x, radius*cos(theta) + origin.y, 15, 15);
  }
}
