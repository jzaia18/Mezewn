class AIBall extends Ball {
  
  //needed for AIBalls only
  float dx;
  float dy;

  AIBall(Sagar s) {
    float r = random(50,256);
    float g = random(50,256);
    float b = random(50,256);
    _mass = (int) random(41) + 10;
    dx = random(30) - 15;
    dy = random(30) - 15;
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
    float speed = max(.002, (.1 - (.001 * (_mass / 4.0)))); //As a decimal (0, 1] representing percent of mouse gap moved
    if (_parent.getTarget() == null) {
        x += (random(width / 8) - x / 8) * speed;
        y += (random(height / 8) - y / 8) * speed;
    }
    else {
      x += (_parent.getTarget().getX() - x) * speed;
      y += (_parent.getTarget().getY() - y) * speed;
    }
  }
  
  void targetClosest(ArrayList<Sagar> s){
    Sagar closestSagar = null;
    float closestDist = 10000; //Returns distance from THIS ball
    for (int i = 0; i < s.size(); i++) {
      Sagar j = s.get(i);
      if (j != _parent && compareTo(j.getBall()) > (_mass * .25) && j.getDistFrom(x, y) < closestDist){
        closestSagar = j;
        closestDist = j.getDistFrom(x, y);
      }
    }
    
    _parent.setTarget(closestSagar);
  }
  
}