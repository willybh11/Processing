
import ddf.minim.*;
import ddf.minim.analysis.*;
import java.io.File;

Minim minim = new Minim(this);
AudioPlayer player;
FFT fft;

ArrayList<Hit> hits = new ArrayList<Hit>();
ArrayList<Explosion> circles = new ArrayList<Explosion>();
ArrayList<String> mp3s = new ArrayList<String>();

int score;
float lastIncrease;
float scoreSize;
int opacity;

final int systemStart = (int)System.currentTimeMillis();

final boolean left = true;
final boolean right = false;

int millis() {
	return - systemStart + (int)System.currentTimeMillis() ;
}

void setup() {
	size(800, 600);
	noStroke();
	textAlign(CENTER);
	ellipseMode(CENTER);

	scoreSize = 30;
	opacity = 0;

	for (String f : new File(dataPath("")).list()) {
		if (f.endsWith(".mp3"))
			mp3s.add(split(f, ".mp3")[0]);
	}

	player = minim.loadFile(mp3s.get(0)+".mp3");
	fft = new FFT(player.bufferSize(), player.sampleRate());

	luvuneedu();
}

void draw() {
	background(255);

	drawHits();
	drawCircles();
	drawUI();
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

	rect(0, height-150, width, 10); // line
}

void countdown() {
	if (frameCount == 180)
		player.play();
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
