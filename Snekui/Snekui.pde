import java.util.Iterator;
ArrayList<Snek> sneks;
ArrayList<Mass> masses;
Snek player;
int AINum;

void setup() {
  fullScreen();
  background(0);
  sneks = new ArrayList<Snek>();
  masses =  new ArrayList<Mass>();
  player = new HumanSnek(sneks, masses);
  sneks.add(player);
  for (int i=0; i<250; i++) masses.add(new Mass());
  for (AINum=0; AINum<10; AINum++) sneks.add(new AISnek(sneks, masses, AINum));
}

void draw() {
  background(0);
  for (Snek s : sneks) s.update();
  for (Mass m : masses) m.display();
  deadSnekRemoval();
  deadSneks();
  massConsumption();
  spawnMasses();
  spawnSneks();
}

void mousePressed() {
  if (player._body.size() > 6) {
    player.speed = 7;
    player.degrade = true;
  } else {
    player.speed = 4;
    player.degrade = false;
  }
}

void mouseReleased() {
  player.speed = 4;
  player.degrade = false;
}

void spawnMasses() {
  if (masses.size() > 500) return;
  if (random(100) < 7 || masses.size() < 100) masses.add(new Mass());
}

void spawnSneks() {
  if (sneks.size() < 10 && random(100) < 2.5){
    AINum++;
    sneks.add(new AISnek(sneks, masses, AINum));
  }
}

void massConsumption() { 
  Iterator it = masses.iterator();
  while (it.hasNext()) {
    Mass m = (Mass) it.next();
    if (!m.exists) it.remove(); 
    for (Snek s : sneks) 
      s.consume(m);
  }
}

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
      snekIt.remove();
    }
  }
}