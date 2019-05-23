
public class Explosion {

	int x;
	float y;
	float startTime;
	float alpha;
	float size;

	public Explosion(boolean direction, float newY) {
		if (direction)
			x = 175;
		else 
			x = width-175;
		startTime = millis();
		alpha = 255;
		y = newY;
	}

	void drawMe() {

		noStroke();

		alpha = map(millis() - startTime, 0, 200, 255,  0);

		size  = map(millis() - startTime, 0, 200, 50, 100);

		fill(0,255,0,alpha);

		ellipse(x,y/*height-150*/,size,size);
	}
};