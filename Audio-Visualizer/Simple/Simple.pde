
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

ArrayList<String> mp3s = new ArrayList<String>();
ArrayList<String> albums = new ArrayList<String>();

int[] bigNums   = new int[]{10, 100, 300, 600, 1200, 2400, 4800, 9600, 20000 };
int[] smallNums = new int[]{10, 55, 100, 200, 300, 450, 600, 900, 1200, 1800, 2400, 3600, 4800, 6200, 9600, 12000, 20000 };

int songNum = 0;
int albumNum = 0;
String path;

boolean inAlbum = false;
boolean paused = false;
boolean started = false;
boolean ARDUINO = false;

ColorPack colorPack = new ColorPack(
/*bg*/  color(0), 
/*waveform*/  color(255), 
/*stroke*/  color(255, 255, 255), 
/*alt*/  color(150, 50, 255), 
/*levels*/  color(150, 50, 255), 
/*timeLine*/  color(255), 
/*timeFill*/  color(70), 
/*low*/  color(165, 0, 255), 
/*mid*/  color(200, 100, 255), 
/*high*/  color(220, 200, 255)
  );

void setup() {
  size(850, 400, P3D);

  //set up serial port
  if (ARDUINO)
    myPort = new Serial(this, Serial.list()[0], 9600);

  //turn local directory into list of mp3 names
  for (String f : new File(dataPath("")).list()) {
    println(f);
    if (f.endsWith(".mp3"))
      mp3s.add(split(f, ".mp3")[0]);
    if (!f.endsWith(".vlw") && !f.endsWith(".mp3"))
      albums.add(f);
  }
  java.util.Collections.sort(mp3s);
  java.util.Collections.sort(albums);

  player = minim.loadFile(mp3s.get(0)+".mp3"); // this will load 20-20
  fft = new FFT(player.bufferSize(), player.sampleRate());

  textFont(loadFont("Montserrat-Regular-100.vlw"));
}

void draw() {

  background(0);

  drawStructure();
  drawWaveform();
  drawLevel();
  drawEQ();
  if (inAlbum) drawSongs();
  else  drawAlbums();
  drawTime();
  drawPause();

  if (!player.isPlaying() && !paused && started) {
    started = false;
    fastForward();
    playPause();
  }
}
