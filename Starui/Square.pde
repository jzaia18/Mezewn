class Square extends Shape {

  Square() {
    c = color(255, 255, 150);
    float heading = random(2*PI);
    vertices = new ArrayList<PVector>();
    vertices.add(new PVector(random(width), random(height)));
    vertices.add(new PVector(vertices.get(0).x + 25*cos(heading), vertices.get(0).y + 25*sin(heading)));
    vertices.add(new PVector(vertices.get(1).x + 25*cos(radians(90)+heading), vertices.get(1).y + 25*sin(radians(90)+heading)));
    vertices.add(new PVector(vertices.get(2).x + 25*cos(heading+radians(180)), vertices.get(2).y + 25*sin(heading+radians(180))));
    s = createShape();
    s.beginShape();
    for (PVector p : vertices) s.vertex(p.x, p.y);
    s.endShape();
    _score = _health = 10;
  }

  Square(boolean shiny) {
    this();
    if (shiny) {
      c = color(75, 255, 100);
      _score = 100;
      _health = 50;
    }
  }

  void display() {
    s.setFill(c);
    s.setStroke(c);
    shape(s, 0, 0);
    fill(255);
    textSize(12);
    text(_health + "", vertices.get(0).x, vertices.get(0).y);
  }
}