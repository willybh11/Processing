
void keyPressed() {

  if (key == CODED) {
    switch(keyCode) {
    case RIGHT:
      fastForward(); 
      break;
    case LEFT:
      rewind(); 
      break;
    }
  } else {

    switch(key) {
    case ' ':
      playPause();
      break;
    }
  }
}
