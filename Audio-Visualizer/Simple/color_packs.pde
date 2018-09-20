
public class Green {
  color Stroke = color(0, 255, 0);
  color Text = color(0, 255, 0);
  color altText = color(50, 150, 250);
  color Wave = color(255);
  color eq = color(20, 160, 0);
}
class Levels extends Green {

  color Low = color(70, 255, 100);
  color Mid = color(255, 255, 70);
  color High= color(255, 0, 0);
}
class Bg extends Levels {
  color Low = color(70, 255, 100, 50);
  color Mid = color(255, 255, 70, 50);
  color High= color(255, 0, 0, 50);
}

public class Red {
  color Stroke = color(255, 0, 0);
  color Text = color(255, 0, 0);
  color altText = color(50, 150, 250);
  color Wave = color(0);
  color eq = color(200, 0, 0);
}
