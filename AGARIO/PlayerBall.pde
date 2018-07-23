class PlayerBall
{
  PVector location;
  boolean collision = false;
  float radius = 15;
  
  //For some reason when trying to access the coords of the PlayerBall via the pVector i was not able to
  //Instead i created individual variables that would hold the coordinates to be manipulated below.
  float x;
  float y;
  float easing = 0.05;


  public PlayerBall()
  {
     location = new PVector(x, y);
     //could pass a number that is used to control the position of the playerball
  }
  
  void updateBalls()
  {
     fill(12,12,245);
     //This code was taken from the easing example on the processing website "https://processing.org/examples/easing.html"
     
     //the following code is what makes the player ball follow the mouse coords with a slight delay
     //Without it the player ball would simply be drawn straight on the mouse coords and would make the game much easier
     float targetX = mouseX; //Sets the X target to be the mouse coords
     float dx = targetX - x;
     x += dx * easing;
     float targetY = mouseY; //Sets the Y target to be the mouse coords
     float dy = targetY - y;
     y += dy * easing;
     
     ellipse(x, y, 30, 30);

  }
  
  

}