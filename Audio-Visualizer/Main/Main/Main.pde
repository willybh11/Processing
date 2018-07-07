
//balance: scale from -1 to 1
//level:   scale from  0 to 1

import ddf.minim.*;
import ddf.minim.analysis.*;
import java.io.File;

Minim[] minim = new Minim[21];
AudioPlayer[] players = new AudioPlayer[21];
FFT[] ffts = new FFT[21];
File folder;
String[] filenames;
String name;
ArrayList<String> mp3s;
PFont font_35;
PFont font_20;
PFont font_15;
int current;

void setup() {
  size(1100, 600, P3D);
  current = 0;  
  folder = new File(dataPath(""));
  filenames = folder.list();
  mp3s = new ArrayList<String>();

  for (int i = 0; i < filenames.length; i++) {
    if (filenames[i].endsWith(".mp3")) {
      mp3s.add(split(filenames[i], ".")[0]);
    }
  }

  for (int i = 0; i < mp3s.size(); i++) {
    //minim = (Minim[]) append(minim, new Minim(this));
    minim[i] = new Minim(this);
    //players = (AudioPlayer[]) append(players, minim[i].loadFile(mp3s.get(i)+".mp3"));
    players[i] = minim[i].loadFile(mp3s.get(i)+".mp3");
    //ffts = (FFT[]) append(ffts, new FFT(players[i].bufferSize(), players[i].sampleRate()));
    ffts[i] = new FFT(players[i].bufferSize(), players[i].sampleRate());
  }
  //player = players[current];
  //fft = new FFT(player.bufferSize(), player.sampleRate());

  font_35 = loadFont("Montserrat-Regular-35.vlw");
  font_20 = loadFont("Montserrat-Regular-20.vlw");
  font_15 = loadFont("Montserrat-Regular-15.vlw");
  textFont(font_15, 15);
}

void draw() {
  background(0);
  AudioPlayer player = players[current];
  FFT fft = ffts[current];

  drawPosition_1     (player);
  drawWaveform       (player);
  drawPosition_2     (player);
  drawBalance        (player);
  drawLevel          (player);
  drawGain           (player);
  drawSongs(players, mp3s, player);
  drawButtons        (player);
  drawEQ        (fft, player);
}

void mouseDragged() {
  if (mouseInBalanceBox()) {
    float newBalance = map(mouseY, 1, 200, -1, 1);
    players[current].setBalance(newBalance);
  } else if (mouseInGainBox()) {
    float newGain;
    if (isShortSlope()) {
      newGain = short_slope(mouseY);
      print("short");
    } else {
      newGain = steep_slope(mouseY);
      print("steep");
    }
    players[current].setGain(newGain);
    println(newGain);
  }
}

void mouseClicked() {
  if (get(mouseX, mouseY) == color(1)) {
    if (players[current].isPlaying()) {
      players[current].pause();
    } else {
      players[current].play();
    }
  } else if (get(mouseX, mouseY) == color(2)) {

    if (players[current].position() == 0) {
      players[current].rewind();
      players[current].pause();
      current--;
      players[current].play();
    } else {
      players[current].rewind();
      players[current].pause();
    }
  } else if (get(mouseX, mouseY) == color(3)) {
    for (int i = 0; i < mp3s.size(); i++) {
      if (i == current) {
        players[current].rewind();
        players[current].pause();
        current++;
        players[current].play();
        break;
      }
    }
  }
}

void keyPressed() {
  if ( players[current].isPlaying() && key == ' ' ) {
    players[current].pause();
  } else if (key == ' ') {
    players[current].play();
  }
}
