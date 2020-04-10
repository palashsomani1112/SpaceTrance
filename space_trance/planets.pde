class Planet {
  //Z position of spawn and maximum Z position
  float startingZ = -10000;
  float maxZ = 1000;
  
  //Position values
  float x, y, z;
  float rotX, rotY, rotZ;
  float sumRotX, sumRotY, sumRotZ;
  
  //builder
  Planet() {
    //Make the planet appear in a random place
    x = random(-width, width);
    y = random(-height, height);
    z = random(startingZ, maxZ);
    
    //Give the planet a random rotation
    rotX = random(0, 1);
    rotY = random(0, 1);
    rotZ = random(0, 1);
  }
  
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    //Assigning values for colour transitions
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, intensity*1000);
    fill(displayColor, 255);
    
    //Color lines, they disappear with the individual intensity of the planet
    color strokeColor = color(255, 150-(20*intensity));
    stroke(strokeColor);
    strokeWeight(1 + (scoreGlobal/300));
    
    //Creating a transformation matrix to perform rotations, enlargements
    pushMatrix();
    
    //Displacement
    translate(x-1, y-1, z-1);
    
    
    //Creation of the sphere, variable size according to the intensity for the planet
    sphere(100 + (intensity/2));
    sphereDetail(16,16);
    
    //Application of the matrix
    popMatrix();
    
    //Z displacement
    z+= (10+(intensity/5)+(pow((scoreGlobal/150), 2)));
    
    //Replace the sphere at the back when it is no longer visible
    if (z >= maxZ) {
      x = random(-width, width);
      y = random(-height, height);
      z = random(startingZ , maxZ);
    }
  }
}