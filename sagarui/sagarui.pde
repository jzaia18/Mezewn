import java.util.ArrayList;

ArrayList<sagar> sagars = new ArrayList<sagar>();

void setup() {
  fullScreen();
  sagars.add(new sagar());
}

void draw() {
  background(0);
  sagars.get(0).display();
  sagars.get(0).move();
}