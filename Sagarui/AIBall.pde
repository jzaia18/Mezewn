class AIBall extends Ball {

  AIBall(Sagarui sg, Sagar s) {
    float r = random(256);
    float g = random(256);
    float b = random(256);
    _col = color(r, g, b);
    _mass = 100;
    x = random((width - r) + r/2);
    y = random((height - r) + r/2);
    parent = s;
    game = sg;
  }

  AIBall(Sagarui sg, Sagar s, int mass) {
    this(sg, s);
    _mass = mass;
  }

  AIBall(Sagarui sg, Sagar s, int mass, float xcor, float ycor) {
    this(sg, s, mass);
    x = xcor;
    y = ycor;
  }

  void move() {
  }
}