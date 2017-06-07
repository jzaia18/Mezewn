abstract class Shape {

  PShape s;
  ArrayList<PVector> vertices;
  color c;
  int _score, _health;

  // Displays the Shape
  void display() {
    displayClean();
    textSize(12);
    text(_health + "", vertices.get(0).x, vertices.get(0).y);
  }


  // Display the Shape minus ugly but useful info
  void displayClean() {
    s.setFill(c);
    s.setStroke(c);
    shape(s, 0, 0);
    fill(255);
  }
}