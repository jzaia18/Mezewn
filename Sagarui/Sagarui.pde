import java.util.Iterator;
ArrayList<Sagar> sagars;
ArrayList<Mass> mass;
Sagar player;
int AINum;

void setup() {
  fullScreen();
  background(0);
  sagars = new ArrayList<Sagar>();
  mass = new ArrayList<Mass>();
  player = new HumanSagar(sagars, mass);
  sagars.add(player);
  for (int i=0; i<250; i++) mass.add(new Mass());
  for (AINum=0; AINum<25; AINum++) sagars.add(new AISagar(sagars, mass, AINum));
  textAlign(CENTER, CENTER);
}


void draw() {
  background(0);
  for (Sagar s : sagars) s.update();
  for (Mass m : mass) m.display();
  spawnMass();
  ballConsumption();
  massConsumption();
  deadSagarRemoval();
  leaderBoard();
}

// For user splitting
void keyPressed() { 
  if (key == ' ')
    player.willSplit = true;
  if (Character.toLowerCase(key) == 'w')
    for (Ball b : player._balls)
      mass.add(new Mass(b.x+b.rad+20, b.y+b.rad+20));
}
void keyReleased() { 
  if (key == ' ')
    player.willSplit = false;
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
    if (s._balls.size() == 0) it.remove();
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
  fill(255);
  text("Top 5 Leader Board", width - 250, 30);
  for (int i = orderedSagars.size()-1; i >= min; i--) {
    Sagar s = orderedSagars.get(i); 
    text(s._name + ": " + s._totalMass, width - 250, 30 + 20 * (orderedSagars.size() - i));
  }
}