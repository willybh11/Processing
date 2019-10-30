 HScrollbar angleScrollbar, angleStepScrollbar, frameRateScrollbar, numDiscsScrollbar, stretchFactorScrollbar;
 HScrollbar fadeMinScrollbar, fadeMaxScrollbar, dotMinSizeScrollbar, dotMaxSizeScrollbar;
 RectToggleButton loopAngleButton, fadeButton; 
 RectButton goldenAngleButton;
 int i = 0;
 int UIWidth = 410;
 int vizWidth = 510;
 int screenWidth = vizWidth + UIWidth;
 int screenHeight = vizWidth;
 int UIStartWidth = vizWidth;
 int UIStartHeight = 10;
 int vizStartWidth = 0;
 int vizStartHeight = 0;
 float currentAngle = 0.0;
 float goldenAngle = 137.5;  //or 222.5
 int timeLastDrawn = 0;
 int timeFadeStarted = 0;
 boolean wantFade = false;
int sbChunkSize = 45;  // amt of vert space allowed for each horiz scrollbar, used for layout in setup()
 
void setup()
{
  size(displayWidth, displayHeight);
  smooth();
  ellipseMode(CENTER);
//  frameRate(100);
//  noStroke();
//  noLoop();
 
  
  // draw the line between display area and UI.  dammit WTF?!
//  stroke(255);
//  line(0, UIStartHeight,screenWidth,UIStartHeight);


  PFont fontA = loadFont("Courier-14.vlw");
  // Set the font and its size (in units of pixels)
  textFont(fontA);
  

 // Define and create horizontal scrollbars    
  int thickerHSHeight = 14;
  int thinnerHSHeight = 14;
  
  angleScrollbar = new HScrollbar(UIStartWidth, UIStartHeight, UIWidth, thickerHSHeight, 1, 0, 360, 88); 
  angleStepScrollbar = new HScrollbar(UIStartWidth, UIStartHeight+sbChunkSize*2, UIWidth, thinnerHSHeight, 1, 0, 360, 0); 
  frameRateScrollbar = new HScrollbar(UIStartWidth, UIStartHeight+sbChunkSize*3, UIWidth, thinnerHSHeight, 1, 25, 2000, 50);
  numDiscsScrollbar = new HScrollbar(UIStartWidth, UIStartHeight+sbChunkSize*5, UIWidth, thickerHSHeight, 1, 1, 2000, 160);
  stretchFactorScrollbar = new HScrollbar(UIStartWidth, UIStartHeight+sbChunkSize*6, UIWidth, thickerHSHeight, 1, 1, 20, 10);
  fadeMinScrollbar = new HScrollbar(UIStartWidth, UIStartHeight+sbChunkSize*9, UIWidth/2-10, thickerHSHeight, 1, 20, 6000, 2500);
  fadeMaxScrollbar = new HScrollbar(UIStartWidth, UIStartHeight+sbChunkSize*10, UIWidth/2-10, thickerHSHeight, 1, 20, 6000, 4500);
  dotMinSizeScrollbar = new HScrollbar(UIStartWidth + UIWidth/2+10, UIStartHeight+sbChunkSize*9, UIWidth/2-10, thickerHSHeight, 1, 1, 30, 0); 
  dotMaxSizeScrollbar = new HScrollbar(UIStartWidth + UIWidth/2+10, UIStartHeight+sbChunkSize*10, UIWidth/2-10, thickerHSHeight, 1, 1, 30, 15);
  
 // Define and create buttons
  color buttoncolor = color(102);
  color highlight = color(51); 
  int buttonSize = 15;
  loopAngleButton = new RectToggleButton(UIStartWidth, int(UIStartHeight+sbChunkSize*1.3), buttonSize, buttoncolor, highlight, "loop through angles?");
  goldenAngleButton = new RectButton(UIStartWidth + UIWidth-buttonSize-2, UIStartHeight + 12, buttonSize, buttoncolor, highlight, "go to golden angle");  //(" + goldenAngle + ")" + '\u00B0');
  fadeButton = new RectToggleButton(UIStartWidth, int(UIStartHeight+sbChunkSize*8.3), buttonSize, buttoncolor, highlight, "fade discs?");

  timeLastDrawn = millis();
}

void draw()
{
  background(0);

  float setAngle = angleScrollbar.getTrueValue();  //closestHalf(angleScrollbar.getPos());
  if (setAngle!=137.5) { //special case: allow non-int angles *only* if user has selected golden angle .. other "irrationals" would be good, too
    setAngle = int(setAngle); 
  }
  
  float angleStepSize = int(angleStepScrollbar.getTrueValue());  //closestTenth((log(angleStepScrollbar.getTrueValue()) / log(10)) * 120.0);
  if (angleStepSize==0) { angleStepSize=0.03; }  //a hack to get a small value that makes the animation smooth (instead of just 0.0, which isn't very interesting)
  int frameRatePauseMillis = int(frameRateScrollbar.getTrueValue());
  int numFlorets = int(numDiscsScrollbar.getTrueValue());
  float stretchFactor = int(stretchFactorScrollbar.getTrueValue());
  int fadeMinRate = int(fadeMinScrollbar.getTrueValue());
  int fadeMaxRate = int(fadeMaxScrollbar.getTrueValue());
  int dotSizeMin = int(dotMinSizeScrollbar.getTrueValue());
  int dotSizeMax = int(dotMaxSizeScrollbar.getTrueValue());

  float loopStepValue = angleStepSize;  //radians(angleStepSize);
  angleScrollbar.update();
  if (!loopAngleButton.value) {
    angleScrollbar.display("seed angle: " + setAngle + '\u00B0');
  } else {
    float tempAngle = currentAngle + loopStepValue;
    angleScrollbar.display("seed angle: " + currentAngle + '\u00B0');  //hack: if we show setAngle while looping, we don't allow non-ints, which we could get by starting with the golden angle :P  so let's allow this here, only if we're looping.
  }
  angleStepScrollbar.update();
  angleStepScrollbar.display("looping angle step size: " + angleStepSize + '\u00B0');
  frameRateScrollbar.update();
  frameRateScrollbar.display("looping frame rate: " + closestTenth(1000.0 / frameRatePauseMillis) + " fps");
  numDiscsScrollbar.update();
  numDiscsScrollbar.display("number of discs: " + numFlorets);
  stretchFactorScrollbar.update();
  stretchFactorScrollbar.display("zoom: " + stretchFactor);
  loopAngleButton.update();
  loopAngleButton.display(false);  
  goldenAngleButton.update();
  goldenAngleButton.display(true);
  
  // DOT SIZE sliders
  fill(255);
  text("disc size range:", UIStartWidth + 0.5*UIWidth + 10, int(UIStartHeight+sbChunkSize*8.3)+16);
  dotMinSizeScrollbar.update();
  dotMaxSizeScrollbar.update();
  if (dotSizeMax<dotSizeMin) {    //min and max sliders need to affect each other
    // if max is too small, bump it up to where min dictates it should be
    dotMaxSizeScrollbar.sposMin = int(dotMaxSizeScrollbar.setPos(dotSizeMin, "outermost diam: " + dotSizeMin + " px"));
    dotMaxSizeScrollbar.spos = constrain(dotMaxSizeScrollbar.sposMin, dotMaxSizeScrollbar.sposMin, dotMaxSizeScrollbar.sposMax);
  } else {
    //  .. otherwise, just update the minimum allowed for max size
    dotMaxSizeScrollbar.sposMin = int(dotMaxSizeScrollbar.getEquivPos(dotSizeMin)) + dotMaxSizeScrollbar.xpos; 
  }
  dotMinSizeScrollbar.display("innermost diam: " + dotSizeMin + " px");
  dotMaxSizeScrollbar.display("outermost diam: " + dotSizeMax + " px"); 
  
  // FADE RATE sliders
  fadeMinScrollbar.update();
  fadeMaxScrollbar.update();
  if (fadeMaxRate<fadeMinRate) {    //min and max sliders need to affect each other
    // if max is too small, bump it up to where min dictates it should be
    fadeMaxScrollbar.sposMin = int(fadeMaxScrollbar.setPos(fadeMinRate, "outermost rate: " + closestTenth(fadeMinRate/1000.0)));
      fadeMaxScrollbar.spos = constrain(fadeMaxScrollbar.sposMin, fadeMaxScrollbar.sposMin, fadeMaxScrollbar.sposMax);
} else {
    //  .. otherwise, just update the minimum allowed for max rate
    fadeMaxScrollbar.sposMin = int(fadeMaxScrollbar.getEquivPos(fadeMinRate)) + fadeMaxScrollbar.xpos; 
  }
  fadeMinScrollbar.display("innermost rate: " + closestTenth(1000.0/fadeMinRate));
  fadeMaxScrollbar.display("outermost rate: " + closestTenth(1000.0/fadeMaxRate));
  fadeButton.update();
  fadeButton.display(false);
  
  
  if (fadeButton.value) {
    if (!wantFade) { timeFadeStarted = millis(); }  // if this is the first time to start fade, start the timer
    wantFade = true;
    fadeMinScrollbar.isActive = true;
    fadeMaxScrollbar.isActive = true; 
  } else {
    wantFade = false;
    fadeMinScrollbar.isActive = false;
    fadeMaxScrollbar.isActive = false;  
  }
  
  
  // BUTTONS and LOOPING SHIZZ
  if (goldenAngleButton.pressed()) {
    currentAngle = goldenAngle;  //radians(goldenAngle);
    angleScrollbar.setPos(goldenAngle, "seed angle: " + goldenAngle + '\u00B0');
  }
  else if (!loopAngleButton.value) {
    angleStepScrollbar.isActive = false;
    frameRateScrollbar.isActive = false;
    currentAngle = setAngle;  //radians(setAngle);
    drawFlorets(numFlorets,radians(setAngle),stretchFactor, dotSizeMin, dotSizeMax, fadeMinRate, fadeMaxRate);
  } else {
    angleStepScrollbar.isActive = true;
    frameRateScrollbar.isActive = true;
    if (readyToDrawNew(frameRatePauseMillis)) {
      currentAngle+=loopStepValue;
      currentAngle = currentAngle%360;  //currentAngle%(2*PI);
      float newAngleForDisplay = currentAngle;  //closestTenth(degrees(currentAngle));
      angleScrollbar.setPos(newAngleForDisplay, "seed angle: " + newAngleForDisplay + '\u00B0');
      timeLastDrawn = millis();
    }
    
    drawFlorets(numFlorets, radians(currentAngle), stretchFactor, dotSizeMin, dotSizeMax, fadeMinRate, fadeMaxRate);
  
  }

}

boolean readyToDrawNew(int timeBtwDraws) {
    return ( (millis() - timeLastDrawn) >= timeBtwDraws );    
}

float closestHalf(float in) {
   if ((0.25 < (in - int(in))) && ((in - int(in)) < 0.75))  { 
     float out = int(in) + 0.5;
     return out;
   }
   return int(in);
}

float closestTenth(float in) {
    int temp = int(in*10);
    return (temp/10.0);
}

void drawFlorets(int numFlorets, float angle, float stretchFactor, int smallestSize, int largestSize, int fadeMinMillisPerCycle, int fadeMaxMillisPerCycle)
{  
    float originX = vizStartWidth + 0.5*vizWidth;
    float originY = screenHeight/2.0;

    // draw gray dot at origin
//    fill(51);
//    ellipse(originX, originY, 2, 2);
    
    float c = stretchFactor;
        
//    fill(255);    //all the rest of the dots are in white  
    
    float discDiameter = 1.0;
    for(int i=0; i < numFlorets; i++) {

        float radius = c * sqrt(i);
        float currentAngleMult = i * angle;

        float y = -1 * radius * sin(currentAngleMult);
        float x = radius * cos(currentAngleMult);

        float drawX = originX + x;
        float drawY = originY + y;

        // determine the color of this dot: depends on disc number
        int fillColor = 255;
        if (wantFade) {
            float millisPerCycle = fadeMinMillisPerCycle + (i/float(numFlorets)) * (fadeMaxMillisPerCycle - fadeMinMillisPerCycle);  //this isn't exact, but it's close enough for now
            float numCyclesCompleted = (millis() - timeFadeStarted)/millisPerCycle;
            numCyclesCompleted = numCyclesCompleted - int(numCyclesCompleted);  // we only care about the non-int part, since each rotation/cycle is the same
            fillColor = int(((cos(numCyclesCompleted*2*PI)+1) / 2.0) * 255);  //((cos(numCyclesCompleted*2*PI) + 1) / 2.0) * 255
        }
        fill(fillColor);
        stroke(fillColor);

        discDiameter = smallestSize + (i/float(numFlorets)) * (largestSize - smallestSize);  //this isn't exact, but it's close enough for now
        
        //draw the disc/floret IFF it sits within the viz window
        if ((vizStartWidth<=drawX) && (drawX<=vizStartWidth+vizWidth) &&
            (vizStartHeight<=drawY) && (drawY<=vizStartHeight+vizWidth)) {
          ellipse(drawX, drawY, discDiameter, discDiameter);
        }
    }
    
    // now reset the stroke color
    stroke(255);
}

class HScrollbar
{
  int swidth, sheight;    // width and height of bar
  int xpos, ypos;         // x and y position of bar
  float spos, newspos;    // x position of slider
  int sposMin, sposMax;   // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  float lowestValue;      // lowest/leftmost spos equals this
  float highestValue;      // highest/rightmost spos equals this
  boolean locked;
  float ratio;
  boolean isActive;
  float trueValue;

  HScrollbar (int xp, int yp, int sw, int sh, int l, float lv, float hv, float defaultPos) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;    //make this value larger if want the slider to "glide" more slowly to cursor location
    lowestValue = lv;
    highestValue = hv;
    isActive = true;
    this.setPos(defaultPos, " ");
    trueValue = defaultPos;
  }

  void setTrueValue(float tv) {
     trueValue = tv; 
  }
  
  float getTrueValue() {
     return trueValue; 
  }

  void update() {
    
    if(over()) {
      over = true;
    } else {
      over = false;
    }
    if(mousePressed && over) {
      locked = true;
    }
    if(!mousePressed) {
      locked = false;
    }
    if(locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
      spos = spos + (newspos-spos)/loose;
    }
    trueValue = this.getPos();

  }

  int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  boolean over() {
    if(mouseX > xpos && mouseX < xpos+swidth &&
    mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display(String label) {
    if (isActive) {
      fill(255);
    } else {
      fill(51); 
    }
    text(label, xpos, ypos+sheight*2.2);
    rect(xpos, ypos, swidth, sheight);
    if(over || locked) {
      fill(255, 0, 255);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);    
  }

  float getPos() {
    // Convert spos to be values between
    // lowest and highest allowable values, scaled linearly with horiz position
    if (xpos>spos) { return lowestValue; }    
    return (lowestValue + (highestValue-lowestValue) * (spos-xpos) / float(swidth-sheight));
  }
  
  // this just does the inverse of getPos(), above.  you give it a value and it moves the slider to that position.
  float setPos(float value, String label) {
    spos = (value * float(swidth-sheight) - lowestValue) / (highestValue - lowestValue) + xpos;
    this.display(label);
    trueValue=value;
    return spos;
  }
  
  // this is just like setPos() above, except it doesn't move the slider or change the position.
  float getEquivPos(float value) {
    return ((value * float(swidth-sheight) - lowestValue) / (highestValue - lowestValue));
  }
}

class ToggleButton extends Button {
  boolean value = false;

  void update() 
  {
    if(over()) {
      currentcolor = highlightcolor;
    } 
    else {
      currentcolor = basecolor;
    }
    
    if(mousePressed && over() && !locked) {
      locked = true;
      value = !value;
 //     println(value);    
    }

    if(!mousePressed) {
      locked = false;
    }
  }
}

class Button
{
  int x, y;
  int size;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;  
  boolean locked = false;
  String label = "";

  void update() 
  {
    if(over()) {
      currentcolor = highlightcolor;
    } 
    else {
      currentcolor = basecolor;
    }
    
    if(mousePressed && over() && !locked) {
      locked = true;
    }

    if(!mousePressed) {
      locked = false;
    }
  }

  boolean pressed() 
  {
    if(!mousePressed) { return false; }
    
    if(over) {
      locked = true;
      return true;
    } 
    else {
      locked = false;
      return false;
    }    
  }

  boolean over() 
  { 
    return true; 
  }

  boolean overRect(int x, int y, int width, int height) 
  {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } 
    else {
      return false;
    }
  }

}

class RectButton extends Button
{
  RectButton(int ix, int iy, int isize, color icolor, color ihighlight, String l) 
  {
    x = ix;
    y = iy;
    size = isize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    label = l;
  }

  boolean over() 
  {
    if( overRect(x, y, size, size) ) {
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }

  void display(boolean textBefore) 
  {
    fill(255);   
    if (textBefore) {
      text(label, x - label.length() * 8.3, y+size);
    } else {
      text(label, x + size + 9, y+size);
    }
    
    stroke(255);
    fill(currentcolor);
    rect(x, y, size, size);
  }
}


class RectToggleButton extends ToggleButton
{
  RectToggleButton(int ix, int iy, int isize, color icolor, color ihighlight, String l) 
  {
    x = ix;
    y = iy;
    size = isize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    label = l;
  }

  boolean over() 
  {
    if( overRect(x, y, size, size) ) {
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }

  void display(boolean textBefore) 
  {
    fill(255);
    if (textBefore) {
      text(label, x - label.length() * 9, y+size);
    } else {
      text(label, x + size + 9, y+size);
    }
    
    stroke(255);
    fill(currentcolor);
    rect(x, y, size, size);
    if (value) {
        line(x,y,x + size, y + size);
        line(x,y+size, x+size, y);
    }

  }
}
