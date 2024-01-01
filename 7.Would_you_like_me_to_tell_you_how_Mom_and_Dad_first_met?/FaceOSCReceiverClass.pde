


import oscP5.*;
OscP5 oscP5;
import netP5.*;
NetAddress dest;
import ddf.minim.*;


//for music
Minim minim;
AudioPlayer player;


// our FaceOSC tracked face dat
Face face = new Face();
PVector  vertice= new PVector();
PImage img;
PImage bgimg;
PFont font;

float bgimg_ratio=640/480;
int bgimg_x=700;
float bgimg_y=bgimg_x*bgimg_ratio;

int col=0;


//for lips
int lips_right=width/2+606;
int lips_width=80;
int lips_y=417;
float mouth_height;
float mouth_height_closed=410;
float mouth_height_opened=430;

//wekinator output data
int kiss;

//walking
PImage[] walkcycle_male = new PImage[8];
PImage[] walkcycle_female= new PImage[8];

// the index of the current walkcycle element to show
int frameToShow = 0;
// position of image
int xx = 0;
// timer to count frames between updates of x and frameToShow
int time = 0;
boolean walking_finished=false;


int imgCenterX=400;
int imgCenterY=300;


String text1 = "Would you like me to tell you";
String text2 = "how Mom and Dad first met";
String text3="We met for the first time on a bridge";
String text4="in the middle of the night";
String text5="That day was our very first date";




void setup() {
  size(1000, 800);
  frameRate(30);
  oscP5 = new OscP5(this, 12000);// wekinator port = 6448, proceesing = 12000
  dest = new NetAddress("127.0.0.1", 6448); //wekinator
  
  img=loadImage("face1.png");
  bgimg=loadImage("bridge1.png");
  font=createFont("peacechild-beta.ttf",10);
 
  for (int i = 1; i <= 8; i++) {
     walkcycle_male[i-1] = loadImage("male/Walk" + (i) + ".png");
    walkcycle_female[i-1] = loadImage("female/Walk" + (i) + ".png");
  }
  
   // Minim 초기화
  minim = new Minim(this);
  
  // 음악 파일 로드
  player = minim.loadFile("LaVieenRose.mp3");
  
  // 음악 재생
  player.play();
  

  

  
}


void draw() {  
  background(0);

  ImageFunction(bgimg,400,300);
  
  
  image(img,width/2+50,height/2+100,300,300);
 stroke(255);
 strokeWeight(5);
 noFill();
 

  if (frameCount % 3 == 0)
 {  
  if(face.found > 0) {
    
    sendOsc_float(face.FaceOSCData);
  }
  
    
 
 

  if(face.mouthHeight<1.18){mouth_height=mouth_height_closed;}
  else if(face.mouthHeight>1.35){mouth_height=mouth_height_opened;}
  else{
 mouth_height=map(face.mouthHeight,1,2,400,440);}
 
 } //framecount if문 완료 - mouth가 자연스럽게 그려지기 
 
  // bezier 위치를 이동하기 위해 translate 사용
  pushMatrix();
  translate(50, 300);
 
  bezier(lips_right-lips_width, lips_y, 612, mouth_height, 612,mouth_height, lips_right, lips_y-5);
   bezier(lips_right-lips_width, lips_y, 612,height-(mouth_height)+20, 612, height- (mouth_height)+20, lips_right, lips_y-5);
   popMatrix();
  
  
  if(kiss==1){
   
  if (time > 10) {
  
    
    if(!walking_finished)
    {
    xx += 7;}

    
    frameToShow += 1;

  
    if (frameToShow >= walkcycle_male.length) {
      frameToShow = 0;
    }
    
  
    time = 0;
  }
  time++;
  }
  

  
  

}

// OSC CALLBACK FUNCTIONS

void oscEvent(OscMessage m) {
   face.parseOSC(m);
    if (m.checkAddrPattern("/wek/outputs")==true) {
     kiss = (int)m.get(0).floatValue();
    
    
   
    
    }
     
 
  
}


void sendOsc_float(float[] mg) {
  OscMessage msg = new OscMessage("/wek/inputs");
 
  msg.add(mg);
  oscP5.send(msg, dest);
}


void ImageFunction(PImage img,int imgCenterX,int imgCenterY){
  
 pushMatrix();
  translate(imgCenterX, imgCenterY);
  
 
  imageMode(CENTER);
  image(img, 0, 0, bgimg_x, bgimg_y);


  
  // Draw the male walkcycle
  walkcycle_male[frameToShow].resize(36, 60);
  image(walkcycle_male[frameToShow],-bgimg_x/2+30+xx, 80);

  // Draw the female walkcycle
  walkcycle_female[frameToShow].resize(36, 60);
  //pushMatrix();
  scale(-1, 1);
  image(walkcycle_female[frameToShow], -(bgimg_x/2-30 - xx), 80);
 // popMatrix();

  
 

if(-bgimg_x/2+46+xx>0)
{walking_finished=true;



}
if(kiss==1){
  
 
     
  heart(0,-80,150);}

  
  // 좌표 이동 상태 복원
  popMatrix();
  
  imageMode(CORNER);

  TextDisplay();
  

}

void heart(int x, int y, int size) {
  //noFill();
  noStroke();
    fill(240,159,125,100);
  beginShape();
  vertex(x, y);
  bezierVertex(x - size/2, y - size / 2, x - size, y + size / 3, x, y + size);
  bezierVertex(x + size, y + size / 3, x + size/2, y - size / 2, x, y);
  endShape(CLOSE);
}




void stop() {
  // 프로그램 종료 시 Minim stop.
  player.close();
  minim.stop();
  super.stop();
}

void TextDisplay(){
  
  textFont(font);

 fill(255, 255, 255); // 텍스트 투명도 설정
  textSize(30);
  text(text1,50,600);
  text(text2,50,630);
  text(text3,50,660);
   text(text4,50,690);
     text(text5,50,720);
  

}
  
