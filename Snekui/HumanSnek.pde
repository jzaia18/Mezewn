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
    for (int j = 0; j < 4; j++) 
      _body.add(new Segment(this, _body.peek().x, _body.peek().y));
    speed = .005;
    degrade = false;
    exists = true;
    _name = "Human";
  }

  void move() {
    if (degrade) {
      if (_body.size() > 5) {
        Segment tmp = _body.removeLast();
        if (random(100) < 30) _mass.add(new Mass(tmp.x, tmp.y, 1));
      } else {
        speed = .005;
        degrade = false;
      }
    }
    Segment oldFirst = _body.getFirst();
    _heading = atan2(mouseY - oldFirst.y, mouseX - oldFirst.x);
    _body.addFirst(new Segment(this, oldFirst.x + (mouseX - oldFirst.x) * speed, oldFirst.y + (mouseY - oldFirst.y) * speed));
    _body.removeLast();
  }
}