
class SpaceShip  {
 
//Position values
float camX, camY, camZ;

//Using a PVector to track two angles
PVector angle;
PVector velocity;
PVector amplitude;
 
  SpaceShip()  {
    angle = new PVector();
    velocity = new PVector(random(-0.05,0.05),random(-0.05,0.05));

    //Random velocities and amplitudes
    amplitude = new PVector(random(width/4),random(height/4));
  }
 
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal)  
  {
    //Mouse translation
    translate(camX, camY, camZ);
    translate(width/2.0-camX, height/2.0-camY);
    translate(-(width/2.0-camX), -(height/2.0-camY));
    
    //to perform oscillation
    angle.add(velocity);
    
    //Oscillating on the x-axis
    float x = sin(angle.x)*amplitude.x;
    //Oscillating on the y-axis
    float y = atan(angle.y)*amplitude.y;
    
    float z = abs(3500); //no oscillation on z-axis
         
    translate((width/3),(height/3));
    //Color lines, they disappear with the intensity of the spaceship
    color strokeColor = color(255, 150-(10*intensity));
    stroke(strokeColor);
    strokeWeight(1 + (scoreGlobal/80));  
    
    //Color fill, it changes with the intensity of the spaceship
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, intensity*1000);
    fill(displayColor, 255);
    
    //rotation to align the spaceship properly
    rotateX(PI/4);
    rotateZ(PI/4);
    
    //Drawing the Oscillator as a line connecting a circle
    float sx = map(x/z, 0,1,0, width);
    float sy = map(y/z, 0,1,0, height);
    float sz = map(z, 0, width, 16, 0);
   
    //create spaceship  
    beginShape();
    vertex(28*sx, 28*sy, 28*sz);
    vertex(28*sx, 28*(sy+5), 28*sz);
    vertex(28*(sx+4), 28*(sy+4), 28*(sz+8));
    
    vertex(28*sx, 28*sy, 28*sz);
    vertex(28*(sx+5),  28*sy, 28*sz);
    vertex(28*(sx+4),   28*(sy+4),  28*(sz+8));
    
    vertex(28*(sx+4), 28*(sy+4),28*(sz+8));
    vertex(28*(sx+5.75),28*(sy+2), 28*(sz+3));
    vertex(28*(sx+4), 28*(sy+4), 28*(sz+4));
    
    vertex(28*(sx+4), 28*(sy+4), 28*(sz+8));
    vertex(28*(sx+2), 28*(sy+5.75), 28*(sz+3));
    vertex(28*(sx+4), 28*(sy+4), 28*(sz+4));
    
    vertex(28*(sx+4), 28*(sy+4), 28*(sz+4));
    vertex(28*(sx+5.75),28*(sy+2),28*(sz+3));
    vertex(28*(sx+7),28*(sy+2),28*(sz+2));
    
    vertex(28*(sx+4), 28*(sy+4), 28*(sz+4));
    vertex(28*(sx+2), 28*(sy+5.75), 28*(sz+3));
    vertex(28*(sx+2), 28*(sy+7), 28*(sz+2));
    
    vertex(28*(sx+5.75),28*(sy+2), 28*(sz+3));
    vertex(28*(sx+5),28*sy,28*sz);
    vertex(28*(sx+10),28*sy,28*sz);
    
    vertex(28*(sx+2), 28*(sy+5.75), 28*(sz+3));
    vertex(28*sx,28*(sy+5),28*sz);
    vertex(28*sx, 28*(sy+10),28*sz);
    
    vertex(28*(sx+10),28*sy,28*sz);
    vertex(28*(sx+4),28*(sy+4),28*sz);
    vertex(28*(sx+4),28*(sy+4),28*(sz+4));
    
    vertex(28*sx,28*(sy+10),28*sz);
    vertex(28*(sx+4),28*(sy+4),28*sz);
    vertex(28*(sx+4),28*(sy+4),28*(sz+4));
    
    vertex(28*sx,28*sy,28*sz);
    vertex(28*(sx+10),28*sy,28*sz);
    vertex( 28*(sx+4),28*(sy+4),28*sz);
    
    vertex(28*sx,28*sy,28*sz);
    vertex(28*sx,28*(sy+10),28*sz);
    vertex(28*(sx+4),28*(sy+4),28*sz);
    endShape();
  }
   //move spaceship via mouse
    void mouseDragged()
  {
    if (mouseButton == LEFT)       // move spaceship on x-y plane
  {
      camX -= (pmouseX - mouseX);
      camY -= (pmouseY - mouseY);
  }
    if (mouseButton == RIGHT)      // move spaceship on z-axis
    {
      camZ += (pmouseY - mouseY);
    }
  }
}