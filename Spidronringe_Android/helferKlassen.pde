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

boolean mouseIsInside(float x1,float y1,float x2,float y2) {
  
 float lowX=Math.min(x1,x2);
 float lowY=Math.min(y1,y2);
 float highX=Math.max(x1,x2);
 float highY=Math.max(y1,y2);
  
 return(mouseX> lowX && mouseX<highX && mouseY>lowY && mouseY< highY);
  
} 


boolean mouseIsInsideAdv(float x1,float y1,float x2,float y2,PVector pos) {
  
 float lowX=Math.min(x1,x2);
 float lowY=Math.min(y1,y2);
 float highX=Math.max(x1,x2);
 float highY=Math.max(y1,y2);
  
 return(pos.x> lowX && pos.x<highX && pos.y>lowY && pos.y< highY);
  
} 
