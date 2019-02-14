
int stage = 0;
int startTime;
int time;

void setup() {
  size(640, 640);
  noStroke();
  rectMode(CENTER);
  startTime = frameCount;
}

void draw() {
  background(50);
  switch(stage) {
  case 0:
    startTime = frameCount;
    stage = 1;
  case 1:
    stage_1();
  }
}

void stage_1() {
  time = frameCount - startTime;
  translate(width/2, height/2);
  
  if (time >= 120) {
    stage++;
    startTime = frameCount;
  } else if (time < 30) {
    rect(0, 0, 500, 500);
  } else if (time >= 30) {
    float size = map(time, 30, 120, 500, 160);
    rect(0, 0, size, size);
    
    rect(-160,-160,160,160);
    rect(-160,160,160,160);
    rect(160,160,160,160);
    rect(160,-160,160,160);
  }
}
