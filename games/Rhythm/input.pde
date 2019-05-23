
void keyPressed() {
	print(round(((millis() - 3600) / 408.6)*4)/4.0);

	if (key == CODED) {
		switch(keyCode) {
			case LEFT:
			strike(true);
			println("\tleft");
			break;
			case RIGHT:
			strike(false);
			println("\tright");
			break;
		}
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
					println(e);
				}
			}
		}

		println(n);

		if (n > 30 && !midStroke) {
			midStroke = true;
			strike(false);
		} else if (n < -30 && !midStroke){
			midStroke = true;
			strike(true);
		} else if (midStroke && abs(n)<20){
			midStroke = false;
		}

        // if (n > 30)       strike(false);  //right
        // else if (n < -30) strike(true);   // left
}
}

void strike(boolean dir) {
	for (Hit i : hits) {
		if (  (dir == i.dir) && (millis() > i.time - 100) && (millis() < i.time + 100) ) {
			i.setStruckness(true);
			return;
		}
	}
	score -= 5;
}
