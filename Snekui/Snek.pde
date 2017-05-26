import java.util.LinkedList;

abstract class Snek {

  LinkedList<Segment> _body;
  ArrayList<Snek> sneks;
  ArrayList<Mass> _mass;
  color _col;
  float speed;
  boolean degrade;

  void display() {
    for (Segment seg : _body) seg.display();
    text("Num Segments: " + _body.size(), _body.getFirst().x+10, _body.getFirst().y);
    text("Speed: " + speed, _body.getFirst().x+10, _body.getFirst().y+10);
  }

  void update() {
    move();
    display();
  }

  abstract void move();

  void consume(Mass m) {
    Segment last = _body.getLast();
    if (dist(_body.getFirst().x, _body.getFirst().y, m.x, m.y) <= 30) {
      _body.addLast(new Segment(this, last.x + 5, last.y + 5));
      m.exists = false;
    }
  }
}