Player p1 = new Player();
HBS HealthBlocks = new HBS();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PVector deathLocation = new PVector(mouseX, mouseY);
PVector textVel = new PVector(0, 0);
PVector winBox = new PVector(-800, height/2);
String gameStatus = "ongoing";
boolean exStarted = false;
int bgColor = 50;
int size = 30;
int time;
int minStage = 0;
int timeOfDamage = -3;
int timeOfDeath;
int textBounces = 0;
int textPos = 0;
int level = 1;
int levelLimits[] = {
  5, 15, 30, 45, 60, 75, 90
};
int colors[] = {
  color(74, 169, 245), color(75, 158, 224), color(56, 118, 167), color(47, 100, 142), color(37, 79, 113), color(31, 68, 98), color(27, 58, 82), color(21, 45, 64), color(16, 34, 49), color(0)
};


void setup() {
  size(700, 700);
  noStroke();
  textAlign(CENTER);
  textSize(40);
  time = frameCount;
  reset();
  HealthBlocks.initialize();
}

void draw() {

  if (keyPressed) {
    if (key == 'r' || key == 'R') {
      gameStatus = "resetting";
    }
  }

  if (gameStatus == "resetting") {
    textBox("Restarting...");
    if (winBox.x >= 720) {
      reset();
    }
  }

  if (gameStatus == "ongoing") {

    drawBG();
    updateEnemies();

    if ( time/60 >= levelLimits[level-1]) {
      gameStatus = "won";
    }

    p1.update();
  }

  if (gameStatus != "resetting") {
    lossCheck();
    winCheck();
  }
}