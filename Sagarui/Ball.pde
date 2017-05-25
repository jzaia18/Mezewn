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

  void consume(Ball b) {
    if (compareTo(b) > (_mass * .8) && dist(x, y, b.x, b.y) <= rad) {
      _mass += b._mass;
      b._parent._balls.remove(b);
    }
  }

  void consume(Mass m) {
     if (dist(x, y, m.x, m.y) <= rad) {
        _mass += m._mass;
        m.exists = false;
     }
  }

  abstract void move();

  void display() {
    rad = 7 + (sqrt(2.0 * _mass) * 1.57);
    fill(_col);
    noStroke();
    ellipse (x, y, 2*rad, 2*rad);
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