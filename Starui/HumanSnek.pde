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


  // Moves the Snek
  void move() {
    
    // If the user is speeding up
    if (degrade) {
      if (_body.size() > 5) {
        Segment tmp = _body.removeLast();
        if (random(100) < 30) masses.add(new Mass(tmp.x, tmp.y));
      } else {
        degrade = false;
        speed = 4;
      }
    }
    
    // Moves by popping the last element off the linked list and adding it to the front O(1)
    Segment oldFirst = _body.getFirst();
    if (abs(oldFirst.x - mouseX) > 10 && abs(oldFirst.y - mouseY) > 10) _heading = atan2(mouseY - oldFirst.y, mouseX - oldFirst.x);
    _body.addFirst(new Segment(this, oldFirst.x + speed * cos(_heading), oldFirst.y + speed * sin(_heading)));
    _body.removeLast();
    x = _body.peek().x;
    y = _body.peek().y;
  }
}