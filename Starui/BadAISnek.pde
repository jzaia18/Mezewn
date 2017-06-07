class BadAISnek extends Snek {

  Snek _target;

  // Constructs a new AISnek
  BadAISnek(ArrayList<Snek> s, ArrayList<Mass> m, int i) {
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
    //warui AISneks go in a random direction making them difficult to target
    _heading = random(-TWO_PI, TWO_PI);
    _body.addFirst(new Segment(this, oldFirst.x + speed * cos(_heading), oldFirst.y + speed * sin(_heading)));
    _body.removeLast();
  }
}