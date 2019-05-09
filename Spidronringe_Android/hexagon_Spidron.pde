ResPoints result; //<>// //<>//
int minDist = 1;
ArrayList <PVector> aVectorList = new ArrayList <PVector>(), bVectorList = new ArrayList <PVector>(), 
      dVectorList = new ArrayList <PVector>(), cVectorList = new ArrayList <PVector>();

void drawSpidron(PVector a, PVector b) {
  while (dist(a.x, a.y, b.x, b.y) > minDist) {
    result = new ResPoints(getPoints(a, b).c, getPoints(a, b).d);
    drawMyTriangle(a, b, result.c, result.d);
    aVectorList.add(a);
    bVectorList.add(b);
    cVectorList.add(result.c);
    dVectorList.add(result.d);
    a = result.d;
    b = result.c;
  }
  for (int i = 0; i < aVectorList.size(); i++) {
    drawMyTriangle(aVectorList.get(i), bVectorList.get(i), dVectorList.get(i), cVectorList.get(i));
  }
}

ResPoints getPoints(PVector a, PVector b) {
  float abstand = dist(a.x, a.y, b.x, b.y)/(sqrt(3)/2)/2;
  PVector c = new PVector(0, 0);
  PVector d = new PVector(0, 0);

  PVector he = b.copy().sub(a);
  he.set(-he.y, he.x);
  he.normalize();
  he.mult(abstand);
  d = a.copy().add(he);
  d.set(d.x, d.y);
  d = new PVector(d.x, d.y);

  //Berechne C
  he = d.copy().sub(b);
  c = b.copy().add(he.div(2));
  return (new ResPoints(c, d));
}

void drawMyTriangle(PVector a, PVector b, PVector c, PVector d) {
  fill(currVal.rColor,currVal.gColor, currVal.bColor);
  triangle(a.x, a.y, b.x, b.y, c.x, c.y);
  point(d.x, d.y);
  stroke(40);
  strokeWeight(2);
  line(d.x, d.y, a.x, a.y);
}
