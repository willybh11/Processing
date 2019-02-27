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
      if (random(100) < 2) {
        col = color(0,50,150);
      } else {
        col = color(10,50,130);
      }
    // col = color(random(10),50,150 - random(20));
  }

  void Update() {
    theta = (2*PI) * (((frameCount + delay) % speed) / speed);

    pushMatrix();
    translate(origin.x, origin.y);
    fill(col);
    ellipse(radius*sin(theta), radius*cos(theta), 15, 15);
    popMatrix();
  }
}
