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

  void display() {
    fill(128);
    noStroke();
    ellipse(x, y, 8, 8);
  }
}
