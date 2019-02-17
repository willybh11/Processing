public class Enemy {

  float speed;
  PVector vel = new PVector(0, 0);
  PVector pos = new PVector(width/2, height/2);

  public Enemy(float spd) { //#1
    speed = spd;
  }

  void update() {

    vel.add(PVector.sub(p1.pos, pos).normalize().mult(speed));

    collisionCheck();
    drawEnemy();
  }

  void drawEnemy() {
    pos.x += vel.x;
    pos.y += vel.y;

    fill(232, 79, 90); //enemy color
    ellipse(pos.x, pos.y, 15, 15);
  }

  void collisionCheck() {
    if (pos.x >= width-57) {  //collide with right wall
      vel.x *= -0.5;
      pos.x = width-58;
    }
    if (pos.x <= 57) {  //collide with left wall
      vel.x *= -0.5; 
      pos.x = 58;
    }
    if (pos.y >= height-57) {  //collide with top wall
      vel.y *= -0.5;
      pos.y = height-58;
    }
    if (pos.y <= 57) {  //collide with bottom wall
      vel.y *= -0.5;
      pos.y = 58;
    }
  }

  void damageCheck() {
    if (size != 0) {
      if (time/60 > timeOfDamage+1) {
        if ( (dist(pos.x, pos.y, p1.pos.x, p1.pos.y) < size/2 + 7)) {
          size -= 5;
          timeOfDamage = time/60;
        }
      } else {
        //bgColor = 150;
      }
    }
  }

  void endGameUpdate() {
    vel.y += 0.3;
    if (vel.x > 0) {
      vel.x -= 0.01;
    }
    if (vel.x <0) {
      vel.x += 0.01;
    }

    if (textBounces < 1) {
      collisionCheck();
    }
    drawEnemy();
  }
}