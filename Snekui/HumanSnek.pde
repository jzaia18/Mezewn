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
  }

  void move() {
    Segment oldFirst = _body.getFirst();
    _body.addFirst(new Segment(this, oldFirst.x + (mouseX - oldFirst.x) * .5, oldFirst.y + (mouseY - oldFirst.y) * .5));
    _body.removeLast();
  }
}