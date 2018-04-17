class Circle{
  
  color currentColor;
  color black = color(0, 0, 0, 95);
  color white = color(255);
  color strokeColor = color(0);
  boolean circleOver;
  int circleX, circleY;
  int circleSize = 20;
  int mode = 0;
  
  Circle(int _xpos, int _ypos){
    circleX = _xpos;
    circleY = _ypos;
    currentColor = white;
  }
  
  void display(){
    stroke(strokeColor);
    strokeWeight(1.5);
    fill(currentColor);
    ellipse(circleX, circleY, circleSize, circleSize);
  }
  
  
  void overCircle(){
    float disX = circleX-mouseX;
    float disY = circleY-mouseY;
    if(sqrt(sq(disX) + sq(disY)) < circleSize/2){
      circleOver = true;
      strokeColor = color(#ee5260);
    }else{
      circleOver = false;
      strokeColor = color(0);
    }
  }
  
  void mousePressed(){
    if (circleOver && currentColor  == black){
      currentColor = white;
      mode = 0;
    }else if(circleOver && currentColor == white){
      currentColor = black;
      mode = 1;
    }  
  }
  
  int getMode(){
    return mode;
  }

}