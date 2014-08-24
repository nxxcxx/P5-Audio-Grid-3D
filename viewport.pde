
double[] defaultCam = {
  2.614837, 0.04779443, -3.1347873, 300
};
boolean enableAxis = false, 
enableGrid = false;

void keyPressed() {
  if ( key == 'q' || key == 'Q') {
    cam.setRotations(defaultCam[0], defaultCam[1], defaultCam[2]);
    cam.lookAt(GRID_SIZE_X*GRID_SPC*0.52, 0, GRID_SIZE_Z*GRID_SPC*0.5);
    cam.setDistance(defaultCam[3]);
  }
  else if ( key == 'a' || key == 'A') {
    enableAxis = !enableAxis;
  }
  else if ( key == 's' || key == 'S') {
    enableGrid = !enableGrid;
  } 
  else if (keyCode == UP) {
    grid.easing += 0.01; 
    println(grid.easing);
  } 
  else if (keyCode == DOWN) {
    grid.easing -= 0.01; 
    println(grid.easing);
  }
  else if (keyCode == LEFT) {
    STROKE_WEIGHT -= 0.5 ; 
    if (STROKE_WEIGHT < 1) STROKE_WEIGHT = 1;
    println(STROKE_WEIGHT);
  } 
  else if (keyCode == RIGHT) {
    STROKE_WEIGHT += 0.5 ; 
    if (STROKE_WEIGHT < 1) STROKE_WEIGHT = 1;
    println(STROKE_WEIGHT);
  }
  else if ( key == 'e' || key == 'E') {
    grid.amplitude += 50;
    println(grid.amplitude);
  } 
  else if ( key == 'd' || key == 'D') {
    grid.amplitude -= 50;
    if(grid.amplitude < 50) grid.amplitude = 50;
    println(grid.amplitude);
  }
}

void visualGuide() {
  //// world AXIS
  if (enableAxis) {
    noFill();
    strokeWeight(1);
    stroke(0, 255, 0, 127);
    line(0, 0, 0, 0, 80, 0); // y
    stroke(255, 0, 0, 127);
    line(0, 0, 0, 80, 0, 0);  // x
    stroke(0, 0, 255, 127);
    line(0, 0, 0, 0, 0, 80);  // z
    stroke(255, 40);
    box(10);
  }
  //// world GRID
  if (enableGrid) {
    strokeWeight(1);
    stroke(255, 80);
    for (int i = 0; i < 10; i++) {
      int spc = i*50;
      pushMatrix();
      translate(-450/2, 0, -450/2);
      line(spc, 0, 0, spc, 0, 450);  // z
      line(0, 0, spc, 450, 0, spc);  // x
      popMatrix();
    }
  }
  ////
}

void mouseClicked() {
  //println(cam.getRotations());
}
