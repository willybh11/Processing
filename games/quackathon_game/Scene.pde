
class Scene {

    int sceneNum;  
  
    public Scene(int num) {
      sceneNum = num;
    }
    
    void drawScene() {
      switch(sceneNum) {
       case 1:
         drawScene1();
         break;
      }
    }
    
    void drawScene1() {
      fill(255);
      // the floor
      rect(0,height-100,width/2-500,100);
      rect(width/2-200,height-100,width/2+200,100);
      
      rect(width/2+400,height-500,100,400);
    }
  
}
