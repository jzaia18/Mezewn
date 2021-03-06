import java.util.Iterator;
class Snekui extends UI {
  ArrayList<Snek> sneks;
  ArrayList<Mass> masses;
  Snek player;
  int AINum;
  boolean playerIsDead, playerIsSpectating, warui;

  Snekui() {
    setup();
  }

  Snekui(boolean war) {
    if (war) {
      background(0);
      sneks = new ArrayList<Snek>();
      masses =  new ArrayList<Mass>();
      player = new HumanSnek(sneks, masses);
      sneks.add(player);
      for (int i=0; i<250; i++) masses.add(new Mass());
      for (AINum=0; AINum<10; AINum++) sneks.add(new BadAISnek(sneks, masses, AINum));
      warui = war;
    } else setup();
  }

  // Sets up the world
  void setup() {
    background(0);
    sneks = new ArrayList<Snek>();
    masses =  new ArrayList<Mass>();
    player = new HumanSnek(sneks, masses);
    sneks.add(player);
    for (int i=0; i<250; i++) masses.add(new Mass());
    for (AINum=0; AINum<10; AINum++) sneks.add(new AISnek(sneks, masses, AINum));
  }


  // Main fucntion that is looped
  void draw() {
    background(0);
    updateSneks();
    updateMasses();
    updateLeaderboard();
  }


  // Consumes length for a speed boost when the mouse is clicked
  void mousePressed() {
    // Only attempt if the player is not dead
    if (player.exists) {
      if (player._body.size() > 6) {
        player.speed = 7;
        player.degrade = true;
      } else {
        player.speed = 4;
        player.degrade = false;
      }
    } 

    // Otherwise check which button the player has pressed if they have pressed one
    else {
      if (playerIsDead) {
        if (mouseX > width/2-75 && mouseX < width/2+75) { 
          if (mouseY > height/2-80 && mouseY < height/2) {
            player = new HumanSnek(sneks, masses);
            sneks.add(player);
            playerIsDead = false;
          }
          if (mouseY > height/2+40 && mouseY < height/2+120) {
            playerIsDead = false;
            playerIsSpectating = true;
          }
        }
      } else if (playerIsSpectating) {
        if (mouseX > 85 && mouseX < 160 && mouseY > height-80 && mouseY < height-50) {
          player = new HumanSnek(sneks, masses);
          sneks.add(player);
          playerIsSpectating = false;
        }
      }
    }
  }


  void keyReleased() {
  }

  // Slow the player back down when they let go of the mouse
  void mouseReleased() {
    player.speed = 4;
    player.degrade = false;
  }


  // Updates Sneks, and takes care of respawn options
  void updateSneks() {
    deadSnekRemoval();
    deadSneks();
    for (Snek s : sneks) s.update();
    spawnSneks();
    respawn();
  }


  // Updates Masses
  void updateMasses() {
    for (Mass m : masses) m.display();
    massConsumption();
    spawnMasses();
  }


  // Updates leaderboard & player stats
  void updateLeaderboard() {
    playerStats();
    leaderBoard();
  }


  // Spawns new Masses
  void spawnMasses() {
    if (masses.size() > 500) return;
    if (random(100) < 7 || masses.size() < 100) masses.add(new Mass());
  }


  // Respawns dead AISneks
  void spawnSneks() {
    if (sneks.size() < 10 && random(100) < 2.5) {
      AINum++;
      if (warui) sneks.add(new BadAISnek(sneks, masses, AINum));
      else sneks.add(new AISnek(sneks, masses, AINum));
    }
  }


  // Consumes Masses
  void massConsumption() { 
    Iterator it = masses.iterator();
    while (it.hasNext()) {
      Mass m = (Mass) it.next();
      if (!m.exists) it.remove(); 
      for (Snek s : sneks) 
        s.consume(m);
    }
  }


  // Marks Sneks that have crashed for death
  void deadSneks() {
    ArrayList heads = new ArrayList<Segment>(), segments = new ArrayList<Segment>();
    Iterator allSneksIt = sneks.iterator();
    while (allSneksIt.hasNext()) { // Iterates through all Sneks in the game
      Snek currSnek = (Snek) allSneksIt.next(); 
      Iterator currSnekIt = currSnek._body.iterator();
      while (currSnekIt.hasNext()) { // Iterates through a given Snek to get its body segments
        Segment currSeg = (Segment) currSnekIt.next();
        if (currSeg == currSeg._parent._body.peek()) heads.add(currSeg); // Add the head to the head ArrayList
        else segments.add(currSeg); // Add the other body segments to the segments ArrayList
      }
    }
    Iterator allHeadsIt = heads.iterator();
    while (allHeadsIt.hasNext()) { // Iterates through the ArrayList of all heads
      Segment currHead = (Segment) allHeadsIt.next();
      currHead._parent.inDanger = false; // Assume not in danger of death
      Iterator segIt = segments.iterator();
      while (segIt.hasNext()) { // Iterates through all segments to make sure they are not in contact with the current head
        Segment currSeg = (Segment) segIt.next();
        if (currHead._parent != currSeg._parent) {
          float distFromSeg =  dist(currHead.x, currHead.y, currSeg.x, currSeg.y);
          if (distFromSeg < 50) 
            currHead._parent.inDanger = true; // If near death, alert the Snek
          if (distFromSeg < 30) {
            currHead._parent.exists = false; // If the Snek has collided with another, alert it that it has died  
            break;
          }
        }
      }
    }
  }


  // Removes the dead Sneks from the game
  void deadSnekRemoval() {
    Iterator snekIt = sneks.iterator();
    while (snekIt.hasNext()) {  // Iterates through all Sneks and removes the ones that should be dead
      Snek currSnek = ((Snek) snekIt.next());
      if (!currSnek.exists) {
        Iterator bodyIt = currSnek._body.iterator();
        while (bodyIt.hasNext()) {
          Segment currSeg = (Segment) bodyIt.next(); 
          if (random(4) < 1)
            masses.add(new Mass(currSeg.x, currSeg.y));
        }
        if (currSnek == player)
          playerIsDead = true;
        snekIt.remove();
      }
    }
  }


  void keyPressed() {
  }


  void mouseClicked() {
  }


  // Displays the leaderboard
  void leaderBoard() {
    ArrayList<Snek> orderedSneks = MergeSortSnek.sort(sneks);
    int min = 0;
    if (orderedSneks.size() > 5)
      min = orderedSneks.size() - 5;
    textSize(20);
    textAlign(TOP, RIGHT);
    fill(255);
    text("Top 5 Leader Board", width - 275, 30);
    for (int i = orderedSneks.size()-1; i >= min; i--) {
      Snek s = orderedSneks.get(i); 
      text(s._name + ": " + s._body.size(), width - 275, 30 + 20 * (orderedSneks.size() - i));
    }
  }


  // Handles the respawn menu for the user
  void respawn() {
    if (playerIsDead) {
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
    } else if (playerIsSpectating) {
      fill(177);
      rect(85, height-80, 75, 30);
      textSize(14);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Respawn", 125, height-65);
    }
  }


  // Displays player stats
  void playerStats() {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("Player Stats", 125, height-115);
    textSize(12);
    if (player.exists) text("Length: " + player._body.size(), 125, height-95);
    else text("Length: 0", 125, height-95);
  }
}