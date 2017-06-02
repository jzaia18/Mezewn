class AIBall extends Ball {

  //needed for AIBalls only
  float dx;
  float dy;

  AIBall(Sagar s) {
    _mass = (int) random(6) + 7;
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
    if (_parent.getTarget() == null) { // There is no nearby Ball to eat
      Mass target = findNearestMass();
      x += speed * cos(atan2(target.y - y, target.x - x) + random(-.1,.1));
      y += speed * sin(atan2(target.y - y, target.x - x) + random(-.1,.1));
    } 
    else if (_parent.chasingTarget) { // If persuing a smaller Ball
      Ball target = _parent.getTarget();
      x += speed * cos(atan2(target.y - y, target.x - x) + random(-.1,.1));
      y += speed * sin(atan2(target.y - y, target.x - x) + random(-.1,.1));
    }
    else { // If fleeing a larger Ball
      Ball target = _parent.getTarget();
      x -= speed * cos(atan2(target.y - y, target.x - x) + random(-.1,.1));
      y -= speed * sin(atan2(target.y - y, target.x - x) + random(-.1,.1));
    }
    if (x > width - 75)
      x = width - 75;
    if (y > height - 40)
      y = height - 40;
    if (x < 0)
      x = 0;
    if (y < 0)
      y = 0;
  }

  Mass findNearestMass() {
    Mass closestMass = _parent.mass.get(0);
    float closestDist = dist(x, y, closestMass.x, closestMass.y);
    for (Mass m : _parent.mass) {
      float mDist = dist(x, y, m.x, m.y);
      if (mDist < closestDist) {
        closestMass = m;
        closestDist = mDist;
      }
    }
    return closestMass;
  }

  void targetClosest(ArrayList<Sagar> sagars) {
    _parent.chasingTarget = null;
    Ball toTarget = null;
    for (int i = 0; i < sagars.size(); i++) {
      Sagar currSagar = sagars.get(i);
      for (Ball currCheck : currSagar._balls) {
        if (currCheck.getDistFrom(x, y) < rad * 4) {
          // If within the Ball's sight distance
          if (currCheck._mass < _mass * .8 && (toTarget == null || currCheck._mass > toTarget._mass)) {
            toTarget = currCheck;
            _parent.chasingTarget = true;
          } else if (currCheck._mass > _mass * 1.2) {
            toTarget = currCheck;
            _parent.chasingTarget = false;
          }
        }
      }
    }
    _parent.setTarget(toTarget);
  }
}