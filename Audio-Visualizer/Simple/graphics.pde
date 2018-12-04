
public void drawPause() {
  if (!player.isPlaying()) {
    fill(colorPack.alt, 200); //70
    rect(280, 200, 30, 100, 50);
    rect(330, 200, 30, 100, 50);
  }
}

public void drawAlbums() {
  textAlign(LEFT);
  textSize(30);
  fill(colorPack.alt);
  for (int i = 0; i < albums.size(); i++) {
    if (i == albumNum) fill(colorPack.alt);
    else fill(colorPack.stroke);
    text(albums.get(i), 610, 40*(i+1));
  }
}

public void drawStructure() {
  stroke(colorPack.stroke);
  fill(colorPack.bg);

  rect(1, 1, width-1, height-1); // main box
  rect(1, 1, 50, 399); // around levels
  line(600, 0, 600, 400); // divide eq/songs
  rect(600, 350, 250, 50);
}

public void drawTime() {
  stroke(colorPack.timeLine);
  int pos = int(map(player.position(), 0, player.length(), 600, 850));
  line(pos, 350, pos, 400);

  fill(colorPack.timeFill);
  noStroke();
  rect(600, 350, pos-600, 50);

  fill(colorPack.alt);  
  textAlign(LEFT);
  textSize(40);
  String seconds = nf((player.position()/1000)%60);
  if (int(seconds) < 10) 
    seconds = '0'+seconds;
  text(nf(player.position()/1000/60, 1, 0)+":"+seconds, 620, 388);
  fill(colorPack.stroke);
  text("| " + nf(player.length()/1000/60, 1, 0)+":"+nf((player.length()/1000)%60, 2, 0), 720, 388);
}

public void drawEQ() {
  fft.forward(player.mix);

  float w = 550/8.0;
  int h;
  String output = "";
  fill(colorPack.bg);
  stroke(colorPack.stroke);
  for (int i = 0; i < 8; i++) {
    h = max(min(getHeight(fft, bigNums[i], bigNums[i+1])-50, 400), 0);
    output += str(int(map(h, 400, 0, -1, 8)));
    rect(51+w*i, h, w-1, 400-h);
  }

  w = 550/16.0;
  fill(colorPack.levels);
  noStroke();
  for (int i = 0; i < 16; i++) {
    h = getHeight(fft, smallNums[i], smallNums[i+1]);
    rect(51+w*i, h, w-1, 400-h);
  }

  if (ARDUINO) {
    myPort.write(output);
  }
}

public void drawWaveform() {
  stroke(colorPack.waveform);
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
      fill(colorPack.low, 70);
    } else if (i < 9) {
      fill(colorPack.mid, 70);
    } else {
      fill(colorPack.high, 70);
    }
    rect(10, height-40 - (39*i), 30, 28);
  }

  int num_L = round(player.left .level() * 10 * 1.2);
  int num_R = round(player.right.level() * 10 * 1.2);

  for (int i = 0; i < num_L; i++) {
    if (i < 5) {
      fill(colorPack.low);
    } else if (i < 9) {
      fill(colorPack.mid);
    } else {
      fill(colorPack.high);
    }
    rect(10, height-40 - (39*i), 6, 28);
    rect(10, height-40 - (39*i), 12, 28, 10);
  }

  for (int i = 0; i < num_R; i++) {
    if (i < 5) {
      fill(colorPack.low);
    } else if (i < 9) {
      fill(colorPack.mid);
    } else {
      fill(colorPack.high);
    }
    rect(34, height-40-(39*i), 6, 28);
    rect(28, height-40 - (39*i), 12, 28, 10);
  }
  stroke(colorPack.stroke);
}

public void drawSongs() {

  textAlign(LEFT);
  textSize(30);
  fill(colorPack.alt);

  text(songNum+1+": "+mp3s.get(songNum), 610, 35);

  textSize(20); 
  fill(colorPack.stroke);

  for (int i = songNum+1; i < mp3s.size(); i++) {
    if (i - songNum <= 10) {
      text(i+1+": "+mp3s.get(i), 610, 35+30*abs(songNum - i));
    }
    if (songNum > mp3s.size()-11 && i == mp3s.size()-1) {
      text("-------------------------------", 605, 35+30*abs(songNum-i-1));
    }
  }
}
