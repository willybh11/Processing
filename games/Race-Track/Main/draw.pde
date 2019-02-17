public void drawTrack() {
  background(grass);
  fill(border1); //outside red
  rect(50, 50, 1600, 800, 225);
  fill(border2); //outside white
  rect(60, 60, 1580, 780, 225);
  fill(asphalt); //track
  rect(70, 70, 1560, 760, 225);
  fill(border2); //inside white border
  rect(230, 230, 1240, 440, 225);
  fill(border1); //insdie red border
  rect(240, 240, 1220, 420, 225);
  fill(grass); //inside grass
  rect(250, 250, 1200, 400, 225);
  fill(dark); //scoreboard & controls
  rect(300, 480, 1100, 150, 150);
  rect(360, 280, 350, 180, 200);
}

public void drawControls() {
  textAlign(LEFT);
  textSize(30);
  fill(p1C);
  text("Player 1: WASD", 400, 320);
  fill(p2C);
  text("Player 2: Arrow Keys", 400, 360);
  fill(p3C);
  text("Player 3: TFGH", 400, 400);
  fill(p4C);
  text("Player 4: IJKL", 400, 440);
}

public void drawLaps() {
  textAlign(CENTER);
  textSize(150);
  fill(p1C);
  text(cars.get(0).laps, 400, 610);
  fill(p2C);
  text(cars.get(1).laps, 700, 610);
  fill(p3C);
  text(cars.get(2).laps, 1000, 610);
  fill(p4C);
  text(cars.get(3).laps, 1300, 610);
}

public void drawFinishLine() {
  for (int i = 0; i < 10; i++) {
    fill(255);
    rect(570-(i%2*20), i*20+50, 20, 20);
    fill(0);
    rect(550+(i%2*20), i*20+50, 20, 20);
  }
}