class Mass {

  float x, y;
  int _mass;
  boolean exists;
  color _col;

  Mass() {
    float r = random(50,256);
    float g = random(50,256);
    float b = random(50,256);
    _col = color(r, g, b);
    _mass = (int) random(2) + 1;
    x = random(width - 30) + 15;
    y = random(height - 30) + 15;
    exists = true;
  }

  Mass(float xcor, float ycor) {
    this();
    x = xcor;
    y = ycor;
  }

  void display() {
    fill(_col);
    noStroke();
    ellipse(x, y, 8, 8);
  }
}