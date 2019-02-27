
public class Wave {

    ArrayList<Point> points = new ArrayList<Point>();

    // dpeth: how far below newY the wave will go
    // newY: y coord of center point of uppermost circle
    // density: relative distance between the points on the x axis (not exact to pixels)
    // increment: distance between pixels on the y axis (exact to pixels)
    // speed: how many frames it takes for a one wave to compelete

    public Wave(int depth,int newY,float density, int increment, float speed) {
 
        for (float y = newY; y <= newY+depth; y += increment) {
            for (float delay = (-20*density); delay < 64*density + (20*density); delay++) {
                points.add(new Point(delay, delay*  20/density, y, 100-((y-300)/3.3),speed));
            }
        }
    }

    void Update() {
        for (Point point : points) {
            point.Update();
        }
    }
}