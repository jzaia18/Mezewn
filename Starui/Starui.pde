UI game;
PImage sagar, snek, chrench;
ArrayList<Mass> mass;
ArrayList<Shape> shapes;

void setup() {
  fullScreen();
  background(0);
  game = null;
  //for main menu
  //only load images once
  sagar = loadImage("sagarui.png");
  snek = loadImage("snekui.png");
  chrench = loadImage("chrenchui.png");
  mass = new ArrayList<Mass>();
  for (int i = 0; i < 250; i++) mass.add(new Mass());
  shapes = new ArrayList<Shape>();
  for (int i = 0; i < 75; i++) shapes.add(randShape());
}

void draw() {
  if (game == null) {
    //draws a main menu with buttons for each game
    background(0);
    //random mass and balls for less emptiness
    for (Mass m : mass) m.display();
    for (Shape s : shapes) s.displayClean();
    imageMode(CENTER);
    image(sagar, 300, height/2);
    image(snek, width-375, height/2);
    image(chrench, width/2, height/2 + 275);
    fill(128);
    rect(width/2-50, height/2-100, 100, 50);
    rect(width/2-50, height/2-40, 100, 50);
    rect(width/2-50, height/2+20, 100, 50);
    rect(width/2-50, height/2+80, 100, 50);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(15);  
    text("Sagar.ui", width/2, height/2-75);
    text("Snek.ui", width/2, height/2-15);
    text("Chrench.ui", width/2, height/2+45);
    text("War.ui", width/2, height/2+105);
    textSize(100);
    text("Star.ui", width/2, 200);
    textSize(30);
    text("Sagar.ui", 300, height/2+160);
    text("Snek.ui", width-300, height/2+160);
    text("Chrench.ui", width/2, height/2+400);
  } else {
    //draw the current game
    game.draw();
    //return to main menu button
    fill(128);
    rect(width-160, height-80, 80, 30);
    textSize(14);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Main Menu", width-120, height-65);
  }
}

void mouseClicked() {
  if (game == null) {
    if (mouseX > width/2-50 && mouseX < width/2+50) {
      //check for mouse clicks on game buttons to start a game
      if (mouseY > height/2-100 && mouseY < height/2-50) game = new Sagarui();
      else if (mouseY > height/2-40 && mouseY < height/2+10) game = new Snekui();
      else if (mouseY > height/2+20 && mouseY < height/2+70) game = new Chrenchui();
      else if (mouseY > height/2+80 && mouseY < height/2+130) {
        int rand = (int) random(3);
        if (rand == 0) game = new Sagarui(true);
        if (rand == 1) game = new Snekui(true);
        if (rand == 2) game = new Chrenchui(true);
      }
    }
  } else {
    //for the games that also have a mouseClicked();
    game.mouseClicked(); 
    //to check if the main menu button has been clicked
    if (mouseX > width-160 && mouseX < width-80 && mouseY > height-80 && mouseY < height-50) game = null;
  }
}


//"inherit" these methods from the current game.
void mousePressed() { 
  if (game != null) game.mousePressed();
}

void mouseReleased() { 
  if (game != null) game.mouseReleased();
}

void keyPressed() { 
  if (game != null) game.keyPressed();
}

void keyReleased() { 
  if (game != null) game.keyReleased();
}


// Generate a small random shape for a nice background
Shape randShape() {
  int rand = (int) random(100);
  if (rand < 80) return new Square();
  else if (rand < 90) return new Triangle();
  else if (rand < 95) return new Pentagon();
  else if (rand < 97) return new Square(true);  
  else if (rand < 98) return new Triangle(true);
  else return new Pentagon(true);
}