import java.util.Collections; //<>//
import java.util.Comparator;
PVector middle;
int n=8;
int state=0;
ArrayList <PVector> points = new ArrayList<PVector>();
ArrayList <Color> colors= new ArrayList<Color>();
ArrayList <PVector> oldpoints = new ArrayList<PVector>();
boolean convex;
Color currVal;
Color green= new Color(255, 255, 255);
Color red= new Color(175, 9, 4);
Color blue = new Color(0, 115, 200);
float standard;
boolean freeze=false;
int touchStartedX;
int erklaerungstextpos;
int touchStartedY;
int erklaerungstextlaenge;
float buttonStand;
PVector state0ScrollVec, mymouse=new PVector();
int textAnfangState0;
int stateScrollBack;
int textanfangsize;
boolean notmove;
// in der android versio  nicht
//PVector[] touches= new PVector[1];
PImage infoImg;
HashMap <String, ImageField> images=new HashMap <String, ImageField>();
void settings() {
  if (txtExist("notfirstrun.txt")) {
    state=1;
  } else {
    String [] values= new String[1];
    values[0]="notfirstrun";
    saveStrings("notfirstrun.txt", values);
    state=0;
  }
}
void setup() {

  middle=new PVector(width/2, height/2);
  standard= height/15; //
  buttonStand=standard*1.2;//1.5; 
  textAnfangState0= height/10;
  //if ((width-height)/3*2+int(height*1.3)<width) {
  //if (width/height==4/3) {
  println("vier zu drei");
  textanfangsize=height/20;
  erklaerungstextpos=(width-int(height*1.3))/2;
  erklaerungstextlaenge = int(height*1.6);
  //} else {
  erklaerungstextpos=width/8;
  erklaerungstextlaenge = int(height*1.6);
  textanfangsize=int(standard*0.75);
  //}

  orientation(LANDSCAPE);
  colors.add(new Color(0, 115, 200));  //blau
  colors.add(new Color(100, 0, 170)); //lila
  colors.add(new Color(216, 111, 197)); //rosa
  colors.add(new Color(211, 34, 34)); //rot
  colors.add(new Color(10, 120, 0));   //grün
  //  colors.add(new Color(242, 242, 56)); // gelb
  colors.add(new Color(255, 255, 255));//weiß
  colors.add(new Color(200, 110, 11)); //orange
  //  colors.add(new Color(4, 201, 196)); //zitron
  //colors.add(new Color(0, 230, 230)); //türkis
  currVal = colors.get((int)random(0, colors.size()));
  infoImg=loadImage("info.png");
  images.put("info", new ImageField(loadImage("info.png"), standard/2, height-buttonStand*2.5-standard/2, buttonStand*2.2, buttonStand*2.2, CORNER, "CORNER"));
  images.put("yes", new ImageField(loadImage("yes.png"), width-buttonStand*2.5-standard/2, height-buttonStand*2.5-standard/2, buttonStand*2.5, buttonStand*2.5, CORNER, "CORNER"));
  images.put("freezegreen", new ImageField(loadImage("freezegreen.png"), standard/2, standard/2, buttonStand*2.5, buttonStand*2.5, CORNER, "CORNER"));
  images.put("freezeblue", new ImageField(loadImage("freezeblue.png"), standard/2, standard/2, buttonStand*2.5, buttonStand*2.5, CORNER, "CORNER"));  
  //minus und plus positionen anpassen 2,5
  images.put("minus", new ImageField(loadImage("minus2.png"), width-buttonStand*2.6*2, buttonStand*1.25+standard/2, buttonStand*2, buttonStand*2, CENTER, "CENTER"));
  images.put("plus", new ImageField(loadImage("plus.png"), width-buttonStand*0.75*2, buttonStand*1.25+standard/2, buttonStand*2, buttonStand*2, CENTER, "CENTER"));
}


void draw() {
  if (state==0 ) {
    images.get("yes").xPos=width-buttonStand*2.5-standard/2;
  } else {
    images.get("plus").xPos=width-buttonStand*0.75*2;
    if (maxDrawNum>=10) {
      images.get("minus").xPos=width-buttonStand*3.1*2;
    } else {
      images.get("minus").xPos=width-buttonStand*2.6*2;
    }
  }
  background(255);

  abbruch = 0;
  points.clear();
  if (freeze==false) {
    refresh(true);
  } else {
    freezerefresh();
  }

  if (state==0) {
    startInstructions();
    if (notmove) {
      if (textAnfangState0-20>=height/10) {
        textAnfangState0-=20;
      } else if (textAnfangState0+20+erklaerungstextlaenge < height-height/10) {
        textAnfangState0+=20 ;
      }
    }
  } else {

    filter();
    if (freeze) {  
      images.get("freezeblue").show();
    } else {  
      images.get("freezegreen").show();
      if (points.size()<2) {
        fill(0);
        textSize(standard);
        textAlign(LEFT, CENTER);
        textSize(buttonStand);
        text("freeze", images.get("freezegreen").xPos+images.get("freezegreen").pictureWidth+standard/2, images.get("freezegreen").yPos+images.get("freezegreen").pictureHeight/2);
        textAlign(CORNER);
        //textSize(buttonStand);
        //text("freeze", images.get("freezegreen").xPos+images.get("freezegreen").pictureWidth+standard/2, images.get("freezegreen").yPos+images.get("freezegreen").pictureHeight/2);
      }
    }
  }
  aVectorList.clear();
  bVectorList.clear();
  cVectorList.clear();
  dVectorList.clear();
}


void startInstructions() {
  background(255);
  fill(0);
  textAlign(CORNER);
  textSize(textanfangsize); //76,8
  String text="Um einen Spidronarm zu bilden, legen Sie zwei Finger auf das Display. \nWenn Sie mehr als zwei Finger auf das Display legen, entsteht, je nach Anzahl der Finger, ein Spidronring im n-Eck, wobei Ihre Finger die Eckpunkte des Spidronrings darstellen. \nWenn Sie drei Finger auf das Display legen, erscheint durch Spiegeln der Eckpunkte am Mittelpukt ein Spidronring im Hexagon. \nUm einen \"schoenen\" Spidronring entstehen zu lassen, muss man versuchen, die Finger so zu platzieren, dass der resultierende Spidronring gleichseitig ist. \nWenn man sich das Ergebnis nun dauerhaft ansehen moechte, kann man auf den \"freeze\" Button (links oben) klicken. Wiederholtes klicken loescht das Ergebnis. \nDamit ein Errechnen eines Spidronrings ueberhaupt moeglich ist, muss man seine Finger konvex (nach aussen gewoelbt) um deren Mittelpunkt verteilen. \n(Profi: Die Anzahl der Innenverbindungen kann oben rechts eingestellt werden. Bei 0 erscheint also nur das n-Eck, bei 1 die erste Ebene, bei zwei die ersten beiden Ebenen, etc.)";
  text(text, erklaerungstextpos, textAnfangState0, height*1.3, erklaerungstextlaenge); // höhe: 3072  width-erklaerungstextpos*1.5 (width-height)/3  width/2+height/2
  fill(255);
  rectMode(CORNER);
  noStroke();
  drawTransition(0, height-height/10, height/10, width, 90, 5, "down");
  drawTransition(0, height/10, height/10, width, 90, 5, "up");
  images.get("yes").show();

  stroke(1);
}


//wähle Aktion
void filter() {
  switch(points.size()) {
  case 0:
    currVal = colors.get((int)random(0, colors.size()));
    fill(0);
    textSize(buttonStand*2);
    textAlign(LEFT, CENTER);
    images.get("plus").show();
    images.get("minus").show();
    text(maxDrawNum, (images.get("minus").xPos+images.get("plus").pictureWidth*0.61), images.get("minus").yPos*0.94);
    textAlign(CENTER, CENTER);
    textSize(standard*1.6);
    text("Bitte mindestens 2 Finger \nauf das Display legen!", displayWidth/2, displayHeight/2);
    fill(255);
    images.get("info").show();
    break;

  case 1:
    fill(0);
    textSize(buttonStand*2);
    textAlign(LEFT, CENTER);
    images.get("plus").show();
    images.get("minus").show();
    text(maxDrawNum, (images.get("minus").xPos+images.get("plus").pictureWidth*0.61), images.get("minus").yPos*0.94);
    textAlign(CENTER, CENTER);
    textSize(standard*1.6);
    text("Bitte mindestens 2 Finger \nauf das Display legen!", displayWidth/2, displayHeight/2);
    fill(255);
    images.get("info").show();
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
    strokeWeight(2);

    line(points.get(0).x, points.get(0).y, points.get(1).x, points.get(1).y);
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

void touchStarted() {
  touchStartedX=mouseX;
  touchStartedY=mouseY;
  if (state==0 &&points.size()==1) {
    notmove=false;
  }
}

void touchEnded() {
  if (state==1 ) {

    if (images.get("info").mouseAndPosWereInsideImageField()) {
      state=0;
    } else if (images.get("plus").mouseAndPosWereInsideImageField()) {
      maxDrawNum++; 
      if (maxDrawNum>15) maxDrawNum=15;
    } else if (images.get("minus").mouseAndPosWereInsideImageField()) {
      maxDrawNum--;
      if (maxDrawNum<0) maxDrawNum=0;
    }// hier anderung von width zu displaywidth wegen homeleiste
    if (maxDrawNum>=10) {
      images.get("minus").xPos=displayWidth-buttonStand*3.1*2;
    } else {
      images.get("minus").xPos=displayWidth-buttonStand*2.6*2;
    }
  } else {
    if (images.get("yes").mouseAndPosWereInsideImageField()) {
      state=1;
      //textAnfangState0=height/10;
    }
  }
  notmove=true;
}

void touchMoved() {
  notmove=false;
  if (touches.length==1&&state==0) {
    textAnfangState0+=int((mouseY-pmouseY)*5/12);
  }
  if (textAnfangState0 > buttonStand*2) {
    textAnfangState0=int(buttonStand*2);
  } else if (textAnfangState0 +erklaerungstextlaenge < height-buttonStand*2) {
    textAnfangState0=int(height-buttonStand*2-erklaerungstextlaenge);
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
  ImageField fregre = images.get("freezegreen");
  for (int i=0; i<touches.length; i++) {
    if ( !mouseIsInsideAdv(fregre.xPos, fregre.yPos, fregre.xPos+fregre.pictureWidth, fregre.yPos+fregre.pictureHeight, new PVector(touches[i].x, touches[i].y))) {
      points.add(new PVector(touches[i].x, touches[i].y));
    } else if (touches.length>2) {
      freeze=true;
      for (PVector e : points) {
        oldpoints.add(e);
      }
    }
  }
}


void freezerefresh() {
  ImageField fregre = images.get("freezeblue");
  for (int i=0; i<touches.length; i++) {
    if (mouseIsInsideAdv(fregre.xPos, fregre.yPos, fregre.xPos+fregre.pictureWidth, fregre.yPos+fregre.pictureHeight, new PVector(touches[i].x, touches[i].y))) {
      freeze=false;
      oldpoints.clear();
      refresh(true);
      return;
    }
  }

  for (PVector e : oldpoints) {
    points.add(e);
  }
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
