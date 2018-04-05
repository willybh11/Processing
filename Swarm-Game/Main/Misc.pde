public void addEnemies() {
  for (int i = 0; i < 2; i++) {
    enemies.add(new Enemy(random(5, 15)/100));
  }
}

public void drawBG() {
  fill(bgColor);                  
  rect(0, 0, width, height);  //draw grey background
  
  fill(0);
  rect(50, 50, width-100, height-100, 20); //draw play area

  fill(74, 169, 245);
  text("LVL                              NXT LVL", width/2, 40); //top data

  fill(60); //was 30
  textSize(60);
  text("S    W    A    R    M", width/2, height-60);

  fill(80); //was 40
  textSize(80);
  text(level, 80, 120);
  text(levelLimits[level-1], width-110, 120); //for nxt lvl

  HealthBlocks.update();

  fill(60); //was 20
  if (round(frameCount/60) >= 10) {
    textSize(510);
    text(round(time/60), width/2, height-150);
  } else {
    textSize(600);
    text(round(time/60), width/2, height-130);
  }
  textSize(40);

  bgColor = 50;
}

public void updateEnemies() {
  if (gameStatus == "ongoing") {
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).damageCheck();
      enemies.get(i).update();
    }
  }
  if (gameStatus == "lost") {
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).endGameUpdate();
    }
  }
}

public void textBox(String text) {
  fill(0, 255, 40); //wincolor
  rect(winBox.x, height-50, 800, 50);

  fill(bgColor);
  rect(winBox.x-20, height-50, 20, 50);

  if ( (winBox.x+400 > 250) && (winBox.x+400 < 350) ) {
    winBox.x += 2;
  } else {
    winBox.x += 20;
  }
  textSize(30);
  fill(20);
  text(text, winBox.x+400, height-15);
  textSize(40);
}

public void reset() {
  for (int i = enemies.size()-1; i >= 0; i--) {
    enemies.remove(i);
  }
  deathLocation = new PVector(mouseX, mouseY);
  textVel = new PVector(0, 0);
  winBox = new PVector(-800, height/2);
  gameStatus = "ongoing";
  bgColor = 50;
  size = 20;
  time = 0;
  minStage = 0;
  timeOfDamage = -3;
  timeOfDeath = 10000;
  textBounces = 0;
  textPos = 0;
  level = 1;
  for (int i = 0; i < 2; i++) {
    enemies.add(new Enemy(random(5, 15)/100));
  }
  addEnemies();
}