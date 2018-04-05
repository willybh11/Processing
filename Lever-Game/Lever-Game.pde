
ArrayList<PVector> origins   = new ArrayList<PVector>();
ArrayList<PVector> positions = new ArrayList<PVector>();

boolean[] movingDown = {false, false, false};
boolean[] movingUp   = {false, false, false};

int[] winList = {0, 0, 0};
int[] tries   = {0, 0, 0};
int[] chances = {2, 4, 6}; // out of 10

void setup() {
  size(900, 1050); 
  background(0);
  textAlign(CENTER);
  //noStroke();

  origins.add(new PVector(100, 350));
  origins.add(new PVector(350, 350));
  origins.add(new PVector(600, 350));

  for (int i = 0; i < 3; i++) {
    positions.add(new PVector(100, 100));
  }
  // draw my name
  fill(120, 10, 255);
  textSize(20);
  text("Will Hagele", 840, 995);
}

void draw() {
  drawStuff();
  moveCheck();
}

void mousePressed() {

  for (int i = 0; i < 3; i++) {
    int pullsLeft = 100-(tries[0]+tries[1]+tries[2]);
    if (mouseOver(i)) {
      if (pullsLeft > 0) {
        movingDown[i] = true;
        pull(i);
      }
    }
    if (mouseOverBox(i)) {
      for (int j = 0; j < pullsLeft; j++) {
        pull(i);
        movingDown = new boolean[] {true, true, true};
      }
    }
  }
}