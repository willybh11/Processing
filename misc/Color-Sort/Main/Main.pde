
color[] grid = new color[10000]; // list of finished grid colors
IntList indices = new IntList(); // range of 10k, will be randomized
int hue = round(random(0, 100)); // spiice things up a bit

void setup() {
  noStroke();
  size(1000, 1000);
  colorMode(HSB, 100);                   // its easier to draw a grid when there are easy x and y variables (s,b)
  for (int i = 0; i < 100; i++) {
    for (int j = 0; j < 100; j++) {
      grid[100*i+j] = color(hue, j, i);  // put all colors in a list
      indices.append(i*100+j);           // add 1 to 'indices', up to 10k
    }
  }
  indices.shuffle(); // randomize starting grid
}

void draw() {
  if (sortGrid() != 0) {             // sortGrid both sorts the grid once and returns the number of pixels moved
    for (int i = 0; i < 5; i++) {   //change this value to change the speed of the sort
      sortGrid();
    }
  }
  drawGrid();
  //cycleColors();
}

void cycleColors() {
  hue = (hue + 1) % 100;                 //add 1 value to the hue
  for (int i = 0; i < 100; i++) {
    for (int j = 0; j < 100; j++) {
      grid[100*i+j] = color(hue, j, i);  // put all new colors in a list
    }
  }
}

int sortGrid() {
  int numMoved = 0;
  for (int i = 1; i < 10000; i++) {            // check every pixel
    if (indices.get(i) < indices.get(i-1)) {   // if the pixel to i's left is greater than i, they should switch
      int oldi = indices.get(i);               // store this for later
      indices.set(i, indices.get(i-1));        // set i to the pixel to its left
      indices.set(i-1, oldi);                  // set the pixel to i's left to i's old value
      numMoved++;                              // we moved a pixel
    }
  }
  return numMoved;
}

void drawGrid() {
  for (int i = 0; i < 100; i++) {         // treat grid like a 2D array,
    for (int j = 0; j < 100; j++) {  
      fill(grid[indices.get(100*i + j)]); // even though its really indexing a 1D list
      rect(j*10, i*10, 10, 10);           // a 'pixel' is actually 10x10
    }
  }
}
