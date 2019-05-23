
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
ArrayList<String> mp3s = new ArrayList<String>();

int score;
float lastIncrease;
float scoreSize;
int opacity;
color bgColor;
int resetTime;

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

	scoreSize = 30;
	opacity = 0;
	lastIncrease = -200;
	//systemStart = 0;
	bgColor = color(255);

	for (String f : new File(dataPath("")).list()) {
		if (f.endsWith(".mp3"))
			mp3s.add(split(f, ".mp3")[0]);
	}

	player = minim.loadFile(mp3s.get(0)+".mp3");
	fft = new FFT(player.bufferSize(), player.sampleRate());

	luvuneedu();
}

void draw() {

	takeSerialInput();

	background(bgColor);

	setGradient(0,height - 150,width,100,0,255,1);
	setGradient(0,height - 250,width,100,255,0,1);

	drawHits();
	drawCircles();
	drawUI();
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == 1) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == 2) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }

  noStroke();
}

void reset() {
	player.rewind();
	score = 0;
	lastIncrease = 0;

	for (Hit hit : hits) {
		hit.reset();
	}

	systemStart = (int)System.currentTimeMillis();
}

void drawCircles() {
	for (int i = 0; i < circles.size(); i++) {
		if (circles.get(i).alpha <= 0) {
			circles.remove(i);
		} else
		circles.get(i).drawMe();
	}
}

void drawUI() {

	if (frameCount <= 180)
		countdown();

	scoreSize = 30 + max(0,map(millis() - lastIncrease,0,200,30,0));

	textSize(scoreSize);
	fill(0,opacity);
	text(score,width/2,50);

	rectMode(CENTER);
	// rect(width/2, height-150, width, 200); // line

	scoreSize = map(millis() - lastIncrease,0,200,70,90);

	float tempOpacity = map(millis() - lastIncrease,0,200,50,0);

	textSize(scoreSize);
	fill(0,tempOpacity);	
	text(score,width/2,70);


}

void countdown() {
	if (frameCount == 180) {
		player.play();
		reset();
	}
	else {
		opacity += 255 / 180;
		textSize(250);
		fill(0);
		text( 3 - frameCount / 60, width/2, height-250);
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
