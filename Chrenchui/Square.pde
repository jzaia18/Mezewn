class Square extends Shape {

  Square() {
    x = random(width);
    y = random(height);
    c = color(random(50, 256), random(50, 256), random(50, 256));
  }


  void display() {
    fill(c);
    noStroke();
    rect(x, y, 20, 20);
  }
}