class Color {
  int rColor;
  int gColor;
  int bColor;

  Color(int rColor, int gColor, int bColor) {
    this.rColor=rColor;
    this.gColor=gColor;
    this.bColor=bColor;
  }
}

class ResPoints {
  PVector c;
  PVector d;

  ResPoints(PVector c, PVector d) {
    this.c=c;
    this.d=d;
  }
}

boolean mouseIsInside(float x1, float y1, float x2, float y2) {

  float lowX=Math.min(x1, x2);
  float lowY=Math.min(y1, y2);
  float highX=Math.max(x1, x2);
  float highY=Math.max(y1, y2);

  return(mouseX> lowX && mouseX<highX && mouseY>lowY && mouseY< highY);
} 

boolean mouseAndPosWereInside(float x1, float y1, float x2, float y2, String rectMode) {
  float positionX=float(touchStartedX);
  float positionY=float(touchStartedY);
  float lowX=0;
  float highX=0;
  float lowY=0;
  float highY=0;
  switch(rectMode) {
  case "CORNERS":
    lowX=Math.min(x1, x2);
    lowY=Math.min(y1, y2);
    highX=Math.max(x1, x2);
    highY=Math.max(y1, y2);
    break;
  case "CORNER":
    lowX=x1;
    highX=x1+x2;
    lowY=y1;
    highY=y1+y2;
    break;
  case "CENTER":
    lowX=x1-x2/2;
    highX=x1+x2/2;
    lowY=y1-y2/2;
    highY=y1+y2/2;
    break;
  }
  if (pmouseX> lowX && pmouseX<highX && pmouseY>lowY && pmouseY< highY && positionX>lowX && positionX<highX && positionY>lowY && positionY<highY) {//
    return true;
  }
  return false;
}

boolean mouseIsInsideAdv(float x1, float y1, float x2, float y2, PVector pos) {

  float lowX=Math.min(x1, x2);
  float lowY=Math.min(y1, y2);
  float highX=Math.max(x1, x2);
  float highY=Math.max(y1, y2);

  return(pos.x> lowX && pos.x<highX && pos.y>lowY && pos.y< highY);
} 

class ImageField {
  PImage image=new PImage();
  float xPos;
  float yPos;
  float pictureWidth;
  float pictureHeight;
  int imageMode;
  String imageModeString;

  ImageField() {
  }

  ImageField(PImage image, float xPos, float yPos, float pictureWidth, float pictureHeight, int imageMode, String imageModeString) {
    this.image=image;
    this.xPos=xPos;
    this.yPos=yPos;
    this.pictureWidth=pictureWidth;
    this.pictureHeight=pictureHeight;
    this.imageMode=imageMode;
    this.imageModeString=imageModeString;
  }

  void show() {
    imageMode(imageMode);
    image(image, xPos, yPos, pictureWidth, pictureHeight);
  }

  boolean mouseAndPosWereInsideImageField() {
    return mouseAndPosWereInside(xPos, yPos, pictureWidth, pictureHeight, imageModeString);
  }
}

void drawTransition(float startX, float startY, float transitionLength, float transitionLong, float steps, int strongness, String direction) {
  noStroke();
  rectMode(CORNERS);
  if (steps>transitionLength)steps=transitionLength;
  switch(direction) {
  case "right":
    for (int i=0; i < steps; i++) {
      fill(255, int(i*(255/steps))); 
      rect(startX+i*(transitionLength/steps), startY, startX+(i+1)*(transitionLength/steps)+strongness, startY+transitionLong);
    }
    break;
  case "left":
    for (int i=0; i < steps; i++) {
      fill(255, int(i*(255/steps))); 
      rect(startX-i*(transitionLength/steps), startY, startX-(i+1)*(transitionLength/steps)-strongness, startY+transitionLong);
    }
    break;
  case "up":
    for (int i=0; i < steps; i++) {
      fill(255, int(i*(255/steps))); 
      rect(startX, startY-i*(transitionLength/steps), startX+transitionLong, startY-(i+1)*(transitionLength/steps)-strongness);
    }
    break;
  case "down":
    for (int i=0; i < steps; i++) {
      fill(255, int(i*(255/steps))); 
      rect(startX, startY+i*(transitionLength/steps), startX+transitionLong, startY+(i+1)*(transitionLength/steps)+strongness);
    }
    break;
  }
}

boolean txtExist(String name) {
  boolean result = true;
  try {
    String [] lines=loadStrings(name);
    println(lines[0]);
  }
  catch(Exception e) {
    result=false;
  }
  return result;
}
