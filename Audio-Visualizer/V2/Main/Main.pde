 
import ddf.minim.*;
import ddf.minim.analysis.*;
import java.io.File;
import processing.serial.*;

Minim minim = new Minim(this);
AudioPlayer player;
AudioPlayer oldPlayer;
FFT fft; 

ArrayList<String> mp3s = new ArrayList<String>();
ArrayList<String> albums = new ArrayList<String>();

int[] bigNums   = new int[]{10, 100, 300, 600, 1200, 2400, 4800, 9600, 20000 };
int[] smallNums = new int[]{10, 55, 100, 200, 300, 450, 600, 900, 1200, 1800, 2400, 3600, 4800, 6200, 9600, 12000, 20000 };

int songNum = 0;
int albumNum = 0;
String path;

boolean inAlbum = false;

color bg = color(0);
color waveform = color(255);
color stroke = color(255, 255, 255);
color alt = color(150, 50, 255);
color levels = color(150, 50, 255);
color timeLine = color(255);
color timeFill = color(70);
color low = color(165, 0, 255);
color mid = color(200, 100, 255);
color high = color(220, 200, 255);

void setup() {
  size(850, 400);//, P3D);

  //turn local directory into list of mp3 names
  for (String f : new File(dataPath("")).list()) {
    if (f.endsWith(".mp3"))			mp3s.add(split(f, ".mp3")[0]);
    else if (!f.endsWith(".vlw"))	albums.add(f);
  }
  java.util.Collections.sort(mp3s);
  java.util.Collections.sort(albums);

  player = minim.loadFile(mp3s.get(0)+".mp3"); // this will load 20-20
  oldPlayer = player;
  fft = new FFT(player.bufferSize(), player.sampleRate());

  textFont(loadFont("Montserrat-Regular-100.vlw"));
}

void draw() {

  background(0);

  drawStructure();
  drawWaveform();
  drawLevel();
  drawEQ();
  if (inAlbum) 	drawSongs();
  else  		drawAlbums();
  drawTime();
  drawPause();
  autoPlay();
}
