public class Point {

  public float delay;
  public PVector origin;
  private PVector pos;
  private float theta;
  private float radius;

  public Point(float newDelay, float x, float y, float newRadius) {
    delay = newDelay;
    origin = new PVector(x,y);
    radius = newRadius;
  }

  void Update() {
    theta = (2*PI) * (((frameCount + delay) % 180) / 180);
    pos = new PVector(radius*cos(theta), radius*sin(theta));

    pushMatrix();
    translate(origin.x, origin.y);
    fill(0, 50, 150);
    noStroke();
    ellipse(pos.y, pos.x, 15, 15);
    popMatrix();
  }
}
