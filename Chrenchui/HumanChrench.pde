class HumanChrench extends Chrench{
  
  void move(){
    if (wP == true) yPos -= speed;
    if (aP == true) xPos -= speed;
    if (sP == true) yPos += speed;
    if (dP == true) xPos += speed;
  }
  
}