
import ddf.minim.*;
import ddf.minim.ugens.*;

Oscil wave;
PImage hand;
PImage clap;
short num;
short timer;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
boolean connected1;
boolean connected2;

void setup() {
  size(600, 600);
  textAlign(CENTER);
  noStroke();
  timer = 840; // in frames (15 sec, 3 for start, 11 for time)
  hand  = loadImage("data/hand.jpg");
  clap  = loadImage("data/clap.jpg");

  wave  = new Oscil(0, 0.5f, Waves.SQUARE);
  wave.patch(new Minim(this).getLineOut());
}

void draw() {
  background(255);
  if (timer > 0) timer --;

  if (timer/60 > 10) { // countdown
    textSize(500);
    fill(0);
    text(timer/60 - 10, 300, 460);
  } else if (timer/60 <= 10 && timer > 0) { // main section
    textSize(100);
    fill(200);
    rect(100, 40, 400, 150, 30);

    if (connected()) image(clap, 100, 200);
    else           image(hand, 100, 200);

    if (timer/60 <= 3) fill(255, 0, 0); 
    else fill(0); 
    text(timer/60, 200, 150); 

    fill(0);
    text('|', 300, 150);
    text(num, 400, 150);
  } 
  if (timer == 0) { // end score
    wave.setFrequency(0);
    textSize(400);
    text(num, 300, 450);
  }
}

boolean connected() {
  return (connected1 && connected2);
}

boolean onTime() {
  return (timer > 0 && timer/60 < 11);
}

void keyPressed() {
  if (key == ' ' && !connected() && onTime()) connected1 = true;
  if (key == 'w' && !connected() && onTime()) connected2 = true; 
  if (connected()) {
    num++;
    wave.setFrequency(50*num);
  }
}

void keyReleased() {
  if (key == ' ') connected1 = false;
  if (key == 'w') connected2 = false;
}
