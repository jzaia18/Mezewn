boolean mainMenu, inGame;
UI game;
PImage sagar, snek, chrench;

void setup() {
  fullScreen();
  background(0);
  mainMenu = true;
  inGame = false;
  game = null;
  sagar = loadImage("sagarui.png");
  snek = loadImage("snekui.png");
}

void draw() {
  if (mainMenu && !inGame) {
    imageMode(CENTER);
    image(sagar, 300, height/2);
    image(snek, width-300, height/2);
    image(sagar, width/2, height/2 + 325);
    fill(128);
    rect(width/2-50, height/2-100, 100, 50);
    rect(width/2-50, height/2-40, 100, 50);
    rect(width/2-50, height/2+20, 100, 50);
    rect(width/2-50, height/2+80, 100, 50);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(15);
    text("Sagarui", width/2, height/2-75);
    text("Snekui", width/2, height/2-15);
    text("Chrenchui", width/2, height/2+45);
    text("Warui", width/2, height/2+105);
    textSize(30);
    text("Star.ui", width/2, 200);
    text("Sagarui", 300, height/2+160);
    text("Snekui", width-300, height/2+160);
    text("Chrenchui", width/2, height/2+475);
  } else if (!mainMenu && inGame && game != null) {
    game.draw();
  }
}

void mouseClicked() {
  if (mainMenu && !inGame) {
    //todo make a real main menu 
    if (mouseX > width/2-50 && mouseX < width/2+50) {
      if (mouseY > height/2-100 && mouseY < height/2-50) {        
        game = new Sagarui();
        inGame = true;
        mainMenu = false;
      } else if (mouseY > height/2-40 && mouseY < height/2+10) {        
        game = new Snekui();
        inGame = true;
        mainMenu = false;
      } else if (mouseY > height/2+20 && mouseY < height/2+70) {        
        //game = new Chrenchui();
        //inGame = true;
        //mainMenu = false;
      } else if (mouseY > height/2+80 && mouseY < height/2+130) {
        //int rand = (int) random(3);
        //if (rand == 0) game = new WaruiSagarui();
        //if (rand == 1) game = new WaruiSnekui();
        //if (rand == 2) game = new WaruiChrenchui();
        //inGame = true;
        //mainMenu = false;
      }
    }
  } else if (!mainMenu && inGame) {
    game.mouseClicked();
  }
}

void mousePressed() {
  if (!mainMenu && inGame && game != null) 
    game.mousePressed();
}

void mouseReleased() {
  if (!mainMenu && inGame && game != null) 
    game.mouseReleased();
}


void keyPressed() {
  if (!mainMenu && inGame && game != null) 
    game.keyPressed();
}