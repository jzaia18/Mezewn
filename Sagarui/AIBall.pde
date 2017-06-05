class AIBall extends Ball {

  //needed for AIBalls only
  float dx, dy;
  
  
  // Constructs a new AIBall
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


  // Allows one to specify the mass of an AIBall
  AIBall(Sagar s, int mass) {
    this(s);
    _mass = mass;
  }


  // Allows one to specify the co-ordinates and mass of an AIBall
  AIBall(Sagar s, int mass, float xcor, float ycor) {
    this(s, mass);
    x = xcor;
    y = ycor;
  }


  // Moves the AIBall
  void move() {
    float speed = 8 * pow(_mass, -0.439);
       
    // If there is no target, seek out small Masses
    if (_parent.getTarget() == null && _parent.mass.size() != 0) { // There is no nearby Ball to eat
      Mass target = findNearestMass();
      float direction = atan2(target.y - y, target.x - x) + random(-.1,.1);
      x += speed * cos(direction);
      y += speed * sin(direction);
    } 
    
    // If persuing a smaller Ball
    else if (_parent.chasingTarget) { 
      Ball target = _parent.getTarget();
      float direction = atan2(target.y - y, target.x - x) + random(-.1,.1);
      x += speed * cos(direction);
      y += speed * sin(direction);
    }
    
    // If fleeing a larger Ball
    else { 
      Ball target = _parent.getTarget();
      float direction = atan2(target.y - y, target.x - x) + random(-.1,.1);
      x -= speed * cos(direction);
      y -= speed * sin(direction);
    }
    
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
  
  
  // Finds the closest Mass to this AIBall
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


  // Sets the parent's target to the closest Ball, may be chasing or fleeing
  void targetClosest(ArrayList<Sagar> sagars) {
    _parent.chasingTarget = null;
    Ball toTarget = null;
    for (int i = 0; i < sagars.size(); i++) {
      Sagar currSagar = sagars.get(i);
      for (Ball currCheck : currSagar._balls) {
        if (currCheck.getDistFrom(x, y) < rad * 4) { // If within the Ball's sight distance
          if (currCheck._mass < _mass * .8 && (toTarget == null || currCheck._mass > toTarget._mass)) { // If this Ball can be eaten
            toTarget = currCheck;
            _parent.chasingTarget = true;
          } else if (currCheck._mass > _mass * 1.2) { // If this Ball can be eaten
            toTarget = currCheck;
            _parent.chasingTarget = false;
            break;
          }
        }
      }
    }
    _parent.setTarget(toTarget);
  }
}