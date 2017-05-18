ArrayList<Sagar> sagars = new ArrayList<Sagar>();

void setup() {
  fullScreen();
  sagars.add(new HumanSagar());
}

void draw() {
  background(0);
  sagars.get(0).display();
  sagars.get(0).move();
}