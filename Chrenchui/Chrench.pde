import java.util.concurrent.ConcurrentLinkedDeque;

abstract class Chrench implements Comparable {

  ArrayList<Chrench> chrenchs; 
  ArrayList<Shape> shapes;
  PShape tank, body, gun;
  float xPos, yPos, speed, heading;
  boolean wP, aP, sP, dP, exists, shooting;
  int level, _score;
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
    move();
    look();
    display();
  }

  void display() {
    shape(tank, xPos, yPos);
    textSize(10);
    textAlign(CENTER, CENTER);
    fill(255);
    text(_name, xPos, yPos);
  }
}