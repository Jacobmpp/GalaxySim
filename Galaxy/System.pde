public class System implements Comparable<System>{
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
      velocity = new PVector(cos(a + PI), sin(a + PI)).mult(sqrt(mass_) / sqrt(r) / 17);
    }
    velocity.add(new PVector(cos(a + PI / 2), sin(a + PI / 2)).mult(mass_ / pow(r, 2) / 30));
    //vel.sub(new PVector(cos(a+PI/2), sin(a+PI/2)).mult(m_/r/r/r/r/r));
    location.add(velocity);
  }
  public void show() {
    strokeWeight(sqrt(map(mass*mass, 0, 3600, 1, 25)));
    if (mass > 3.2) {
      stroke(25, 25, 255, 200);
    } else if (mass > 1.7) {
      stroke(200, 200, 255, 200);
    } else if (mass > 1.1) {
      stroke(170, 170, 100, 200);
    } else {
      stroke(120 + 130 * mass, 250 * mass, 50 * mass, 200);
    }
    point(location.x, location.y);
  }
  public float getMass(){
    return mass;
  }
  public int compareTo(System compared) {
      float compareQuantity = compared.getMass(); 
      return round(compareQuantity - this.mass);
    }
}
