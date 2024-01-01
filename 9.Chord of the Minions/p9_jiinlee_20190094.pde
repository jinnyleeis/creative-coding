import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;

import oscP5.*;
import netP5.*;

boolean testMode = false; // 0: traning 1: testing

float mic_pos=100;

OscP5 oscP5;
NetAddress dest;
 
Minim minim;
AudioOutput out;
AudioPlayer[] minion1_pitch =new AudioPlayer[11];
AudioPlayer[] minion2_pitch =new AudioPlayer[11];
PImage[] minion1 = new PImage[3];
PImage[] minion2 = new PImage[3];
PImage mic;


float volume_min1=-100;
float volume_min2=-100;
int pos=-200;


int frameToShow = 0;
int xx = 0;
int time = 0;
boolean is_singing=false;

int imgCenterX=400;
int imgCenterY=300;

int startTime;


float ML_Out1 = 0; 
float ML_Out2 = 0; 


void setup()
{
  size(800, 600, P3D);
  
  
   oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6448);
 
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
  
  
   minim = new Minim(this);
  

  
  for (int i = 1; i <= 11; i++) {
     minion1_pitch[i-1] = minim.loadFile("minion1/"+(i)+ ".mp3");
    minion2_pitch[i-1] = minim.loadFile("minion2/"+(i)+ ".mp3");
  }
  
   for (int i = 1; i <= 3; i++) {
    minion1[i-1] = loadImage("m" + (i) + ".png");
    minion2[i-1] = loadImage("m" + (i) + ".png");
  }
  
  mic=loadImage("mic.png");
  
  
 
  
  

 
  
  // 음악 재생
 minion1_pitch[0].play();

 
 
  
  
}
 
void draw()
{
  

  
  
    if (millis() - startTime < 700) {
    is_singing = true;
  } else {
    is_singing = false;
  }
  
  background(255);
 // stroke(255);
  translate(imgCenterX, imgCenterY);
  
  imageMode(CENTER);
 
   minion1[frameToShow].resize(160, 200);
     minion2[frameToShow].resize(160, 200);
   image(minion1[frameToShow],-100,0);
    image(minion2[frameToShow],100,0);
    
     mic.resize(160, 200);
   image(mic,mic_pos,80);
    float volume = map(mouseX, 0, width, -100, 0);
  // volume=slider;
   
   
//   player1.setGain(volume);
    
    for(int i=0; i<minion1_pitch.length; i++)
  {minion1_pitch[i].setGain(volume_min1);
if (!minion1_pitch[i].isPlaying()) {
    minion1_pitch[i].rewind(); // 사운드 파일을 처음으로 되감음

  }
}
  
   for(int i=0; i<minion2_pitch.length; i++)
  {minion2_pitch[i].setGain(volume_min2);
if (!minion2_pitch[i].isPlaying()) {
    minion2_pitch[i].rewind(); // 사운드 파일을 처음으로 되감음
   
  }
}

if(is_singing){
 if (time > 10) {
  
    
    if(is_singing)
    {
    xx += 2;}

    
    frameToShow += 1;

  
    if (frameToShow >= minion1.length) {
      frameToShow = 0;
    }
    
  
    time = 0;
  }
  time++;
 

}

 if (frameCount % 3 == 0) sendOsc(mic_pos);
 
   if (testMode) {
   
    fill(120);
    text("Running", -300,-250);
  
   
  } else {
    fill(120);
    text("Training", -300,-250);
  }
}
 
void keyPressed()
{
  
 // is_singing=true;
  
    

  float pitch = 0;
  switch(key) {
    
    case '1':  startTime = millis(); pitch = 261.63;is_singing=true; minion1_pitch[0].play();minion2_pitch[0].play(); break;// C4
    case '2': startTime = millis(); pitch = 293.66;is_singing=true; minion1_pitch[1].play();minion2_pitch[1].play(); break;// D4
    case '3': startTime = millis(); pitch = 329.63; is_singing=true; minion1_pitch[2].play();minion2_pitch[2].play();break;// E4
    case '4': startTime = millis(); pitch = 349.23; is_singing=true; minion1_pitch[3].play();minion2_pitch[3].play();break;// F4
    case '5': startTime = millis(); pitch = 392.00; is_singing=true; minion1_pitch[4].play();minion2_pitch[4].play();break;// G4
    case '6': startTime = millis(); pitch = 440.00; is_singing=true; minion1_pitch[5].play();minion2_pitch[5].play();break;// A4
    case '7': startTime = millis(); pitch = 493.88; is_singing=true; minion1_pitch[6].play();minion2_pitch[6].play();break;// B4
    case '8': startTime = millis(); pitch = 523.25; is_singing=true; minion1_pitch[7].play();minion2_pitch[7].play();break;// C5
    case '9': startTime = millis(); pitch = 587.33; is_singing=true; minion1_pitch[8].play();minion2_pitch[8].play();break;// D5
    case '0': startTime = millis(); pitch = 659.25; is_singing=true; minion1_pitch[9].play();minion2_pitch[9].play();break;// E5
    case '-': startTime = millis(); pitch = 698.46; is_singing=true; minion1_pitch[10].play();minion2_pitch[10].play();break;// F5
    case 'l':left();break;
    case 'r':right();break;
    case ' ':testMode = !testMode; break;
  }
  
   
}

void stop()
{
  out.close();
  minim.stop();
 
  super.stop();
}


void left() {
  // 왼쪽 버튼을 눌렀을 때 mic_pos 값을 -5 감소
  mic_pos -= 5;
}

void right() {
  // 오른쪽 버튼을 눌렀을 때 mic_pos 값을 +5 증가
  mic_pos += 5;
}


void sendOsc(float mic_pos) {
  OscMessage msg = new OscMessage("/wek/inputs");
    msg.add(mic_pos);
  oscP5.send(msg, dest);
}

void oscEvent(OscMessage m) {

  /* check if theOscMessage has the address pattern we are looking for. */
  if (m.checkAddrPattern("/wek/outputs")==true) {

    ///* check if the typetag is the right one. */
   // if (m.checkTypetag("f")) {

      /* extract the values from the osc message */
      ML_Out1 = m.get(0).floatValue();  // get the first osc argument
       ML_Out2 = m.get(1).floatValue();  // get the second osc argument
      //println(ML_Out);
       volume_min1=map(ML_Out1, 0, 1, -100, 20);
       volume_min2=map(ML_Out2, 0, 1, -100, 20);
    
  }
}
