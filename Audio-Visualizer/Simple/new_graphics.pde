
public void drawStructure() {
  stroke(0, 255, 0);
  fill(0, 0);

  rect(1, 1, width-1, height-1); // main box

  rect(1, 1, 50, 399); // around levels

  line(600, 0, 600, 400); // divide eq/songs

  rect(600, 350, 250, 50);
}

public void drawTime() {
  stroke(255);
  int pos = int(map(player.position(), 0, player.length(), 600, 850));
  line(pos, 350, pos, 400);
  
  fill(70);
  noStroke();
  rect(600,350,pos-600,50);

  fill(50,150,250);  
  textAlign(LEFT);
  textSize(40);
  seconds = nf((player.position()/1000)%60);
  if (int(seconds) < 10) 
    seconds = '0'+seconds;
  text(nf(player.position()/1000/60, 1, 0)+":"+seconds, 620, 388);
  fill(0,255,0);
  text("| " + nf(player.length()/1000/60, 1, 0)+":"+nf((player.length()/1000)%60, 2, 0), 720, 388);
}

public void drawEQ() {
  fft.forward(player.mix);

  float w = 550/8.0;
  int h;
  String output = "";
  fill(0);
  for (int i = 0; i < 8; i++) {
    h = max(min(getHeight(fft, bigNums[i], bigNums[i+1])-50, 400), 0);
    output += str(int(map(h, 400, 0, -1, 8)));
    rect(50+w*i, h, w, 400-h);
  }

  w = 550/16.0;
  fill(20, 160, 0);
  noStroke();
  for (int i = 0; i < 16; i++) {
    h = getHeight(fft, smallNums[i], smallNums[i+1]);
    rect(50+w*i, h, w, 400-h);
  }

  if (ARDUINO) {
    myPort.write(output);
  }
}

public void drawWaveform() {
  stroke(255);
  for (int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 50, 600 ); //curent pos in drawing
    float x2 = map( i+1, 0, player.bufferSize(), 50, 600 ); //one pixel to the right
    line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
    line( x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
  }
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
    // rect(60, height-40 - (39*i), 30, 28);
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
    rect(10, height-40 - (39*i), 12, 28);
  }

  for (int i = 0; i < num_R; i++) {
    if (i < 5) {
      fill(70, 255, 100);
    } else if (i < 9) {
      fill(255, 255, 70);
    } else {
      fill(255, 0, 0);
    }
    rect(28, height-40 - (39*i), 12, 28);
  }
  stroke(0, 255, 0);
}

public void drawSongs() {
  textAlign(LEFT);
  textSize(30);
  fill(50, 150, 250);
  text(songNum+1+": "+mp3s.get(songNum), 610, 97);

  textSize(20);
  fill(0, 255, 0);

  for (int i = songNum-1; i > songNum-3; i--) {
    if (i < 0) {
      text(mp3s.size()+1+i+": "+mp3s.get(mp3s.size()+i), 620, 90-30*diff(songNum, i));
    } else {
      text(i+1+": "+mp3s.get(i), 620, 90-30*diff(songNum, i));
    }
  }

  for (int i = songNum+1; i < songNum+9; i++) {
    if (i > mp3s.size()-1) {
      text(i%mp3s.size()+1+": "+mp3s.get(i%mp3s.size()), 620, 100+30*(i-songNum));
    } else {
      text(i+1+": "+mp3s.get(i), 620, 100+30*(i-songNum));
    }
  }
}
