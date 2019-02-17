//2048

int[] nums = new int[16];
int[] colors = new int[]{ color(255), 
                          color(255, 255, 75), 
                          color(75, 255, 100), 
                          color(255, 200, 75),
                          color(255,77,175),
                          color(171,77,255),
                          color(77,277,255),
                          color(147,255,54),
                          color(255,54,68),
                          color(255,141,54)};

void setup() {
  size(450, 450);
  noStroke();
  textAlign(CENTER);
  textSize(40);

  //make starting grid
  int start1 = int(random(0,16));
  int start2 = start1;
  while(start2 == start1) {
   start2 = int(random(0,16)); 
  }
  for (int i = 0; i < 16; i++) {
    if (i == start1 || i == start2) {
     nums[i] = 2;
     continue;
    }
    nums[i] = 0;
  }
}

void draw() {
  background(200);
  
  drawGrid();
  
}

float log2(int n) {
  return log(n) / log(2);
}
