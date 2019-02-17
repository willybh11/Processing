public class Car {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector startPos = new PVector(0, 0);
  float angle = 0;
  int wheelWidth = 15;
  int carLength = 80;
  int carWidth = 50;
  int laps = 0;
  int n = 0;

  PVector posFromCenter;

  public Car(float x, float y) {
    startPos.x = x;
    startPos.y = y;
    pos.add(startPos);
  }

  void update(boolean[] keys, color Color) {
    keyCheck(keys);
    collisionCheck();
    grassCheck();
    moveMe(); 
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    fill(Color);
    rect(-40, -25+wheelWidth, 75, carWidth-2*wheelWidth); //body: long
    rect(-22, -25, 28, 50); //body: wide
    rect(30, -25, 5, carWidth); //flat edge of bumper
    rect(30, -25, 10, carWidth, 5); //curved edge of front bumper
    fill(0);
    rect(10, -25, 16, wheelWidth, 5); //front left wheel
    rect(10, 9, 16, wheelWidth, 5); //front right wheel
    rect(-43, -25, 16, wheelWidth, 5); //back left wheel
    rect(-43, 9, 16, wheelWidth, 5); //back right wheel
    //rect(-40, -25, 80, 50); //base rectangle
    popMatrix();
  }

  void moveMe() {
    pos.add(vel);
    vel.mult(0.97); //6
  }

  void backToStart() {
    pos.x = startPos.x;
    pos.y = startPos.y;
    vel.x = 0;
    vel.y = 0;
    angle = 0;
    n = 0;
  }

  void keyCheck(boolean[] keys) {
    if (keys[0]) { //w
      vel.y += sin(angle)*0.7;
      vel.x += cos(angle)*0.7;
    }
    if (keys[1]) { //s
      /*
      vel.y -= sin(angle)*0.8;
       vel.x -= cos(angle)*0.8;
       */
      vel.y *= 0.9;
      vel.x *= 0.9;
    }
    if (keys[2]) { //a
      angle -= 0.06;
    }
    if (keys[3]) { //d
      angle += 0.06;
    }
  }

  void grassCheck() {
    color front = get(round(pos.x+40), round(pos.y));
    color back  = get(round(pos.x-40), round(pos.y));
    if (front == grass || back == grass || front == dark || back == dark) {
      vel.mult(0.9);
    }
  }

  void collisionCheck() {
    // check each side for each wall
    if (pos.x > width || pos.x < 0 || pos.y > height || pos.y-25 < 0) {
      backToStart();
    }
  }
}