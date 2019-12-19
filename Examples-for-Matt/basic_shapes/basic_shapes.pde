
void setup() {
  size(800,600);    // (width, height)
}

void draw() {  
  
  // background() draws the background. 
  background(255); // (red, green, blue)
  
  // fill() determines what color to FILL shapes with with.
  fill(0,255,0);   // (red, green, blue)
  
  // stroke() determines what color to draw LINES with.
  stroke(0,0,255); // (red, green, blue)
  
  // rect() draws from the top left corner of the rectangle. 
  rect(100,100,200,300); // (x, y, width, height)
  
  noStroke(); // let's NOT draw lines. 
  
  // ellipse() draws from the center.
  ellipse(500,400,100,200); // (x, y, vertical diameter, horizontal diameter)
  ellipse(600,400,50,50);
  
  // let's draw lines with a new color!
  stroke(255,0,0);
  
  // line() draws a line. Nice and simple!
  line(700,100,700,300); // (x1, y1, x2, y2)
  
  // color values can be RGB, but if you provide ONE value it will be monochrome. 0 is black and 255 is white.
  stroke(100);
  
  line(600,100,750,200);
  
  triangle(400,200,400,300,500,200); // (x1, y1, x2, y2, x3, y3)

}
