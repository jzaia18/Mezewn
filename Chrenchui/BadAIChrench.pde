class BadAIChrench extends Chrench {

  Chrench _target;

  BadAIChrench(ArrayList<Chrench> c, ArrayList<Shape> s, int num) {
    shots = new ConcurrentLinkedDeque<Bullet>();
    xPos = random(50, width - 50);
    yPos = random(50, height - 50);
    chrenchs = c;
    shapes = s;
    speed = 5;
    col = color(random(256), random(256), random(256));
    tank = createShape(GROUP);
    body = createShape(ELLIPSE, 0, 0, 50, 50);
    body.setFill(col);
    body.setStroke(col);
    gun = createShape(RECT, 0, -15, 50, 30);
    gun.setFill(col);
    tank.addChild(body);
    tank.addChild(gun);
    gun.setStroke(col);
    _name = "AI #" + num;
    heading = 0;
    exists = true;
    _score = 10;
    _health = 100;
    _bulletSpeed = 7;
    _bulletReload = 250;
    _bulletDamage = 5;
  }

  void move() {
    //make it  
  }

  void look() {
    targetClosest();
    // If there is no target, seek out shapes
    if (_target == null && shapes.size() != 0) {
      Shape toEat = targetShape();
      heading = atan2(toEat.vertices.get(0).y - yPos, toEat.vertices.get(0).x - xPos);
    } else heading = atan2(_target.yPos-yPos, _target.xPos-xPos);
    int index = tank.getChildIndex(gun);
    //remove gun to be replaced later
    tank.removeChild(index);
    float point1x, point1y, point2x, point2y, point3x, point3y, point4x, point4y;
    gun = createShape();
    gun.beginShape();
    point1x = 12.5*cos(heading)+12.5*cos(heading-radians(90));
    point1y = 12.5*sin(heading)+12.5*sin(heading-radians(90));
    point2x = point1x + 30*cos(heading);
    point2y = point1y + 30*sin(heading);
    point3x = point2x + 25*cos(radians(90)+heading);
    point3y = point2y + 25*sin(radians(90)+heading);
    point4x = point3x + 30*cos(heading+radians(180));
    point4y = point3y + 30*sin(heading+radians(180));
    gun.vertex(point1x, point1y);
    gun.vertex(point2x, point2y);
    gun.vertex(point3x, point3y);
    gun.vertex(point4x, point4y);
    gun.endShape(CLOSE);
    //finalize and add gun as child
    gun.setFill(col);
    gun.setStroke(col);
    tank.addChild(gun);
  }

  void shoot() {
    if (System.currentTimeMillis() > _bulletReload + lastShot) {
      shots.add(new Bullet(this, chrenchs, shapes));
      lastShot = System.currentTimeMillis();
    }
  }

  // Finds the closest Chrench within a vision radius
  void targetClosest() {
    _target = null;
    float targetDist = 0;
    for (Chrench checkChrench : chrenchs) {
      float distFromCheck = dist(checkChrench.xPos, checkChrench.yPos, xPos, yPos);
      if ( distFromCheck < 220 && checkChrench != this && (_target == null || distFromCheck < targetDist)) {
        _target = checkChrench;
        targetDist = distFromCheck;
      }
    }
  }

  // Returns the closest Shape
  Shape targetShape() {
    Shape closestShape = shapes.get(0);
    float closestDist = dist(closestShape.vertices.get(0).x, closestShape.vertices.get(0).y, xPos, yPos);
    for (Shape s : shapes) {
      float checkDist = dist(s.vertices.get(0).x, s.vertices.get(0).y, xPos, yPos);
      if ( checkDist < closestDist) {
        closestShape = s;
        closestDist = checkDist;
      }
    }
    return closestShape;
  }
}