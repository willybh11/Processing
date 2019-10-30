
class Particle {

	PVector pos, vel;
	boolean homing, inIntro;
	int xMin, xMax, yMin, yMax;

	public Particle(float x, float y, float velX, float velY, boolean h, int xmin, int xmax, int ymin, int ymax, boolean i) {
		pos = new PVector(x, y);
		vel = new PVector(velX,velY);
		homing = h;
		inIntro = i;
		xMin = xmin;
		xMax = xmax;
		yMin = ymin;
		yMax = ymax;
	}

	void update() {

		vel.y += 0.15;

		if (pos.x <= xMin) {
			vel.x *= 0.5;
			pos.x = xMin + 1;
		} else if (pos.x >= xMax) {
			vel.x *= -0.5;
			pos.x = xMax - 1;
		}

		if (pos.y <= yMin) {
			vel.y *= 0.5;
			pos.y = yMin + 1;
		} else if (pos.y >= yMax) {
			vel.y *= -0.5;
			pos.y = yMax - 1;
		}

		pos.add(vel);
	}

	void drawMe() {
		fill(255,0,0);
		noStroke();
		ellipse(pos.x,pos.y,10,10);
	}
}
class IntroParticle {

	PVector pos, vel;

	public Particle(float x, float y, float velX, float velY) {
		pos = new PVector(x, y);
		vel = new PVector(velX,velY);
	}

	void update() {

		vel.y += 0.15;

		if (pos.x <= xMin) {
			vel.x *= 0.5;
			pos.x = xMin + 1;
		} else if (pos.x >= xMax) {
			vel.x *= -0.5;
			pos.x = xMax - 1;
		}

		if (pos.y <= yMin) {
			vel.y *= 0.5;
			pos.y = yMin + 1;
		} else if (pos.y >= yMax) {
			vel.y *= -0.5;
			pos.y = yMax - 1;
		}

		pos.add(vel);
	}

	void drawMe() {
		fill(255,0,0);
		noStroke();
		ellipse(pos.x,pos.y,10,10);
	}
}