class AISagar extends Sagar {

  AISagar(Sagarui s) {
    balls = new PriorityQueue<Ball>();
    balls.add(new AIBall(game, this, 10));
    game = s;
  }

  void split() {
    PriorityQueue<Ball> tmp = new PriorityQueue<Ball>();
    for (Ball b : balls) {
      if (b._mass > 50) {
        tmp.add(new AIBall(game, this, b._mass/2, b.x+50, b.y+50)); //fix placement
        tmp.add(new AIBall(game, this, b._mass/2, b.x-50, b.y-50));
      } else tmp.add(b);
    }
    balls = tmp;
  }
}