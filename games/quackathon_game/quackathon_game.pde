
Scene stage;
Player player;

void setup() {
  fullScreen();
  noStroke();
  stage = new Scene(1);
  player = new Player();
}

void draw() {
  background(0);
  stage.drawScene();
  player.movePlayer();
  player.collisionCheck();
  player.drawPlayer();
}

void keyPressed() {
  switch(key) {
  case 'w':
  case 'W':
    player.vel.y -= 1;
    break;
  case 's':
  case 'S':
    player.vel.y += 1;
    break;
  case 'a':
  case 'A':
    player.vel.x -= 1;
    break;
  case 'd':
  case 'D':
    player.vel.x += 1;
    break;
  }
}
