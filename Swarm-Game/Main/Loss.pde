public void lossCheck() {
  if (gameStatus == "lost") {
  
    fill(50);                  
    rect(0, 0, width, height);  //draw grey background

    fill(0);
    rect(50, 50, width-100, height-100, 20); //draw black playspace

    if (minStage == 0) {
      minStage = 1;
    }

    if (minStage == 1) {

      if (size != 50) {
        size += 2;
        fill(74, 169, 245); //playercolor
        ellipse(deathLocation.x, deathLocation.y, size, size);
      } 

      if (size == 50) {
        minStage = 2;
      }
    }

    if (minStage == 2) {
      if (size > 0) { 
        size -= 4;
        fill(74, 169, 245); //playercolor
        ellipse(deathLocation.x, deathLocation.y, size, size);
      } else {
        minStage = 3;
      }
    }

    updateEnemies();

    if (time/60 > timeOfDeath+1) { //text animation
      if (textBounces < 3) {
        textVel.x += 0.2;

        if (textPos > height/2+90) {
          textVel.x *= -0.3;
          textBounces ++;
          if (textBounces == 1) {
            for (int i = 0; i < enemies.size(); i++) {
              enemies.get(i).vel.y -= random(5,10);
              enemies.get(i).vel.x += random(-5,5);
            }
          }
        }

        textPos += textVel.x;
      }
      textSize(50);
      text("    You got...         ", width/2, textPos-220);
      textSize(90);
      text("SWARMED", (width/2) + random(-3, 3), textPos-100+random(-3, 3));
      if (textBounces > 0) {
        textSize(50);
        text("\n("+str(timeOfDeath)+" sec. @ lvl"+level+")", width/2, 420);
      }
    }
  }
  time += 1;
}