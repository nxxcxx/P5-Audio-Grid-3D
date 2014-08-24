class Grid {

  float amplitude = 100;

  PVector[][] grid;
  int gW, gD, gS;
  float[][] dx;
  float[][] dxE;
  float[][] dxRaw;
  float easing = 0.15;
  float gridRealDepth;

  float[][] vertexColor;
  float[][] vertexBrightness;


  Grid(int gWidth, int gDepth, int gSpacing) {
    gW = gWidth;
    gD = gDepth;
    gS = gSpacing;
    grid = new PVector[gW][gD];
    gridRealDepth = gD*gS;

    dx = new float[gD][gW];
    dxE = new float[gD][gW];
    dxRaw = new float[gD][gW];

    vertexColor = new float[gD][gW];
    vertexBrightness = new float[gD][gW];
  }

  void setGridPoints(int indexW, int indexD, float x, float y, float z) {
    grid[indexW][indexD] = new PVector(x, y, z);
  }

  void render() {
    // update grid
    for (int d=0; d<gD; d++) { 
      for (int w=0; w<gW; w++) { 
        ///easing 
        dxRaw[gD-1][w] = -abs(song.mix.get(w) * amplitude);
        dx[d][w] =  dxRaw[d][w] - dxE[d][w];
        if (abs(dx[d][w]) > 1) {
          dxE[d][w] += dx[d][w] * easing;
        }
        //plot xyz and draw
        setGridPoints(w, d, w*gS, dxE[d][w], d*gS);

        //make Rainbow 
        //float pointDist = dist(grid[w][d].x, grid[w][d].y, grid[w][d].z, grid[w][d].x, 0, grid[w][d].z);
        //map amplitude to color dxE[d][w] is in negative so need absolute
        //exponential color distribution
        float c = map(pow(abs(dxE[d][w]), 2), 0, amplitude*amplitude, 0, 260); 
        vertexColor[d][w] = c;

        float b = map(abs(dxE[d][w]), 0, 30, 0, 100);
        vertexBrightness[d][w] = b;

        //shift data
        if (d<gD-1) dxE[d][w] = dxE[d+1][w];
        if (d<gD-1) vertexColor[d][w] = vertexColor[d+1][w];
      }
    }  // end

    // draw grid
    for (int d=0; d<gD-1; d++) { 
      beginShape(QUAD_STRIP);
      for (int w=0; w<gW; w++) {
        colorMode(HSB, 360, 100, 100, 100);     
        float c1 = vertexColor[d][w];
        float c2 = vertexColor[d+1][w];
        float b1 = vertexBrightness[d][w];
        float b2 = vertexBrightness[d+1][w];
        fill(c1, 100, b1, 100);
        vertex(grid[w][d].x, grid[w][d].y, grid[w][d].z);
        fill(c2, 100, b2, 100);
        vertex(grid[w][d+1].x, grid[w][d+1].y, grid[w][d+1].z);
        colorMode(RGB, 255);
      }
      endShape();
    }
  } // end of render
  void drawTEXT() {
    float[] rotations = cam.getRotations();
    pushMatrix();
    rotateX(rotations[0]);
    rotateY(rotations[1]);
    rotateZ(rotations[2]);
    textFont(font);
    text("WAVE01", 0, 0, 0);
    popMatrix();
  } // end of drawTEXT
} // end of class Grid
