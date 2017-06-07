import java.util.LinkedList;

abstract class Snek implements Comparable {

  LinkedList<Segment> _body;
  ArrayList<Snek> sneks;
  ArrayList<Mass> masses;
  color _col;
  float speed, _heading, x, y;
  boolean degrade, exists, inDanger;
  String _name;


  // Compares this Snek to another by length
  public int compareTo(Object o) {
    if (!(o instanceof Snek)) {
      throw new ClassCastException();
    }
    return _body.size() - ((Snek) o)._body.size();
  }


  // Returns the smaller Snek between an input and itself
  Snek smallerSnek(Snek s) {
    if (compareTo(s) < 0) 
      return this;
    return s;
  }


  // Displays the Snek
  void display() {
    for (Segment seg : _body) seg.display();
    textAlign(TOP, RIGHT);
    textSize(10);
    fill(255);
    text(_name, _body.getFirst().x+10, _body.getFirst().y);
  }


  // Useful for showing Snek information
  String toString() {
    String ret = "Name: " + _name; 
    ret += "\nNum Segments: " + _body.size();
    ret += "\nSpeed: " + speed;
    return ret += "\nExists: " + exists;
  }


  // Update the Snek
  void update() {
    move();
    display();
  }


  // To be implemented by Human/AI Snek
  abstract void move();


  // Consume a small Mass
  void consume(Mass m) {
    Segment last = _body.getLast();
    if (dist(_body.getFirst().x, _body.getFirst().y, m.x, m.y) <= 15) {
      m.exists = false;
      if (_body.size() > 1) _body.addLast(new Segment(this, last.x + (last.x - _body.get(_body.size()-2).x), last.y + (last.y - _body.get(_body.size()-2).y)));
      else _body.addLast(new Segment(this, last.x + random(-1, 1), last.y + random(-1, 1)));
    }
  }
}