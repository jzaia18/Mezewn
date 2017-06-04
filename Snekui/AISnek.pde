class AISnek extends Snek {

  Snek _target;

  AISnek(ArrayList<Snek> s, ArrayList<Mass> m, int i) {
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
    for (int j = (int) random(4, 15); j > 4; j--) 
      _body.add(new Segment(this, x, y));
    exists = true;
    speed = 4;
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
    Segment oldFirst = _body.getFirst();
    targetClosest();
    if (_target == null) {
      Mass toEat = targetMass();
      _heading = atan2(toEat.y - oldFirst.y, toEat.x - oldFirst.x) + random(-.15, .15);
      _body.addFirst(new Segment(this, oldFirst.x + speed * cos(_heading), oldFirst.y + speed * sin(_heading)));
    } else if (inDanger){
      _heading += random(-1.6, 1.6);
      _body.addFirst(new Segment(this, oldFirst.x + speed * cos(_heading), oldFirst.y + speed * sin(_heading)));
    } else {
      _heading = atan2((_target.y + sin(_target._heading) * 200) - oldFirst.y, (_target.x + cos(_target._heading) * 200) - oldFirst.x) + random(-.1, .1);
      _body.addFirst(new Segment(this, oldFirst.x + speed * cos(_heading), oldFirst.y + speed * sin(_heading)));
    }
    _body.removeLast();
    x = _body.peek().x;
    y = _body.peek().y;
  }

  void targetClosest() {
    _target = null;
    float targetDist = 0;
    for (Snek checkSnek : sneks) {
      Segment checkHead = checkSnek._body.peek();
      float distFromCheck = dist(checkHead.x, checkHead.y, x, y);
      if ( distFromCheck < 220 && checkSnek != this && (_target == null || distFromCheck < targetDist)) {
        _target = checkSnek;
        targetDist = distFromCheck;
      }
    }
  }

  Mass targetMass() {
    Mass closestMass = masses.get(0);
    float closestDist = dist(closestMass.x, closestMass.y, x, y);
    for (Mass m : masses) {
      float checkDist = dist(m.x, m.y, x, y);
      if ( checkDist < closestDist) {
        closestMass = m;
        closestDist = checkDist;
      }
    }
    return closestMass;
  }
}