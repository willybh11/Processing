
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
    case SHIFT:
      if (listening) {
        listening = false;
        if (input != "") {
          if (songNum < mp3s.size() && int(input) <= mp3s.size()) {
            playPause();
            songNum = int(input) - 1;
            player = minim.loadFile(mp3s.get(songNum)+".mp3");
            fft = new FFT(player.bufferSize(), player.sampleRate());
            break;
          }
        }
      } else {
        listening = true;
        input = "";
      }
    }
  } else {
    if (key == ' ') {
      playPause();
    } else if (key == int(key) && listening) {
      input += key;
    }
  }
}
