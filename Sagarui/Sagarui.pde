ArrayList<Ball> sagars = new ArrayList<Ball>();

void setup() {
  fullScreen();
  sagars.add(new Ball());
}

void draw() {
  background(0);
  sagars.get(0).display();
  sagars.get(0).move();
}