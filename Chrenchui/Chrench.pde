abstract class Chrench {

  PShape tank, body, gun;
  float xPos, yPos;
  float speed;
  boolean wP, aP, sP, dP;
  float heading;
  int level;
  color c;

  abstract void move();

  void display() {
    //fill(c);
    shape(tank, xPos, yPos);
    //shape(gun, xPos, yPos);
  }
}