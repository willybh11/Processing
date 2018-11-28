
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

int[] bigNums   = new int[]{10, 100, 300, 600, 1200, 2400, 4800, 9600, 20000 };
int[] smallNums = new int[]{10, 55, 100, 200, 300, 450, 600, 900, 1200, 1800, 2400, 3600, 4800, 6200, 9600, 12000, 20000 };

int songNum = 0;
String dragState = "none";
String input = "";

boolean listening = false;

final static boolean ARDUINO = false;

ColorPack green_black = new ColorPack(
  /*bg*/        color(0),
  /*waveform*/  color(255),
  /*stroke*/    color(0,255,0),
  /*alt*/       color(50,150,250),
  /*levels*/    color(20,160,0),
  /*timeLine*/  color(255),
  /*timeFill*/  color(70),
  /*low*/       color(70,255,100),
  /*mid*/       color(255,255,70),
  /*high*/      color(255,0,0)
);

ColorPack red_white = new ColorPack(
  /*bg*/        color(255),
  /*waveform*/  color(0),
  /*stroke*/    color(255,0,0),
  /*alt*/       color(50,150,250),
  /*levels*/    color(255,50,80),
  /*timeLine*/  color(0),
  /*timeFill*/  color(200),
  /*low*/       color(255,50,80),//color(70,255,100),
  /*mid*/       color(200,50,250),//color(255,255,70),
  /*high*/      color(80,50,250)//color(255,0,0)
);

ColorPack gold_black = new ColorPack(
  /*bg*/        color(0),
  /*waveform*/  color(255),
  /*stroke*/    color(250,250,50),
  /*alt*/       color(150,50,255),
  /*levels*/    color(150,50,255),
  /*timeLine*/  color(255),
  /*timeFill*/  color(70),
  /*low*/       color(255,255,70),
  /*mid*/       color(255,150,50),
  /*high*/      color(255,0,0)
);

ColorPack purple_black = new ColorPack(
  /*bg*/        color(0),
  /*waveform*/  color(255),
  /*stroke*/    color(255,255,255),
  /*alt*/       color(150,50,255),
  /*levels*/    color(150,50,255),
  /*timeLine*/  color(255),
  /*timeFill*/  color(70),
  /*low*/       color(165,0,255),
  /*mid*/       color(200,100,255),
  /*high*/      color(220,200,255)
);

ColorPack blue_black = new ColorPack(
  /*bg*/        color(0),
  /*waveform*/  color(255),
  /*stroke*/    color(255,255,255),
  /*alt*/       color(150,50,255),
  /*levels*/    color(100,255,250),
  /*timeLine*/  color(255),
  /*timeFill*/  color(70),
  /*low*/       color(165,0,255),
  /*mid*/       color(200,100,255),
  /*high*/      color(220,200,255)
);

ColorPack colorPack = purple_black;

void setup() {
  size(850, 400, P3D);

  //set up serial port
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
