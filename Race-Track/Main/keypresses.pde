void keyPressed() {
  if (key == 'w') {
    p1K[0] = true;
  }
  if (key == 's') {
    p1K[1] = true;
  }
  if (key == 'a') {
    p1K[2] = true;
  }
  if (key == 'd') {
    p1K[3] = true;
  }
  if (key == 'r') {
    for (int i = 0; i < 4; i++) {
     cars.get(i).backToStart(); 
     cars.get(i).laps = 0;
    }
    
  }

  if (key == 't') {
    p3K[0] = true;
  }
  if (key == 'g') {
    p3K[1] = true;
  }
  if (key == 'f') {
    p3K[2] = true;
  }
  if (key == 'h') {
    p3K[3] = true;
  }
  if (key == 'i') {
    p4K[0] = true;
  }
  if (key == 'k') {
    p4K[1] = true;
  }
  if (key == 'j') {
    p4K[2] = true;
  }
  if (key == 'l') {
    p4K[3] = true;
  }
  if (key == CODED) {
    if (keyCode == UP) {
      p2K[0] = true;
    }
    if (keyCode == DOWN) {
      p2K[1] = true;
    }
    if (keyCode == LEFT) {
      p2K[2] = true;
    }
    if (keyCode == RIGHT) {
      p2K[3] = true;
    }
  }
}

void keyReleased() {
  if (key == 'w') {
    p1K[0] = false;
  }
  if (key == 's') {
    p1K[1] = false;
  }
  if (key == 'a') {
    p1K[2] = false;
  }
  if (key == 'd') {
    p1K[3] = false;
  }
  if (key == 't') {
    p3K[0] = false;
  }
  if (key == 'g') {
    p3K[1] = false;
  }
  if (key == 'f') {
    p3K[2] = false;
  }
  if (key == 'h') {
    p3K[3] = false;
  }
  if (key == 'i') {
    p4K[0] = false;
  }
  if (key == 'k') {
    p4K[1] = false;
  }
  if (key == 'j') {
    p4K[2] = false;
  }
  if (key == 'l') {
    p4K[3] = false;
  }
  if (key == 'r') {
  }
  if (key == CODED) {
    if (keyCode == UP) {
      p2K[0] = false;
    }
    if (keyCode == DOWN) {
      p2K[1] = false;
    }
    if (keyCode == LEFT) {
      p2K[2] = false;
    }
    if (keyCode == RIGHT) {
      p2K[3] = false;
    }
  }
}