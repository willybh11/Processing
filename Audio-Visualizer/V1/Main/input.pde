
void mouseDragged() {

  switch (dragState) {
  case "balance": 
    player.setBalance(map(min(200, max(1, mouseY)), 1, 200, -1, 1));
    break;
  case "gain": 
    player.setGain(map(min(580, max(201, mouseY)), 201, 580, 6, -30)); 
    break;
  case "none":
    if (mouseInBalanceBox()) {
      dragState = "balance";
    } else if (mouseInGainBox()) {
      dragState = "gain";
    }
  }
}

void mouseReleased() {
  dragState = "none";
}

void mouseClicked() {

  switch (int(hex(get(mouseX, mouseY), 6))) {
  case 10101:   
    playPause();   
    break;
  case 20202:
    rewind();      
    break;
  case 30303: 
    fastForward(); 
    break;
  case 40404:        
    mute();        
    break;
  default: 
    if (get(mouseX, mouseY) == color(6) || get(mouseX, mouseY) == color(0, 254, 0)) {
      player.setBalance(0);
    } else if (get(mouseX, mouseY) == color(5) || get(mouseX, mouseY) == color(0, 253, 0)) {
      player.setGain(0);
    }
  }
}

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
    case 'm':
      mute();
      break;
    case 'b':
      player.setBalance(0);
      break;
    case 'g':
      player.setGain(0);
      break;
    }
  }
}
