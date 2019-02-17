public class Point {

  public float delay;
  public PVector origin;
  public boolean path;
  private PVector pos;
  private float theta;
  private float radius;

  public Point(float newDelay, PVector newOrigin, float newRadius) {
    delay = newDelay;
    origin = newOrigin;
    radius = newRadius;
  }

  void Update(String p) {
    theta = (2*PI) * (((frameCount + delay) % 120.) / 120);
    pos = new PVector(radius*cos(theta), radius*sin(theta));
    path = p == "path";

    pushMatrix();
    translate(origin.x, origin.y);

    if (path) {
      noFill();
      stroke(255, 0, 0, 50);
      strokeWeight(15);
      ellipse(0, 0, 2*radius, 2*radius);
      fill(255, 0, 0);
    } else {
      fill(0, 0, 255);
    }
    noStroke();
    ellipse(pos.y, pos.x, 15, 15);
    popMatrix();
  }
}
