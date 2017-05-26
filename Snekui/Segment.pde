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
    fill(_col);
    stroke(128);
    ellipse(x,y,30,30);
  }
}