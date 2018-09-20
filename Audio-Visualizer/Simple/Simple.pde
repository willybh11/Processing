
//balance: scale from -1 to 1
//level:   scale from  0 to 1

import ddf.minim.*;
import ddf.minim.analysis.*;
import java.io.File;
import processing.serial.*;

Minim minim = new Minim(this);
AudioPlayer player;
FFT fft;
Serial myPort;

Green colorPack = new Green();

ArrayList<String> mp3s = new ArrayList<String>();

int[] bigNums   = new int[]{10, 100, 300, 600, 1200, 2400, 4800, 9600, 20000 };
int[] smallNums = new int[]{10, 55, 100, 200, 300, 450, 600, 900, 1200, 1800, 2400, 3600, 4800, 6200, 9600, 12000, 20000 };

int songNum = 0;
String dragState = "none";
String seconds;

final static boolean ARDUINO = false;

void setup() {
  size(850, 400, P3D);

  //set up serial port to send data through
  if (ARDUINO)
    myPort = new Serial(this, Serial.list()[0], 9600);

  //turn local directory into list of mp3 names
  for (String f : new File(dataPath("")).list()) {
    if (f.endsWith(".mp3"))
      mp3s.add(split(f, ".mp3")[0]);
  }
  java.util.Collections.sort(mp3s);

  player = minim.loadFile(mp3s.get(0)+".mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());

  textFont(loadFont("Montserrat-Regular-100.vlw"));
}

void draw() {

  background(0);

  drawStructure();
  drawWaveform();
  drawLevel();
  drawEQ();
  drawSongs();
  drawTime();
  drawPause();
  
  //println(mouseX,mouseY);
}
