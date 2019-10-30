
import ddf.minim.*;
import ddf.minim.analysis.*;
import java.io.File;
import processing.serial.*;

Minim minim = new Minim(this);
AudioPlayer player;
FFT fft;

Serial myPort;

ArrayList<Hit> hits = new ArrayList<Hit>();
ArrayList<Explosion> circles = new ArrayList<Explosion>();

String mp3;

int score 				= 0;
float lastIncrease 		= -200;
float scoreSize 		= 30;
int opacity 			= 0;
int whenToStartPlaying 	= 0; // in frames

int systemStart = (int)System.currentTimeMillis();

final boolean left = true;
final boolean right = false;

boolean midStroke = false;

int millis() {
	return (int)System.currentTimeMillis() - systemStart;
}

void setup() {
	size(800, 600);
	noStroke();
	textAlign(CENTER);
	ellipseMode(CENTER);

	myPort = new Serial(this, Serial.list()[4], 9600);

	for (String f : new File(dataPath("")).list())
		if (f.endsWith(".mp3"))	mp3 = f;

	player = minim.loadFile(mp3);
	fft = new FFT(player.bufferSize(), player.sampleRate());
}

void draw() {

	background(255);
	takeSerialInput();

	int timer = whenToStartPlaying - frameCount;

	if (whenToStartPlaying == 0 && !player.isPlaying())	drawInstructions();
	if (score == -25 && whenToStartPlaying == 0)		whenToStartPlaying = frameCount + 179;
	if (timer <= 180 && timer >= 0)						countdown();

	drawUI();
	drawHits();
	drawCircles();
	
}

void drawInstructions() {
	fill(0);
	textSize(55);
	text("Will and Leo's Rhythm Game",width/2,70);
	textSize(30);
	text("Hit each dot as it passes through the grey box!\nHits are detected by SPEED, not position.\nThat is speed of ROTATION along the Y axis.\nSmall, quick flicks are the most effective!\nRemember to Leave space to flick in either\ndirection up to 3 or 4 times.\nPress 'r' to reset the song, or 'q' to quit!",width/2,165);

	rect(50,105,700,5);
	rect(50,480,700,5);

	String text = "Flick the controller " + str(5 - score/-5);
	if (5 - score/-5 > 1)	text += " more times to begin.";
	else 					text += " more time to begin.";

	text(text,width/2,550);
}

void reset() {
	player.rewind();
	score = 0;
	lastIncrease = 0;

	systemStart = (int)System.currentTimeMillis();
	hits = new ArrayList<Hit>();
	circles = new ArrayList<Explosion>();

	luvuneedu(millis());
}

void drawCircles() {
	for (int i = 0; i < circles.size(); i++) {
		if (circles.get(i).alpha <= 0)
			circles.remove(i);
		else
			circles.get(i).drawMe();
	}
}

void drawUI() {

	scoreSize = 30 + max(0,map(millis() - lastIncrease,0,200,30,0));

	textSize(scoreSize);
	fill(0,opacity);
	text(score,width/2,50);

	rectMode(CORNER);
	fill(200,opacity);
	rect(0,height-250,width,200);

	scoreSize = map(millis() - lastIncrease,0,200,70,90);

	float tempOpacity = map(millis() - lastIncrease,0,200,50,0);

	textSize(scoreSize);
	fill(0,tempOpacity);	
	text(score,width/2,70);
}

void countdown() {
	score = 0;

	if (frameCount == whenToStartPlaying) {
		player.play();
		luvuneedu(millis());
		reset();
	}
	else if (frameCount < whenToStartPlaying) {
		opacity += 255 / 180;
		textSize(250);
		fill(0);
		text(1 + (whenToStartPlaying - frameCount) / 60, width/2, height-250);
	}
}

void drawHits() {

	for (Hit i : hits) {
		if (i.time - millis() > height) break;
		if (i.time - millis() < -200) continue;
		if (i.struck) continue;
		
		fill(255, 0, 0);
		
		if (i.dir) ellipse(175, millis() - i.time + height - 150, 50, 50); // left
		else ellipse(width-175, millis() - i.time + height - 150, 50, 50); // right
		
	}
}
