class AISagar extends Sagar {

  AISagar(Sagarui s) {
    _balls = new PriorityQueue<Ball>();
    _balls.add(new AIBall(this, 10));
  }

  void split() {
    PriorityQueue<Ball> tmp = new PriorityQueue<Ball>();
    for (Ball b : _balls) {
      if (b._mass > 50) {
        tmp.add(new AIBall(this, b._mass/2, b.x+50, b.y+50)); //fix placement
        tmp.add(new AIBall(this, b._mass/2, b.x-50, b.y-50));
      } else tmp.add(b);
    }
    _balls = tmp;
  }
}