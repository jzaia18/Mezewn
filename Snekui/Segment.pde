class Segment {

  float x, y;
  color _col; 
  Snek _parent;

  Segment(Snek s) {
    x = random(width);
    y = random(height);
    _parent = s;
    _col = _parent._col;
  }

  Segment(Snek s, float xcor, float ycor) {
    this(s);
    x = xcor;
    y = ycor;
  }

  void display() {
    noStroke();
    fill(_col);
    ellipse(x, y, 30, 30);
  }
  
  boolean inContactWith(Segment s) {
    return dist(x, y, s.x, s.y) <= 30; 
  }
}