import java.util.PriorityQueue;

abstract class Sagar {

  PriorityQueue<Ball> _balls;
  long _lastSplitTime;
  int _totalMass;

  void move() {
    for (Ball b : _balls) b.move();
  }

  void display() {
    for (Ball b : _balls) b.display();
  }

  void calcMass() {
    _totalMass = 0;
    for (Ball b: _balls) _totalMass += b.getMass();
  }
  
  void update() {
    move();
    display();
    calcMass();
  }

  int getMass() {
      return _totalMass;
  }

}