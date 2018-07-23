
//This class deals with all the code that relates to the drawing on the loading screen
PImage img; //Used for the background of the start menu (src: https://pixabay.com/en/planet-moon-orbit-solar-system-581239/)
PFont font; //Used for the font which is created below

class LoadingScreen
{
   //Setting the typography of the font I am going to be using

   PImage img; //Used for the background of the start menu (src: https://pixabay.com/en/planet-moon-orbit-solar-system-581239/)
   PFont font; //Used for the font which is created below
  
   //Deals with the slow fade of the background when the game is first started
   int tint = 50;
   int take = 5;
  
   float rectX, rectY; //Stores the position of the start button
   float w, h; //Stores the width and height of the start button
  
   boolean startClick = false;
   public LoadingScreen()
   {
     //nothing need to be done when an instance is created, however it is good practice to write your own constructor
   }
   
   //Method that displays all of the text on the screen when the game is started/restarted
   public void setupScreen()
   { 
     smooth();
     background(0);
     //https://pixabay.com/en/planet-moon-orbit-solar-system-581239/
     img = loadImage("space.jpg");
     img.resize(width, height + 15);
     //tint(tint - take);
     //tint = tint + take;
     image(img, 0, 0);
     
     //Setting up the font
     fill(255);
     font = loadFont("ArialMT-48.vlw");
     textFont(font, 30);
     textAlign(LEFT);
     text("AGARIO", 10, 50);
     textFont(font, 10);
     text("Remake by Connor Bridle", 13, 60);
     textFont(font, 15);
     text("Press C for controls/keybindings", 13, height - 20);
     
     //Setting up the start text area
     rectX = width/2;
     rectY = 100;
     w = 300;
     h = 100;
     rectMode(CENTER);
     noFill();
     rect(rectX, rectY, w, h);
     textAlign(CENTER);
     textFont(font, 30);
     text("PRESS S TO START", width/2, 110);
     fill(255);
     
     
   }
   
   //Method that displays the control/key information when the correct key is pressed
   public void displayInformation()
   {
     fill(255);
     textAlign(CENTER);
     textFont(font, 40);
     text("CONTROLS:", width/2, height/2 - 30);
     textFont(font, 20);
     text("Key 'P': Pause", width/2, height/2);
     text("Key 'C': Control information", width/2, height/2 + 30);
     text("Key 'R': Restart", width/2, height/2 + 60);
     text("Key 'S': Start", width/2, height/2 + 90);
   }
   
   //Method that calls both of the above methods (saves room in main class)
   public void drawLoading()
   {
     setupScreen();
     displayInformation();
   }
}