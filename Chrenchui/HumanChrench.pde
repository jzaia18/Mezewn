class HumanChrench extends Chrench {

  HumanChrench(ArrayList<Chrench> c, ArrayList<Shape> s) {
    shots = new ConcurrentLinkedDeque<Bullet>();
    lastShot = -500;
    xPos = random(50, width - 50);
    yPos = random(50, height - 50);
    chrenchs = c;
    shapes = s;
    speed = 5;
    col = color(random(256), random(256), random(256));
    tank = createShape(GROUP);
    body = createShape(ELLIPSE, 0, 0, 50, 50);
    body.setFill(col);
    body.setStroke(col);
    gun = createShape(RECT, 0, -15, 50, 30);
    gun.setFill(col);
    tank.addChild(body);
    tank.addChild(gun);
    gun.setStroke(col);
    heading = 0;
    _name = "Player";
    exists = true;
    _score = 10;
    shooting = false;
  }
  
  void update(){
    move();
    look();
    shoot();
    display();
  }

  void move() {
    if (wP) yPos -= speed;
    if (aP) xPos -= speed;
    if (sP) yPos += speed;
    if (dP) xPos += speed;
    Iterator it = shots.iterator();
    while (it.hasNext())
      ((Bullet)it.next()).update();
  }

  void look() {
    int index = tank.getChildIndex(gun);
    //remove gun to be replaced later
    tank.removeChild(index);
    heading = atan2(mouseY - yPos, mouseX - xPos);
    //make gun a PShape with four vertices made based on mouse angle
    float point1x, point1y, point2x, point2y, point3x, point3y, point4x, point4y;
    gun = createShape();
    gun.beginShape();
    point1x = 12.5*cos(heading)+12.5*cos(heading-radians(90));
    point1y = 12.5*sin(heading)+12.5*sin(heading-radians(90));
    point2x = point1x + 30*cos(heading);
    point2y = point1y + 30*sin(heading);
    point3x = point2x + 25*cos(radians(90)+heading);
    point3y = point2y + 25*sin(radians(90)+heading);
    point4x = point3x + 30*cos(heading+radians(180));
    point4y = point3y + 30*sin(heading+radians(180));
    gun.vertex(point1x, point1y);
    gun.vertex(point2x, point2y);
    gun.vertex(point3x, point3y);
    gun.vertex(point4x, point4y);
    gun.endShape(CLOSE);
    //finalize and add gun as child
    gun.setFill(col);
    gun.setStroke(col);
    tank.addChild(gun);
  }
  
  void shoot(){
    if (shooting && System.currentTimeMillis() > 250 + lastShot){
      shots.add(new Bullet(this));
      lastShot = System.currentTimeMillis();
    }
  }
}