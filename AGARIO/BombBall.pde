class BombBall extends Ball
{
  PVector location;
  PVector velocity;
  
  boolean hit = false;
  float radius = bBallRad;
  float pRadius = 15;
  
  float bombSpeed = 6;
  
  //boolean to indicate whether the game is over (if there is a playerball/bombball impact)
  boolean endGame = false;

  public BombBall(float x, float y)
  {
    location = new PVector(x, y);
    velocity = new PVector(random(-bombSpeed,bombSpeed), random(-bombSpeed, bombSpeed)); //Gives each ball a random speed, this means each game could be different each time the user plays, rather than a consistent game state
    
  }

  //Adds the velocity to the balls/PVector location
  void move()
  {
    location.add(velocity);
  }

  //Constraint method that keeps the balls within the screen size
  void bouncing()
  {
    if ((location.x > width - radius) || (location.x < radius))
     {
          velocity.x = -velocity.x;
     }
    if ((location.y > height - radius) || (location.y < radius))
     {
          velocity.y = -velocity.y;
     } 
  }
  
  //Method that updates the balls and checks whether a hit occurs
  void updateBalls()
  {
    fill(245, 12, 12);
    
    if (hit)
    {
      fill(100,100,100);
    }
    ellipse(location.x, location.y, 30, 30); 
  }
  
  //Checks whether the player ball has impacted the bomb ball, resulting in game over
  boolean checkEndgame()
  {
    if (endGame == true)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  //Takes the a player ball instance as a parameter, that way it can access coordinates and test whether or not a collision is occuring
  void collide(PlayerBall pBall)
  {
    //Sets the variable hit to the result of the method pCollision. I am inputting the coordinates of the bomb balls and the pBall and also the radius of both. 
    //This allows me to check collision (if the distance between then is less than the sum of the radius)
    hit = bombCollision(location.x, location.y, radius, pBall.x, pBall.y, pRadius); //If the outcome of the below method is true; a hit is occuring.
  }
  
  //This is the method that figures out whether a ball is actually colliding with the player ball
  boolean bombCollision(float bX, float bY, float bRadius, float pX, float pY,  float pRadius)
  {
    float distance = dist(bX, bY, pX, pY); //Distance between the two balls x and y coords
    
    //If the distance between balls is less than the sum of radius, hit occuring
    if (distance <= (bRadius + pRadius))
    {
      println("Game over!");
      endGame = true;
      return true;
    }
    else
    {
      return false;
    }
  }
}