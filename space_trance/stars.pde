class Star {
  //Z position of spawn and maximum Z position
  float startingZ = -10000;
  float maxZ = 1000;
  
  //Position values
  float x, y, z;
  float rotX, rotY, rotZ;
  float sumRotX, sumRotY, sumRotZ;
  
  //builder
  Star() {
    //Make the star appear in a random place
    x = random(-width, width);
    y = random(-height, height);
    z = random(startingZ, maxZ);
    
    //Give the star a random rotation
    rotX = random(0, 1);
    rotY = random(0, 1);
    rotZ = random(0, 1);
  }
  
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    //Assigning values for colour transitions
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, intensity*1000);
    fill(displayColor, 255);
    
    //Color lines, they disappear with the individual intensity of the star
    color strokeColor = color(255, 150-(20*intensity));
    stroke(strokeColor);
    strokeWeight(1 + (scoreGlobal/300));
    
    //Creating a transformation matrix to perform rotations, enlargements
    pushMatrix();
    
    //Displacement
    translate(x-1, y-1, z-1);
    
    
    //Creation of the diamond, variable size according to the intensity for the star
    sphere(10 + (intensity/2));
    sphereDetail(0,1);
    
    //Application of the matrix
    popMatrix();
    
    //Z displacement
    z+= (1+(intensity/25)+(pow((scoreGlobal/75), 2)));
    
    //Replace the diamond at the back when it is no longer visible
    if (z >= maxZ) {
      x = random(-width, width);
      y = random(-height, height);
      z = random(startingZ , maxZ);
    }
  }
}