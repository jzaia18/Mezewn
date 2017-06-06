import java.util.concurrent.ConcurrentLinkedDeque;

abstract class Chrench implements Comparable {

  ArrayList<Chrench> chrenchs; 
  ArrayList<Shape> shapes;
  PShape tank, body, gun;
  float xPos, yPos, speed, heading;
  boolean wP, aP, sP, dP, exists, shooting;
  int level, _score, _health, _maxHealth, _bulletSpeed, _bulletDamage, _bulletReload, _points, _pointsUsed;
  color col;
  String _name;
  double lastShot;
  ConcurrentLinkedDeque<Bullet> shots;

  public int compareTo(Object o) {
    if (!(o instanceof Chrench)) {
      throw new ClassCastException();
    }
    return _score - ((Chrench) o)._score;
  }

  abstract void move();

  abstract void look();

  abstract void shoot();

  void update() {
    look();
    move();
    doBodyDamage();
    shoot();
    display();
    updateBullets();
  }

  void display() {
    shape(tank, xPos, yPos);
    textSize(10);
    textAlign(CENTER, CENTER);
    fill(255);
    text(_name + "\nHP: " + _health, xPos, yPos);
  }
  
  void doBodyDamage() {
   for (Chrench c: chrenchs) {
     if (c != this && dist(c.xPos, c.yPos, xPos, yPos) < 95) {
      _health -= 5;
      c._health -=5;
     }
   }
  }

  void updateBullets() {
    Iterator it = shots.iterator();
    while (it.hasNext()) {
      Bullet b = (Bullet) it.next();
      if (!b.exists) it.remove();
      else b.update();
    }
  }
  
  void updatePoints() {
    _points = _score / 100 - _pointsUsed;
  }
}