
public class Wave {

    ArrayList<Point> points = new ArrayList<Point>();
    float dispersal;
    PVector origin;

    public Wave(int x,int y,float disp, int increment) {
        dispersal = disp;
        origin = new PVector(x,y);

        for (float yCoord = origin.y; yCoord <= origin.y+600; yCoord += increment) {
            for (float delay = (-20*dispersal); delay < 64*dispersal + (20*dispersal); delay++) {
                points.add(new Point(delay, delay*20/dispersal, yCoord, 100-((yCoord-300)/3.3)));
            }
        }
    }

    void Update() {
        for (Point point : points) {
            point.Update();
        }
    }
}