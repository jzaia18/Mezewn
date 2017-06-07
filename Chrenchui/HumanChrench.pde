class HumanChrench extends Chrench {

  boolean wP, aP, sP, dP, oneP, twoP, threeP, fourP, fiveP, sixP; 

  HumanChrench(ArrayList<Chrench> c, ArrayList<Shape> s) { 
    shots = new ConcurrentLinkedDeque<Bullet>();
    lastShot = -500;
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
    heading = 0;
    _name = "Player";
    _score = 10;
    _health = _maxHealth = 100;
    _healthRegen = 1;
    _bulletSpeed = 7;
    _maxLevel = _bulletDamage = _bodyDamage = 5;
    _bulletReload = 250;
    _points = _pointsUsed = _speedLevel = _healthLevel = _bulletSLevel = _bulletDLevel = _bulletRLevel = _healthRLevel = _bodyDLevel = 0;
  }

  void move() {
    if (wP) yPos -= speed;
    if (aP) xPos -= speed;
    if (sP) yPos += speed;
    if (dP) xPos += speed;
    //prevents player from moving out of bounds
    if (xPos > width) xPos = width;
    if (xPos < 0) xPos = 0;
    if (yPos > height) yPos = height;
    if (yPos < 0) yPos = 0;
  }

  void look() {
    int index = tank.getChildIndex(gun);
    //remove gun to be replaced later
    tank.removeChild(index);
    heading = atan2(mouseY - yPos, mouseX - xPos);
    //make gun a PShape with four vertices made based on mouse angle
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

  void levelUp() {
    if (_points - _pointsUsed > 0) {
      if (oneP && _healthLevel < _maxLevel) {
        _pointsUsed++;
        _healthLevel++;
        _healthRegen++;
      }
      if (twoP && _bodyDLevel < _maxLevel) {
        _pointsUsed++;
        _bodyDLevel++;
        _bodyDamage++;
      }
      if (threeP && _bulletSLevel < _maxLevel) {
        _pointsUsed++;
        _bulletSLevel++;
        _bulletSpeed++;
      }
      if (fourP && _bulletDLevel < _maxLevel) {
        _pointsUsed++;
        _bulletDLevel++;
        _bulletDamage++;
      }
      if (fiveP && _bulletRLevel < _maxLevel) {
        _pointsUsed++;
        _bulletRLevel++;
        _bulletReload-=10;
      }
      if (sixP && _speedLevel < _maxLevel) {
        _pointsUsed++;        
        _speedLevel++;
        speed+=.25;
      }
    }
    oneP = twoP = threeP = fourP = fiveP = sixP = false;
  }
}