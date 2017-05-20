class HumanBall extends Ball {

  HumanBall(Sagarui sg, Sagar s) {
    float r = random(256);
    float g = random(256);
    float b = random(256);
    _col = color(r, g, b);
    _mass = 10000000;
    x = random((width - r) + r/2);
    y = random((height - r) + r/2);
    parent = s;
    game = sg;
  }

  HumanBall(Sagarui sg, Sagar s, int mass) {
    this(sg, s);
    _mass = mass;
  }

  HumanBall(Sagarui sg, Sagar s, int mass, float xcor, float ycor) {
    this(sg, s, mass);
    x = xcor;
    y = ycor;
  }

  void move() {
    x += (mouseX - x) * .06;
    y += (mouseY - y) * .06;
  }
}