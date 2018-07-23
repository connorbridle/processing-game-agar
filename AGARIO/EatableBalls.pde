class EatableBalls extends Ball
{
  PVector location;
  PVector velocity;
 
  boolean collided = false;
  boolean collision = false;
  float radius = eBallRad;
  float mass = radius;
  float distance;
  float velocX1;
  float velocX2;
  float velocY1;
  float velocY2;
  
  boolean hit = false;
  float hitdis;
  
  float ballSpeed = 1;
  
  public EatableBalls(float x, float y)
  {
    location = new PVector(x, y);
    velocity = new PVector(random(-ballSpeed,ballSpeed), random(-ballSpeed, ballSpeed));
    
  }
  
  //Adds the velocity to the ball/location PVector
  void move()
  {
    location.add(velocity);
  }

  //This method checks whether the balls are hitting the horizontal or verticle walls
  //If they are, it reverses their velocity and they bounce back in the other direction
  void bouncing()
  {
    if ((location.x > width -10) || (location.x < 10))
     {
          velocity.x = -velocity.x;
     }
    if ((location.y > height - 10) || (location.y < 10))
     {
          velocity.y = -velocity.y;
     } 
  }
  
  //This method updates the balls by redrawing their position after certain checks have been done
  //The collision check is done here which checks whether a collision is occuring between two balls
  void updateBalls()
  {
    if (collision == true)
    {
      //fill(255, 0 , 0);
      collide(); //If a collision is about to be true; calls the collide method which which change velocity and location when two balls collide
    }
    else
    {
      fill(100, 255, 100);
    }
    
    if (hit == true)
    {
      fill(255, 255, 255);
    }
    ellipse(location.x, location.y, 20, 20); 
  }
  
  //A method that checks whether a ball might collide, if they might, the collision boolean is set to true which results in the below method being called
  void checkCollisions(ArrayList<EatableBalls> eBalls)
  {
    
      collision = false;
      collided = false;
      for(EatableBalls b: eBalls)
      {
       if(b!=this)
         //This is creating a sort of bounding box around each ball
         if (b.location.x + radius + radius > location.x
         && b.location.x < location.x + radius + radius
         && b.location.y + radius + radius > location.y
         && b.location.y < location.y + radius + radius)
         {
           collision = true;
         }
               
      }
  }
  
  //This methods deals with the collisions between eatable balls
  void collide()
  {
    
    for (EatableBalls b: eBalls)
    {
       //Using pythag theorum to find out the distance between the two points
       distance = sqrt((b.location.x - location.x) * (b.location.x - location.x) + (b.location.y - location.y) * (b.location.y - location.y));
       if (distance < (radius * 2))
       {
         collided = true;
         
         //This is the code that deals with the changing of velocity once a collision occurs
         //When a ball collides with a wall, it's as easy as reversing the velocity
         //However, when colliding with another ball it is much more challenging
         
         velocX1 = (b.velocity.x * (b.mass - mass) + (2 * b.mass * velocity.x)) / (b.mass + mass); //In other words, (this balls x speed * (this balls mass - other mass) + (2 * this balls mass * this balls x speed) / (the combined mass)
         velocY1 = (b.velocity.y * (b.mass - mass) + (2 * b.mass * velocity.y)) / (b.mass + mass); //Because the mass of the balls are the same, no speed (or energy) is lost or gained. If the balls were different in mass this would change
         velocX2 = (velocity.x * (mass - b.mass) + (2 * mass * b.velocity.x)) / (b.mass + mass);
         velocY2 = (velocity.y * (mass - b.mass) + (2 * mass * b.velocity.y)) / (b.mass + mass);
         
         //Replaces the balls current velocity with the one calculated in the previous step (ie, when a ball collides, the velocity is changed depending on the outcome of the above calculation)
         velocity.x = velocX2;
         velocity.y = velocY2;
         b.velocity.x = velocX1;
         b.velocity.y = velocY1;
        
       }
       
    }
  }
  
  //Takes the a player ball instance as a parameter, that way it can access coordinates and test whether or not a collision is occuring
  void playerCollision(PlayerBall pBall)
  {
   //Sets the variable hit to the result of the method pCollision. I am inputting the coordinates of the eatable balls and the pBall and also the radius of both. 
   //This allows me to check collision (if the distance between then is less than the sum of the radius)
   hit = collision(location.x, location.y, radius, pBall.x, pBall.y, 15);

  }
  
  //This is the method that figures out whether a ball is actually colliding with the player ball
  boolean collision(float eX, float eY, float radius, float pX, float pY, float pRadius)
  {
    //Using the dist() function to calculate the distance between two points. Could use pythag therom here (sqrt((a*a) + (b*b))) but this method is quicker and saves code space
    float distance = dist(eX, eY, pX, pY);
    
    //If the distance between the points is smaller than the player radius and the eatable ball radius, collision is occuring so return true.
    if (distance <= radius + pRadius)
    {
      return true;
    }
    return false;
  }
  
  //Checks whether a collision is occuring, is there is one, the method returns true to the main program.
  boolean removeCheck()
  {
    if (hit == true)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
}