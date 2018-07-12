
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

Minim[] minim = new Minim[21];
AudioPlayer[] players = new AudioPlayer[21];
FFT[] ffts = new FFT[21];
String[] filenames;
String dragState;
ArrayList<String> mp3s;
PFont font_100;
PFont font_80;
PFont font_35;
PFont font_20;
PFont font_18;
PFont font_15;
int current;


void setup() {
  size(1100, 600, P3D);
  current = 0;  
  filenames = new File(dataPath("")).list();
  mp3s = new ArrayList<String>();

  for (int i = 0; i < filenames.length; i++) {
    if (filenames[i].endsWith(".mp3")) {
      mp3s.add(split(filenames[i], ".mp3")[0]);
    }
  }
  
  java.util.Collections.sort(mp3s);

  for (int i = 0; i < mp3s.size(); i++) {
    minim[i] = new Minim(this);
    players[i] = minim[i].loadFile(mp3s.get(i)+".mp3");
    ffts[i] = new FFT(players[i].bufferSize(), players[i].sampleRate());
  }

  font_100= loadFont("Montserrat-Regular-100.vlw");
  font_80 = loadFont("Montserrat-Regular-80.vlw");
  font_35 = loadFont("Montserrat-Regular-35.vlw");
  font_20 = loadFont("Montserrat-Regular-20.vlw");
  font_18 = loadFont("Montserrat-Regular-18.vlw");
  font_15 = loadFont("Montserrat-Regular-15.vlw");
  textFont(font_15, 15);
}

void draw() {
  background(0);
  
  AudioPlayer player = players[current];
  FFT fft = ffts[current];

  drawStructure();
  drawPosition_1     (player);
  drawWaveform       (player);
  drawPosition_2     (player);
  drawBalance        (player);
  drawLevel          (player);
  drawGain           (player);
  drawButtons        (player);
  drawEQ        (fft, player);
  drawTime           (player);
  drawSongs(players, mp3s, player);
}

void mouseDragged() {

  if (dragState == "balance") {
    float newBalance = map(min(200, max(1, mouseY)), 1, 200, -1, 1);
    players[current].setBalance(newBalance);
  }

  if (dragState == "gain") {
    float newGain = map(min(580, max(201, mouseY)), 201, 580, 6, -30);
    players[current].setGain(newGain);
  }

  if (dragState == "none") {
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
      if (current == 0) { 
        current = mp3s.size()-1;
      } else {
        current--;
        players[current].play();
      }
    } else {
      players[current].rewind();
      players[current].pause();
    }
  } else if (get(mouseX, mouseY) == color(3)) {
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
  } else if (get(mouseX, mouseY) == color(4)) {
    if (!players[current].isMuted()) {
      players[current].mute();
    } else {
      players[current].unmute();
    }
  } else if (get(mouseX, mouseY) == color(5) || get(mouseX, mouseY) == color(0, 254, 0)) {
    players[current].setGain(0);
  } else if (get(mouseX, mouseY) == color(6) || get(mouseX, mouseY) == color(0, 253, 0)) {
    players[current].setBalance(0);
  }
}

void keyPressed() {
  if ( players[current].isPlaying() && key == ' ' ) {
    players[current].pause();
  } else if (key == ' ') {
    players[current].play();
  }
}
