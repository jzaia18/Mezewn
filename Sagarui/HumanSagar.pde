class HumanSagar extends Sagar {

  // Construct a new HumanSagar
  HumanSagar(ArrayList<Sagar> s, ArrayList<Mass> m) {
    float r = random(50, 256);
    float g = random(50, 256);
    float b = random(50, 256);
    _col = color(r, g, b);
    sagars = s;
    mass = m;
    _balls = new PriorityQueue<Ball>();
    _balls.add(new HumanBall(this, 10));
    _name = "Player";
  }


  // Splits this all Balls into 2 Balls of half mass
  void split() {
    if (_balls.size() < 10 && _balls.peek()._mass >= 50 && System.currentTimeMillis() - _lastSplitTime >= 1500) {
      willSplit = false;
      PriorityQueue<Ball> tmp = new PriorityQueue<Ball>();
      for (Ball b : _balls) {
        float direction = atan2(mouseY - b.y, mouseX - b.x);
        tmp.add(new HumanBall(this, b._mass / 2, b.x + 3 * b.rad * cos(direction), b.y + 3 * b.rad * sin(direction)));
        tmp.add(new HumanBall(this, b._mass / 2, b.x, b.y));
      }
      _balls = tmp;
      _lastSplitTime = System.currentTimeMillis();
    }
  }

  // Merge 2 Balls  
  void merge(HumanBall b1, HumanBall b2) {
    PriorityQueue<Ball> tmp = new PriorityQueue<Ball>(_balls);
    _lastSplitTime = System.currentTimeMillis();
    tmp.add(new HumanBall(b1._parent, b1._mass + b2._mass, b1.x, b1.y));
    tmp.remove(b1);
    tmp.remove(b2);
    _balls = tmp;
  }
}