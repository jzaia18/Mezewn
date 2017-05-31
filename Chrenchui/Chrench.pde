class Chrench{
  
  float xPos, yPos;
  float speed;
  boolean wP,aP,sP,dP;
  float heading;
  int level;
  color c;
  
  Chrench(){
    xPos = random(50,width - 50);
    yPos = random(50,height - 50);
    speed = 50;
    c = color(random(256),random(256),random(256));
  }
  
  void move(){}
  
  void display(){
    fill(c);
    ellipse(xPos,yPos,30,30);
  }
  
}