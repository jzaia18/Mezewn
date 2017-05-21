class HumanSagar extends Sagar {

  HumanSagar() {
    _balls = new PriorityQueue<Ball>();
    _balls.add(new HumanBall(this, 20));
  }

  void split() {
    PriorityQueue<Ball> tmp = new PriorityQueue<Ball>();
    for (Ball b : _balls) {
      if (b._mass > 50) {
        tmp.add(new HumanBall(this, b._mass/2, b.x+50, b.y+50)); // fix placement
        tmp.add(new HumanBall(this, b._mass/2, b.x-50, b.y-50));
      } else tmp.add(b);
    }
    _balls = tmp;
  }
}