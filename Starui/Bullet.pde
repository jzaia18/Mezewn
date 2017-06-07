class Bullet {

  Chrench _parent;
  ArrayList<Chrench> chrenchs; 
  ArrayList<Shape> shapes;
  float heading;
  float xPos, yPos;
  int _speed, _damage;
  boolean exists;

  Bullet(Chrench ch, ArrayList<Chrench> c, ArrayList<Shape> s) {
    _parent = ch;
    heading = ch.heading;
    _speed = ch._bulletSpeed;
    _damage = ch._bulletDamage;
    xPos = ch.xPos + 40*cos(heading);
    yPos = ch.yPos + 40*sin(heading);
    chrenchs = c;
    shapes = s;
    exists = true;
  }


  // Moves the Bullet
  void move() {
    xPos += _speed * cos(heading);
    yPos += _speed * sin(heading);
    if (xPos < 0 || xPos > width || yPos < 0 || yPos > height) exists = false;
  }


  // Displays the Bullet
  void display() {
    fill(_parent.col);
    ellipse(xPos, yPos, 20, 20);
  }


  // Updates all info regarding the Bullet
  void update() {
    move();
    display();
    hittingShapes();
  }


  // Deal damage upon collision with an object
  void hittingShapes() {
    
    // If hit a shape
    for (Shape s : shapes) {
      boolean touching = false;
      for (PVector p : s.vertices) 
        if (dist(p.x, p.y, xPos, yPos) <= 10)
          touching = true;
      if (touching) {
        exists = false;
        s._health -= _damage;
        if (s._health <= 0) _parent._score += s._score;
      }
    }
    
    // If hit a Chrench
    for (Chrench c : chrenchs) {
      boolean touching = false;
      if (dist(xPos, yPos, c.xPos, c.yPos) <= 25) {
        exists = false;
        if (c.lastHit + 500 < System.currentTimeMillis()) {
          c._health -= _damage;
          c.lastHit = System.currentTimeMillis();
          if (c._health <= 0)  _parent._score += c._score;
        }
      }
    }
  }
}