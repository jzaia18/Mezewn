class Mass {

  float x, y, col;
  int _mass;
  boolean exists;
  Sagarui game;    

  Mass(Sagarui sg) {
    _mass = (int) random(5);
    x = random(width);
    y = random(height);
    game = sg;
    exists = true;
  }

  Mass(Sagarui sg, Ball b) {
    this(sg);
    x = b.x + (-30 + random(30));
    y = b.y + (-30 + random(30));
  }

  void display() {
    fill(128);
    noStroke();
    ellipse(x, y, 8, 8);
  }
}