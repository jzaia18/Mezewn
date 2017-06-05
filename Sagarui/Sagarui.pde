import java.util.Iterator;
ArrayList<Sagar> sagars;
ArrayList<Mass> mass;
Sagar player;
int AINum;
boolean playerIsDead, playerIsSpectating;
final boolean debug = false; // Turn on for debug tools

// Sets up the game
void setup() {
  fullScreen();
  background(0);
  sagars = new ArrayList<Sagar>(); // All players in the game
  mass = new ArrayList<Mass>(); // All small edible masses
  player = new HumanSagar(sagars, mass); 
  sagars.add(player);
  for (int i=0; i<300; i++) mass.add(new Mass()); // Start the world with 300 small masses (True cap is 400)
  for (AINum=0; AINum<25; AINum++) sagars.add(new AISagar(sagars, mass, AINum)); // There are always 25 players (Except when waiting for respawn)
}


// Main function that loops while the game is in progress
void draw() {
  background(0);
  updateMasses();
  updateSagars();
  updateLeaderboard();
}


// For user controls
void keyPressed() { 
  if (! playerIsDead) {

    // Press space to split
    if (key == ' ') 
      player.willSplit = true;

    // Press W to eject a small portion of your mass
    if (Character.toLowerCase(key) == 'w') 
      for (Ball b : player._balls) {
        if (b._mass > 50) {
          float direction = atan2(mouseY - b.y, mouseX - b.x);
          mass.add(new Mass(b.x + 3 * b.rad * cos(direction), b.y + 3 * b.rad * sin(direction), (int) (b._mass * .02)));
          b._mass = b._mass - (int) (b._mass * .025);
        }
      }

    // debug tool, press ` to  spawn infinite Mass
    if (debug && Character.toLowerCase(key) == '`') 
      for (Ball b : player._balls) {
        float direction = atan2(mouseY - b.y, mouseX - b.x);
        mass.add(new Mass(b.x + 1.6 * b.rad * cos(direction), b.y + 1.6 * b.rad * sin(direction)));
      }
  }
}


// For respawn options
void mouseClicked() {
  if (playerIsDead) {

    // If the user pressed the respawn button
    if (mouseX > width/2-75 && mouseX < width/2+75) { 
      if (mouseY > height/2-80 && mouseY < height/2) {
        player = new HumanSagar(sagars, mass);
        sagars.add(player);
        playerIsDead = false;
      }
      if (mouseY > height/2+40 && mouseY < height/2+120) {
        playerIsDead = false;
        playerIsSpectating = true;
      }
    }
  } 

  // If the user is currently spectating
  else if (playerIsSpectating) { 
    if (mouseX > 85 && mouseX < 160 && mouseY > height-80 && mouseY < height-50) {
      player = new HumanSagar(sagars, mass);
      sagars.add(player);
      playerIsSpectating = false;
    }
  }
}


// Update the status of each of the Sagars
void updateSagars() {
  for (Sagar s : sagars) s.update(); // Have each Sagar update its own values

  // Eat edible things
  ballConsumption(); 
  massConsumption();

  // Take care of the dead
  deadSagarRemoval();
  respawn();
}


// Update the status of each of the Masses
void updateMasses() {
  for (Mass m : mass) m.display();
  spawnMass();
}


// Update the status of the leaderboard as well as player info
void updateLeaderboard() {
  leaderBoard();
  playerStats();
}


// Check if any Balls ate any other Balls
void ballConsumption() {
  Iterator it1 = sagars.iterator();
  Sagar sagar1, sagar2;
  Ball ballA, ballB;
  while (it1.hasNext()) { // Iterate through the ArrayList of all sagars
    Iterator it2 = sagars.iterator();
    sagar1 = (Sagar) it1.next();
    while (it2.hasNext()) {
      sagar2 = (Sagar) it2.next();
      if (sagar1 != sagar2) {
        Iterator ballsIt1 = sagar1._balls.iterator(); // Iterate through the Balls of each sagar
        while (ballsIt1.hasNext()) {
          ballA = (Ball) ballsIt1.next();
          Iterator ballsIt2 = sagar2._balls.iterator();
          while (ballsIt2.hasNext()) {
            ballB = (Ball) ballsIt2.next();
            if (ballA.consume(ballB))
              ballsIt2.remove();
          }
        }
      }
    }
  }
}


// Check if any Balls ate any Masses
void massConsumption() { 
  Iterator it = mass.iterator();
  while (it.hasNext()) {
    Mass m = (Mass) it.next();
    if (!m.exists) it.remove(); 
    for (Sagar s : sagars) {
      for (Ball b : s._balls) {
        b.consume(m);
      }
    }
  }
}


// Remove the dead Sagars from the world
void deadSagarRemoval() {
  Iterator it = sagars.iterator();
  while (it.hasNext()) {
    Sagar s = (Sagar) it.next();
    if (s._balls.size() == 0) { 
      if (s == player) playerIsDead = true;
      it.remove();
    }
  }
}


// Spawn new Masses as the world starts to run out
void spawnMass() {
  if (mass.size() > 400) return;
  if (random(10) < 1 || mass.size() < 100) mass.add(new Mass());
}


// Display the leaderboard
void leaderBoard() {
  ArrayList<Sagar> orderedSagars = MergeSort.sort(sagars);
  int min = 0;
  if (orderedSagars.size() > 5)
    min = orderedSagars.size() - 5;
  textSize(20);
  textAlign(TOP, LEFT);
  fill(255);
  text("Top 5 Leader Board", width - 250, 30);
  for (int i = orderedSagars.size()-1; i >= min; i--) {
    Sagar s = orderedSagars.get(i); 
    text(s._name + ": " + s._totalMass, width - 250, 30 + 20 * (orderedSagars.size() - i));
  }
}


// Check if the player wants to respawn, respawn AIs randomly
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

  if (sagars.size() < 25 && random(20) < 1) {
    sagars.add(new AISagar(sagars, mass, AINum));
    AINum++;
  }
}


// Display the player's mass in the bottom right  
void playerStats() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Player Stats", 125, height-115);
  textSize(12);
  if (player._balls.size()>0) text("Mass: " + player._totalMass, 125, height-95);
  else text("Mass: 0", 125, height-95);
}