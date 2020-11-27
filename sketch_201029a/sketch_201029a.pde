
boolean startup;
float ballx;
float bally;
float ball_size;
int ball_opacity;

void setup() {
  size(400,400);
  startup = true;
  ball_size = 60;
  ball_opacity = 0;
  ballx = 200;
  bally = 200;
  noStroke();
}

void draw() {
  background(255);
  draw_ball();
  
}

void draw_ball() {
  if (startup == true) {
    ball_size -= 0.5;
    ball_opacity += 2;
    ballx = width/2;
    bally = height/2;
    
    if (ball_size <= 10) {
      startup = false;
    }
  } 
  
  fill(255,0,0,ball_opacity);
  ellipse(ballx, bally, ball_size, ball_size);

}
