
public void keyPressed() {
  print(round(((millis() - 3600) / 408.6)*4)/4.0);

  switch(keyCode) {
    case LEFT:
    strike(true);
    println("\tleft");
    break;
    case RIGHT:
    strike(false);
    println("\tright");
    break;
  }
}

public void strike(boolean dir) {
  for (Hit i : hits) {
    if (  (dir == i.dir) && (millis() > i.time - 100) && (millis() < i.time + 100) ) {
      i.setStruckness(true);
      return;
    }
  }
  score -= 5;
}
