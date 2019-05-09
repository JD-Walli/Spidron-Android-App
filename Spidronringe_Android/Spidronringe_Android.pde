import java.util.Collections; //<>//
import java.util.Comparator;
PVector middle;
float r;
int n=15;
int state=0;
ArrayList <PVector> points = new ArrayList<PVector>();
ArrayList <Color> colors= new ArrayList<Color>();
ArrayList <PVector> oldpoints = new ArrayList<PVector>();
boolean convex;
Color currVal;
Color green= new Color(43, 175, 4);
Color red= new Color(175, 9, 4);
Color blue = new Color(0, 115, 200);
float standard;
boolean freeze=false;
float buttonStand;
PVector state0ScrollVec, mymouse=new PVector();
int textAnfangState0;

//// in der android versio  nicht
//PVector[] touches= new PVector[]{new PVector(10, 300)};

void setup() {

  //// in der android versio  nicht
  //size(1280, 800);
  middle=new PVector(width/2, height/2);
  r=height/4;
  standard= height/15;
  buttonStand=standard*1.5;
  textAnfangState0= int(buttonStand*2);
  orientation(LANDSCAPE);
  colors.add(new Color(0, 115, 200));  //blau
  colors.add(new Color(100, 0, 170)); //lila
  //  colors.add(new Color(216, 111, 197)); //rosa
  colors.add(new Color(211, 34, 34)); //rot
  //colors.add(new Color(10, 120, 0));   //grün
  //  colors.add(new Color(242, 242, 56)); // gelb
  colors.add(new Color(255, 255, 255));//weiß
  colors.add(new Color(200, 110, 11)); //orange
  //  colors.add(new Color(4, 201, 196)); //zitron
  //colors.add(new Color(156, 202, 206)); //türkis
  currVal = colors.get((int)random(0, colors.size()));
}


void draw() {
  abbruch = 0;
  points.clear();
  if (freeze==false) {
    refresh(true);
  } else {
    freezerefresh();
  }
  if (state==0) {
    startInstructions();
  } else {
    fill(0);
    textSize(standard);
    textAlign(CORNER);
    textSize(standard*0.75);
    text("freeze", buttonStand+standard/3, buttonStand*0.75);
    filter();
    fill(255);
    rect(0, 0, buttonStand, buttonStand);
    if (freeze) {
      fill(red.rColor, red.gColor, red.bColor, 200);
    } else {
      fill(green.rColor, green.gColor, green.bColor, 200);
    }
    strokeWeight(5);
    rect(0, 0, buttonStand, buttonStand);
    strokeWeight(1);
  }
  aVectorList.clear();
  bVectorList.clear();
  cVectorList.clear();
  dVectorList.clear();
}

void startInstructions() {
  //blablablablabla
  background(200);
  textSize(standard*0.75);
  text("Um ein Spidronarm zu bilden, legen Sie zwei Finger auf das Display. \nWenn Sie Ihre Finger auf das Display legen, entsteht, je nach Anzahl der Finger, ein Spidronring im n-Eck, wobei Ihre Finger die Eckpunkte des Spidronrings darstellen. \nWenn Sie drei Finger auf das Display legen,erscheint durch spiegeln der Eckpunkte am Mittelpukt ein Spidronring im Hexagon. \nUm einen \"schönen\" Spidronring entstehen zu lassen, muss man versuchen, die Finger so zu platzieren, dass der resultierende Spidronring gleichseitig ist. \nWenn man sich das Ergebnis nun dauerhaft ansehen möchte, kann man auf den \"freeze\" Button (links oben) klicken. Widerholtes klicken löscht das Ergebnis. \nDamit ein errechnen eines Spidronrings überhaupt möglich ist, muss man seine Finger konvex (nach außen gewölbt) um deren Mittelpunkt verteilen. \n[Profi: Die Anzahl der Innenverbindungen kann oben rechts eingestellt werden. Bei 0 erscheint also nur das n-Eck, bei 1 die erste Ebene, bei zwei die ersten beiden Ebenen, etc.]", width/8, textAnfangState0, width/8*6, 1280);
}

//wähle Aktion
void filter() {
  switch(points.size()) {
  case 0:
    currVal = colors.get((int)random(0, colors.size()));
    fill(0);
    textSize(standard);
    textAlign(CENTER, CENTER);
    text("_", width-standard*2, standard-standard/2);
    text("+", width-standard, standard);
    text(maxDrawNum, width-standard*3.5, standard);
    textSize(standard*1.5);
    text("Bitte mindestens 2 Finger \nauf das Display legen!", displayWidth/2, displayHeight/2);
    break;

  case 1:
    fill(0);
    textSize(standard);
    textAlign(CENTER, CENTER);
    text("_", width-standard*2, standard-standard/2);
    text("+", width-standard, standard);
    text(maxDrawNum, width-standard*3.5, standard);
    textSize(standard*1.5);
    text("Bitte mindestens 2 Finger \nauf das Display legen!", displayWidth/2, displayHeight/2);
    break;

  case 2:   
    background(green.rColor, green.gColor, green.bColor);
    if (points.get(1).x > points.get(0).x) {
      PVector he=points.get(1);
      PVector he2=points.get(0);
      points.clear();
      points.add(he);
      points.add(he2);
    }
    drawSpidron(points.get(0), points.get(1));
    break;

  case 3:  
    background(green.rColor, green.gColor, green.bColor);
    rechne();
    polygon();
    break;

  case 4:
    sortPoints(points);
    fill(currVal.rColor, currVal.gColor, currVal.bColor);
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    break;

  default:
    polygon();
  }
}

void mousePressed() {
  if (state==1) {
    if (mouseIsInside(width-standard*1.5, buttonStand, width, 0)&&!freeze) {
      maxDrawNum++;
      println(maxDrawNum);
    } else if (mouseIsInside(width-standard*3, buttonStand, width-standard, 0)&&!freeze) {
      maxDrawNum--;
      if (maxDrawNum<0) {
        maxDrawNum=0;
      }
      println(maxDrawNum);
    }
  } else if (mouseIsInside(width/8, 0, width/8*6, height)&&points.size()==1) {
    state0ScrollVec=new PVector(points.get(0).x, points.get(0).y);
  }
}

void mouseReleased() {
  if (mouseIsInside(width/8, 0, width/8 * 7, height)&&state==0) {
    textAnfangState0-=state0ScrollVec.y-mymouse.y;
  }
  if(textAnfangState0 > buttonStand*2){
    textAnfangState0=int(buttonStand*2);
  }else if(textAnfangState0+1280 < height-buttonStand*2){
    textAnfangState0=-1280+height-int(buttonStand*2);
  }
}

//leitet n-eck funktionen ein
void polygon() {
  durchschnittsVektor = new PVector();
  for (PVector p : points) {
    durchschnittsVektor.add(p);
  }
  durchschnittsVektor.div(points.size());

  sortPoints(points);
  convex=saveConvex();
  if (convex) {
    background(green.rColor, green.gColor, green.bColor);
  } else {
    background(red.rColor, red.gColor, red.bColor);
  }
  connect(points);
}

//aktualisiere points
void refresh(boolean save) {
  background(255, 255, 255);
  if (touches.length==1&&state==0) {
    mymouse=new PVector(touches[0].x, touches[0].y);
  }
  for (int i=0; i<touches.length; i++) {
    if (!mouseIsInsideAdv(0, 0, buttonStand, buttonStand, new PVector(touches[i].x, touches[i].y))) {
      points.add(new PVector(touches[i].x, touches[i].y));
    }
  }
  if (save) {
    for (int i=0; i<touches.length; i++) {
      if (mouseIsInsideAdv(0, 0, buttonStand, buttonStand, new PVector(touches[i].x, touches[i].y))) {
        freeze=true;
        for (PVector e : points) {
          oldpoints.add(e);
        }
      }
    }
  }
}


void freezerefresh() {
  for (PVector e : oldpoints) {
    points.add(e);
  }
  //for (int i=0; i<touches.length; i++) {
  //  if (mouseIsInsideAdv(0, 0, buttonStand, buttonStand, new PVector(touches[i].x, touches[i].y))) {
  if (mouseIsInside(0, 0, buttonStand, buttonStand)) {
    freeze=false;
    oldpoints.clear();
    refresh(true);
    return;
  }
  //}
}


void rechne() {
  durchschnittsVektor=new PVector();
  for (PVector p : points) {
    durchschnittsVektor.add(p);
  }
  durchschnittsVektor.div(points.size());
  ArrayList<PVector> punktelo=new ArrayList();
  for (PVector p : points) {
    punktelo.add(p);
  }

  for (PVector p : points) {
    PVector he=durchschnittsVektor.copy().sub(p);
    punktelo.add(p.copy().add(he.copy().mult(2)));
  }

  points.clear();
  for (PVector p : punktelo) {
    points.add(p);
  }

  durchschnittsVektor=new PVector();
  for (PVector p : points) {
    durchschnittsVektor.add(p);
  }
  durchschnittsVektor.div(points.size());
}
