
Thing myThing;

void setup() {
  myThing = new Thing(5, false);
  
  myThing.printNum();
  
  myThing.bool = true;
  
  myThing.printNum();
}
