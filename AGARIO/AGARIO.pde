import ddf.minim.*;

//Creating class instances which are used to create the background music
Minim minim;
Minim pminim;
AudioPlayer player;
AudioPlayer pop;

//Array to hold the eatable balls
ArrayList<EatableBalls> eBalls = new ArrayList();
private int eatableCount = 30; //This is the maximum amount of eatable balls there can be at any one time

//Array to hold the bomb balls
ArrayList<BombBall> bBalls = new ArrayList(); 
private int bombCount = 10; //Used throughout the program to control how many balls are added depending on score

//Creating an instance of the Playerball class, this creates the player ball that follows the mouse coords
PlayerBall pBall = new PlayerBall();

//Ball diameters / radius
private float bBallDiameter = 30;
private float eBallDiameter = 20;
float bBallRad = 15;
float eBallRad = 10;

//Boolean that monitors the state of the game
private boolean start = false;
private boolean gameOver = false;


//Variable that is used to hold the score of the player, this variable is going to be used for control over many aspects such as total bombballs
//if score is less than 1, you can't die
private float score = 0;
private float highscore = 0;
private float scoreCounter = 0;
private float test = 0;

//Variable that will help with difficulty levels and prevent more than the wanted amount of bBalls to be added to the array mid-game
private int bBallCounter = 1;

//Creating new instances of the loading/gameover screens to access
private LoadingScreen load = new LoadingScreen();
private GameoverScreen over = new GameoverScreen();

void setup()
{
  size(1024,768);
  smooth();
  frameRate(120);

  
  //Setting up the music player so that it constantly loops over the soundfile until the game is closed (Space theme music): https://www.freesound.org/people/Tristan_Lohengrin/sounds/273149/
  minim = new Minim(this);
  player = minim.loadFile("music.wav");
  player.loop();
    
  
  //Writing the balls the the eatable array
  for (int x = 0; x < eatableCount; x++)
  {
      eBalls.add(new EatableBalls(random(eBallDiameter, width - eBallDiameter), random(eBallDiameter, height - eBallDiameter)));
  }
  
  //Writing the balls to the bomb array
  for (int i = 0; i < bombCount; i++)
  {
      bBalls.add(new BombBall(random(bBallDiameter, width - bBallDiameter), random(bBallDiameter, height - bBallDiameter))); 
  }
  
  //pBall = new PlayerBall(mouseX, mouseY); 


  
} //End of setup


void draw()
{
  println(frameRate);
  //This segment deals with the issue of whether to start the game, or whether to show the loading screen
  if (start) //If the start boolean is true, run the startGame method
  {
    startGame();
  }
  else if(gameOver)
  {
    endGame();
  }
  else
  {
    load.drawLoading(); //Starting/menu screen; if gameOver or startGame are not true, run the drawLoading method of the loadingScreen class
  }
  
  if (key == 'c' || key =='C' && gameOver == false)
  {
    pauseGame();
    load.displayInformation();
  }
  
}

void keyPressed()
{
  if (key == 's' || key == 'S')
  {
    start = true;
  }
  if(gameOver == false)
  {
    if (key == 'p' || key == 'P')
    {
      pauseGame();
    }
  }
  if (key == 'r' || key == 'R')
  {
    gameOver = false;
    restartGame();
  }

}


//Method that deals with all the drawing to the sketch when the player is still alive, called via the draw method
void startGame()
{
  //println(frameRate);
  background(0);
  stroke(255);
  fill(255);
  
  //Setting up the score text
  font = loadFont("ArialMT-48.vlw");
  textFont(font, 22);
  textAlign(RIGHT);
  text("Score: " + score, width - 10, height - 50);
  text("Highscore: " + highscore, width - 10, height - 70);
  text("Bomb Count: " + bBalls.size(), width - 10, 20);
  
  //Instead of using an enhanced for loop i had to use a regular for loop as without it accessing the array when the program is running causes a ConcurrentModificationException
  for (int counter = 0; counter < eBalls.size(); counter++)
  {
    EatableBalls ball = eBalls.get(counter);
    ball.move();
    ball.bouncing();
    ball.checkCollisions(eBalls);
    ball.playerCollision(pBall); //Passes the player ball to the playerCollision method of the Eatable balls class
    if (ball.removeCheck()) //Decides whether or not a collision is occuring, if return is true, code below is executed
    {
      pop = minim.loadFile("pop.wav"); //Source: https://www.freesound.org/people/yottasounds/sounds/176727/ (pop sound)
      pop.play();
      eBalls.remove(counter); //Removes the current colliding ball
      score += 10; //Increments the score by 10 (ie when a player eats a ball, score increases)
    }
    ball.updateBalls();
  }
  
  //loop that produces the bomb balls
  for (int counter = 0; counter < bBalls.size(); counter++)
  {
     BombBall ball = bBalls.get(counter);
     ball.move();
     ball.bouncing();
     //If the score is less than 1, you cannot collide with bomb balls. Prevents the issue of spawning inside other bomb balls and instantly dying
     if (score > 10)
     {
       ball.collide(pBall);
     }
     
     if (ball.checkEndgame())
     {
       start = false;
       gameOver = true;
     }
     ball.updateBalls();
  }
  
   pBall.updateBalls();
   //pBall.checkCollisions();
   
   //if statement that keeps the supply of green cells
   if (eBalls.size() < 25)
   {
     for (int i = 0; i < 5; i++)
     {
       eBalls.add(new EatableBalls(random(eBallDiameter, width - eBallDiameter), random(eBallDiameter, height - eBallDiameter))); //If the eBalls arraylist dips below 25, the for loop refills that array with 5 more balls
     }
   }
   
  //Calls the scoreCheck() method that checks whether new bombBalls need to be added
   scoreCheck();
   
}

//Method that deals with the sketch when the endGame boolean is true, ie when the player ball hits a bomb ball
void endGame()
{
  over.setupScreen();
  if (score > highscore)
  {
    highscore = score;
  }
  //Resetting all variables
  score = 0;
  bBallCounter = 1;
  test = 0;
  scoreCounter = 0;
}

//Method that deals with the sketch when the pause key is pressed (p)
void pauseGame()
{
  start = false;
  
}

//This method restarts the game whatever state it is at
//It can be used in the middle of the current game or after you have died
void restartGame()
{
  eBalls.clear(); //Clears the eBalls array, without this line 30 more eatable balls will be added to the arraylist as we are recalling the setup method.
  bBalls.clear(); //Clears the bBalls array, without this line 10 more bomb balls would be added to the arraylist as I recalled the setup method
  start = false;
  
  //If the score is bigger than the current highscore variable, the highscore is changed to be the new score; after which score is reset
  if (score > highscore)
  {
    highscore = score;
  }
  //Resetting all variables to ensure a new score is kept and scoreCounters are reset to the scoreCheck method functions correctly
  score = 0;
  bBallCounter = 1;
  test = 0;
  scoreCounter = 0;
  
  setup(); //Recalls the setup method, ie restarts the game after the arrays have been cleared
}

//method that executes some code depending on the score of the current game. It's used to decide when to add some new bBalls to the game (a method of increasing difficulty over time)
void scoreCheck()
{
  
   if (scoreCounter + 200 == score && test + 1 == bBallCounter)
   {
     bBalls.add(new BombBall(bBallDiameter, bBallDiameter));
     bBallCounter++;
     scoreCounter = score;
     test += 1;
   }

}