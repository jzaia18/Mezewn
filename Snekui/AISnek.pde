class AISnek extends Snek{

  AISnek(ArrayList<Snek> s, ArrayList<Mass> m) {
    float r = random(50, 256);
    float g = random(50, 256);
    float b = random(50, 256);
    _col = color(r, g, b);
    sneks = s;
    _mass = m;
    _body = new LinkedList<Segment>();
    _body.add(new Segment(this));
  }
  
  void move() {
    
  }
  
}