import java.util.PriorityQueue;

abstract class Sagar {

  PriorityQueue<Ball> balls;
  Sagarui game;

  void move() {
    for (Ball b : balls) b.move();
  }

  void display() {
    for (Ball b : balls) b.display();
  }
  
  void update() {
    move();
    display();
  }
}