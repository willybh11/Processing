// public void drawEQ() {
//   fft.forward(player.mix);

//   float w = 350/8.0;
//   int h;
//   String output = "";
//   stroke(0,255,0);
//   fill(50, 110, 40);
//   for (int i = 0; i < 8; i++) {
//     h = max(min(getHeight(fft, bigNums[i], bigNums[i+1])-50, 300), 50);
//     output += str(int(map(h, 300, 50, -1, 8)));
//     rect(0+w*i, h, w, 300-h);
//   }

//   w = 350/16.0;
//   fill(100, 255, 100);
//   noStroke();
//   for (int i = 0; i < 16; i++) {
//     h = getHeight(fft, smallNums[i], smallNums[i+1]);
//     rect(0+w*i, h, w, 300-h);
//   }
// }

// public int getHeight(FFT fft, int min, int max) {
//   int n = 0;
//   for (float i = min; i < max; i++) {
//     n += fft.getFreq(i);
//   }
//   n = max(50, 300-n/80);
//   return(n);
// }
