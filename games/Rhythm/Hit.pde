
public class Hit {
	float time;
	float beatLength;
	float beats;
	boolean dir; // left: true
	boolean struck;
	int offset;

	public Hit(float beatss, boolean direction, int newOffset) {
		dir = direction;
		beats = beatss;
		struck = false;
		offset = newOffset;//3500;
		beatLength = 408.16; // bpm : 147
		time = offset + beatLength * beats;
	}

	void reset() {
		struck = false;
		offset = -300; // !
		time = offset + beatLength * beats;
	}

	void setStruckness(boolean struckness) {
		if (struckness) {
			struck = struckness;
			score += 10;
			lastIncrease = millis();
			circles.add(new Explosion(dir,millis() + height - 150 - time));
		}
	}
}