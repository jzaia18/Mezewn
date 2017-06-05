class AIChrench extends Chrench {

  AIChrench(ArrayList<Chrench> c, ArrayList<Shape> s, int num) {
    shots = new ConcurrentLinkedDeque<Bullet>();
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
    _name = "AI #" + num;
    heading = 0;
    exists = true;
    _score = 10;
  }

  void move() {
  }

  void look() {
  }
  
  void shoot(){
  }
  
}