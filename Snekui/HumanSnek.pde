class HumanSnek extends Snek {

  HumanSnek(ArrayList<Snek> s, ArrayList<Mass> m) {
    float r = random(50, 256);
    float g = random(50, 256);
    float b = random(50, 256);
    _col = color(r, g, b);
    sneks = s;
    _mass = m;
    _body = new LinkedList<Segment>();
    _body.add(new Segment(this));
    speed = .005;
    degrade = false;
  }

  void move() {
    if (degrade) {
      if (_body.size() > 5) {
        Segment tmp = _body.removeLast();
        if (random(100) < 30) _mass.add(new Mass(tmp.x, tmp.y));
      } else {
        speed = .005;
        degrade = false;
      }
    }
    Segment oldFirst = _body.getFirst();
    _body.addFirst(new Segment(this, oldFirst.x + (mouseX - oldFirst.x) * speed, oldFirst.y + (mouseY - oldFirst.y) * speed));
    _body.removeLast();
  }
}