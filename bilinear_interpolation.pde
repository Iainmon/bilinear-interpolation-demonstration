static final int SIZEX = 500;
static final int SIZEY = 500;

final int spacing = 10; // The spacing in pixels inbetween each gridpoint
float map[][];

final color LOW_COLOR = color(98, 3, 252, 255);
final color HIGH_COLOR = color(252, 186, 3, 255);

void setup() {
  
  size(500, 500);
  background(0);
  
  int dimensionSize = SIZEX / spacing + spacing;
  map = new float[dimensionSize][dimensionSize];
  
  
  // Initializes the map like a chessboard. 1 or 0 every other.
  //for (int x = 0; x < map.length; x++) {
  //  for (int y = 0; y < map.length; y++) {
  //    map[x][y] = y % 2 > 0 ? x % 2 > 0 ? 0.0f : 1.0f : x % 2 > 0 ? 1.0f : 0.0f;
  //  }
  //}
  
  // Initializes the map with random floats from 0.0 to 1.0.
  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map.length; y++) {
      map[x][y] = random(0.0f, 1.0f);
    }
  }
  
  // Initializes the map with values with either 0.0 or 1.0
  //for (int x = 0; x < map.length; x++) {
  //  for (int y = 0; y < map.length; y++) {
  //    if (random(0.0f, 1.0f) > 0.5f) {
  //      map[x][y] = 1.0f;
  //    } else {
  //      map[x][y] = 0.0f;
  //    }
  //  }
  //}
  
}

void draw() {
  //displayGrid();
  displayInterpolatedMap();
}

void displayGrid() {
  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map.length; y++) {
      stroke(lerpColor(HIGH_COLOR, LOW_COLOR, map[x][y]));
      point(x * spacing, y * spacing);
    }
  }
}

void displayInterpolatedMap() {
  for (int x = 0; x < SIZEX; x++) {
    for (int y = 0; y < SIZEY; y++) {
      
      float sampleLocationX = (float)x / spacing;
      float sampleLocationY = (float)y / spacing;
      
      int mappedX = floor(sampleLocationX);
      int mappedY = floor(sampleLocationY);
      mappedX = constrain(mappedX, 0, map.length - 2);
      mappedY = constrain(mappedY, 0, map.length - 2);
      
      float averageWeightX = sampleLocationX - mappedX;
      float averageWeightY = sampleLocationY - mappedY;
      
      float r1 = lerp(map[mappedX][mappedY], map[mappedX + 1][mappedY], averageWeightX);
      float r2 = lerp(map[mappedX][mappedY + 1], map[mappedX + 1][mappedY + 1], averageWeightX);
      
      float z = lerp(r1, r2, averageWeightY);
      
      stroke(lerpColor(HIGH_COLOR, LOW_COLOR, z));
      point(x, y);
      
    }
  }
}
