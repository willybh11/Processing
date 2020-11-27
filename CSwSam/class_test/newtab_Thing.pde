
class Thing {
  
  int num;
  boolean bool;
  
  Thing(int number, boolean another_parameter) {
    num = number;
    bool = another_parameter;
  }
  
  void printNum() {
    if (bool == true) {
      num += 1;
    }
    
    println(num);
  }
}
