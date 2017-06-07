import java.util.PriorityQueue;

abstract class Sagar implements Comparable {

  PriorityQueue<Ball> _balls;
  long _lastSplitTime;
  int _totalMass;
  Ball _target; //Only used for AIs
  Boolean chasingTarget; //True if chasing, false if fleeing, null if targetLess
  boolean willSplit;
  ArrayList<Sagar> sagars;
  ArrayList<Mass> mass;
  color _col;
  String _name;

  // Compares 2 Sagars by mass
  public int compareTo(Object o) {
    if (!(o instanceof Sagar)) throw new ClassCastException(); // This should never be run
    return _totalMass - ((Sagar) o)._totalMass;
  }

  
  // Move all Balls
  void move() {
    for (Ball b : _balls) b.move();
  }


  // Display all Balls
  void display() {
    textSize(10);
    textAlign(CENTER, CENTER);
    for (Ball b : _balls) b.display();
  }


  // Calculate Total Mass
  void calcMass() {
    _totalMass = 0;
    for (Ball b : _balls) _totalMass += b.getMass();
  }


  // Update this Sagar's variables and Balls
  void update() {
    decay();
    targetClosest();
    move();
    display();
    calcMass();
    if (willSplit) split();
  }


  // Decays some mass
  void decay() {
    if (random(300 - sqrt(_totalMass)) < 1)
      for (Ball b: _balls)
        if (b._mass > 20) b._mass -= random(1, 5);
  }


  // To be implented by AISagar & HumanSagar
  abstract void split();
  
  
  // These are not abstract because they do nothing if used by the wrong playertype (Human/AI)
  void merge(HumanBall b1, HumanBall b2){}
  void targetClosest() {}


  // Accessors
  int getMass() { return _totalMass; }
  float getDistFrom(float ox, float oy) { return _balls.peek().getDistFrom(ox, oy); }
  Ball getTarget() { return _target; }
  float getX() { return _balls.peek().x; }
  float getY() { return _balls.peek().y; }
  Ball getBall() { return _balls.peek(); }
  
  // Mutators
  void setTarget(Ball t) { _target = t; }
}