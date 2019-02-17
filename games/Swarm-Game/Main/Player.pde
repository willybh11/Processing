public class Player {

  PVector pos = new PVector(width/2, height/2);

  void update() {

    if (size == 0) {
      timeOfDeath = round(time/60);
      gameStatus = "lost";

      deathLocation.x = pos.x;
      deathLocation.y = pos.y;
      return;
    }
    int rad = size/2;
    pos.x = min(max(mouseX, 50+rad), width-50-rad); 
    pos.y = min(max(mouseY, 50+rad), height-50-rad);

    fill(74, 169, 245); //playerColor
    ellipse(pos.x, pos.y, size+5, size+5);
  }
  
  void addLife() {
   size += 5; 
  }
  
}