
public void drawSongs(AudioPlayer[] players, ArrayList<String> mp3s, AudioPlayer player) {
  textAlign(LEFT);
  textFont(font_35, 35);
  textSize(35);
  fill(0, 255, 0);
  text("Available Songs:", 120, 350);
  line(100, 300, 1000, 300);
  textFont(font_20, 20);
  textSize(20);

  for (int i = 0; i < mp3s.size(); i++) {
    if (player == players[i]) { 
      fill(50, 150, 250);
    } else { 
      fill(0, 255, 0);
    }
    if (i < 7) {
      text(mp3s.get(i), 120, 400+(30*i));
    } else if (i < 14) {
      text(mp3s.get(i), 320, 400+(30*(i-7)));
    } else if (i < 21) {
      text(mp3s.get(i), 520, 400+(30*(i-14)));
    }
  }
}

public void drawEQ(FFT fft, AudioPlayer player) {
  line(649, 300, 649, height);
  stroke(255);
  fft.forward(player.mix);

  for (int x = 650; x < fft.specSize() + 650 - 162; x++) {
    line(x, height, x, height - min(300, map(fft.getBand(x-650), 0, 100, 0, 300)));
  }
}

public void drawButtons(AudioPlayer player) {
  fill(1); //play/pause button
  if (player.isPlaying()) {    
    rect(185, 220, 20, 60);
    rect(215, 220, 20, 60);
  } else {
    triangle(190, 220, 190, 280, 240, 250);
  }

  fill(2); //rewind
  triangle(120, 250, 140, 220, 140, 280);
  triangle(140, 250, 160, 220, 160, 280);

  fill(3); //ff
  triangle(280, 250, 260, 220, 260, 280);
  triangle(300, 250, 280, 220, 280, 280);
}

public void drawWaveform(AudioPlayer player) {
  stroke(255);
  for (int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 0, 1000 );
    float x2 = map( i+1, 0, player.bufferSize(), 0, 1000 );
    line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
    line( x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
  }
}

public void drawPosition_1(AudioPlayer player) {
  fill(30);
  float posx = map(player.position(), 0, player.length(), 0, 1000);
  rect(0, 0, posx, 200);
}

public void drawPosition_2(AudioPlayer player) {
  float posx = map(player.position(), 0, player.length(), 0, 1000);
  stroke(0, 255, 0);
  line(posx, 0, posx, 200);
  line(0, 200, width, 200);
  line(1000, 0, 1000, height);
}

public void drawBalance(AudioPlayer player) {
  fill(40);
  textSize(80);
  textAlign(CENTER);
  text("L", 1050, 75);
  text("R", 1050, 185);

  float balance = map(player.getBalance(), -1, 1, 1, 180);

  fill(0, 0);
  rect(1000, balance, 100, 20);
  fill(0, 255, 0);
  textSize(15);
  text(nf(player.getBalance(), 1, 2), 1050, balance+15);
}

public void drawLevel(AudioPlayer player) {

  fill(0, 0);
  rect(1, 200, 49, 400);
  rect(50, 200, 50, 400);
  noStroke();

  for (int i = 0; i < 10; i++) {
    if (i < 5) {
      fill(70, 255, 100, 50);
    } else if (i < 9) {
      fill(255, 255, 70, 50);
    } else {
      fill(255, 0, 0, 50);
    }
    rect(10, height-40 - (39*i), 30, 28);
    rect(60, height-40 - (39*i), 30, 28);
  }

  int num_L = round(player.left .level() * 10 * 1.2);
  int num_R = round(player.right.level() * 10 * 1.2);

  for (int i = 0; i < num_L; i++) {
    if (i < 5) {
      fill(70, 255, 100);
    } else if (i < 9) {
      fill(255, 255, 70);
    } else {
      fill(255, 0, 0);
    }
    rect(10, height-40 - (39*i), 30, 28);
  }


  for (int i = 0; i < num_R; i++) {
    if (i < 5) {
      fill(70, 255, 100);
    } else if (i < 9) {
      fill(255, 255, 70);
    } else {
      fill(255, 0, 0);
    }
    rect(60, height-40 - (39*i), 30, 28);
  }
  stroke(0, 255, 0);
}

public void drawGain(AudioPlayer player) {
  fill(50);
  textSize(30);
  text("100%", 1050, 230);
  text("0%", 1050, 585);

  stroke(100);
  line(1035, 400, 1065, 400);
  line(1035, 300, 1065, 300);
  line(1035, 500, 1065, 500);
  line(1045, 450, 1055, 450);
  line(1045, 550, 1055, 550);
  line(1045, 350, 1055, 350);
  line(1045, 250, 1055, 250);
  stroke(0, 255, 0);

  fill(0, 0);

  float posy = map(player.getGain(), 0, -50, 200, 480);
  rect(1000, posy, 100, 20);
  fill(0, 255, 0);
  textSize(15);
  text(player.getGain(), 1050, posy+15);
}
