
void keyPressed() {
  
  if (key == CODED) {
    switch(keyCode) {
    case DOWN:
    case RIGHT:
      if (inAlbum) fastForward(); 
      else albumNum++;
      break;
    case UP:
    case LEFT:
      if (inAlbum) rewind(); 
      else albumNum--;
      break;
    }
  } 
  if (key == ' ' || keyCode == ENTER) {
    enter();
  } else if (key == '/') {
    inAlbum = false; 
    songNum = 0;
  }
}
