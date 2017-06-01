abstract class Ball implements Comparable {

  float x, y, rad;
  color _col;
  int _mass;
  Sagar _parent;

  public int compareTo(Object o) {
    if (!(o instanceof Ball)) {
      throw new ClassCastException();
    }
    Ball b = (Ball)o;
    return _mass - b._mass;
  }

  boolean consume(Ball b) {
    if (compareTo(b) > (_mass * .2) && dist(x, y, b.x, b.y) <= rad) {
      _mass += b._mass;
      return true;
      //b._parent._balls.remove(b);
    }
    return false;
  }

  void consume(Mass m) {
     if (dist(x, y, m.x, m.y) <= rad) {
        _mass += m._mass;
        m.exists = false;
     }
  }

  abstract void move();

  void display() {
    rad = 2 + (sqrt(8 * _mass));
    fill(_col);
    noStroke();
    ellipse (x, y, 2*rad, 2*rad);
    fill(255, 255, 255);
    text(_parent._name, x, y);
  }
  
  int getMass(){
     return _mass; 
  }
  
  Sagar getParent(){
     return _parent; 
  }
  
  float getDistFrom(float dx, float dy){
   return dist(x, y, dx, dy); 
  }
  
}