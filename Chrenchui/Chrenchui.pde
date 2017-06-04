import java.util.Iterator;
ArrayList<Chrench> chrenchs;
ArrayList<Shape> shapes;
Chrench player;
int AINum;
boolean respawn1, respawn2;

void setup() {
  fullScreen();
  background(0);
  chrenchs = new ArrayList<Chrench>();
  shapes = new ArrayList<Shape>();
  player = new HumanChrench(chrenchs, shapes);
  chrenchs.add(player);
  for (int i=0; i<120; i++) shapes.add(randShape());
  for (AINum=0; AINum<10; AINum++) chrenchs.add(new AIChrench(chrenchs, shapes, AINum));
}

void draw() {
  background(0);
  for (Chrench c : chrenchs) c.update();
  for (Shape s : shapes) s.display();
  playerStats();
  leaderBoard();
  respawn();
}


void keyPressed() {
  if (player.exists) {
    if (Character.toLowerCase(key) == 'w') player.wP = true;
    if (Character.toLowerCase(key) == 'a') player.aP = true;
    if (Character.toLowerCase(key) == 's') player.sP = true;
    if (Character.toLowerCase(key) == 'd') player.dP = true;
  }
}
void keyReleased() {
  if (player.exists) {
    if (Character.toLowerCase(key) == 'w') player.wP = false;
    if (Character.toLowerCase(key) == 'a') player.aP = false;
    if (Character.toLowerCase(key) == 's') player.sP = false;
    if (Character.toLowerCase(key) == 'd') player.dP = false;
  }
}

void mousePressed() {
  if (player.exists) 
    player.shooting = true;
}

Shape randShape() {
  //int rand = (int) random(3);
  //if (rand == 0) return new Pentagon();
  //if (rand == 1) return new Triangle();
  return new Square();
}

void leaderBoard() {
  ArrayList<Chrench> orderedChrenchs = MergeSort.sort(chrenchs);
  int min = 0;
  if (orderedChrenchs.size() > 5)
    min = orderedChrenchs.size() - 5;
  textSize(20);
  textAlign(TOP, LEFT);
  fill(255);
  text("Top 5 Leader Board", width - 250, 30);
  for (int i = orderedChrenchs.size()-1; i >= min; i--) {
    Chrench s = orderedChrenchs.get(i); 
    text(s._name + ": " + s._score, width - 250, 30 + 20 * (orderedChrenchs.size() - i));
  }
}

void respawn() {
  if (respawn1) {
    fill(255);
    textSize(25);
    textAlign(CENTER, CENTER);
    text("You died. Click to respawn or spectate.", width/2, height/2-130);
    fill(177);
    rect(width/2-75, height/2-80, 150, 80);
    fill(255);
    textSize(20);
    text("Respawn", width/2, height/2-40);
    fill(177);
    rect(width/2-75, height/2+40, 150, 80);
    fill(255);
    text("Spectate", width/2, height/2+80);
  } else if (respawn2) {
    fill(177);
    rect(85, height-80, 75, 30);
    textSize(14);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Respawn", 125, height-65);
  }
}

void playerStats() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Player Stats", 125, height-115);
  textSize(12);
  if (player.exists) text("Score: " + player._score, 125, height-95);
  else text("Mass: 0", 125, height-95);
}