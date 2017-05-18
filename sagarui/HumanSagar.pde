class HumanSagar extends Sagar {

  float x, y, rad;
  color c;

  HumanSagar() {
    float r = random(256);
    float g = random(256);
    float b = random(256);
    c = color(r, g, b);
    rad = 100;
    x = random((width - r) + r/2);
    y = random((height - r) + r/2);
  }

  void move() {

    float dx = mouseX - x;
    x += dx * .06 * (10 / rad);

    float dy = mouseY - y;
    y += dy * .06 * (10 / rad);
  }

  void display() {
    fill(c);
    ellipse (x, y, 2*rad, 2*rad);
  }
}