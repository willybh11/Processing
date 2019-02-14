
public class Planet {

  private float step;
  private float theta;
  private float DPR;
  private int size;
  private int radius;
  private int orbitDiameter;
  private color Color;
  public PVector origin;

  public Planet(float daysPerRevolution, int newRadius, int newSize, int newColor) {
    DPR = daysPerRevolution;
    radius = newRadius; // orbital distance (not to scale)
    size = newSize; // thousands of miles * 4
    Color = newColor;
    orbitDiameter = 2*radius;

    step = (2*PI) / (DPR * 60) * (365. / 10);
    theta = 0;
    origin = new PVector(0,0);
  }

  public void Update() {
    theta += step;
    theta %= 2*PI;
    
    noFill();
    stroke(150);
    ellipse(origin.x, origin.y, orbitDiameter, orbitDiameter);

    PVector pos = pointOnCircle();

    noStroke();
    fill(Color);
    ellipse(pos.x, pos.y, size, size); // diameter = thousands of miles * 4
  }

  public PVector pointOnCircle() {
    return (new PVector(origin.x + radius * cos(theta), origin.y + radius * sin(theta)));
  }
}
