Chrench player;

void keyPressed(){
  if (Character.toLowerCase(key) == 'w') player.wP = true;
  if (Character.toLowerCase(key) == 'a') player.aP = true;
  if (Character.toLowerCase(key) == 's') player.sP = true;
  if (Character.toLowerCase(key) == 'd') player.dP = true;
}
void keyReleased(){
  if (Character.toLowerCase(key) == 'w') player.wP = false;
  if (Character.toLowerCase(key) == 'a') player.aP = false;
  if (Character.toLowerCase(key) == 's') player.sP = false;
  if (Character.toLowerCase(key) == 'd') player.dP = false;
}

void setup(){
  fullScreen();
  background(0);
  player = new HumanChrench();
}

void draw(){
  background(0);
  player.display();
  player.move();
}