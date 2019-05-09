ArrayList <PVector> pointsneu = new ArrayList<PVector>(); //<>// //<>//
int abbruch = 0;
PVector durchschnittsVektor = new PVector();
int maxDrawNum=8;


//Berechne points hauptmethode
void calcInsidePoints() {
  boolean saveAbs=dist(points.get(0).x, points.get(0).y, points.get((2)%points.size()).x, points.get((2)%points.size()).y)>1;
  int ps = points.size();
  for (int i=0; i<points.size(); i++) {
    pointsneu.add(getIntersectionPoint(points.get(i), points.get((i+1)%ps), points.get((i+2)%ps), points.get((i+3)%ps)));
  }
  points.clear();
  for (PVector p : pointsneu) {
    points.add(p);
  }
  pointsneu.clear();
  abbruch+=1;
  if (saveAbs) 
    connect(points);
}

//berechne Innenpoints

PVector getIntersectionPoint(PVector a, PVector b, PVector c, PVector d) {

  PVector s = new PVector();

  float m1 = ((c.y - a.y) / ((c.x - a.x)==0 ? (n>=15? standard/7.2:1) : (c.x - a.x)));//(n==15? 5:1)
  float m2 = ((b.y - d.y) / ((b.x - d.x)==0 ? (n>=15? standard/7.2:1) : (b.x - d.x)));
  float t1 = a.y - m1 * a.x;
  float t2 = b.y - m2 * b.x;

  s.x = (t2 - t1) / (m1 - m2);

  s.y = m1 * s.x + t1;

  return s;
}

//connect Innenpoints
void connect(ArrayList <PVector> points) {
  colorPolygon();

  strokeWeight(2);
  for (int i=0; i<points.size(); i++) {
    line(points.get(i).x, points.get(i).y, points.get((i+1)%points.size()).x, points.get((i+1)%points.size()).y);
    if (abbruch<maxDrawNum)
      line(points.get(i).x, points.get(i).y, points.get((i+2)%points.size()).x, points.get((i+2)%points.size()).y);
  }
  strokeWeight(1);
  if (!convex)
    notConvex();
  if (abbruch<maxDrawNum) {
    calcInsidePoints();
  }
}

//sortiere liste hauptmethode
void sortPoints(ArrayList<PVector> points) {

  Comparator<PVector> comp = new pointsComparator();
  Collections.sort(points, comp);
}

//Klasse comperator
public class pointsComparator implements Comparator<PVector> {

  @Override
    public int compare(PVector p1, PVector p2) {
    float w1 = calcAngle(p1);
    float w2 = calcAngle(p2);

    if (w1 > w2) {
      return 1;
    } else return -1;
  }
}


//berechne winkel (sortieren)
float calcAngle(PVector p) {
  PVector he = new PVector(p.x - durchschnittsVektor.x, p.y - durchschnittsVektor.y);

  float winkel = PVector.angleBetween( new PVector(1, 0), he);
  if (he.y < 0) winkel = 2*PI-winkel;
  return winkel;
}


// konvexheit prüfen
boolean saveConvex() {

  int ps = points.size();
  PVector he;

  for (int i=0; i<ps; i++) {
    he = getIntersectionPoint(durchschnittsVektor, points.get(i), points.get((i+1)%ps), points.get((i+2)%ps));

    if (dist(points.get((i+1)%ps).x, points.get((i+1)%ps).y, durchschnittsVektor.x, durchschnittsVektor.y)<=(dist(he.x, he.y, durchschnittsVektor.x, durchschnittsVektor.y))+(n>=10?0:7)) {
      abbruch=100;
      return false;
    }
  }
  return true;
}

//n-eck einfärben
void colorPolygon() {
  fill(currVal.rColor, currVal.gColor, currVal.bColor);
  beginShape();
  for (PVector p : points) {
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}

//rotdisplay
void notConvex() {
  fill(0);
  textSize(standard);
  textAlign(CENTER);
  text("Bitte bilden Sie ein konvexes n-Eck!", displayWidth/2, displayHeight/5);
}