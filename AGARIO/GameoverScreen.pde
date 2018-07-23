class GameoverScreen 
{
  //Deals with the slow fade of the background when the game is first started
  int tint = 50;
  int take = 5;
  public GameoverScreen()
  {
    //empty as nothing needs to be excecuted when an instance is created, however is good practice to write the constructor
  }
  
  //Method that displays all of the text on the screen when gameover is reached
  public void setupScreen()
  {
    smooth();
    
    //Deals with the creation of the text/logo in the top left
    fill(255);
    font = loadFont("ArialMT-48.vlw");
    textFont(font, 30);
    textAlign(LEFT);
    text("AGARIO", 10, 50);
    textFont(font, 10);
    text("Remake by Connor Bridle", 13, 60);
    
    //Game over text
    textFont(font, 48);
    textAlign(CENTER);
    text("GAME OVER!", width/2, height/2);
    textFont(font, 20);
    text("Press R to restart game", width/2, (height/2) + 20);
  }
}