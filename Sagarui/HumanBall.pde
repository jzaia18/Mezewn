class HumanBall extends Ball {

  HumanBall(Sagar s) {
    _mass = 10;
    float r = random(256);
    x = random((width - r) + r/2);
    y = random((height - r) + r/2);
    _parent = s;
    _col = _parent._col;
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


  float getDistFrom(float ox, float oy) {
    return dist(x, y, ox, oy);
  }

  void move() {
    Ball b;
    Iterator it = _parent._balls.iterator();
    while (it.hasNext()) {
      b = (Ball)it.next();
      if (b != this && b.getDistFrom(x, y) < (rad + b.rad)) {
        if (System.currentTimeMillis() - _parent._lastSplitTime < 5000) {
          x-= (b.x - x) * .08; 
          y-= (b.y - y) * .08;
        } else {
          _parent.merge(this, (HumanBall) b);
        }
      }
      float speed = max(.002, .00001 * (100000.0/_mass)); //As a decimal (0, 1] representing percent of mouse gap moved
      x += (mouseX - x) * speed;
      y += (mouseY - y) * speed;
    }
  }
}