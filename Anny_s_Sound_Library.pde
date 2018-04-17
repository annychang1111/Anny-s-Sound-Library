import processing.sound.*;
SoundFile kick, snare, hihat, hihatO, tom1, tom2, cymbal1, cymbal2, shaker, claps, percussions1, percussions2;
SoundFile pA1, pA2, pB0, pCU2, pCU3, pD4, pD5, pE2, pFU1, pF5, pF6, pGU3;
SoundFile fAU3, fA2, fA3, fC2, fC3, fC4, fDU2, fDU3, fD2, fD4, fFU2, fFU3;
SoundFile tD1, tE1, tFU1, tG1, tA1, tB1, tC2, tCU2, tD2, tE2, tFU2, tG2;
SoundFile station;

ArrayList<Circle> drumCircles;
int [] numbers = new int [192];

ArrayList<Circle> pianoCircles;
int [] numbersP = new int [192];

ArrayList<Circle> fluteCircles;
int [] numbersF = new int [192];

ArrayList<Circle> tinCircles;
int [] numbersT = new int [192];

int stage = 0;

int column = 16;
int row = 12;
int circleSize = 20;
int w = 1280;
int h = 720;

int counter = 0;
int beat;
int sound;
int beatNow;

boolean startOver;
boolean instrumentOver;
boolean clearOver;
boolean stationOver;
boolean stationPlaying = false;
boolean helpOver;
boolean helpShowing = true;
PImage instrumentChosen;
PImage pBig, fBig, dBig, wBig;
PImage stationPic, helpPic;
PImage instruction;

PFont font;
PFont fontI;

void setup(){
  //red: #ee5260
  //light grey: #dbdbdb
  fill(0, 0, 0, 20);
  rect(0, 0, width, height);
  stroke(0);
  strokeWeight(1.5);
  smooth();
  fullScreen();
  //size(1280, 720);
  frameRate(4);
  

  drumCircles = new ArrayList<Circle>();
  pianoCircles = new ArrayList<Circle>();
  fluteCircles = new ArrayList<Circle>();
  tinCircles = new ArrayList<Circle>();
  
  //add circles
  for(int i = 0; i < column; i++){
    for(int j = 0; j <row; j++){
      drumCircles.add(new Circle(i*w/column + w/column, j*h/row + h/row/2));
    }
  }
  
  for(int i = 0; i < column; i++){
    for(int j = 0; j <row; j++){
      pianoCircles.add(new Circle(i*w/column + w/column, j*h/row + h/row/2));
    }
  }
  
  for(int i = 0; i < column; i++){
    for(int j = 0; j <row; j++){
      fluteCircles.add(new Circle(i*w/column + w/column, j*h/row + h/row/2));
    }
  }
  
  for(int i = 0; i < column; i++){
    for(int j = 0; j <row; j++){
      tinCircles.add(new Circle(i*w/column + w/column, j*h/row + h/row/2));
    }
  }
  
  drumLoad();
  pianoLoad();
  fluteLoad();
  tinLoad();
  station = new SoundFile(this, "station.wav");
  
  pBig = loadImage("pBig-01.png");
  fBig = loadImage("fBig-01.png");
  dBig = loadImage("dBig-01.png");
  wBig = loadImage("wBig-01.png");
  stationPic = loadImage("station.jpg");
  helpPic = loadImage("help.jpg");
  instruction = loadImage("instruction.png");
  
  font = createFont("RobotoMono-Light.ttf", 20);
  fontI = createFont("RobotoMono-LightItalic.ttf", 20);

}

void draw(){
  if(stage == 0){
    //clear dots
    for(int i = 0; i < drumCircles.size(); i++){
      drumCircles.clear();
    }
    for(int i = 0; i < pianoCircles.size(); i++){
      pianoCircles.clear();
    }
    for(int i = 0; i < fluteCircles.size(); i++){
      fluteCircles.clear();
    }
    for(int i = 0; i < tinCircles.size(); i++){
      tinCircles.clear();
    }
    
    //announce class again 
    for(int i = 0; i < column; i++){
      for(int j = 0; j <row; j++){
        drumCircles.add(new Circle(i*w/column + w/column, j*h/row + h/row/2));
      }
    }  
    for(int i = 0; i < column; i++){
      for(int j = 0; j <row; j++){
        pianoCircles.add(new Circle(i*w/column + w/column, j*h/row + h/row/2));
      }
    }    
    for(int i = 0; i < column; i++){
      for(int j = 0; j <row; j++){
        fluteCircles.add(new Circle(i*w/column + w/column, j*h/row + h/row/2));
      }
    }
    for(int i = 0; i < column; i++){
      for(int j = 0; j <row; j++){
        tinCircles.add(new Circle(i*w/column + w/column, j*h/row + h/row/2));
      }
    }
     
    background(255);
    showText("Anny's Sound Library", 0, 0, 70, color(#ee5260));
    //showText("Cilck a dot to begin your visual sound journey!", 0, +60, 20, color(0));
    showText("<START>", 0, +70, 25, color(0));
  }
  
  if(stage != 0){
    background(255);
    rectMode(CENTER);
    fill(0);
    rect(width/2, height/2, width-15, height-15);
    fill(255);
    rect(width/2, height/2, width-20, height-20);
    
    fill(0);
    textFont(fontI, 15);
    textAlign(CENTER, CENTER);
    text("Anny's Sound Library", 110, height-25);
       
    showText("<Clear>", 0, height/2-30, 20, color(0));
    
    counter++;
    beat = counter/1;
    
    if(stage == 3){
    //draw circles, if circles mouse over
      for(int i = 0; i < drumCircles.size(); i++){
        drumCircles.get(i).display();
        drumCircles.get(i).overCircle();
      }
    }else if(stage == 1){
      for(int i = 0; i < pianoCircles.size(); i++){
        pianoCircles.get(i).display();
        pianoCircles.get(i).overCircle();
      }
    }else if(stage == 2){
      for(int i = 0; i < fluteCircles.size(); i++){
        fluteCircles.get(i).display();
        fluteCircles.get(i).overCircle();
      }
    }else if(stage == 4){
      for(int i = 0; i < tinCircles.size(); i++){
        tinCircles.get(i).display();
        tinCircles.get(i).overCircle();
      }
    }
    
    beatOn();
    beatPressed(3);
    beatPressed(1);
    beatPressed(2);
    beatPressed(4);
  
    instrumentPic();
    instrumentChosen.resize(40, 40);
    imageMode(CORNER);
    image(instrumentChosen, width/2+60, height-55);
    stationPic.resize(40, 40);
    image(stationPic, width/2-100, height-54);
    helpPic.resize(30, 30);
    image(helpPic, width-40, height-45);
    
    //help showing
    if(helpShowing == true){
      fill(214, 214, 214, 240);
      rectMode(CORNER);
      rect(width/2 + 340, height/2 - 60, 300, 400);
      instruction.resize(300, 400);
      image(instruction, width/2 + 340, height/2 - 60);
    }else if(helpShowing == false){
    }
    
  }
}

void showText(String text, int xPosMov, int yPosMov, int size, color textColor){
  fill(textColor);
  textFont(font, size);
  textAlign(CENTER, CENTER);
  text(text, width/2+xPosMov, height/2+yPosMov);
}

void mousePressed(){
  //circles mouse press 
  if(stage == 3){
    for(int i = 0; i < drumCircles.size(); i++){
      drumCircles.get(i).mousePressed();
    }
  }else if(stage == 1){
    for(int i = 0; i < pianoCircles.size(); i++){
      pianoCircles.get(i).mousePressed();
    }
  }else if(stage == 2){
    for(int i = 0; i < fluteCircles.size(); i++){
      fluteCircles.get(i).mousePressed();
    }
  }else if(stage == 4){
    for(int i = 0; i < tinCircles.size(); i++){
      tinCircles.get(i).mousePressed();
    }
  }
 
  instrumentOver();
  if(instrumentOver == true){
    if(stage == 0){
      stage = 1;
    }else if(stage == 1){
      stage = 2;
    }else if(stage == 2){
      stage = 3;
    }else if(stage == 3){
      stage = 4;
    }else if(stage == 4){
      stage = 1;
    }
  }
 
  clearOver();
  if(clearOver == true){
    stage = 0;
    soundStop();
  }
 
  startOver();
  if(startOver == true){
    stage = 1; 
  }
  
  stationOver();
  if(stationOver == true && stationPlaying == false){
    station.play();
    stationPlaying = true;
  }else if(stationOver == true && stationPlaying == true){
    station.stop();
    stationPlaying = false;
  }
  
  helpOver();
  if(helpOver == true && helpShowing == true){
    helpShowing = false;
  }else if(helpOver == true && helpShowing == false){
    helpShowing = true;
  }
 
}

void beatOn(){
  for(int i = 0; i < row; i++){
    fill(#ee5260);
    ellipse(beat%16*w/column + w/column, i*h/row + h/row/2, circleSize, circleSize);
  }
  
}

void beatPressed(int getInstrument){
  if(getInstrument == 3){
    for(int i = 0; i < drumCircles.size(); i++){ 
      if(drumCircles.get(i).getMode() == 1){
          numbers[i] = i;
          if(beat%16 == numbers[i]/12){
            getDrumSound(numbers[i]%12);
            drumTrigger();
          }
      }
    }
  }else if(getInstrument == 1){
    for(int i = 0; i < pianoCircles.size(); i++){ 
      if(pianoCircles.get(i).getMode() == 1){
          numbers[i] = i;
          if(beat%16 == numbers[i]/12){
            getPianoSound(numbers[i]%12);
            pianoTrigger();
          }
      }
    }
  }else if(getInstrument == 2){
    for(int i = 0; i < fluteCircles.size(); i++){ 
      if(fluteCircles.get(i).getMode() == 1){
          numbers[i] = i;
          if(beat%16 == numbers[i]/12){
            getFluteSound(numbers[i]%12);
            fluteTrigger();
          }
      }
    }
  }else if(getInstrument == 4){
    for(int i = 0; i < tinCircles.size(); i++){ 
      if(tinCircles.get(i).getMode() == 1){
          numbers[i] = i;
          if(beat%16 == numbers[i]/12){
            getTinSound(numbers[i]%12);
            tinTrigger();
          }
      }
    }
  }
}

void drumTrigger(){
  imageMode(CENTER);
  image(dBig, random(width/4, width*3/4), random(height/4, height*3/4));
}

void pianoTrigger(){
  imageMode(CENTER);
  image(pBig, random(width/4, width*3/4), random(height/4, height*3/4));
}

void fluteTrigger(){
  imageMode(CENTER);
  image(fBig, random(width/4, width*3/4), random(height/4, height*3/4));
}

void tinTrigger(){
  imageMode(CENTER);
  image(wBig, random(width/4, width*3/4), random(height/4, height*3/4));
}

void startOver(){
  if(width/2 - 45 < mouseX && mouseX < width/2 + 45 && height/2 + 55 < mouseY && mouseY < height/2 + 85){
    startOver = true;
  }else{
    startOver = false;
  }
}

void instrumentOver(){
  if(width/2 + 60 < mouseX && mouseX < width/2 + 100 && height - 55 < mouseY && mouseY < height - 15){
    instrumentOver = true;
  }else{
    instrumentOver = false;
  }
}

void stationOver(){
  if(width/2 - 100 < mouseX && mouseX < width/2 - 60 && height - 54 < mouseY && mouseY < height - 14){
    stationOver = true;
  }else{
    stationOver = false;
  }
}

void helpOver(){
  if(width - 40 < mouseX && mouseX < width - 10 && height - 45 < mouseY && mouseY < height - 15){
    helpOver = true;
  }else{
    helpOver = false;
  }
}

void clearOver(){
  if(width/2 - 35 < mouseX && mouseX < width/2 + 35 && height - 40 < mouseY && mouseY < height - 20){
    clearOver = true;
  }else{
    clearOver = false;
  }
}

void instrumentPic(){
  if(stage == 3){
    instrumentChosen = loadImage("dSmall.jpg");
  }else if(stage == 1){
    instrumentChosen = loadImage("pSmall.jpg");
  }else if(stage == 2){
    instrumentChosen = loadImage("fSmall.jpg");
  }else if(stage == 4){
    instrumentChosen = loadImage("wSmall.jpg");
  }
}

void drumLoad(){
  kick = new SoundFile(this, "kick.wav");
  snare = new SoundFile(this, "snare.wav");
  hihat = new SoundFile(this, "hihat.wav");
  hihatO = new SoundFile(this, "hihato.wav");
  tom1 = new SoundFile(this, "tom1.wav");
  tom2 = new SoundFile(this, "tom2.wav");
  cymbal1 = new SoundFile(this, "cymbal1.wav");
  cymbal2 = new SoundFile(this, "cymbal2.wav");
  shaker = new SoundFile(this, "shaker.wav");
  claps = new SoundFile(this, "claps.wav");
  percussions1 = new SoundFile(this, "percussions1.wav");
  percussions2 = new SoundFile(this, "percussions2.wav");
}

void pianoLoad(){
  pA1 = new SoundFile(this, "pnoA1.wav");
  pA2 = new SoundFile(this, "pnoA2.wav");
  pB0 = new SoundFile(this, "pnoB0.wav");
  pCU2 = new SoundFile(this, "pnoC#2.wav");
  pCU3 = new SoundFile(this, "pnoC#3.wav");
  pD4 = new SoundFile(this, "pnoD4.wav");
  pD5 = new SoundFile(this, "pnoD5.wav");
  pE2 = new SoundFile(this, "pnoE2.wav");
  pFU1 = new SoundFile(this, "pnoF#1.wav");
  pF5 = new SoundFile(this, "pnoF5.wav");
  pF6 = new SoundFile(this, "pnoF6.wav");
  pGU3 = new SoundFile(this, "pnoG#3.wav");
}

void fluteLoad(){
  fAU3 = new SoundFile(this, "fA#3.wav");
  fA2 = new SoundFile(this, "fA2.wav");
  fA3 = new SoundFile(this, "fA3.wav");
  fC2 = new SoundFile(this, "fC2.wav");
  fC3 = new SoundFile(this, "fC3.wav");
  fC4 = new SoundFile(this, "fC4.wav");
  fDU2 = new SoundFile(this, "fD#2.wav");
  fDU3 = new SoundFile(this, "fD#3.wav");
  fD2 = new SoundFile(this, "fD2.wav");
  fD4 = new SoundFile(this, "fD4.wav");
  fFU2 = new SoundFile(this, "fF#2.wav");
  fFU3 = new SoundFile(this, "fF#3.wav");
}

void tinLoad(){
  tD1 = new SoundFile(this, "tD1.wav");
  tE1 = new SoundFile(this, "tE1.wav");
  tFU1 = new SoundFile(this, "tF#1.wav");
  tG1 = new SoundFile(this, "tG1.wav");
  tA1 = new SoundFile(this, "tA1.wav");
  tB1 = new SoundFile(this, "tB1.wav");
  tC2 = new SoundFile(this, "tC2.wav");
  tCU2 = new SoundFile(this, "tC#2.wav");
  tD2 = new SoundFile(this, "tD2.wav");
  tE2 = new SoundFile(this, "tE2.wav");
  tFU2 = new SoundFile(this, "tF#2.wav");
  tG2 = new SoundFile(this, "tG2.wav");
}

void getDrumSound(int drumChosen){
  if(drumChosen == 0){
    hihatO.play();
    dBig.resize(450, 450);
  }else if(drumChosen == 1){
    hihat.play();
    dBig.resize(400, 400);
  }else if(drumChosen == 2){
    snare.play();
    dBig.resize(500, 500);
  }else if(drumChosen == 3){
    kick.play();
    dBig.resize(600, 600);
  }else if(drumChosen == 4){
    tom1.play();
    dBig.resize(550, 550);
  }else if(drumChosen == 5){
    tom2.play();
    dBig.resize(550, 550);
  }else if(drumChosen == 6){
    cymbal1.play();
    dBig.resize(400, 400);
  }else if(drumChosen == 7){
    cymbal2.play();
    dBig.resize(400, 400);
  }else if(drumChosen == 8){
    shaker.play();
    dBig.resize(300, 300);
  }else if(drumChosen == 9){
    claps.play();
    dBig.resize(450, 450);
  }else if(drumChosen == 10){
    percussions1.play();
    dBig.resize(200, 200);
  }else if(drumChosen == 11){
    percussions2.play();
    dBig.resize(200, 200);
  }
}

void getPianoSound(int pianoChosen){
  if(pianoChosen == 0){
    pB0.play();
    pBig.resize(520, 520);
  }else if(pianoChosen == 1){
    pFU1.play();
    pBig.resize(510, 510);
  }else if(pianoChosen == 2){
    pA1.play();
    pBig.resize(500, 500);
  }else if(pianoChosen == 3){
    pCU2.play();
    pBig.resize(480, 480);
  }else if(pianoChosen == 4){
    pE2.play();
    pBig.resize(470, 470);
  }else if(pianoChosen == 5){
    pA2.play();
    pBig.resize(460, 460);
  }else if(pianoChosen == 6){
    pCU3.play();
    pBig.resize(450, 450);
  }else if(pianoChosen == 7){
    pGU3.play();
    pBig.resize(440, 440);
  }else if(pianoChosen == 8){
    pD4.play();
    pBig.resize(430, 430);
  }else if(pianoChosen == 9){
    pD5.play();
    pBig.resize(420, 420);
  }else if(pianoChosen == 10){
    pF5.play();
    pBig.resize(410, 410);
  }else if(pianoChosen == 11){
    pF6.play();
    pBig.resize(400, 400);
  }
}

void getFluteSound(int fluteChosen){
  if(fluteChosen == 0){
    fC2.play();
    fBig.resize(460, 460);
  }else if(fluteChosen == 1){
    fD2.play();
    fBig.resize(450, 450);
  }else if(fluteChosen == 2){
    fDU2.play();
    fBig.resize(440, 440);
  }else if(fluteChosen == 3){
    fFU2.play();
    fBig.resize(430, 430);
  }else if(fluteChosen == 4){
    fA2.play();
    fBig.resize(420, 420);
  }else if(fluteChosen == 5){
    fC3.play();
    fBig.resize(410, 410);
  }else if(fluteChosen == 6){
    fDU3.play();
    fBig.resize(400, 400);
  }else if(fluteChosen == 7){
    fFU3.play();
    fBig.resize(390, 390);
  }else if(fluteChosen == 8){
    fA3.play();
    fBig.resize(380, 380);
  }else if(fluteChosen == 9){
    fAU3.play();
    fBig.resize(370, 370);
  }else if(fluteChosen == 10){
    fC4.play();
    fBig.resize(360, 360);
  }else if(fluteChosen == 11){
    fD4.play();
    fBig.resize(350, 350);
  }
}

void getTinSound(int tinChosen){
  if(tinChosen == 0){
    tD1.play();
    wBig.resize(460, 460);
  }else if(tinChosen == 1){
    tE1.play();
    wBig.resize(450, 450);
  }else if(tinChosen == 2){
    tFU1.play();
    wBig.resize(440, 440);
  }else if(tinChosen == 3){
    tG1.play();
    wBig.resize(430, 430);
  }else if(tinChosen == 4){
    tA1.play();
    wBig.resize(420, 420);
  }else if(tinChosen == 5){
    tB1.play();
    wBig.resize(410, 410);
  }else if(tinChosen == 6){
    tC2.play();
    wBig.resize(400, 400);
  }else if(tinChosen == 7){
    tCU2.play();
    wBig.resize(390, 390);
  }else if(tinChosen == 8){
    tD2.play();
    wBig.resize(380, 380);
  }else if(tinChosen == 9){
    tE2.play();
    wBig.resize(370, 370);
  }else if(tinChosen == 10){
    tFU2.play();
    wBig.resize(360, 360);
  }else if(tinChosen == 11){
    tG2.play();
    wBig.resize(350, 350);
  }
}

void soundStop(){
  kick.stop();
  snare.stop();
  hihat.stop();
  hihatO.stop();
  tom1.stop();
  tom2.stop();
  cymbal1.stop();
  cymbal2.stop();
  shaker.stop();
  claps.stop();
  percussions1.stop();
  percussions2.stop();
  
  pA1.stop();
  pA2.stop();
  pB0.stop();
  pCU2.stop();
  pCU3.stop();
  pD4.stop();
  pD5.stop();
  pE2.stop();
  pFU1.stop();
  pF5.stop();
  pF6.stop();
  pGU3.stop();
  
  fAU3.stop();
  fA2.stop();
  fA3.stop();
  fC2.stop();
  fC3.stop();
  fC4.stop();
  fDU2.stop();
  fDU3.stop();
  fD2.stop();
  fD4.stop();
  fFU2.stop();
  fFU3.stop();
  
  tD1.stop();
  tE1.stop();
  tFU1.stop();
  tG1.stop();
  tA1.stop();
  tB1.stop();
  tC2.stop();
  tCU2.stop();
  tD2.stop();
  tE2.stop();
  tFU2.stop();
  tG2.stop();
  
  station.stop();
  
}