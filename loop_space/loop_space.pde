// 1 year = 10 seconds = 600 frames

ArrayList<Planet> planets;
Planet luna;

void setup() {
  size(800, 800);
  noStroke();

  planets = new ArrayList<Planet>() {{
    add(new Planet(59, 50, 6, color(200, 80, 5)));      // mercury
    add(new Planet(229,70,15, color(245,230,190)));     // venus
    add(new Planet(365,90,16, color(60,60,255)));       // Earth
    add(new Planet(687,110,8, color(255,130,90)));      // Mars
    add(new Planet(4330,200,160, color(245,70,15)));    // Jupiter
    add(new Planet(30000,320,60, color(200,250,250)));  // Uranus
    add(new Planet(60000,390,60, color(40,50,200)));    // Neptune
  }};
  
  luna = new Planet(28,15,4,color(150));
}

void draw() {
  background(15, 0, 45);
  translate(width/2, height/2);

  //Sol
  fill(255, 255, 115);
  ellipse(0, 0, 60, 60);

  for (int i = 0; i < planets.size(); i++) {
    planets.get(i).Update();
  }
  
  luna.origin = planets.get(2).pointOnCircle();
  luna.Update();
}
