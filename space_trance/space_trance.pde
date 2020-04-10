// SPACE TRANCE : a generative audiovisual display based on the concept of hyperspace jump from Star Wars
// Palash Somani - 17101247 iMedia
// the spaceship can be dragged across the space using mouse buttons and mouse movement
// use left mouse button, hold it and drag the mouse in any direction to move spaceship in x-y plane
// use the right mouse button, hold it and drag the mouse up and down to move spaceship in z-axis
// to change the audio, rename your desired audio track to song and paste it in data folder or edit the name of .mp3 file in 'line 58'.

//code references taken from "ProcessingCubes" by Samuel Lapointe: https://github.com/samuellapointe/ProcessingCubes
//code references taken from "3D CAD-style navigation with mouse" thread from Processing Forum: https://forum.processing.org/two/discussion/1396/3d-cad-style-navigation-with-mouse
//code references taken from "Chapter 3: Oscillation" of book "Nature of Code" by Daniel Shiffman : http://natureofcode.com/book/chapter-3-oscillation/
//audio track taken : C2C - F.U.Y.A. : https://www.youtube.com/watch?v=1KOaT1vdLmc
//CODE*****

//libraries
import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer song;
FFT fft;

//Global variables
float specLow = 0.03; // 3% (lower spectrum for bass)
float specMid = 0.125;  // 12.5% (medium spectrum for kicks and medium frequency sounds)
float specHi = 0.20;   // 20% (higher spectrum for high frequency sounds)

float scoreLow = 0;  // initial low score from the generated audio spectrum
float scoreMid = 0;  // initial medium score from the generated audio spectrum
float scoreHi = 0;   // initial high score from the generated audio spectrum

float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;

float angle = 0;
float aVelocity = 0.05;

// Softening value
float scoreDecreaseRate = 25;

//Identifying graphical elements; creating arrays
SpaceShip spaceship = new SpaceShip();
Star[] stars = new Star[1000];
Planet[] planets = new Planet[3];


void setup()
{
  //Display in 3D on the entire screen
  fullScreen(P3D);
  frameRate(60);
  smooth(); 
  
  //Load the minim library
  minim = new Minim(this);
 
  //Load song
  song = minim.loadFile("song.mp3"); 
  
  //Create the FFT object to analyze the song
  fft = new FFT(song.bufferSize(), song.sampleRate());
  
  for (int i = 0; i < stars.length; i++)
  {
    stars[i] = new Star(); //create new star when a star disappears from screen
  }
    for (int i = 0; i < planets.length; i++)
  {
    planets[i] = new Planet();  //create new planet when a planet disappears from screen
  }
  song.play(0); //play song
}

void draw()
{
  background(0);
  translate(width/48,height/48);

 //Forward the song. One draw () for each "frame" of the song
  fft.forward(song.mix);
  
  //Calculation of "scores" (power) for three categories of sound
  //First, save old values
  oldScoreLow = scoreLow;
  oldScoreMid = scoreMid;
  oldScoreHi = scoreHi;
  
  //Reset values
  scoreLow = 0;
  scoreMid = 0;
  scoreHi = 0;
 
  //Calculate the new "scores"
  for(int i = 0; i < fft.specSize()*specLow; i++)
  {
    scoreLow += fft.getBand(i);
  }
  
  for(int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
  {
    scoreMid += fft.getBand(i);
  }
  
  for(int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
  {
    scoreHi += fft.getBand(i);
  }
  
  //To slow down the descent.
  if (oldScoreLow > scoreLow) {
    scoreLow = oldScoreLow - scoreDecreaseRate;
  }
  
  if (oldScoreMid > scoreMid) {
    scoreMid = oldScoreMid - scoreDecreaseRate;
  }
  
  if (oldScoreHi > scoreHi) {
    scoreHi = oldScoreHi - scoreDecreaseRate;
  }
  
  //Volume for all frequencies at this time, with the highest sounds higher.
  //This allows the animation to go faster for the higher pitched sounds, which is more noticeable
  float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;
  
  //Subtle color of background
  background(scoreLow/5, scoreMid/5, scoreHi/5);
   
  //display stars and planets
    for(int i = 0; i < stars.length; i++)
  {
     float bandValue = fft.getBand(i);
     stars[i].display(scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
  }
   for(int i = 0; i < planets.length; i++)
  {
     float bandValue = fft.getBand(i);
     planets[i].display(scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
  }
  //display spaceship
  float bandValue = fft.getBand(1000);
  spaceship.display( scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
  spaceship.mouseDragged();  //move spaceship
  }