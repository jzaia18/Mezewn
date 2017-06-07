class HumanBall extends Ball {

  HumanBall(Sagar s) {
    _mass = 10;
    float r = random(256);
    x = random((width - r) + r/2);
    y = random((height - r) + r/2);
    _parent = s;
    _col = _parent._col;
  }


  // Allows specification of mass
  HumanBall(Sagar s, int mass) {
    this(s);
    _mass = mass;
  }


  // Allows specification of mass and position
  HumanBall(Sagar s, int mass, float xcor, float ycor) {
    this(s, mass);
    x = xcor;
    y = ycor;
  }

  // Returns the distance from a given point
  float getDistFrom(float ox, float oy) { 
    return dist(x, y, ox, oy);
  }


  // Moves the Ball
  void move() {
    Ball b;
    Iterator it = _parent._balls.iterator();
    while (it.hasNext()) {
      b = (Ball)it.next();

      // If 2 balls are intersecting, have them collide
      if (b != this && b.getDistFrom(x, y) < (rad + b.rad)) {
        if (System.currentTimeMillis() - _parent._lastSplitTime < 7500) {
          float direction = atan2(b.y - y, b.x - x);
          float magnitude = .02 * min(b.rad, rad);
          x-= magnitude + cos(direction); 
          y-= magnitude + sin(direction);
          b.x+= magnitude + cos(direction); 
          b.y+= magnitude + sin(direction);
        } else {
          _parent.merge(this, (HumanBall) b);
        }
      } 
      
      // Else follow the mouse
      else {
        float speed = 8 * pow(_mass, -0.439);
        float heading = atan2(mouseY - y, mouseX - x);
        x += speed * cos(heading);
        y += speed * sin(heading);
      }
    }
  }
}