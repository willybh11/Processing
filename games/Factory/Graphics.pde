
public void drawGrid() {

	pushMatrix();
	translate(50,50);
	strokeWeight(1);
	stroke(150);

	for (int row = 0; row < 15; row++) {
		for (int col = 0; col < 15; col++) {

			BuildingObject square = grid[row][col];

			fill(square.rgb);
			rect(col*50,row*50,50,50);
		}
	}

	popMatrix();
}

public void drawBuildMenu() {

	pushMatrix();
	translate(850,50);
	fill(255);
	rect(0,0,500,750);
	popMatrix();
}

public void drawInventory() {

	pushMatrix();

	translate(50,850);
	fill(255);
	rect(0,0,1300,100);

	fill(0);

	for (int i = 0; i < inventory.length; i++) {
		fill(0);
		textSize(24);
		text(itemNames[i],50 + 100*i,30);
		textSize(20);
		text(inventory[i],50 + 100*i,53);

		stroke(150);
		strokeWeight(1);
		line(100*(i+1),0,100*(i+1),100);

		switch(itemNames[i]) {
			case "Iron Ore":
			drawIronOre(50 + 100*i,75);
			break;
			case "Iron Bar":
			drawIronBar(50 + 100*i,75);
			break;
		}
	}

	popMatrix();
}

public void drawMouse() {
	if (mouseX < 800 && mouseX > 50 && mouseY < 800 && mouseY > 50) {
		int col = mouseY / 50;
		int row = mouseX / 50;

		stroke(255,0,0);
		strokeWeight(3);
		noFill();
		rect(row*50,col*50,50,50);
	} else {
		fill(255,0,0);
		noStroke();
		rect(mouseX-1,mouseY-10,2,20);
		rect(mouseX-10,mouseY-1,20,2);
	}
}