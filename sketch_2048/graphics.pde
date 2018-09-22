

public void drawGrid() {
  for (int y = 0; y < 4; y++) {
    for (int x = 0; x < 4; x++) {      
      int n = nums[y*4+x];

      fill(colors[max(0, int(log2(n)))]);
      rect(10*(x+1)+x*100, 10*(y+1)+y*100, 100, 100, 20);
      
      if (n > 0) {
        fill(0);
        text(n, 10*(x+1)+x*100+50, 10*(y+1)+y*100+65);
      }
    }
  }
}
