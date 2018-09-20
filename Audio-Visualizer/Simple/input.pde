
void keyPressed() {

  if (key == CODED) {
    switch(keyCode) {
    case DOWN:
    case RIGHT:
      fastForward(); 
      break;
    case UP:
    case LEFT:
      rewind(); 
      break;
    }
  } else {
    playPause();
  }
}
