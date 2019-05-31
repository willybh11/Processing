
void keyPressed() {
	// print(round(((millis() - 3600) / 408.6)*4)/4.0);

	if (key == CODED) {
		if (keyCode == LEFT)	strike(true);
		if (keyCode == RIGHT)	strike(false);
	} else {
		switch(key) {
			case 'r':
			case 'R':
			reset();
			break;
			case 'q':
			case 'Q':
			exit();
		}
	}
}

void takeSerialInput() {
	while (myPort.available() > 0) {

		String inBuffer = myPort.readString();
		int n = 0;

		if (inBuffer != null) {
			String trimmed = trim(inBuffer);
			if (trimmed.length() > 0) {
				try {
					n = Integer.parseInt(trimmed);
				} catch (NumberFormatException e) {
					println("CAUGHT TWO NUMBERS");
				}
			}
		}

		if (n == 327 && !midStroke)				strike(true);
		else if (n == -327 && !midStroke)		strike(false);
		else if (midStroke && abs(n) != 327)	midStroke = false;
	}
}

void strike(boolean dir) {

	midStroke = true;

	for (Hit i : hits) {
		if (  (dir == i.dir) && (millis() > i.time - 100) && (millis() < i.time + 100) ) {
			i.setStruckness(true);
			return;
		}
	}
	score -= 5;
}
