ArrayList<Car> cars = new ArrayList<Car>();
color grass   = color(58, 175, 67);
color dark    = color(100, 100, 100);
color asphalt = color(144, 144, 144);
color border1 = color(255, 139, 139);
color border2 = color(232, 229, 229);
color text    = color(27, 44, 180);
color p1C     = color(40, 159, 247);
color p2C     = color(240, 0, 28);
color p3C     = color(0, 255, 0);
color p4C     = color(250, 109, 248);
boolean[] p1K = new boolean[4]; //[w,s,a,d]
boolean[] p2K = new boolean[4]; //[up,down,left,right]
boolean[] p3K = new boolean[4]; //[t,g,f,h]
boolean[] p4K = new boolean[4]; //[i,j,k,l]
PVector mid   = new PVector(850, 450);
float h;
float n;
float x;
float y;

void setup() {
  size(1700, 900);
  cars.add(new Car(500, 110));
  cars.add(new Car(500, 190));
  cars.add(new Car(400, 110));
  cars.add(new Car(400, 190));
}

void draw() {

  drawTrack();
  drawControls();
  drawFinishLine();
  drawLaps();

  lapCheck();

  cars.get(0).update(p1K, p1C);
  cars.get(1).update(p2K, p2C);
  cars.get(2).update(p3K, p3C);
  cars.get(3).update(p4K, p4C);
}

void lapCheck() {
  for (int i = 0; i < 4; i++) {
    h = abs(PVector.sub(cars.get(i).pos, mid).heading());
    x = cars.get(i).pos.x;
    y = cars.get(i).pos.y;
    n = cars.get(i).n;
    if (n == 0 && h > 0.4 && h < 0.6) { //bottom right check
      cars.get(i).n++;
    }
    if (n == 1 && h < 2.55 && h > 2.45) { //top left check
      cars.get(i).n++;
    }
    if (x > 550 && x < 590 && y > 70 && y < 250) { //finish line check
      if (n == 2) {
        cars.get(i).laps++;
      }
      cars.get(i).n = 0;
    }
  }
}