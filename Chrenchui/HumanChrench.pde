class HumanChrench extends Chrench {

  void move() {
    if (wP == true) yPos -= speed;
    if (aP == true) xPos -= speed;
    if (sP == true) yPos += speed;
    if (dP == true) xPos += speed;
  }


  HumanChrench() {
    xPos = random(50, width - 50);
    yPos = random(50, height - 50);
    speed = 5;
    c = color(random(256), random(256), random(256));
    tank = createShape(GROUP);
    body = createShape(ELLIPSE, 0, 0, 50, 50);
    body.setFill(c);
    gun = createShape(RECT, -15, -35, 30, 30);
    gun.setFill(c);
    tank.addChild(body);
    tank.addChild(gun);
  }
}