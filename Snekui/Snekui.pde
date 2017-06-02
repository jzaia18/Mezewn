import java.util.Iterator;
ArrayList<Snek> sneks;
ArrayList<Mass> mass;
Snek player;

void setup() {
  fullScreen();
  background(0);
  sneks = new ArrayList<Snek>();
  mass =  new ArrayList<Mass>();
  player = new HumanSnek(sneks, mass);
  sneks.add(player);
  for (int i=0; i<250; i++) mass.add(new Mass());
  for (int i=0; i<10; i++) sneks.add(new AISnek(sneks, mass, i));
}

void draw() {
  background(0);
  for (Snek s : sneks) s.update();
  for (Mass m : mass) m.display();
  deadSnekRemoval();
  deadSneks();
  massConsumption();
  spawnMass();
}

void mousePressed() {
  if (player._body.size() > 5) {
    player.speed = 7;
    player.degrade = true;
  }
}

void mouseReleased() {
  player.speed = 4;
  player.degrade = false;
}

void spawnMass() {
  if (mass.size() > 500) return;
  if (random(100) < 5) mass.add(new Mass());
}

void massConsumption() { 
  Iterator it = mass.iterator();
  while (it.hasNext()) {
    Mass m = (Mass) it.next();
    if (!m.exists) it.remove(); 
    for (Snek s : sneks) 
      s.consume(m);
  }
}

void deadSneks() {
  Iterator it = sneks.iterator();
  ArrayList heads = new ArrayList <Segment>(), segments = new ArrayList<Segment>();
  Snek snek;
  Segment seg, head, deah;
  while (it.hasNext()) {
    snek = (Snek) it.next();
    Iterator snekIt = snek._body.iterator();
    while (snekIt.hasNext()) {
      seg = (Segment) snekIt.next();
      if (seg == seg._parent._body.peek()) heads.add(seg);
      else segments.add(seg);
    }
  }
  Iterator headIt = heads.iterator();
  while (headIt.hasNext()) {
    head = (Segment) headIt.next();
    Iterator headTi = heads.iterator();
    while (headTi.hasNext()) {
      deah = (Segment) headTi.next();
      if (head != deah && head.inContactWith(deah)) {
        head._parent.smallerSnek(deah._parent).exists = false;
        return;
      }
    }
    Iterator segIt = segments.iterator();
    while (segIt.hasNext()) {
      seg = (Segment) segIt.next();
      if (head._parent != seg._parent && head.inContactWith(seg)) {
        head._parent.exists = false;
        return;
      }
    }
  }
}

void deadSnekRemoval() {
  Iterator it = sneks.iterator();
  while (it.hasNext())  
    if (((Snek) it.next()).exists == false) 
      it.remove();
}