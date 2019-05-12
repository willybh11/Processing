
BuildingObject[][] grid = new BuildingObject[15][15];

int[] inventory = {0,0};
String[] itemNames = {"Iron Ore", "Iron Bar"};

void setup() {

	size(1400,1000);
	noCursor();
	textAlign(CENTER);

	for (int i = 0; i < 15; i++) {
		for (int j = 0; j < 15; j++) {
			addBuildingObject("Empty",i,j);
		}
	}

	addBuildingObject("Iron Ore Patch",1,1);
	addBuildingObject("Iron Ore Patch",1,2);
	addBuildingObject("Iron Ore Patch",2,1);
	addBuildingObject("Iron Ore Patch",3,1);
	addBuildingObject("Iron Ore Patch",2,2);
}

void draw() {
	background(220);

	drawGrid();
	drawBuildMenu();
	drawInventory();

	drawMouse();
}

void addBuildingObject(String title, int row, int col) {

	int rgb = 0;

	switch(title) {
		case "Empty":
		rgb = color(255);
		break;
		case "Iron Ore Patch":
		rgb = color(120,150,170);
		break;
	}

	grid[row][col] = new BuildingObject(title,row,col,rgb);
}