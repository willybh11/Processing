
ArrayList<Stem> stems = new ArrayList<Stem>();
ArrayList<Flower> flowers = new ArrayList<Flower>();

boolean flowering = false;


void setup() {
	size(800,800);
	stroke(80,60,40);
	fill(120,240,60);

	stems.add(new Stem(width/2,height,0,30));
}

void draw() {
	if (!flowering) grow();
	else flower();
}

void grow() {
	for (int i = 0; i < stems.size(); i++) {
		if (stems.get(i).update()) stems.remove(i);	
	}
}

void flower() {
	for (Flower flower : flowers) {
		flower.update();
	}
}

void mouseClicked() {
	flowering = true;
	noStroke();

	for (Stem stem : stems) {
		flowers.add(new Flower(stem.pos.x,stem.pos.y,stem.angle,color(255,0,0)));
	}
}

class Flower {

	PVector origin;
	float angle;
	color flowerColor;

	public Flower(float x, float y, float a, color c) {
		origin = new PVector(x,y);
		angle = a;
		flowerColor = c;
	}

	void update() {

		pushMatrix();
		translate(origin.x,origin.y);
		// rotate(angle);
		fill(flowerColor);

		ellipse(0,0,5,5);

		popMatrix();

	}
}

class Stem {

	PVector pos;
	PVector vel;
	float angle;
	int size;

	public Stem(float x, float y, float a, float s) {
		pos = new PVector(x,y);
		vel = new PVector(0,-1).rotate(radians(a));
		angle = a;
		size = int(s);
	}

	boolean update() {

		if (int(random(50)) == 1) {
			stems.add(new Stem(pos.x,pos.y,angle-20,size*0.75));
			stems.add(new Stem(pos.x,pos.y,angle+20,size*0.75));
			return true;
		} else {
			pos.add(vel);
			ellipse(pos.x,pos.y,size,size);
			return false;
		}
	}
}