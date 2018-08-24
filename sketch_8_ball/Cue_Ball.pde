
public class CueBall {
  PVector pos = new PVector(348,350);
  PVector vel = new PVector(0,0);
  color myColor = color(230,230,210);
  int size = 25;
  
  void drawMe() {
    fill(myColor);
    ellipse(pos.x,pos.y,size,size);
  }
  
  void moveMe() {
   pos.add(vel);
   vel.mult(0.98);
  }
}
