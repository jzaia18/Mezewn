import java.util.concurrent.ConcurrentLinkedDeque;

abstract class Chrench implements Comparable {

  ArrayList<Chrench> chrenchs; 
  ArrayList<Shape> shapes;
  PShape tank, body, gun;
  float xPos, yPos, speed, heading;
  boolean shooting;
  int _maxLevel, _score, _speedLevel, _health, _maxHealth, _healthLevel, _bulletSpeed, _bulletSLevel, _bulletDamage, _bulletDLevel, _bulletReload, _bulletRLevel, _points, _pointsUsed, _healthRegen, _healthRLevel, _bodyDamage, _bodyDLevel;
  color col;
  String _name;
  double lastShot = -500;
  double lastHit = System.currentTimeMillis();
  ConcurrentLinkedDeque<Bullet> shots;

  // Compares Chrenchs based on score (for scoreboard)
  public int compareTo(Object o) {
    if (!(o instanceof Chrench)) {
      throw new ClassCastException();
    }
    return _score - ((Chrench) o)._score;
  }

  // Implemened differently by AI/Human
  abstract void move();
  abstract void look();
  abstract void levelUp();


  // Update all Chrench variables
  void update() {
    look();
    move();
    doBodyDamage();
    shoot();
    display();
    updateBullets();
    regenHealth();
    levelUp();
    updatePoints();
  }


  // Display the Chrench
  void display() {
    shape(tank, xPos, yPos);
    textSize(10);
    textAlign(CENTER, CENTER);
    fill(255);
    text(_name + "\nHP: " + _health, xPos, yPos);
  }


  // Fire a Bullet
  void shoot() {
    if (shooting && System.currentTimeMillis() > _bulletReload + lastShot) {
      shots.add(new Bullet(this, chrenchs, shapes));
      lastShot = System.currentTimeMillis();
    }
  }


  // Collision damage
  void doBodyDamage() {
    //invincibility frames
    if (lastHit + 500 < System.currentTimeMillis()) {
      
      // If collided with a Chrench
      for (Chrench c : chrenchs) {
        if (c != this && dist(c.xPos, c.yPos, xPos, yPos) < 95) {
          c._health -= _bodyDamage;
          if (c._health <= 0) _score += c._score;
          lastHit = System.currentTimeMillis();
        }
      }
      
      // If collided with a Shape
      for (Shape s : shapes) {
        boolean touching = false;
        for (PVector p : s.vertices)
          if (dist(p.x, p.y, xPos, yPos) < 25)
            touching = true;
        if (touching) {
          _health -= 5;
          s._health -= _bodyDamage;
          if (s._health <= 0) _score += s._score;
          lastHit = System.currentTimeMillis();
        }
      }
    }
  }


  // Update all Bullets fired
  void updateBullets() {
    Iterator it = shots.iterator();
    while (it.hasNext()) {
      Bullet b = (Bullet) it.next();
      if (!b.exists) it.remove();
      else b.update();
    }
  }


  // Adjust score
  void updatePoints() {
    _points = _score / 100;
  }


  // Regen health slowly
  void regenHealth() {
    if (frameCount % 150 == 0) {
      if (_health + _healthRegen < _maxHealth) _health += _healthRegen;        
      else _health = _maxHealth;
    }
  }
}