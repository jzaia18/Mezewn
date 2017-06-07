import java.util.Iterator;
class Chrenchui extends UI {

  ArrayList<Chrench> chrenchs;
  ArrayList<Shape> shapes;
  HumanChrench player;
  int AINum;
  boolean respawn1, respawn2, warui;

  Chrenchui() {
    setup();
  }

  Chrenchui(boolean war) {
    if (war) {
      background(0);
      chrenchs = new ArrayList<Chrench>();
      shapes = new ArrayList<Shape>();
      player = new HumanChrench(chrenchs, shapes);
      chrenchs.add(player);
      for (int i=0; i<75; i++) shapes.add(randShape());
      for (AINum=0; AINum<10; AINum++) chrenchs.add(new BadAIChrench(chrenchs, shapes, AINum));
      warui = war;
    } else setup();
  }

  // Sets up the world
  void setup() {
    background(0);
    chrenchs = new ArrayList<Chrench>();
    shapes = new ArrayList<Shape>();
    player = new HumanChrench(chrenchs, shapes);
    chrenchs.add(player);
    for (int i=0; i<75; i++) shapes.add(randShape());
    for (AINum=0; AINum<10; AINum++) chrenchs.add(new AIChrench(chrenchs, shapes, AINum));
  }


  // The main function that loops while game is in play
  void draw() {
    background(0);
    for (Chrench c : chrenchs) c.update();
    for (Shape s : shapes) s.display();
    playerStats();
    leaderBoard();
    respawn();
    shapeRemoval();
    chrenchRemoval();
  }


  // Used so that the user can move their Chrench
  void keyPressed() {
    if (player._health > 0) {
      if (Character.toLowerCase(key) == 'w') player.wP = true;
      if (Character.toLowerCase(key) == 'a') player.aP = true;
      if (Character.toLowerCase(key) == 's') player.sP = true;
      if (Character.toLowerCase(key) == 'd') player.dP = true;
      if (key == '1') player.oneP = true;
      if (key == '2') player.twoP = true;
      if (key == '3') player.threeP = true;
      if (key == '4') player.fourP = true;
      if (key == '5') player.fiveP = true;
      if (key == '6') player.sixP = true;
    }
  }

  // Alerts the Chrench to stop moving
  void keyReleased() {
    if (player._health > 0) {
      if (Character.toLowerCase(key) == 'w') player.wP = false;
      if (Character.toLowerCase(key) == 'a') player.aP = false;
      if (Character.toLowerCase(key) == 's') player.sP = false;
      if (Character.toLowerCase(key) == 'd') player.dP = false;
      if (key == '1') player.oneP = false;
      if (key == '2') player.twoP = false;
      if (key == '3') player.threeP = false;
      if (key == '4') player.fourP = false;
      if (key == '5') player.fiveP = false;
      if (key == '6') player.sixP = false;
    }
  }


  // Used to alert the Chrench to start firing
  void mousePressed() {
    if (player._health > 0) {
      player.shooting = true;
    }
    // Otherwise check which button the player has pressed if they have pressed one
    else {
      if (respawn1) {
        if (mouseX > width/2-75 && mouseX < width/2+75) { 
          if (mouseY > height/2-80 && mouseY < height/2) {
            player = new HumanChrench(chrenchs, shapes);
            chrenchs.add(player);
            respawn1 = false;
          }
          if (mouseY > height/2+40 && mouseY < height/2+120) {
            respawn1 = false;
            respawn2 = true;
          }
        }
      } else if (respawn2) {
        if (mouseX > 85 && mouseX < 160 && mouseY > height-80 && mouseY < height-50) {
          player = new HumanChrench(chrenchs, shapes);
          chrenchs.add(player);
          respawn2 = false;
        }
      }
    }
  }


  // Used to alert the Chrench to stop firing
  void mouseReleased() {
    if (player._health > 0)
      player.shooting = false;
  }

  void mouseClicked() {
  }


  // Generate a small random shape
  Shape randShape() {
    int rand = (int) random(100);
    if (rand < 80) return new Square();
    else if (rand < 90) return new Triangle();
    else if (rand < 95) return new Pentagon();
    else if (rand < 97) return new Square(true);  
    else if (rand < 98) return new Triangle(true);
    else return new Pentagon(true);
  }


  // Displays the leaderboard
  void leaderBoard() {
    ArrayList<Chrench> orderedChrenchs = MergeSortChrench.sort(chrenchs);
    int min = 0;
    if (orderedChrenchs.size() > 5)
      min = orderedChrenchs.size() - 5;
    textSize(20);
    textAlign(TOP, LEFT);
    fill(255);
    text("Top 5 Leader Board", width - 275, 30);
    for (int i = orderedChrenchs.size()-1; i >= min; i--) {
      Chrench s = orderedChrenchs.get(i); 
      text(s._name + ": " + s._score, width - 275, 30 + 20 * (orderedChrenchs.size() - i));
    }
  }


  // Repspawns the user
  void respawn() {
    //respawns player
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
    //respawns shapes
    if (shapes.size() < 75) {
      shapes.add(randShape());
    }
    //respawns AIs
    if (chrenchs.size() < 10) {
      if (warui) chrenchs.add(new BadAIChrench(chrenchs, shapes, AINum));
      else chrenchs.add(new AIChrench(chrenchs, shapes, AINum));
      AINum++;
    }
  }


  // Displays player stats in the bottom right corner
  void playerStats() {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("Player Stats", 125, height-115);
    textSize(12);
    if (player._health > 0) {
      text("Score: " + player._score, 125, height-95);
      text("Points: " + (player._points - player._pointsUsed), 125, height-85);
      text("HP: " + player._health, 125, height-75);
      text("(1) Health Regen: Level " + player._healthLevel + "/" + player._maxLevel, 125, height-65);
      text("(2) Body Damage: Level " + player._bodyDLevel + "/" + player._maxLevel, 125, height-55);
      text("(3) Bullet Speed: Level " + player._bulletSLevel + "/" + player._maxLevel, 125, height-45);
      text("(4) Bullet Damage: Level " + player._bulletDLevel + "/" + player._maxLevel, 125, height-35);
      text("(5) Bullet Reload: Level " + player._bulletRLevel + "/" + player._maxLevel, 125, height-25);
      text("(6) Movement Speed: Level " + player._speedLevel + "/" + player._maxLevel, 125, height-15);
    } else text("Score: 0", 125, height-95);
  }

  void shapeRemoval() {
    Iterator it = shapes.iterator();
    while (it.hasNext()) {
      if (((Shape) it.next())._health <= 0) it.remove();
    }
  }

  void chrenchRemoval() {
    Iterator it = chrenchs.iterator();
    while (it.hasNext()) {
      Chrench c = (Chrench) it.next();
      if (c._health <= 0) {
        if (c == player) respawn1 = true;
        it.remove();
      }
    }
  }
}