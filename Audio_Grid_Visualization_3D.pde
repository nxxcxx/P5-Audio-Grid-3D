//KN1C
import peasy.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

PeasyCam cam;
Minim minim;
AudioPlayer song;

FFT  fft;

PFont font;
String FRAME_RATE = new String();
final static int GRID_SIZE_X = 512; // Must less than song buffer size
final static int GRID_SIZE_Z = 100;
final static int GRID_SPC = 1;
float STROKE_WEIGHT = 1;
Grid grid;

void setup() {
  size(1200, 600, P3D); 
  smooth();

  font = createFont("Arial", 14, true);
  //Minim
  minim = new Minim(this);
  song = minim.loadFile("gh.mp3", 512);
  song.play();

  fft = new FFT( song.bufferSize(), song.sampleRate() );

  //Peasy Cam
  cam = new PeasyCam(this, defaultCam[3]);
  cam.setMinimumDistance(0.001);
  cam.setMaximumDistance(9999999);
  cam.setRotations(defaultCam[0], defaultCam[1], defaultCam[2]);
  cam.lookAt(GRID_SIZE_X*GRID_SPC*0.52, 0, GRID_SIZE_Z*GRID_SPC*0.5);

  grid = new Grid(GRID_SIZE_X, GRID_SIZE_Z, GRID_SPC);
} // end of setup

void draw() {
  background(33);
  // set clipping distance
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, (float) width/height, cameraZ/1000.0, cameraZ*1000.0);
  //// guide elements
  visualGuide();
  //// HUD
  cam.beginHUD();
  if ( frameCount % 10 == 0) FRAME_RATE = int(frameRate) + " FPS";
  textAlign(LEFT);
  textFont(font);
  fill(255);
  text(FRAME_RATE, 5, 15);
  cam.endHUD();
  //// Line
  stroke(255, 127);
  int offset = 5;
  line(-offset, 0, -offset, -offset, 0, GRID_SIZE_Z*GRID_SPC+offset);
  line(-offset, 0, GRID_SIZE_Z*GRID_SPC+offset, GRID_SIZE_X*GRID_SPC+offset, 0, GRID_SIZE_Z*GRID_SPC+offset);
  line(-offset, 0, GRID_SIZE_Z*GRID_SPC+offset, -offset, -grid.amplitude/2.0, GRID_SIZE_Z*GRID_SPC+offset);
  //// audio Grid
  strokeWeight(STROKE_WEIGHT);
  noStroke();
  noFill();
  grid.render();
  //grid.drawTEXT();
} // end of draw
