class Segment {

  float x, y;
  color _col; 
  Snek _parent;

  Segment(Snek s, float xcor, float ycor) {
    _parent = s;
    _col = _parent._col;
    x = xcor;
    y = ycor;
  }

  // Displays the Segment
  void display() {
    noStroke();
    fill(_col);
    ellipse(x, y, 30, 30);
  }
}