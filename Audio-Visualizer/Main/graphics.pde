
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
  rect(1, 1, 1099, 599);
}

public void drawTime() {
  fill(70);  
  textAlign(LEFT);
  textSize(70);
  text(nf(player.position()/1000/60, 1, 0)+":"+nf((player.position()/1000)%60), 655, 270);
  text("| " + nf(player.length()/1000/60, 1, 0)+":"+nf((player.length()/1000)%60, 2, 0),815,270);
  //textSize(80);
  //text(nf(player.length()/1000/60, 1, 0)+":"+nf((player.length()/1000)%60, 2, 0), 825, 400);
  //textSize(35);
  //text("out of", 825, 335);
}

public void drawSongs() {
  textAlign(LEFT);
  textSize(35);
  fill(0, 255, 0);
  text("Available Songs ("+mp3s.size()+"/14):", 120, 350);
  textSize(20);

  for (int i = 0; i < mp3s.size(); i++) {
    if (i == songNum) { 
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

public void drawEQ() {
  fft.forward(player.mix);

  float w = 350/8.0;
  int h;
  String output = "";
  fill(50, 110, 40);
  for (int i = 0; i < 8; i++) {
    h = max(min(getHeight(fft, bigNums[i], bigNums[i+1])-50, 600), 200);
    output += str(int(map(h, 600, 200, -1, 8)));
    rect(650+w*i, h, w, 600-h);
  }

  w = 350/16.0;
  fill(100, 255, 100);
  noStroke();
  for (int i = 0; i < 16; i++) {
    h = getHeight(fft, smallNums[i], smallNums[i+1]);
    rect(650+w*i, h, w, 600-h);
  }

  if (ARDUINO) {
    myPort.write(output);
  }
}

public void drawButtons() {
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

  textSize(18); 
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

public void drawWaveform() {
  stroke(255);
  for (int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 0, 1000 ); //curent pos in drawing
    float x2 = map( i+1, 0, player.bufferSize(), 0, 1000 ); //one pixel to the right
    line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
    line( x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
  }
}

public void drawBalance() {
  textSize(80);
  fill(60);  
  textAlign(CENTER);
  text("L", 1050, 75);
  text("R", 1050, 185);

  float balance = map(player.getBalance(), -1, 1, 1, 180);

  fill(0, 0);
  stroke(0, 255, 0);
  rect(1000, balance, 100, 20);
  fill(0, 255, 0);
  textSize(15);
  text(nf(player.getBalance(), 1, 2), 1050, balance+15);
}

public void drawLevel() {


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

public void drawGain() {
  fill(80);
  textSize(35);
  text("+ 6db", 1050, 230);
  text("-30db", 1050, 585);



  fill(0, 0);

  float posy = map(player.getGain(), 6, -30, 201, 580);
  rect(1000, posy, 100, 20);
  fill(0, 255, 0);
  textSize(15);
  text(nf(player.getGain(), 1 + 1*int(player.getGain() >= 10), 1)+" db", 1050, posy+15);
}
