import java.util.PriorityQueue;

abstract class Sagar {

  PriorityQueue<Ball> _balls;
  long _lastSplitTime;
  int _totalMass;
  Ball _target; //Only used for AIs
  Boolean chasingTarget; //True if chasing, false if fleeing
  boolean willSplit;
  ArrayList<Sagar> sagars;
  ArrayList<Mass> mass;
  color _col;
  String _name;

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
    if (willSplit) split();
  }

  abstract void split();
  abstract void merge(HumanBall b1, HumanBall b2);

  void targetClosest(){}

  int getMass() {
      return _totalMass;
  }
  
  float getDistFrom(float ox, float oy){
   return _balls.peek().getDistFrom(ox,oy); 
  }
  
  void setTarget(Ball t){ _target = t; }
  
  Ball getTarget(){ return _target; }
  float getX(){ return _balls.peek().x; }
  float getY(){ return _balls.peek().y; }
  Ball getBall() { return _balls.peek(); }

}