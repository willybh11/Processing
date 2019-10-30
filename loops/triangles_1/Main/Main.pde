
ArrayList<Triangle> tris = new ArrayList<Triangle>();

void setup() {
	size(800,800);
	// noStroke();

	for (int i = 0; i < 6; i++) {
		tris.add(new Triangle(i*60, i%2 == 0));
	}
}

void draw() {
	background(0);

	translate(width/2,height/2);

	int frame = frameCount % 240;

	if (frame == 0) {
		for (Triangle tri : tris) {
			if (tri.offset) tri.offset = false;
			else tri.offset = true;
		}
	}

	if (frame < 60) {
		for (Triangle tri : tris) {
			if (tri.offset) tri.y[0] = tri.y[0] - 2;
		}
	} else if (frame < 120) {
		for (Triangle tri: tris) {
			if (tri.offset) tri.rot[0] = tri.rot[0] + 2;
			else tri.rot[0] = tri.rot[0] - 2;
		}
	} else if (frame < 180) {
		for (Triangle tri : tris) {
			if (tri.offset) tri.y[0] = tri.y[0] + 2;
		}
	} else if (frame < 240) {
		for (Triangle tri : tris) {
			tri.rot[0] = tri.rot[0] + 1.5;
		}
	}

	for (int i = 0; i < tris.size(); i++) {
		tris.get(i).drawMe();
	}
}

class Triangle {

	float[] y 		= {0,0,0};
	float[] rot 	= new float[3];
	int[] 	colors 	= { color(255,0,0,50), color(0,255,0,50), color(0,0,255,50)};

	boolean offset;

	public Triangle(float r, boolean o) {

		for (int i = 0; i < 3; i++)
			rot[i] = r;

		offset = o;
	}

	void drawMe() {

		for (int i = 0; i < 3; i++) {
			pushMatrix();

			fill(colors[i]);
			rotate(radians(rot[i]));
			equilateralTriangle(0,y[i],80);

			popMatrix();
		}

		for (int i = 1; i < 3; i++) {
			if (y[i] < y[i-1] && y[i-1] > 20)
				y[i] += 10;
		}

	}

	void equilateralTriangle(float x, float y, float h) {

		triangle(x,y,x-(h/sqrt(3)),y-h,x+(h/sqrt(3)),y-h);
	}
}