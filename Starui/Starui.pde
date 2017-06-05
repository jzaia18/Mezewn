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
    background(0);
    imageMode(CENTER);
    image(sagar, 300, height/2);
    image(snek, width-375, height/2);
    image(sagar, width/2, height/2 + 275);
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
    textSize(100);
    text("Star.ui", width/2, 200);
    textSize(30);
    text("Sagarui", 300, height/2+160);
    text("Snekui", width-300, height/2+160);
    text("Chrenchui", width/2, height/2+400);
  } else if (!mainMenu && inGame && game != null) {
    game.draw();
    fill(128);
    rect(width-160, height-80, 80, 30);
    textSize(14);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Main Menu", width-120, height-65);
  }
}

void mouseClicked() {
  if (mainMenu && !inGame) {
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
    if (mouseX > width-160 && mouseX < width-80 && mouseY > height-80 && mouseY < height-50) {
     game = null;
     inGame = false;
     mainMenu = true;
    }
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