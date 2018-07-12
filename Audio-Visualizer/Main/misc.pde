
public boolean mouseInBalanceBox() {
  return (mouseX > 1000 && mouseY < 200);
}

public boolean mouseInGainBox() {
  return (mouseX > 1000 && mouseY > 200);
}

public float getHeight(FFT fft, int min, int max) {
  float n = 0.0;
  for (float i = min; i < max; i++) {
    n += fft.getFreq(i);
  }
  n = max(200,600-n/80);
  return(n);
}
