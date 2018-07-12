
public void drawStructure() {
  stroke(100);
  line(1035, 400, 1065, 400);
  line(1035, 300, 1065, 300);
  line(1035, 500, 1065, 500);
  line(1045, 450, 1055, 450);
  line(1045, 550, 1055, 550);
  line(1045, 350, 1055, 350);
  line(1045, 250, 1055, 250);
  stroke(0, 255, 0);
  line(318, 200, 318, 300);
  line(100, 300, 649, 300);
  line(649, 200, 649, 600);
  line(0, 200, 1100, 200);
  line(1000, 0, 1000, 600);
  fill(0, 0);
  rect(1, 200, 49, 400);
  rect(50, 200, 50, 400);
}

public void drawTime(AudioPlayer player) {
  fill(70);  
  textAlign(CENTER);
  textFont(font_100, 100);
  text(nf(player.position()/1000/60, 1, 0)+":"+nf((player.position()/1000)%60, 2, 0), 825, 300);
  textFont(font_80, 80);
  text(nf(player.length()/1000/60, 1, 0)+":"+nf((player.length()/1000)%60, 2, 0), 825, 400);
  textFont(font_35, 35);
  text("out of", 825, 335);
}

public void drawSongs(AudioPlayer[] players, ArrayList<String> mp3s, AudioPlayer player) {
  textAlign(LEFT);
  textFont(font_35, 35);
  textSize(35);
  fill(0, 255, 0);
  text("Available Songs ("+mp3s.size()+"/21):", 120, 350);
  textFont(font_20, 20);
  textSize(20);

  for (int i = 0; i < mp3s.size(); i++) {
    if (player == players[i]) { 
      fill(50, 150, 250);
    } else { 
      fill(0, 255, 0);
    }
    if (i < 7) {
      text(str(i+1)+". "+mp3s.get(i), 120, 390+(30*i));
    } else if (i < 14) {
      text(str(i+1)+". "+mp3s.get(i), 320, 390+(30*(i-7)));
    } else if (i < 21) {
      text(str(i+1)+". "+mp3s.get(i), 520, 390+(30*(i-14)));
    }
  }
}

public void drawEQ(FFT fft, AudioPlayer player) {
  fft.forward(player.mix);
  float avgBass        = getHeight(fft, 10, 100);
  float avgBass_mid    = getHeight(fft, 100, 300);
  float avgMid_low     = getHeight(fft, 300, 600);
  float avgMidrange    = getHeight(fft, 600, 1200);
  float avgMid_high    = getHeight(fft, 1200, 2400);
  float avgTreble_low  = getHeight(fft, 2400, 4800);
  float avgTreble_mid  = getHeight(fft, 4800, 9600);
  float avgTreble_high = getHeight(fft, 9600, 20000);
  float w = 350/8.0;
  fill(100,255,100);
  noStroke();
  rect(650+w*0, avgBass, w, 600-avgBass       );
  rect(650+w*1, avgBass_mid, w, 600-avgBass_mid   );
  rect(650+w*2, avgMid_low, w, 600-avgMid_low    );
  rect(650+w*3, avgMidrange, w, 600-avgMidrange   );
  rect(650+w*4, avgMid_high, w, 600-avgMid_high   );
  rect(650+w*5, avgTreble_low, w, 600-avgTreble_low );
  rect(650+w*6, avgTreble_mid, w, 600- avgTreble_mid );
  rect(650+w*7, avgTreble_high, w, 600-avgTreble_high);
  stroke(0, 255, 0);
}

public void drawEQ_old(FFT fft, AudioPlayer player) {
  fft.forward(player.mix);

  for (int x = 650; x < fft.specSize() + 650 - 162; x++) {
    float h = map(fft.getBand(x-650), 0, 200, 0, 400);
    stroke(50);
    line(x, height, x, height - min(400, h*5));
    stroke(100);
    line(x, height, x, height - min(400, h*4));
    stroke(255);
    line(x, height, x, height - min(400, h*2));
  }
}

public void drawButtons(AudioPlayer player) {
  fill(1); //play/pause button
  noStroke();
  rect(175, 200, 75, 100);
  stroke(0, 255, 0);
  if (player.isPlaying()) {    
    rect(185, 220, 20, 60);
    rect(215, 220, 20, 60);
  } else {
    triangle(190, 220, 190, 280, 240, 250);
  }

  fill(2); //rewind
  noStroke();
  rect(100, 200, 75, 100);
  stroke(0, 255, 0);
  triangle(120, 250, 140, 220, 140, 280);
  triangle(140, 250, 160, 220, 160, 280);

  fill(3); //ff
  noStroke();
  rect(250, 200, 68, 100);
  stroke(0, 255, 0);
  triangle(280, 250, 260, 220, 260, 280);
  triangle(300, 250, 280, 220, 280, 280);

  fill(4); //mute
  noStroke();
  rect(315, 200, 75, 100);
  stroke(0, 255, 0);
  line(340, 235, 360, 235);
  line(340, 265, 360, 265);
  line(340, 235, 340, 265);
  line(360, 265, 370, 285);
  line(360, 235, 370, 215);
  line(370, 285, 370, 215);

  if (player.isMuted()) {
    strokeWeight(6);
    stroke(255, 0, 0, 180);
    line(330, 280, 390, 220);
    strokeWeight(1);
    stroke(0, 255, 0);
  } else {
    line(380, 250, 400, 250);
    line(380, 230, 395, 215);
    line(380, 270, 395, 285);
  }

  textFont(font_18);  
  textAlign(CENTER);

  fill(5); //gain reset
  rect(430, 212, 73, 73, 20);
  fill(0, 254, 0);  
  text("RESET\nGAIN", 467, 245);

  fill(6); //balance reset
  rect(540, 212, 73, 73, 20);
  fill(0, 253, 0);
  text("RESET\nBLNCE", 577, 245);
  textAlign(LEFT);
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
}

public void drawBalance(AudioPlayer player) {
  textFont(font_80, 80);
  fill(60);
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
  fill(80);
  textSize(30);
  text("+ 6db", 1050, 230);
  text("-30db", 1050, 585);



  fill(0, 0);

  float posy = map(player.getGain(), 6, -30, 201, 580);
  rect(1000, posy, 100, 20);
  fill(0, 255, 0);
  textSize(15);
  text(nf(player.getGain(), 1 + 1*int(player.getGain() >= 10), 1)+" db", 1050, posy+15);
}
