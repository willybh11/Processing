
color fabric = color(76, 157, 86);
color wood   = color(103, 78, 12);
color pocket = color(60, 60, 60);
color gold = color(255, 231, 8);
color silver = color(210, 210, 210);
color line = color(80, 130, 95);

int line_X = 362;

boolean stroke = false;

CueBall Cue = new CueBall();

void setup() {
  size(1400, 700);
  noStroke();
}

void draw() {
  drawTable();
  //println(mouseX, mouseY);
  Cue.drawMe();
  Cue.moveMe();
  if (mousePressed) {
    PVector newVel = vec(new PVector(mouseX, mouseY), Cue.pos).div(20);
    drawCue(newVel);
  }
}

void mousePressed() {
}

void mouseReleased() {
  PVector newVel = vec(new PVector(mouseX, mouseY), Cue.pos).div(20);
  Cue.vel = newVel;
}

void drawCue(PVector newVel) {
  stroke(50, 50, 50);
  strokeWeight(8);
  PVector tip = new PVector(Cue.pos.x-newVel.x*5, Cue.pos.y-newVel.y*5);
  line(tip.x, tip.y, mouseX, mouseY);
  noStroke();
}

void drawTable() {
  background(0);

  fill(wood);
  rect(0, 0, 1400, 700, 45);

  fill(fabric);
  rect(50, 50, 1300, 600);

  quad(60, 30, 30, 60, 50, 80, 80, 50);              //tl
  quad(20, 650, 50, 620, 80, 650, 50, 680);          //bl
  quad(1350, 20, 1380, 50, 1350, 80, 1320, 50);      //tr
  quad(1350, 620, 1380, 650, 1350, 680, 1320, 650);  //br

  fill(gold);
  rect(0, 0, 50, 50);          //tl
  rect(0, 650, 50, 50);        //bl
  rect(1350, 0, 50, 50);       //tr
  rect(1350, 650, 50, 50);     //br
  rect(675, 0, 50, 50);        //tm
  rect(675, 650, 50, 50);      //bm

  quad(0, 30, 30, 0, 60, 30, 30, 60);               //tl
  quad(0, 670, 30, 700, 65, 665, 30, 640);          //bl
  quad(1370, 0, 1400, 30, 1370, 60, 1340, 30);      //tr
  quad(1370, 700, 1400, 670, 1370, 640, 1340, 670); //br


  fill(pocket);
  ellipse(50, 50, 40, 40);    //tl
  ellipse(50, 650, 40, 40);   //bl
  ellipse(1350, 50, 40, 40);  //tr
  ellipse(1350, 650, 40, 40); //br
  ellipse(700, 50, 40, 40);   //tm
  ellipse(700, 650, 40, 40);  //bm

  stroke(line);
  strokeWeight(4);
  line(line_X, 51, line_X, 649);
  noStroke();

  for (int y = 25; y < 676; y += 650) {
    diamond_V(206, y);
    diamond_V(362, y);
    diamond_V(518, y);
    diamond_V(881, y);
    diamond_V(1037, y);
    diamond_V(1193, y);
  }

  for (int x = 25; x < 1376; x += 1350) {
    diamond_H(x, 200);
    diamond_H(x, 350);
    diamond_H(x, 500);
  }
}   

float angle(PVector p1, PVector p2) { // returns in radians
  return atan2(p2.y-p1.y, p2.x-p1.x);
}

PVector vec(PVector p1, PVector p2) { // mouse, then CueBCue
  return new PVector(p2.x-p1.x, p2.y-p1.y);
}

float distance(PVector p1, PVector p2) {
  return sqrt(pow(p2.x-p1.x, 2) + pow(p2.y-p1.y, 2));
}

void diamond_V(int x, int y) {
  fill(silver);  
  quad(x, y-15, x+5, y, x, y+15, x-5, y);
}

void diamond_H(int x, int y) {
  fill(silver);
  quad(x-15, y, x, y+5, x+15, y, x, y-5);
}
