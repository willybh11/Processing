
public class Explosion {

	int x;
	float startTime;
	float alpha;
	float size;

	public Explosion(boolean direction) {
		if (direction)
			x = 175;
		else 
			x = width-175;
		startTime = millis();
		alpha = 255;
	}

	void drawMe() {

		noStroke();

		alpha = map(millis() - startTime, 0, 200, 255,  0);
		size  = map(millis() - startTime, 0, 200, 50, 100);

		fill(0,255,0,alpha);

		ellipse(x,height-150,size,size);
	}
};