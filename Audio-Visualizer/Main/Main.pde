
//balance: scale from -1 to 1
//level:   scale from  0 to 1

//bass: 10-100hz
//mid bass: 100-300hz
//low mid: 300-600hz
//midrange: 600hz-1.2kHz
//high mid: 1.2-2.4khz
//low treble: 2.4-4.8khz
//mid treble: 4.8-9.6khz
//high treble: 9.6-20khz

import ddf.minim.*;
import ddf.minim.analysis.*;
import java.io.File;

Minim[] minim = new Minim[14];
AudioPlayer[] players = new AudioPlayer[14];
FFT[] ffts = new FFT[14];
String dragState;
ArrayList<String> mp3s;
PFont font_100;
PFont font_35;
PFont font_15;
int current;
final static int PLAYPAUSE   = 10101;
final static int REWIND      = 20202;
final static int FASTFORWARD = 30303;
final static int MUTE        = 40404;
final static int BALANCE     = 50505;
final static int GAIN        = 60606;


void setup() {
  size(1100, 600, P3D);
  current = 0;  
  mp3s = new ArrayList<String>();
  dragState = "none";

  for (String f : new File(dataPath("")).list()) {
    if (f.endsWith(".mp3")) {
      mp3s.add(split(f, ".mp3")[0]);
    }
  }

  java.util.Collections.sort(mp3s);

  for (int i = 0; i < mp3s.size(); i++) {
    minim[i] = new Minim(this);
    players[i] = minim[i].loadFile(mp3s.get(i)+".mp3");
    ffts[i] = new FFT(players[i].bufferSize(), players[i].sampleRate());
  }

  font_100= loadFont("Montserrat-Regular-100.vlw");
  font_35 = loadFont("Montserrat-Regular-35.vlw");
  font_15 = loadFont("Montserrat-Regular-15.vlw");
  textFont(font_15, 15);
}

void draw() {

  println(hex(color(0, 254, 0), 6), int(hex(color(0, 254, 0))));

  background(0);

  AudioPlayer player = players[current];
  FFT fft = ffts[current];

  drawStructure();
  drawPosition_1          (player);
  drawWaveform            (player);
  drawPosition_2          (player);
  drawBalance             (player);
  drawLevel               (player);
  drawGain                (player);
  drawButtons             (player);
  drawEQ             (fft, player);
  drawTime                (player);
  drawSongs(players, mp3s, player);
}

void mouseDragged() {

  switch (dragState) {
  case "balance": 
    players[current].setBalance(map(min(200, max(1, mouseY)), 1, 200, -1, 1));
    break;
  case "gain": 
    players[current].setGain(map(min(580, max(201, mouseY)), 201, 580, 6, -30)); 
    break;
  case "none":
    if (mouseInBalanceBox()) {
      dragState = "balance";
    } else if (mouseInGainBox()) {
      dragState = "gain";
    }
  }
}

void mouseReleased() {
  dragState = "none";
}

void mouseClicked() {

  switch (int(hex(get(mouseX, mouseY), 6))) {
  case PLAYPAUSE: 
    if (players[current].isPlaying()) {
      players[current].pause();
    } else {
      players[current].play();
    }
    break;
  case REWIND: 
    if (players[current].position() != 0) {
      players[current].rewind();
      players[current].pause();
    } else if (current == 0) {
      current = mp3s.size()-1;
    } else {
      current--;
      players[current].play();
    }
    break;
  case FASTFORWARD: 
    for (int i = 0; i < mp3s.size(); i++) {
      if (i == current) {
        players[current].rewind();
        players[current].pause();
        if (current == mp3s.size()-1) {
          current = 0;
        } else {
          current++;
          players[current].play();
          break;
        }
      }
    }
    break;
  case MUTE: 
    if (!players[current].isMuted()) {
      players[current].mute();
    } else {
      players[current].unmute();
    }
    break;
  default: 
    if (get(mouseX, mouseY) == color(6) || get(mouseX, mouseY) == color(0, 254, 0)) {
      players[current].setGain(0);
    } else if (get(mouseX, mouseY) == color(5) || get(mouseX, mouseY) == color(0, 253, 0)) {
      players[current].setBalance(0);
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
