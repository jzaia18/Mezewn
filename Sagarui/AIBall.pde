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
    float speed = 8 * pow(_mass, -0.439);
    if (_parent.getTarget() == null) {
        x += speed * cos(atan2(random(height / 8) - 9.0 * y / 8, random(width / 8) - 9.0 * x / 8));
        y += speed * sin(atan2(random(height / 8) - 9.0 * y / 8, random(width / 8) - 9.0 * x / 8));
    }
    else {
      x += speed * cos(atan2(_parent.getTarget().y - y, _parent.getTarget().x - x));
      y += speed * sin(atan2(_parent.getTarget().y - y, _parent.getTarget().x - x));
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