
PImage myImage;
int w,h;
color cp;
int sampleRate = 20;

void setup() {
	myImage = loadImage("bg_werewolf.jpg");
	w = myImage.width;
	h = myImage.height;
	size(1920,1080);
	smooth();
	frameRate(1);
}

void draw() {
	myImage = loadImage("bg_werewolf.jpg");
	showPixels();
}

void clear() {
	background(255);
	noStroke();
	ellipseMode(CORNER);
}

void showPixels() {
	clear();
	for (int j = 0; j < height; j += sampleRate) {
		for (int i = 0; i < width; i += sampleRate) {
			int index = j*myImage.width+i;
			float r = red(myImage.pixels[index]);
			float g = green(myImage.pixels[index]);
			float b = blue(myImage.pixels[index]);
			fill(r,g,b,255);
			ellipse(i,j,sampleRate,sampleRate);
		}
	}
	myImage.updatePixels();
}