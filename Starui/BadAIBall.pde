class BadAIBall extends AIBall {

  // Constructs a new AIBall
  BadAIBall(Sagar s) {
    super(s);
    _mass = (int) random(6) + 7;
    float r = random(256);
    x = random((width - r) + r/2);
    y = random((height - r) + r/2);
    _parent = s;
    _col = _parent._col;
  }


  // Allows one to specify the mass of an AIBall
  BadAIBall(Sagar s, int mass) {
    this(s);
    _mass = mass;
  }

  // Allows one to specify the co-ordinates and mass of an AIBall
  BadAIBall(Sagar s, int mass, float xcor, float ycor) {
    this(s, mass);
    x = xcor;
    y = ycor;
  }


  // Moves the AIBall in a random direction
  void move() {
    int speed = 5;
    float direction = random(-TWO_PI, TWO_PI);
    x += speed * cos(direction);
    y += speed * sin(direction);
    // Prevent Balls from overshooting world boundaries
    if (x > width - 75)
      x = width - 75;
    if (y > height - 40)
      y = height - 40;
    if (x < 0)
      x = 0;
    if (y < 0)
      y = 0;
  }
}