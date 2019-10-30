
ArrayList<IntroParticle> introParticles = new ArrayList<IntroParticle>();

int introStage = 0;
color bgColor;

PVector swarmTextPos;

void setup() {
	size(800,800);
	bgColor = 20;
}

void draw() {
	background(bgColor);

	switch(introStage) {
		case 0:
		preTitleScreen();
	}
}