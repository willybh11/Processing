
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
  } else {
    if (key == ' ') {
      if (inAlbum) playPause();
      else {
        inAlbum = true;
        getSongs();
        println("got songs");
      }
    }
  }
}
