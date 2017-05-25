class HumanBall extends Ball {

  HumanBall(Sagar s) {
    float r = random(50,256);
    float g = random(50,256);
    float b = random(50,256);
    _mass = 10;
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

  
  float getDistFrom(float ox, float oy){
     return dist(x, y, ox, oy); 
  }

  void move() {
    float speed = max(.002, (.1 - (.001 * (_mass / 4.0)))); //As a decimal (0, 1] representing percent of mouse gap moved
    x += (mouseX - x) * speed;
    y += (mouseY - y) * speed;
  }
}