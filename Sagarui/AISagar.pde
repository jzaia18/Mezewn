class AISagar extends Sagar {
  
  // Constructs a new AISagar
  AISagar(ArrayList<Sagar> s, ArrayList<Mass> m, int i) {
    float r = random(50,256);
    float g = random(50,256);
    float b = random(50,256);
    _col = color(r, g, b);
    sagars = s;
    mass = m;
    _balls = new PriorityQueue<Ball>();
    _balls.add(new AIBall(this, 10));
    _name = "AI #" + i;
  }


  // Splits an AISagar (doubles the amount of Balls, halves their  Mass)
  void split() {
    PriorityQueue<Ball> tmp = new PriorityQueue<Ball>();
    for (Ball b : _balls) {
      if (b._mass > 50) {
        float direction = random(-3.14, 3.14);
        tmp.add(new AIBall(this, b._mass / 2, b.x + 3 * b.rad * cos(direction), b.y + 3 * b.rad * sin(direction)));
        tmp.add(new AIBall(this, b._mass / 2, b.x, b.y));
      } else tmp.add(b);
    }
    _balls = tmp;
  }
  
  
  // Asks the smallest Ball to decide what to target (This is good because the smallest Ball is the most afraid of getting eaten)
  void targetClosest(){
    ((AIBall) _balls.peek()).targetClosest(sagars);
  }
}