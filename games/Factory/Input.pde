
void keyPressed() {
	switch(key) {
		case 'q':
		case 'Q':
		exit();
	}
}

void mouseClicked() {

	if (mouseX < 800 && mouseX > 50 && mouseY < 800 && mouseY > 50) { // on grid
		int col = mouseX / 50 - 1;
		int row = mouseY / 50 - 1;

		String handType = entityType(itemInHands);
		String gridType = grid[row][col].type;

		if ( (handType == gridType || handType == "Universal" || gridType == "Universal") && gridType != "Environmental" ) { // swap

			String temp = itemInHands;
			itemInHands = grid[row][col].id;
			addObjectToGrid(temp,row,col,"rowcol");

		}

		if (handType == "Item" && gridType == "Building") {
			if (!grid[row][col].active) {
				grid[row][col].inputItem(itemInHands);
				itemInHands = "Empty";
			}
		}
	} else if (mouseX < 150 && mouseX > 50 && mouseY < 950 && mouseY > 850) { // on hands

		deconstruct(itemInHands);
		itemInHands = "Empty";

	} else if (mouseX < 1400 && mouseX > 200 && mouseY < 950 && mouseY > 850) { // on inv

		int cursorIndex = mouseX / 100 - 2;

		deconstruct(itemInHands);

		itemInHands = itemNames[cursorIndex];
		inventory[cursorIndex]--;

	} else if (mouseX < 1400 && mouseX > 850 && mouseY < 800 && mouseY > 50) {	// on build menu
		for (Button button : buildingButtons) {
			if (button.inBounds(mouseX,mouseY)) {

				for (int i = 0; i < buildingCosts[button.index].length; i++)
					inventory[i] -= buildingCosts[button.index][i];

				deconstruct(itemInHands);
				itemInHands = button.id;
			}
		}
	}
}