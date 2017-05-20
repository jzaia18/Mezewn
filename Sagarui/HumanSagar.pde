class HumanSagar extends Sagar {

  HumanSagar(Sagarui s) {
    balls = new PriorityQueue<Ball>();
    balls.add(new HumanBall(game, this, 20));
    game = s;
  }

  void split() {
    PriorityQueue<Ball> tmp = new PriorityQueue<Ball>();
    for (Ball b : balls) {
      if (b._mass > 50) {
        tmp.add(new HumanBall(game, this, b._mass/2, b.x+50, b.y+50)); // fix placement
        tmp.add(new HumanBall(game, this, b._mass/2, b.x-50, b.y-50));
      } else tmp.add(b);
    }
    balls = tmp;
  }
}