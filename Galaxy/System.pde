public class System{
  public float mass;
  public PVector location;
  public PVector velocity;
  public System(float mass_, float r, float th) {
    location = new PVector(r*cos(th), r*sin(th));
    velocity = new PVector(0, 0);
    mass = mass_;
  }
  public void update(PVector center, float mass_) {
    float r = sqrt(pow((center.x - location.x), 2) + pow((center.y - location.y), 2)) * 10;
    float a = atan2(location.x - center.x, center.y-location.y);
    if (velocity.x == 0 && velocity.y == 0) {
      velocity = new PVector(cos(a + PI), sin(a + PI)).mult(sqrt(G * mass_ / r));
      //initial velocity, I still need to work on making the radius hold constant from the start
    }
    velocity.add(new PVector(cos(a + PI / 2), sin(a + PI / 2)).mult(mass_ / pow(r, 2)).mult(((speed<1)? speed : 1)));
    //apply force
    location.add(velocity.copy().mult(((speed<1)? speed : 1)));
    //update location
  }
  public void show() {
    int weight = round(sqrt(map(mass*mass, 0, 3600, 1, 25)));
    marker(massToColor(mass), weight, location.x, location.y);
    //render dots
  }
  private color massToColor(float mass){
    if (mass > 3.2) {
      return color(25, 25, 255, 200);
    } if (mass > 2.0) {
      return color(255, 200, 200, 200);
    } if (mass > 1.7) {
      return color(200, 200, 255, 200);
    } if (mass > 1.1) {
      return color(170, 170, 100, 200);
    }
    return color(120 + 130 * mass, 250 * mass, 50 * mass, 200);
  }
}
