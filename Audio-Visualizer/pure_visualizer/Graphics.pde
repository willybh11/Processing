
public void waveform(AudioInput in) {
  stroke(255);
  for (int i = 0; i < in.bufferSize() - 1; i++) {
    float x1 = map(i+0, 0, in.bufferSize(), 0, 1024); 
    float x2 = map(i+1, 0, in.bufferSize(), 0, 1024);
    line(x1, 50 +in.left .get(i)*50, x2, 50+in.left .get(i+1)*50);
    line(x1, 150+in.right.get(i)*50, x2, 150+in.right.get(i+1)*50);
  }
}

public void equalizer(FFT fft, AudioInput in) {
  fft.forward(in.mix);

  for (int i = 0; i < fft.specSize(); i++) {
    float h = fft.getBand(i);
    float x = 100 + 2*i;
    stroke(50);
    line(x, height, x, height - min(600, h*10));
    stroke(100);
    line(x, height, x, height - min(600, h*8));
    stroke(255);
    line(x, height, x, height - min(600, h*4));
  }
}

public void levels(AudioInput in) {
  noStroke();

  for (int i = 0; i < 10; i++) {
    if (i < 5) {
      fill(70, 255, 100, 50);
    } else if (i < 9) {
      fill(255, 255, 70, 50);
    } else {
      fill(255, 0, 0, 50);
    }
    rect(10, height-40 - (39*i), 30, 28);
    rect(60, height-40 - (39*i), 30, 28);
  }

  int num_L = round(in.left .level() * 10 * 1.2);
  int num_R = round(in.right.level() * 10 * 1.2);

  for (int i = 0; i < num_L; i++) {
    if (i < 5) {
      fill(70, 255, 100);
    } else if (i < 9) {
      fill(255, 255, 70);
    } else {
      fill(255, 0, 0);
    }
    rect(10, height-40 - (39*i), 30, 28);
  }


  for (int i = 0; i < num_R; i++) {
    if (i < 5) {
      fill(70, 255, 100);
    } else if (i < 9) {
      fill(255, 255, 70);
    } else {
      fill(255, 0, 0);
    }
    rect(60, height-40 - (39*i), 30, 28);
  }
  stroke(0, 255, 0);
}
