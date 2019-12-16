
class Player {

  PVector pos;
  PVector vel;
  String[] playerTypes;
  int playerTypeIndex;

  public Player() {
    playerTypes = new String[]{ "small", "wheels", "normal", "jetpack" };
    playerTypeIndex = 0;
    pos = new PVector(200, height-300);
    vel = new PVector(0, 0);
  }

  void drawPlayer() {
    rectMode(CENTER);
    fill(255, 0, 0);
    switch(playerTypes[playerTypeIndex]) {
    case "small":
      rect(pos.x, pos.y, 10, 10);
      break;
    }
  }

  void movePlayer() {
    pos.add(vel);
    vel.y += 0.1;
    vel.x *= 0.999;
  }

  void collisionCheck() {
    int tempSize;
    if (playerTypes[playerTypeIndex] == "small") {
      tempSize = 10;
    } else {
      tempSize = 25;
    }

    println(get(int(pos.x+tempSize), int(pos.y)));

    if (get(int(pos.x+tempSize), int(pos.y)) == color(255)) { // right check
      vel.x = 0;
    }
    if (get(int(pos.x-tempSize), int(pos.y)) == color(255)) { // left check
      vel.x = 0;
    }
    if (get(int(pos.x), int(pos.y+tempSize)) == color(255)) { // bottom check
      vel.y = 0;
    }
    if (get(int(pos.x), int(pos.y-tempSize)) == color(255)) { // top check
      vel.y = 0;
    }
  }
}
