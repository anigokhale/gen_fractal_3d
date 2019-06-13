import peasy.*;
import java.util.Scanner;

PeasyCam cam;

//two golden ratio constants
float Phi = (1.0 + (float)Math.sqrt(5))/2;
float phi = (1.0 - (float)Math.sqrt(5))/2;

//the five platonic solids
PVector[] tetrahedron = {new PVector(100, 100, 100), new PVector(-100, -100, 100), new PVector(-100, 100, -100), new PVector(100, -100, -100)};
PVector[] cube = {new PVector(-100, 100, 100), new PVector(100, 100, 100), new PVector(100, -100, 100), new PVector(-100, -100, 100), new PVector(-100, 100, -100), new PVector(100, 100, -100), new PVector(100, -100, -100), new PVector(-100, -100, -100)};
PVector[] octahedron = {new PVector(0, 100, 0), new PVector(0, 0, -100), new PVector(100, 0, 0), new PVector(0, -100, 0), new PVector(0, 0, 100), new PVector(-100, 0, 0)};
PVector[] icosahedron = {new PVector(0, Phi, 1).mult(100), new PVector(0, Phi, -1).mult(100), new PVector(0, -Phi, 1).mult(100), new PVector(0, -Phi, -1).mult(100), new PVector(1, 0, Phi).mult(100), new PVector(-1, 0, Phi).mult(100), new PVector(1, 0, -Phi).mult(100), new PVector(-1, 0, -Phi).mult(100), new PVector(Phi, 1, 0).mult(100), new PVector(-Phi, 1, 0).mult(100), new PVector(Phi, -1, 0).mult(100), new PVector(-Phi, -1, 0).mult(100)};
PVector[] dodecahedron = {new PVector(0, phi, Phi).mult(100), new PVector(0, phi, -Phi).mult(100), new PVector(0, -phi, Phi).mult(100), new PVector(0, -phi, -Phi).mult(100), new PVector(Phi, 0, phi).mult(100), new PVector(Phi, 0, -phi).mult(100), new PVector(-Phi, 0, phi).mult(100), new PVector(-Phi, 0, -phi).mult(100), new PVector(phi, Phi, 0).mult(100), new PVector(phi, -Phi, 0).mult(100), new PVector(-phi, Phi, 0).mult(100), new PVector(-phi, -Phi, 0).mult(100), new PVector(1, 1, 1).mult(100), new PVector(1, 1, -1).mult(100), new PVector(1, -1, 1).mult(100), new PVector(1, -1, -1).mult(100), new PVector(-1, 1, 1).mult(100), new PVector(-1, 1, -1).mult(100), new PVector(-1, -1, 1).mult(100), new PVector(-1, -1, -1).mult(100)};

//a custom shape; create a new one based on vertices or copy paste one in from console
PVector[] custom = {new PVector(-19.373587, 10.371316, 39.70834), new PVector(96.74818, 66.434235, -100.48277), new PVector(-49.113247, -105.00315, 82.37618), new PVector(-44.544613, -128.56186, 13.767829), new PVector(76.077805, -38.762527, -77.29668), new PVector(-25.353668, -142.66577, 10.255857), new PVector(-33.767704, 4.383825, 20.926212), new PVector(-130.29863, -2.1288168, 59.630234), new PVector(2.8655884, -23.352285, -20.433027), new PVector(-27.052986, -11.698695, -5.4750643), new PVector(-71.70403, -25.34855, 3.0804076), new PVector(-104.91949, 106.53597, -22.372557), new PVector(-18.577059, -160.37035, -78.061325), new PVector(-178.00989, 3.6015406, -77.7186), new PVector(-13.608478, -7.585574, -1.6136036), new PVector(38.753864, 4.1695995, -130.42613), new PVector(-30.220085, -10.055534, -63.205666), new PVector(88.74884, 20.92408, -89.24415), new PVector(-0.64824617, -19.60382, 77.35046), new PVector(-77.66589, 46.61057, -83.54355), new PVector(34.3871, 11.667451, 44.965523), new PVector(-112.931915, 35.524647, -154.36339), new PVector(-21.563871, 1.3566618, 43.963203), new PVector(49.73331, 47.57543, 4.904558), new PVector(-38.117954, -74.125084, -42.677914), new PVector(-14.521955, -4.236354, -40.197647), new PVector(-144.52028, -10.939803, 47.135532), new PVector(46.372643, -46.299522, -3.3670971), new PVector(102.158066, 118.55598, 1.9331293), new PVector(-139.57114, 67.50059, 98.28633), new PVector(58.751522, -99.430336, 91.69907), new PVector(3.8939235, -2.6347473, 0.79422164), new PVector(29.391327, 99.04514, -149.00165), new PVector(27.60854, -91.06211, -63.986137), new PVector(29.550053, 14.900315, -2.393409), new PVector(-17.767633, -18.11993, 11.910872), new PVector(11.795899, -57.881966, -78.02316), new PVector(-53.467766, -2.977052, 49.246826), new PVector(15.194572, 135.13297, -3.3752587), new PVector(-71.45938, -59.12026, 78.57498), new PVector(52.633007, -128.83696, -86.59795), new PVector(-15.893113, 0.6938725, -23.73389), new PVector(-3.6820252, -3.533732, -1.3366758), new PVector(184.73103, -0.6250327, 26.439825), new PVector(-41.505768, -99.380974, -34.124756), new PVector(-1.895627, 12.075123, 15.406553), new PVector(15.597544, -123.66971, -46.774284), new PVector(18.289284, -92.88888, 33.945778), new PVector(32.657505, 56.4377, 22.28196), new PVector(-4.389348, -6.390027, -4.0750957), new PVector(-13.118026, 10.129279, 23.426266), new PVector(-137.24585, -60.3582, -46.778854), new PVector(36.132137, 0.8356298, 171.75761), new PVector(-50.82056, 104.24566, 0.8315378), new PVector(32.04285, -83.2958, 57.601437), new PVector(56.54329, -179.267, -0.095462784), new PVector(6.901989, -62.187065, 16.728992), new PVector(-103.124985, 34.33189, 40.996567), new PVector(-59.531742, 103.37416, -105.457245), new PVector(-71.852356, -21.883154, -42.74565), new PVector(-44.51582, -23.239431, 34.83739), new PVector(-81.60509, -15.549676, -20.700905), new PVector(-130.91994, -90.35614, -62.737877), new PVector(-34.807865, 140.78088, -134.9219), new PVector(-12.250615, -59.668304, 20.127632), new PVector(116.47375, 19.543823, 137.26462), new PVector(19.933298, -97.331894, 79.946495), new PVector(-81.39461, 112.528175, -103.938774), new PVector(-99.09564, 98.90521, 21.385656), new PVector(-81.28806, -46.043858, -96.26591), new PVector(12.589968, 41.254364, 13.01618), new PVector(61.596916, -39.00178, -45.148712), new PVector(94.116554, -38.200974, 80.32045), new PVector(19.677277, -25.65871, -6.028172), new PVector(29.698006, -173.76263, 4.8201733), new PVector(-14.515704, -129.85599, 59.24491), new PVector(-40.068108, -36.21503, 89.96936), new PVector(6.1837893, 150.59288, -73.86343), new PVector(-2.0973237, 17.522036, 0.47500736), new PVector(149.69205, 23.111979, 42.077938), new PVector(-20.016487, 38.053886, 39.672462), new PVector(148.33932, 55.69583, -6.038026), new PVector(-133.63432, 118.155075, -43.01414), new PVector(43.435154, 31.450623, -28.065903), new PVector(69.76377, 39.742584, 100.461914), new PVector(72.2471, -59.26738, 57.541523), new PVector(97.81018, 46.85335, 111.88069), new PVector(-3.6359582, -60.84461, 93.19394), new PVector(-10.221354, 13.490141, 5.897701), new PVector(-10.022035, 116.55061, 29.786192), new PVector(-65.59271, -59.244946, 101.3129), new PVector(-70.9087, 35.106255, 59.456352), new PVector(88.70654, 84.211876, -43.491745), new PVector(40.247993, -138.0199, 108.20765), new PVector(-24.802097, 17.01335, 7.3133054), new PVector(22.580263, -34.781364, 99.899475), new PVector(-30.012074, -21.723087, 17.311054), new PVector(-170.94678, 52.22279, 82.45173), new PVector(-118.39233, 78.85607, 50.6543), new PVector(-42.006958, 104.53095, 23.83928)};

PVector current = PVector.random3D().mult(100);
ArrayList<Point> points = new ArrayList<Point>(); //list of points rendered
int rand, last, sides;
boolean lines = false;

float sWeight = 1; //strokeWeight of the dots
int numPoint = 100000; //number of points generated
float c = 3.6; //c-value: see line 97
int randMode = 0; //type of random selection- outlined in chooseRandom method
boolean col = true; //whether color is activated or not
boolean pretty = false; //gets rid of shape vertices if true
boolean randSpherical = false; //whether the shape made by randomShaper method is spherical in nature

PVector[] selected = dodecahedron; //which shape is rendered: one of the five platonic solids listed above, custom, or randomShaper() method below

void setup() {
  fullScreen(P3D);
  colorMode(HSB, 100);
  
  //camera stuff
  cam = new PeasyCam(this, 150);
  cam.setMaximumDistance(1000);
  cam.setResetOnDoubleClick(true);
  
  //adds the first point
  points.add(new Point(current.x, current.y, current.z, 0));
  //adds the rest of the points as per rules
  for (int i = 1; i < numPoint; i++) {
    addPoint();
  }
  
  //prints the currently selected shape's coordinates to console
  println(shapeToString(selected));
}

void draw() {
  background(0);

  if (!pretty) drawShape(selected);

  //updates every point in points list
  for (Point p : points) {
    p.update();
  }
  
  //renders axes
  if (lines) axes();
}

//draws the vertices of the shape
void drawShape(PVector[] shape) {
  for (int i = 0; i < shape.length; i++) {
    strokeWeight(10);
    if (col) stroke(i*(100/selected.length), 100, 100);
    else stroke(0, 100, 100);
    point(shape[i].x, shape[i].y, shape[i].z);
  }
}

void keyPressed() {
  if (key == 'x') cam.setPitchRotationMode(); //restricts rotation to x-axis
  else if (key == 'y') cam.setYawRotationMode(); //restricts rotation to y-axis
  else if (key == 'z') cam.setRollRotationMode(); //restricts rotation to z-axis
  else if (key == 'a') cam.setFreeRotationMode(); //frees rotation to all axes
  
  if (key == 'l') lines = !lines; //enables axis rendering
}

//adds a new point to points ArrayList based on chaos game rules
void addPoint() {
  PVector p;
  chooseRandom();
  p = func(current, selected[rand]);
  current.set(p);
  points.add(new Point(p.x, p.y, p.z, rand));
}

//chaos game rule
PVector func(PVector p1, PVector p2) {
  return p1.add(p2).div(c);
}

//chooses a random number for chaos game selection
void chooseRandom() {
  if (randMode == 0) {
    rand = (int)(Math.random()*selected.length);
  } else if (randMode == 1) {
    last = rand;
    while (rand == last) rand = (int)(Math.random()*selected.length);
  }
}

//defines Point class, which make up the rendered dots on screen
class Point {
  PVector pos; //x,y,z position of point
  int domain; //which vertex the point belongs to (which number it was drawn toward)
  Point(float x, float y, float z, int d) {
    pos = new PVector(x, y, z);
    domain = d;
  }

  //draws the point
  void update() {
    if (col) stroke(domain*(100/selected.length), 100, 100);
    else stroke(0, 0, 100);
    strokeWeight(sWeight);
    point(pos.x, pos.y, pos.z);
  }
}

//returns a random shape based on n (number of points) and l (maximum distance of points from origin). If randSpherical is true, all the points will be l distance from origin
PVector[] randomShaper(int n, float l) {
  PVector[] r = new PVector[n];
  float factor;
  if (randSpherical) factor = l;
  else factor = random(l);
  for (int i = 0; i < n; i++) {
    r[i] = PVector.random3D().mult(factor);
  }
  return r;
}

//converts a shape to a string to print it to the console
String shapeToString(PVector[] p) {
  String s = "PVector[] custom = {";
  for (int i = 0; i < p.length; i++) {
    s += "new PVector(" + p[i].x + ", " + p[i].y + ", " + p[i].z + "), ";
  }
  s = s.substring(0, s.length()-2);
  s+="};";
  return s;
}

//displays axes
void axes() {
  stroke(0, 0, 100);
  strokeWeight(2);
  line(-500, 0, 0, 500, 0, 0);
  line(0, -500, 0, 0, 500, 0);
  line(0, 0, -500, 0, 0, 500);
}
