abstract class Ball
{
  
  abstract void move(); //This method should deal with adding the velocity component to the ball to make sure it actually moves
  
  abstract void bouncing(); //This method should deal with keeping the balls within the constraints of the screen. IE when the ball hits the borders of the current screen size; reverse velocity (Constrain method)
  
  abstract void updateBalls(); //This method should deal with the actual drawing and selection about ball movement.
  

}