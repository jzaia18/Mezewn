class Triangle extends Shape {
  
  Triangle() {
    x = random(width);
    y = random(height);
    c = color(random(50, 256), random(50, 256), random(50, 256));
  }


  void display() {
    fill(c);
    noStroke();
    float sidelength = 20; 
    //.577 is 2/3 of the way down the altitude of an equilateral triangle
    triangle(x, y - sidelength * .577, x - sidelength / 2, y + sidelength * .289, x + sidelength / 2, y + sidelength * .289);
  }

}