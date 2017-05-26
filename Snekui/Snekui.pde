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
  for (int i=0; i<25; i++) sneks.add(new AISnek(sneks, mass));
}

void draw() {
  background(0);
  for (Snek s : sneks) s.update();
  for (Mass m : mass) m.display();
  massConsumption();
  spawnMass();
}

void mousePressed() {
  if (player._body.size() > 5) {
    player.speed = .01;
    player.degrade = true;
  }
}

void mouseReleased() {
  player.speed = .005;
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
    for (Snek s : sneks) {
      s.consume(m);
    }
  }
}