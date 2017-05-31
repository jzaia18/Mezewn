class AISnek extends Snek {

  Snek _target;

  AISnek(ArrayList<Snek> s, ArrayList<Mass> m, int i) {
    float r = random(50, 256);
    float g = random(50, 256);
    float b = random(50, 256);
    _col = color(r, g, b);
    sneks = s;
    _mass = m;
    _body = new LinkedList<Segment>();
    _body.add(new Segment(this));
    int rand = (int) random(4, 15);
    for (int j = 0; j < rand; j++) 
      _body.add(new Segment(this, _body.peek().x, _body.peek().y));
    exists = true;
    speed = .01;
    _name = "AISnek #" + i;
  }

  String toString() {
    String ret = "Name: " + _name; 
    ret += "\nNum Segments: " + _body.size();
    ret += "\nSpeed: " + speed;
    ret += "\nExists: " + exists;
    if (_target != null) ret += "\nTarget: " + _target._name;
    return ret;
  }

  void move() {
    if (_target == null || !_target.exists) targetClosest(sneks);
    else {
      Segment targetHead = _target._body.peek();
      Segment oldFirst = _body.getFirst();
      _heading = atan2(targetHead.y - oldFirst.y, targetHead.x - oldFirst.x);
      _body.addFirst(new Segment(this, oldFirst.x + (targetHead.x + 45*cos(_target._heading) - oldFirst.x) * speed, oldFirst.y + (targetHead.y + 45*sin(_target._heading) - oldFirst.y) * speed));
      _body.removeLast();
    }
  }

  void targetClosest(ArrayList<Snek> s) {
    Segment head = _body.peek();
    Snek closestSnek = null;
    float closestDist = 10000; //Returns distance from THIS ball
    for (int i = 0; i < s.size(); i++) {
      Snek j = s.get(i);
      Segment jHead = j._body.peek();
      if (j != this && dist(head.x, head.y, jHead.x, jHead.y) < closestDist) {
        closestSnek = j;
        closestDist = dist(head.x, head.y, jHead.x, jHead.y);
      }
    }
    _target = closestSnek;
  }
}