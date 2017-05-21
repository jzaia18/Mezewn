import java.util.Iterator;
ArrayList<Sagar> sagars = new ArrayList<Sagar>();
ArrayList<Mass> mass = new ArrayList<Mass>();

void setup() {
  fullScreen();
  sagars.add(new HumanSagar());
  for (int i=0; i<250; i++) mass.add(new Mass(this));
  for (int i=0; i<25; i++) sagars.add(new AISagar(this));
}


void draw() {
  background(0);
  for (Sagar s : sagars) s.update();
  for (Mass m : mass) m.display();
  spawnMass();
  ballConsumption();
  massConsumption();
  deadSagarRemoval();
}


void ballConsumption() {
  for (Sagar s1 : sagars) {
    for (Sagar s2 : sagars) {
      if (s1 != s2) {
        for (Ball b1 : s1._balls) {
          for (Ball b2 : s2._balls) {
            b1.consume(b2);
          }
        }
      }
    }
  }
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
}

void spawnMass() {
  if (mass.size() > 1000) return;
  if (random(100) < 10) mass.add(new Mass(this));
}