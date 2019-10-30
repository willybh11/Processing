
void preTitleScreen() {

}

void titleScreen() {

	introParticles.add(new Particle(random(0,800),random(-500,-10),random(-0.5,0.5),random(-0.5,0.5),false,0,800,-501,800,true));

	for (Particle particle : introParticles) {
		particle.update();
		particle.drawMe();
	}
}w