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
    x = random(0, width - 75);
    y = random(0, height - 40);
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