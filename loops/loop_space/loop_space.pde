
ArrayList<Planet> planets;
Planet luna;

PVector pos;

void setup() {
  size(1200, 1050);
  rectMode(CENTER);
  noStroke();

  planets = new ArrayList<Planet>() {{
    add(new Planet(59, 50, 6, color(200, 80, 5)));      // mercury
    add(new Planet(229,70,15, color(245,230,190)));     // venus
    add(new Planet(365,90,16, color(60,60,255)));       // Earth
    add(new Planet(687,110,8, color(255,130,90)));      // Mars
    add(new Planet(4330,200,160, color(245,70,15)));    // Jupiter
    add(new Planet(10755,380,144, color(224,222,158))); // Saturn
    add(new Planet(30688,490,60, color(150,200,250)));  // Uranus
    add(new Planet(60000,560,60, color(40,50,200)));    // Neptune
  }};
  
  luna = new Planet(28,15,4,color(150));
}

void draw() {
  background(15, 0, 45);
  translate(width/2, height/2);

  // Sol
  fill(255, 255, 115);
  ellipse(0, 0, 60, 60);

  // Planets
  for (int i = 0; i < planets.size(); i++) {
    planets.get(i).Update();
  }
  
  // Luna
  luna.origin = planets.get(2).pointOnCircle();
  luna.Update();
  
  // Jupiter's stripes
  pushMatrix();
  pos = planets.get(4).pointOnCircle();
  translate(pos.x,pos.y);
  fill(255,210,200);
  rect(0,30,145,20,10);
  rect(0,-25,150,40,40);
  fill(160,40,20);
  ellipse(-20,15,30,30);
  popMatrix();
  
  // Saturn's rings
  pushMatrix();
  pos = planets.get(5).pointOnCircle();
  translate(pos.x,pos.y);
  rotate(radians(60));
  fill(130,110,60);
  rect(0,0,300,20,10);
  popMatrix();
  
  // Uranus' ring
  pushMatrix();
  pos = planets.get(6).pointOnCircle();
  translate(pos.x,pos.y);
  noFill();
  stroke(255);
  rotate(radians(80));
  arc(0,0,150,30,radians(-69),radians(250));
  noStroke();
  popMatrix();
}
