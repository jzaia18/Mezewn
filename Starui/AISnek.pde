class AISnek extends Snek {

  Snek _target;

  // Constructs a new AISnek
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
    _name = "AI #" + i;
  }


  // Used for displaying the data next to the Snek
  String toString() {
    String ret = "Name: " + _name; 
    ret += "\nNum Segments: " + _body.size();
    ret += "\nSpeed: " + speed;
    ret += "\nExists: " + exists;
    if (_target != null) ret += "\nTarget: " + _target._name;
    return ret;
  }


  // Moves the Snek by popping the last element off the linked list and adding it to the front O(1)
  void move() {
    Segment oldFirst = _body.getFirst();
    targetClosest();
    
    // If there is no target, seek out small Masses
    if (_target == null && masses.size() != 0) {
      Mass toEat = targetMass();
      _heading = atan2(toEat.y - oldFirst.y, toEat.x - oldFirst.x) + random(-.15, .15);
      _body.addFirst(new Segment(this, oldFirst.x + speed * cos(_heading), oldFirst.y + speed * sin(_heading)));
    } 
    
    // If in danger of dying, turn
    else if (inDanger){
      _heading += random(0, .4);
      _body.addFirst(new Segment(this, oldFirst.x + speed * cos(_heading), oldFirst.y + speed * sin(_heading)));
    } 
    
    // Otherwise seek out your target to kill
    else {
      _heading = atan2((_target.y + sin(_target._heading) * 200) - oldFirst.y, (_target.x + cos(_target._heading) * 200) - oldFirst.x) + random(-.1, .1);
      _body.addFirst(new Segment(this, oldFirst.x + speed * cos(_heading), oldFirst.y + speed * sin(_heading)));
    }
    _body.removeLast();
    x = _body.peek().x;
    y = _body.peek().y;
  }


  // Finds the closest Snek within a vision radius
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


  // Returns the closest Mass
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