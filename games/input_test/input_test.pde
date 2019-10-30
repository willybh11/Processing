
float totalTime;

import ddf.minim.*;
import ddf.minim.analysis.*;
import java.io.File;

Minim minim = new Minim(this);
AudioPlayer player;
FFT fft;
ArrayList<String> mp3s = new ArrayList<String>();


void setup() {
	size(100,100);

	for (String f : new File(dataPath("")).list()) {
		if (f.endsWith(".mp3"))
			mp3s.add(split(f, ".mp3")[0]);
	}

	player = minim.loadFile(mp3s.get(0)+".mp3");
	fft = new FFT(player.bufferSize(), player.sampleRate());
}

void draw() {

	textSize(20);
	fill(0);

	if (frameCount == 180)
		player.play();
	else if (frameCount < 180)
		text(frameCount,width/2,height/2);

	background(255);
	totalTime = (frameCount / 60.0 ) * 1000.0;
}

void keyPressed() {
	println((totalTime - 3000) / 408.6);
}