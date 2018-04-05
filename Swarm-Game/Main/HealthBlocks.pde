public class HBS {
 
  ArrayList<PVector> positions = new ArrayList<PVector>();
  ArrayList<PVector> sizes = new ArrayList<PVector>();
  
  void initialize() {
   for (int i = 0; i <= 16; i++) {
    positions.add(new PVector(10,height-(40+50*(i+1)))); 
    sizes.add(new PVector(30,40));
   }
  }
  void update() {
   
    if (time/60 < timeOfDamage+1) {
     minimize(size/5); 
    } else {
     sizes.get(size/5).x = 30;
     sizes.get(size/5).y = 40;
    }
    
    for (int i = 0; i < size/5; i++) {
     fill(colors[i]);
     rect(positions.get(i).x,positions.get(i).y,sizes.get(i).x,sizes.get(i).y,30);
    }
    
  }
  
  void minimize(int index) {
    if (sizes.get(index).x > 0) {
     sizes.get(index).x -= 0.5;
     sizes.get(index).y -= 0.66;
    }
    fill(colors[index]);
    rect(positions.get(index).x,positions.get(index).y,sizes.get(index).x,sizes.get(index).y,30);
  }
  
}