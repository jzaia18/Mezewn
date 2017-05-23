import java.util.PriorityQueue;

abstract class Sagar {

  PriorityQueue<Ball> _balls;
  long _lastSplitTime;
  int _totalMass;
  Sagar _target;

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
    targetClosest();
    move();
    display();
    calcMass();
  }

  void targetClosest(){}

  int getMass() {
      return _totalMass;
  }
  
  float getDistFrom(float ox, float oy){
   return _balls.peek().getDistFrom(ox,oy); 
  }
  
  void setTarget(Sagar t){ _target = t; }
  
  Sagar getTarget(){ return _target; }
  float getX(){ return _balls.peek().x; }
  float getY(){ return _balls.peek().y; }

}