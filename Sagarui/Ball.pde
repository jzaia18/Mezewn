abstract class Ball implements Comparable {

  float x, y, rad;
  color _col;
  int _mass;
  Sagar parent;
  Sagarui game;

  public int compareTo(Object o) {
    if (!(o instanceof Ball)) {
      throw new ClassCastException();
    }
    Ball b = (Ball)o;
    return _mass - b._mass;
  }

  void consume(Ball b) {
    if (compareTo(b) > 1 && dist(x, y, b.x, b.y) <= rad) {
      _mass += b._mass;
      b.parent.balls.remove(b);
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
    rad = _mass/2;
    fill(_col);
    noStroke();
    ellipse (x, y, 2*rad, 2*rad);
  }
}