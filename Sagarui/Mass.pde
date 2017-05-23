class Mass {

  float x, y, col;
  int _mass;
  boolean exists;
  color _col;

  Mass() {
    float r = random(256);
    float g = random(256);
    float b = random(256);
    _col = color(r, g, b);
    _mass = (int) random(2) + 1;
    x = random(width);
    y = random(height);
    exists = true;
  }

  void display() {
    fill(128);
    noStroke();
    ellipse(x, y, 8, 8);
  }
}