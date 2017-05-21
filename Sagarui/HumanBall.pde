class HumanBall extends Ball {

  HumanBall(Sagar s) {
    float r = random(256);
    float g = random(256);
    float b = random(256);
    _col = color(r, g, b);
    _mass = 10000000;
    x = random((width - r) + r/2);
    y = random((height - r) + r/2);
    parent = s;
  }

  HumanBall(Sagar s, int mass) {
    this(s);
    _mass = mass;
  }

  HumanBall(Sagar s, int mass, float xcor, float ycor) {
    this(s, mass);
    x = xcor;
    y = ycor;
  }

  void move() {
    x += (mouseX - x) * (.6 / (_mass/2.5));
    y += (mouseY - y) * (.6 / (_mass/2.5));
  }
}