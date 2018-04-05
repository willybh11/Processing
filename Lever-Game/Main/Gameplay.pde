
public boolean pull(int lever) {
  boolean[] possibleOutcomes = new boolean[10];
  tries[lever]++;
  for (int i = 0; i < 10; i++) {
    if (i < chances[lever]) {
     possibleOutcomes[i] = true; 
    } else {
     possibleOutcomes[i] = false; 
    }
  }
  if (possibleOutcomes[int(random(0,10))]) {
    winList[lever]++;
    return true;
  } else {
   return false; 
  }
}

public boolean mouseOver(int n) {
  return (mouseX > origins.get(n).x && mouseX < origins.get(n).x + 200 && mouseY > origins.get(n).y && mouseY < origins.get(n).y + 600);
}

public boolean mouseOverBox(int n) {
  return (mouseX > origins.get(n).x && mouseX < origins.get(n).x + 200 && mouseY > origins.get(n).y-150 && mouseY < origins.get(n).y-50);
}