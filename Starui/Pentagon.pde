class Pentagon extends Shape {

  Pentagon() {
    c = color(131, 136, 235);
    float heading = random(2*PI);
    vertices = new ArrayList<PVector>();
    vertices.add(new PVector(random(width), random(height)));
    vertices.add(new PVector(vertices.get(0).x + 25*cos(heading), vertices.get(0).y + 25*sin(heading)));
    vertices.add(new PVector(vertices.get(1).x + 25*cos(radians(72)+heading), vertices.get(1).y + 25*sin(radians(72)+heading)));
    vertices.add(new PVector(vertices.get(2).x + 25*cos(heading+radians(144)), vertices.get(2).y + 25*sin(heading+radians(144))));
    vertices.add(new PVector(vertices.get(3).x + 25*cos(heading+radians(216)), vertices.get(3).y + 25*sin(heading+radians(216))));
    s = createShape();
    s.beginShape();
    for (PVector p : vertices) s.vertex(p.x, p.y);
    s.endShape();
    _score = _health = 40;
  }

  Pentagon(boolean shiny) {
    this();
    if (shiny) {
      c = color(75, 255, 100);
      _score = 300;
      _health = 200;
    }
  }

}