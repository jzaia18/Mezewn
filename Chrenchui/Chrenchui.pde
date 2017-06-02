Chrench player;

void keyPressed() {
  if (Character.toLowerCase(key) == 'w') player.wP = true;
  if (Character.toLowerCase(key) == 'a') player.aP = true;
  if (Character.toLowerCase(key) == 's') player.sP = true;
  if (Character.toLowerCase(key) == 'd') player.dP = true;
  if (keyCode == LEFT) player.left = true;
  if (keyCode == RIGHT) player.right = true;
}
void keyReleased() {
  if (Character.toLowerCase(key) == 'w') player.wP = false;
  if (Character.toLowerCase(key) == 'a') player.aP = false;
  if (Character.toLowerCase(key) == 's') player.sP = false;
  if (Character.toLowerCase(key) == 'd') player.dP = false;
  if (keyCode == LEFT) player.left = false;
  if (keyCode == RIGHT) player.right = false;
}

void setup() {
  fullScreen();
  background(0);
  player = new HumanChrench();
}

void draw() {
  background(0);
  player.display();
  player.move();
  player.look();
}