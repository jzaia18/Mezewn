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
    if (_balls.size() < 8 && _totalMass >= 50 && System.currentTimeMillis() - _lastSplitTime >= 5000) {
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
  
  void display() {
    for (Ball b : _balls) b.display();
    text("" + _balls.size(), 50, 50);
  }
}