class HumanChrench extends Chrench {

  void move() {
    if (wP) yPos -= speed;
    if (aP) xPos -= speed;
    if (sP) yPos += speed;
    if (dP) xPos += speed;
  }

  HumanChrench() {
    xPos = random(50, width - 50);
    yPos = random(50, height - 50);
    speed = 5;
    c = color(random(256), random(256), random(256));
    tank = createShape(GROUP);
    body = createShape(ELLIPSE, 0, 0, 50, 50);
    body.setFill(c);
    gun = createShape(RECT, 0, -15, 50, 30);
    gun.setFill(c);
    tank.addChild(body);
    tank.addChild(gun);
    gun.setStroke(c);
  }

  void look() {
    //pushMatrix();
    //heading = atan2(xPos - mouseX, yPos - mouseY);
    //translate(xPos,yPos);
    //rotate(-heading - HALF_PI);
    //popMatrix();
    int index = tank.getChildIndex(gun);
    //remove gun to be replaced later
    tank.removeChild(index);
    heading = atan2(mouseX - xPos, mouseY - yPos);
    
    /*make gun a PShape with four vertices made based on mouse angle (todo)*/
    
    //finalize and add gun as child
    gun.setFill(c);
    gun.setStroke(c);
    tank.addChild(gun);
  }
}