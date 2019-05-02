
public class Hit {
  float time;
  float beatLength;
  boolean dir; // left: true
  boolean struck;
  int offset;

  public Hit(float beats, boolean direction) {
    dir = direction;
    struck = false;
    offset = 3500;
    beatLength = 408.16; // bpm : 147
    time = offset + beatLength * beats;
  }
  
  void setStruckness(boolean struckness) {
    if (struckness) {
     struck = struckness;
     score += 10;
     lastIncrease = millis();
     circles.add(new Explosion(dir));
    }
  }
}