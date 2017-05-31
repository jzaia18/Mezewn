class AIBall extends Ball {
  
  //needed for AIBalls only
  float dx;
  float dy;

  AIBall(Sagar s) {
    _mass = (int) random(41) + 10;
    dx = random(30) - 15;
    dy = random(30) - 15;
    float r = random(256);
    x = random((width - r) + r/2);
    y = random((height - r) + r/2);
    _parent = s;
    _col = _parent._col;
  }

  AIBall(Sagar s, int mass) {
    this(s);
    _mass = mass;
  }

  AIBall(Sagar s, int mass, float xcor, float ycor) {
    this(s, mass);
    x = xcor;
    y = ycor;
  }

  void move() {
    float speed = max(.002, .00001 * (100000.0/_mass)); //As a decimal (0, 1] representing percent of mouse gap moved
    if (_parent.getTarget() == null) {
        x += (random(width / 8) - x / 8) * speed;
        y += (random(height / 8) - y / 8) * speed;
    }
    else {
      x += (_parent.getTarget().x - x) * speed;
      y += (_parent.getTarget().y - y) * speed;
    }
  }
  
  void targetClosest(ArrayList<Sagar> sagars) {
    _parent.chasingTarget = null;
    Ball toTarget = null;
    for (int i = 0; i < sagars.size(); i++) {
      Sagar currSagar = sagars.get(i);
      for (Ball currCheck: currSagar._balls) {
        if (currCheck.getDistFrom(x, y) < rad + 250) {
          // If within the Ball's sight distance
          if (currCheck._mass < _mass * .8 && (toTarget == null || currCheck._mass > toTarget._mass)) {
            toTarget = currCheck;
            _parent.chasingTarget = true;
          }
          else if (currCheck._mass > _mass * 1.2) {
            toTarget = currCheck;
            _parent.chasingTarget = false;
          }
        }
      }
    }
    _parent.setTarget(toTarget);
  }
  
}