
public int getHeight(FFT fft, int min, int max) {
  int n = 0;
  for (float i = min; i < max; i++) {
    n += fft.getFreq(i);
  }
  n = max(0, 400-n/80);
  return(n);
}

public int diff(int a, int b) {
  if (a > b)
    return a-b;
  if (b > a)
    return b-a;
  else
    return 0;
}
