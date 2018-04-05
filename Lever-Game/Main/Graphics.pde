
public void drawStuff() {

  // draw outlines behind winboxes
  for (int i = 0; i < 3; i++) {
    if (mouseOverBox(i)) {
      fill(0, 255, 0);
    } else {
      fill(0);
    }
    rect(origins.get(i).x-5, origins.get(i).y-155, 210, 110);
  }
  

  // draw boxes
  for (int i = 0; i < 3; i++) {
    fill(100);
    rect(100, 50, 700, 100);
    rect(origins.get(i).x, origins.get(i).y, 200, 600);

    rect(origins.get(i).x, origins.get(i).y-150, 200, 100);
    fill(0, 100, 255);
    textSize(50);
    text(winList[i]+"/"+tries[i], origins.get(i).x+100, origins.get(i).y-80);
  }
  

  // draw total score at top
  fill(179, 98, 250);
  textSize(80);
  text((winList[0]+winList[1]+winList[2])+" : "+(tries[0]+tries[1]+tries[2])+" / 100", 450, 125);



  // draw outlines behind levers
  for (int i = 0; i < 3; i++) {
    if (mouseOver(i) && positions.get(i).y == 100) {
      fill(255, 255, 0);
      ellipse(origins.get(i).x + positions.get(i).x, origins.get(i).y + positions.get(i).y, 110, 110);
    }
  }
 
 
  // draw levers
  for (int i = 0; i < 3; i++) {
    fill(220, 220, 220);
    if (positions.get(i).x < 300) { // lever above middle
      rect(origins.get(i).x+positions.get(i).x-20, origins.get(i).y+positions.get(i).y, 40, 300-positions.get(i).y);
    } else { // lever below
      rect(origins.get(i).x+positions.get(i).x-20, origins.get(i).y+300, 40, positions.get(i).y-300);
    }

    fill(255, 0, 0);
    ellipse(origins.get(i).x+positions.get(i).x, origins.get(i).y+positions.get(i).y, 100, 100);
  }
}

public void moveCheck() {

  for (int i = 0; i < 3; i++) {

    if (movingUp[i]) {
      if (positions.get(i).y == 110) {
        movingUp[i] = false;
      }
      if (positions.get(i).y > 100) {
        positions.get(i).y -= 10;
      }
    }

    if (movingDown[i]) {
      if (positions.get(i).y >= 450) {
        movingUp[i] = true;
        movingDown[i] = false;
      }
      if (positions.get(i).y < 500) {
        positions.get(i).y += 50;
      }
    }
  }
}