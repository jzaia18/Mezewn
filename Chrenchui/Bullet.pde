class Bullet {
 
  Chrench _parent;
  float heading;
  float speed;
  float xPos, yPos;
  
  Bullet(Chrench c) {
    _parent = c;
    heading = c.heading;
    speed = 7;
    xPos = c.xPos;
    yPos = c.yPos;
  }
  
  void move(){
    xPos += speed * cos(heading);
    yPos += speed * sin(heading);
  }
  
  void display(){
    fill(_parent.col);
    ellipse(xPos,yPos,20,20);
  }
  
  void update(){
    move();
    display();
  }
  
}