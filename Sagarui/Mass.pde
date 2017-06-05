class Mass {

  float x, y;
  int _mass;
  boolean exists;
  color _col;

  // Create a new Mass
  Mass() {
    float r = random(50,256);
    float g = random(50,256);
    float b = random(50,256);
    _col = color(r, g, b);
    _mass = 1;
    x = random(0, width - 75);
    y = random(0, height - 40);
    exists = true;
  }


  // Create a Mass at a specific location
  Mass(float xcor, float ycor) {
    this();
    x = xcor;
    y = ycor;
  }

  
  // Create a Mass with a given size and location
  Mass(float xcor, float ycor, int s) {
    this(xcor, ycor);
    _mass = s;
  }


  // Display the Mass
  void display() {
    fill(_col);
    noStroke();
    ellipse(x, y, 8, 8);
  }
}