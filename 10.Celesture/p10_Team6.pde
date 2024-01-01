import oscP5.*;
OscP5 oscP5;
import netP5.*;
NetAddress dest;


int ML_Out1 = 0; 
int ML_Out2 = 0;
int _case=1;
boolean isrotated=false;
int scale_factor=500;

float x0,y0;
float rotationAngle=0.7;
float angle=radians(18);


// 이미지 이동 애니메이션 위한 변수
float duration = 0.3;  // 이동을 완료하는 데 걸리는 시간 (초)
float startTime;  // 이동 시작 시간



int numTerms = 15; // 등차수열의 항의 개수
float[][] coordinates = new float[numTerms][2]; // 2차원 배열을 선언

PImage[] dimension = new PImage[numTerms];
PImage[] dimension_with_bg = new PImage[numTerms];




PImage backgroundImage;
float scrollSpeed = 2; // 스크롤 속도
float scrollPosition = 0; // 스크롤 위치




void setup() {
  size(1000, 800); 
  
  background(0);
  frameRate(30);
  oscP5 = new OscP5(this, 12000);// wekinator port = 6448, proceesing = 12000
  dest = new NetAddress("127.0.0.1", 6448); //wekinator
  
  
   for (int i = 1; i <= numTerms; i++) {
    dimension[i-1] = loadImage("dimension/"+(i) + ".png");
     dimension[i-1].resize(scale_factor,scale_factor);
   
    dimension_with_bg[i-1] = loadImage("dimension_with_bg/"+(i) + ".png");
     dimension_with_bg[i-1].resize(scale_factor,scale_factor);
    

  }
  
  backgroundImage =loadImage("backgorund.png");
  
  
  
   x0 = 200; // x좌표 등차수열의 초기항
   y0 = 500; // y좌표 등차수열의 초기항
   
   
   for (int i = 0; i < numTerms; i++) {
    coordinates[i][0] = 0 + i * 30; // x좌표의 등차수열
    coordinates[i][1] = 0 + i * (-13); // y좌표의 등차수열
  }
  
  
   for (int i = 0; i < numTerms; i++) {
    println("Point " + i + ": (" + coordinates[i][0] + ", " + coordinates[i][1] + ")");
  }
}
   

  



void draw(){

 

 //if (frameCount % 3 == 0){
   
    ArrangeGesture(x0,y0,_case);
   
 // print("model1",ML_Out1," ");
  //  print("model2",ML_Out1," ");
    

// }

  image(backgroundImage, 0, scrollPosition, width, height);


}


void ArrangeGesture(float x0,float y0,int _case){
  
  float currentTime = millis() / 1000.0 - startTime;


// pushMatrix();

  translate(x0, y0);
  // rotateY(0.1); 
  //x0, y0 - (0,0)이라 가정하고 이미지 정렬 
  
  // if(!isrotated){
 //  rotateY(rotationAngle);
  //rotateX(PI / 4); 
// isrotated=true;}
// else{rotateY(0);}
    // 예시로 Y축을 기준으로 45도 회전  
  imageMode(CENTER);
  
 // popMatrix();
    if(_case==1){
  
   for (int i = 0; i < numTerms; i++) {
     
      
pushMatrix();
//rotateY(-PI/10); 
image(dimension[numTerms-1-i], 0, i*0); 
//image(dimension[numTerms-1-i], coordinates[numTerms-1-i][0], coordinates[numTerms-1-i][1]); 
popMatrix();
  
  }

}
  
  
if(_case==2){
  
if(currentTime<duration){
 // pushMatrix();
 
//popMatrix();
    background(0);}
    
    
    for (int i = 0; i < numTerms; i++) {
      
     float startX=0;
     float startY=0; // 케이브의 중심과 같은 위치 
     
     float targetX=coordinates[numTerms-1-i][0];
     float targetY=coordinates[numTerms-1-i][1];
     
       
     
        if (currentTime < duration) {
       
          
    // 이동 중일 때
    float percentComplete = currentTime / duration;  // 완료된 비율
    float currentX = lerp(startX, targetX, percentComplete);  // x 좌표 보간
    float currentY = lerp(startY, targetY, percentComplete);  // y 좌표 보간
    
 //   float x = coordinates[i][0];
  //  float y = coordinates[i][1];
   // dimension[i].resize(200, 200);
   // scale(scale_factor);
    
  //  image(dimension[i], x, y); // dimension 배열에 저장된 이미지를 좌표 (0, 0)에서 그림
//  pushMatrix();
//rotateY(PI / 4);
// pushMatrix();
//if(angle!=0){
//  pushMatrix();
// pushMatrix();

//rotateY(angle); 
//angle=0;
//}

//translate(currentX, currentY);
//rotateY(angle); 
image(dimension[numTerms-1-i], currentX, currentY);
// popMatrix();
//rotateY(0); 
//isrotated=false;
//}
//else{image(dimension[numTerms-1-i], currentX, currentY);}
 // image(dimension[numTerms-1-i], currentX, currentY);
  
  //popMatrix();
 // popMatrix();
  }
 // popMatrix();
  
}


  
  
  
  //  popMatrix();
  
}
}


void keyPressed()
{
  
    switch(key) {
   case '1': _case=1; background(0); startTime = millis() / 1000.0;break;
   case '2': _case=2;isrotated=true; background(0); startTime = millis() / 1000.0;break;
 //  case '3':  isrotated=false;break;
    }
  
}


//void mousePressed() {
//  // 마우스를 클릭할 때마다 회전 각도 업데이트
/// isrotated=false;
//}



void oscEvent(OscMessage m) {

  /* check if theOscMessage has the address pattern we are looking for. */
  if (m.checkAddrPattern("/wek/outputs")==true) {

      ML_Out1 = m.get(0).intValue();  // get the first osc argument
       ML_Out2 = m.get(1).intValue();  // get the second osc argument
     
    
  }
}



void keyPressed() {
  // "c" 키를 눌렀을 때 스크롤 위치를 조절
  if (key == 'c' || key == 'C') {
    scrollPosition += scrollSpeed;
    if (scrollPosition > backgroundImage.height - height) {
      scrollPosition = 0;
    }
  }


  
