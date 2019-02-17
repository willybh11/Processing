

void keyPressed() {
  if (key == CODED) {

    for (int i = 0; i < 2; i ++) {
      boolean changing = true;

      switch(keyCode) {
      case UP:
        while (changing) {
          changing = false;
          for (int x = 0; x < 4; x++) {
            for (int y = 3; y > 0; y--) {

              changing = move(y*4+x, min(15, y*4+x-4));
            }
          }
        }
        break;
      case DOWN:
        while (changing) {
          changing = false;
          for (int x = 0; x < 4; x++) {
            for (int y = 0; y < 3; y++) {

              changing = move(y*4+x, min(15, y*4+x+4));
            }
          }
        }
        break;
      case LEFT:
        while (changing) {
          changing = false;
          for (int y = 0; y < 4; y++) {
            for (int x = 3; x > 0; x--) {

              changing = move(y*4+x, y*4+x-1);
            }
          }
        }
        break;
      case RIGHT:
        while (changing) {
          changing = false;
          for (int y = 0; y < 4; y++) {
            for (int x = 0; x < 3; x++) {

              changing = move(y*4+x, y*4+x+1);
            }
          }
        }
        break;
      }
    }
  }
  add2();
}
