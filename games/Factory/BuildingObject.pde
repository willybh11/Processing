
abstract class EntityObject {

	int row;
	int col;
	int x;
	int y;
	String id;
	String type;
	boolean active;

	void drawMe() {}
	void update() {}
	boolean inputItem(String item) {
		return false;
	}

	void initXY(int newX, int newY) {
		x = newX;
		y = newY;
	}

	void initRowCol(int r, int c) {
		row = r;
		col = c;
		x = col*50 + 25;
		y = row*50 + 25;
	}
}

abstract class Building extends EntityObject {

	float startTime;
	float timeLimit;
	char outputDirection;
	boolean active;
	boolean full;
}

abstract class Environmental extends EntityObject {
}

abstract class Item extends EntityObject {
}

class IronOrePatch extends Environmental {

	public IronOrePatch(int a, int b, String coordType) {

		if (coordType == "rowcol")	initRowCol(a,b);
		else if (coordType == "xy")	initXY(a,b);

		id = "Iron Ore Patch";
		type = "Environmental";
	}

	@Override
	void drawMe() {
		fill(120,150,170);
		rect(x - 25,y - 25,50,50);
	}
}

class Empty extends EntityObject {

	public Empty(int a, int b, String coordType) {

		if (coordType == "rowcol")	initRowCol(a,b);
		else if (coordType == "xy")	initXY(a,b);

		id = "Empty";
		type = "Universal";
	}

	@Override
	void drawMe() {
		fill(255);
		stroke(150);
		strokeWeight(1);

		rect(x - 25,y - 25,50,50);
	}

	@Override
	boolean inputItem(String item) {
		addObjectToGrid(item,row,col,"rowcol"); // should destroy itself
		return true;
	}
}

class IronOre extends Item {

	public IronOre(int a, int b, String coordType) {

		if (coordType == "rowcol")	initRowCol(a,b);
		else if (coordType == "xy")	initXY(a,b);

		id = "Iron Ore";
		type = "Item";
	}

	@Override
	void drawMe() {
		fill(120,150,170);
		noStroke();
		ellipse(x,y,26,26);
	}
}

class IronBar extends Item {

	public IronBar(int a, int b, String coordType) {

		if (coordType == "rowcol")	initRowCol(a,b);
		else if (coordType == "xy")	initXY(a,b);

		id = "Iron Bar";
		type = "Item";
	}

	@Override
	void drawMe() {
		fill(170,200,200);
		noStroke();
		rect(x-13,y-5,26,10);
	}
}

class Smelter extends Building {

/*
change abstract Building into a hopper class!
have more advanced buildings (smelter, assembler, etc) EXTEND Hopper
hopper will function the same way that the smelter does with a non-smeltable item
maybe add a little delay? (.5 sec)
*/


	String oreID;
	EntityObject output;

	public Smelter(int a, int b, String coordType) {

		if (coordType == "rowcol")	initRowCol(a,b);
		else if (coordType == "xy")	initXY(a,b);

		id = "Smelter";
		type = "Building";
		outputDirection = 'E'; //east by default
		timeLimit = 3000; // 3 sec
		oreID = "Empty";
	}

	@Override
	void drawMe() {

		pushMatrix();
		translate(x,y); // center of tile
		fill(80);
		rect(-25,-25,50,50);

		if (full) {
			fill(0,255,0);
		} else if (active) {
			if (frameCount % 100 < 50)	fill(255,frameCount % 50 * 4,0);
			else 						fill(255,200 - (frameCount % 50 * 4),0);
		} else {
			fill(0);
		}

		ellipse(0,0,25,25);

		fill(0,255,0);
		noStroke();

		switch(outputDirection) {
			case 'W':
			rect(-20,-3,6,6);
			break;
			case 'E':
			rect(20,-3,6,6);
			break;
		}

		popMatrix();
	}

	@Override
	void update() {
		println(millis(),startTime + timeLimit,full);
		if (millis() >= startTime + timeLimit || full) {

			int outputRow = 0;
			int outputCol = 0;

			switch(outputDirection) {
				case 'N':
				outputRow = row-1;
				outputCol = col;
				break;
				case 'E':
				outputRow = row;
				outputCol = col+1;
				break;
				case 'S':
				outputRow = row+1;
				outputCol = col;
				break;
				case 'W':
				outputRow = row;
				outputCol = col-1;
				break;
			}

			switch(oreID) {
				case "Iron Ore":
				if (grid[outputRow][outputCol].inputItem("Iron Bar")) {
					active = false;
					oreID = "Empty";
					full = false;
					println("full set to false");
				} else {
					full = true;
					println("iron bar: full set to true");
				}
				break;
				case "Empty":
				break;
				default:
				if (grid[outputRow][outputCol].inputItem(oreID)) {
					active = false;
					oreID = "Empty";
					full = false;
				} else {
					full = true;
					println("default, full set to true");
				}
			}
		}
	}

	boolean inputItem(String ore) {
		if (!active && !full) {
			oreID = ore;
			startTime = millis();
			active = true;

			if (oreID != "Iron Ore") {
				startTime = 0;
			}
			return true;
		} else {
			return false;
		}
	}
}