abstract class Ball implements Comparable {

  float x, y, rad;
  color _col;
  int _mass;
  Sagar _parent; // Important for keeping track of bretheren

  // Returns whether or not this Ball is larger
  public int compareTo(Object o) {
    if (!(o instanceof Ball)) throw new ClassCastException(); // This should never happen
    return _mass - ((Ball)o)._mass;
  }

  
  // Adds the mass of an eaten Ball, and returns whether eating was successful (Actual removal of the dead Ball takes place in Sagarui.pde)
  boolean consume(Ball b) {
    if (compareTo(b) > (_mass * .2) && dist(x, y, b.x, b.y) <= rad) {
      _mass += b._mass;
      return true;
    }
    return false;
  }


  // Comsumes a small Mass
  void consume(Mass m) {
     if (dist(x, y, m.x, m.y) <= rad && m.exists) {
        _mass += m._mass;
        m.exists = false;
     }
  }


  // This is different for AI and humans
  abstract void move();


  // Draws the Ball
  void display() {
    rad = 2 + (sqrt(8 * _mass));
    fill(_col);
    noStroke();
    ellipse (x, y, 2*rad, 2*rad);
    fill(255, 255, 255);
    text(_parent._name, x, y);
  }
  
  // Accessors  
  int getMass(){ return _mass; }
  Sagar getParent(){ return _parent; }
  float getDistFrom(float dx, float dy){ return dist(x, y, dx, dy); }

}