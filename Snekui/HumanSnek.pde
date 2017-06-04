class HumanSnek extends Snek {

  HumanSnek(ArrayList<Snek> s, ArrayList<Mass> m) {
    float r = random(50, 256);
    float g = random(50, 256);
    float b = random(50, 256);
    _col = color(r, g, b);
    sneks = s;
    masses = m;
    x = random(width);
    y = random(height);
    _body = new LinkedList<Segment>();
    _body.add(new Segment(this, x, y));
    for (int j = 0; j < 4; j++) 
      _body.add(new Segment(this, x, y));
    speed = 4;
    degrade = false;
    exists = true;
    _name = "Player";
  }

  void move() {
    if (degrade) {
      if (_body.size() > 5) {
        Segment tmp = _body.removeLast();
        if (random(100) < 30) masses.add(new Mass(tmp.x, tmp.y));
      } else {
        degrade = false;
        speed = 4;
      }
    }
    Segment oldFirst = _body.getFirst();
    _heading = atan2(mouseY - oldFirst.y, mouseX - oldFirst.x);
    _body.addFirst(new Segment(this, oldFirst.x + speed * cos(_heading), oldFirst.y + speed * sin(_heading)));
    //_body.addFirst(new Segment(this, oldFirst.x + (mouseX - oldFirst.x) * speed, oldFirst.y + (mouseY - oldFirst.y) * speed));
    _body.removeLast();
    x = _body.peek().x;
    y = _body.peek().y;
  }
}