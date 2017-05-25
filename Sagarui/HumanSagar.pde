class HumanSagar extends Sagar {
  
  
  HumanSagar(ArrayList<Sagar> s, ArrayList<Mass> m) {
    float r = random(50,256);
    float g = random(50,256);
    float b = random(50,256);
    _col = color(r, g, b);
    sagars = s;
    mass = m;
    _balls = new PriorityQueue<Ball>();
    _balls.add(new HumanBall(this, 10));
  }

  

  void split() {
    if (_balls.size() < 10 && _balls.peek()._mass >= 50 && System.currentTimeMillis() - _lastSplitTime >= 5000) {
      willSplit = false;
      PriorityQueue<Ball> tmp = new PriorityQueue<Ball>();
      for (Ball b : _balls) {
        tmp.add(new HumanBall(this, b._mass / 2, b.x + b.rad, b.y + b.rad));
        tmp.add(new HumanBall(this, b._mass / 2, b.x, b.y));
      }
      _balls = tmp;
      _lastSplitTime = System.currentTimeMillis();
    }
  }
  
  void merge(HumanBall b1, HumanBall b2){
     _lastSplitTime = System.currentTimeMillis();
     _balls.add(new HumanBall(b1._parent, b1._mass + b2._mass, b1.x, b1.y));
     _balls.remove(b1);
     _balls.remove(b2);
  }
  
  void display() {
    for (Ball b : _balls) b.display();
    text("# balls: " + _balls.size(), 50, 50);
    text("Total Mass: " + _totalMass, 50, 60);
  }
}