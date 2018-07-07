
public boolean mouseInBalanceBox() {
  return (mouseX > 1000 && mouseY < 200);
}

public boolean mouseInGainBox() {
  return (mouseX > 100 && mouseY > 200);
}

public boolean isShortSlope() {
 return (mouseX > 100 && mouseY < 400); 
}

public float short_slope(float position) {
  return map(position, 200, 600, 0, 1) * (1/5)  * -1;
}

public float steep_slope(float position) {
  return map(position, 200, 600, 0, 1) * 2  * -1;
}
