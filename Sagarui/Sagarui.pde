import java.util.Iterator;
ArrayList<Sagar> sagars;
ArrayList<Mass> mass;
Sagar player;
int AINum;
boolean respawn1, respawn2;

void setup() {
  fullScreen();
  background(0);
  sagars = new ArrayList<Sagar>();
  mass = new ArrayList<Mass>();
  player = new HumanSagar(sagars, mass);
  sagars.add(player);
  for (int i=0; i<250; i++) mass.add(new Mass());
  for (AINum=0; AINum<25; AINum++) sagars.add(new AISagar(sagars, mass, AINum));
}


void draw() {
  background(0);
  for (Sagar s : sagars) s.update();
  for (Mass m : mass) m.display();
  spawnMass();
  ballConsumption();
  massConsumption();
  deadSagarRemoval();
  respawn();
  leaderBoard();
  playerStats();
}

// For user splitting
void keyPressed() { 
  if (player._balls.size() > 0) {
    if (key == ' ')
      player.willSplit = true;
    if (Character.toLowerCase(key) == 'w')
      for (Ball b : player._balls)
        mass.add(new Mass(b.x+b.rad+20, b.y+b.rad+20));
  }
}

void keyReleased() { 
  if (key == ' ')
    player.willSplit = false;
}

void mouseClicked() {
  if (player._balls.size() == 0) {
    if (respawn1) {
      if (mouseX > width/2-75 && mouseX < width/2+75) { 
        if (mouseY > height/2-80 && mouseY < height/2) {
          player = new HumanSagar(sagars, mass);
          sagars.add(player);
          respawn1 = false;
        }
        if (mouseY > height/2+40 && mouseY < height/2+120) {
          respawn1 = false;
          respawn2 = true;
        }
      }
    } else if (respawn2) {
      if (mouseX > 85 && mouseX < 160 && mouseY > height-80 && mouseY < height-50) {
        player = new HumanSagar(sagars, mass);
        sagars.add(player);
        respawn2 = false;
      }
    }
  }
}

void ballConsumption() {
  Iterator it = sagars.iterator();
  Sagar tmp;
  Sagar pmt;
  Ball next;
  Ball txen;
  while (it.hasNext()) {
    Iterator ti = sagars.iterator();
    tmp = (Sagar)it.next();
    while (ti.hasNext()) {
      pmt = (Sagar)ti.next();
      if (tmp != pmt) {
        Iterator ball = tmp._balls.iterator();
        while (ball.hasNext()) {
          next = (Ball)ball.next();
          Iterator llab = pmt._balls.iterator();
          while (llab.hasNext()) {
            txen = (Ball)llab.next();
            if (next.consume(txen))
              llab.remove();
          }
        }
      }
    }
  }
  //for (Sagar s1 : sagars)
  //  for (Sagar s2 : sagars)
  //    if (s1 != s2)
  //      for (Ball b1 : s1._balls)
  //        for (Ball b2 : s2._balls)
  //          b1.consume(b2);
}

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

void deadSagarRemoval() {
  Iterator it = sagars.iterator();
  while (it.hasNext()) {
    Sagar s = (Sagar) it.next();
    if (s._balls.size() == 0) { 
      if (s == player) respawn1 = true;
      it.remove();
    }
  }
  while (sagars.size() < 25) {
    sagars.add(new AISagar(sagars, mass, AINum));
    AINum++;
  }
}

void spawnMass() {
  if (mass.size() > 350) return;
  if (random(10) < 1 || mass.size() < 50) mass.add(new Mass());
}
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
  if (player._balls.size()>0) text("Mass: " + player._totalMass, 125, height-95);
  else text("Mass: 0", 125, height-95);
}