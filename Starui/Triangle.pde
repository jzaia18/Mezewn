class Triangle extends Shape {

  Triangle() {
    c = color(255, 75, 75);
    float heading = random(2*PI);
    vertices = new ArrayList<PVector>();
    vertices.add(new PVector(random(width), random(height)));
    vertices.add(new PVector(vertices.get(0).x + 25*cos(heading), vertices.get(0).y + 25*sin(heading)));
    vertices.add(new PVector(vertices.get(0).x + 25*cos(heading-PI/3), vertices.get(0).y + 25*sin(heading-PI/3)));
    s = createShape();
    s.beginShape();
    for (PVector p : vertices) s.vertex(p.x, p.y);
    s.endShape();
    _score = 25;
    _health = 15;
  }

  Triangle(boolean shiny) {
    this();
    if (shiny) {
      c = color(75, 255, 100);
      _score = 200;
      _health = 150;
    }
  }

}