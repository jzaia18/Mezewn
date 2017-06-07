class AIChrench extends Chrench {

  Chrench _target;
  Boolean isFleeing;

  AIChrench(ArrayList<Chrench> c, ArrayList<Shape> s, int num) {
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
    _score = 10;
    _health = _maxHealth = 100;
    _healthRegen = 1;
    _bulletSpeed = 7;
    _bulletReload = 250;
    _bulletDamage = _bodyDamage = _maxLevel = 5;
    shooting = true;
    _points = _pointsUsed = _healthLevel = _bulletSLevel = _bulletDLevel = _bulletRLevel = _healthRLevel = _bodyDLevel = 0;
  }

  void move() {
    int multiplier = 1;
    if (isFleeing) multiplier = -1;
    xPos += cos(heading) * speed * multiplier;
    yPos += sin(heading) * speed * multiplier;
    //prevents AI from moving out of bounds
    if (xPos > width) xPos = width;
    if (xPos < 0) xPos = 0;
    if (yPos > height) yPos = height;
    if (yPos < 0) yPos = 0;
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

  // Finds the closest Chrench within a vision radius
  void targetClosest() {
    _target = null;
    isFleeing = null;
    float targetDist = 0;
    for (Chrench checkChrench : chrenchs) {
      for (Bullet b : checkChrench.shots) {
        if (dist(b.xPos, b.yPos, xPos, yPos) < 125) {
          _target = b._parent;
          isFleeing = true;
          return;
        }
      }
      float distFromCheck = dist(checkChrench.xPos, checkChrench.yPos, xPos, yPos);
      if ( distFromCheck < 220 && checkChrench != this && (_target == null || distFromCheck < targetDist)) {
        _target = checkChrench;
        targetDist = distFromCheck;
        isFleeing = false;
      } else if (distFromCheck < 110 && checkChrench != this) {
        _target = checkChrench;
        isFleeing = true;
      }
    }
  }

  // Returns the closest Shape
  Shape targetShape() {
    isFleeing = false;
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

  void levelUp() {
    if (_points - _pointsUsed > 0) {
      int rand = (int) random(6);
      if (rand == 0 && _healthLevel < _maxLevel) {
        _pointsUsed++;
        _healthLevel++;
        _healthRegen++;
      }
      if (rand == 1 && _bodyDLevel < _maxLevel) {
        _pointsUsed++;
        _bodyDLevel++;
        _bodyDamage++;
      }
      if (rand == 2 && _bulletSLevel < _maxLevel) {
        _pointsUsed++;
        _bulletSLevel++;
        _bulletSpeed++;
      }
      if (rand == 3 && _bulletDLevel < _maxLevel) {
        _pointsUsed++;
        _bulletDLevel++;
        _bulletDamage++;
      }
      if (rand == 4 && _bulletRLevel < _maxLevel) {
        _pointsUsed++;
        _bulletRLevel++;
        _bulletReload-=1;
      }
      if (rand == 5 && _speedLevel < _maxLevel) {
        _pointsUsed++;
        _speedLevel++;
        speed+=.25;
      }
    }
  }
}