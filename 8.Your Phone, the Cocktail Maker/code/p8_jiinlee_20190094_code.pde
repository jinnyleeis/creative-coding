import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress dest;

PImage[] cocktail_textures = new PImage[8];
PImage[] fruits = new PImage[5];



PShader shade;
PImage glass,bg,obj,bgwithglass;
PFont font;


float scaleFactor=0.3;
float fluid_height;
float mixed_percent=0;



boolean ispouring=false;
boolean isshaking=false;


int is_mixed=0;

//glass와 fluid의 높이 관련 변수
float glass_height;
float added_height;
float added_mixed_percent=0.005;


int selected_fruit;
int selectedImage1;
int selectedImage2;


void setup() 
{
  background(0);
 
  size(480, 640, P2D);
  
  
  oscP5 = new OscP5(this, 10000);
  dest = new NetAddress("127.0.0.1", 6449);
  
  
  
  
for(int i=1; i<=8; i++){
cocktail_textures[i-1]=loadImage("texture/texture" + (i) + ".png");
}

for(int i=1; i<=5; i++){
fruits[i-1]=loadImage("fruit/fruit" + (i) + ".png");
}
   

obj=loadImage("shader_obj.png");//쉐이더 적용할 이미지 
bg=loadImage("justbackground.png"); //배경이미지 
bgwithglass=loadImage("barbackground_withglass2.png"); //glass 포함 배경 이미지 
glass=loadImage("justglass2.png"); //glass 이미지 
 


  setupShader();
  
  //랜덤값 설정 - 칵테일 텍스처, 과일 
   selectedImage1 = int(random(cocktail_textures.length));
  selectedImage2 = int(random(cocktail_textures.length));
  selected_fruit=int(random(fruits.length));
  
  
 
}

void draw() 
{
  
 

  
  imageMode(CENTER);
  background(0);
  translate(width/2,height/2);
   
  
 

  // turn on shader and display source
   setShaderParameters();
   scale(scaleFactor);
   image(bg, 0,0);
 
   shader(shade);
   
if(ispouring){pour();}
if(isshaking){shake();}
  
  fluid_height=map(added_height,0,height,1,0);

 

 


 image(obj, 0,0);

  
 resetShader();
    
   
 image(bgwithglass, 0,0);
 image(fruits[selected_fruit], 0,0);
  

  
   

  

}

void pour()
{

    if(added_height<600)
   {
     
   added_height+=2;
 
   }

}

void shake(){
  
 
  
  if(mixed_percent<1)
  {
    mixed_percent+=added_mixed_percent;
    
   is_mixed=1;
   
  }


}

void setupShader() 
{
  shade = loadShader("cocktail.glsl");

}

void setShaderParameters() 
{
  
    

 
   
 
      shade.set("texture1", cocktail_textures[selectedImage1]);
    
    shade.set("texture2", cocktail_textures[selectedImage2]); 
 
    shade.set("ismixed", is_mixed);
    
    shade.set("cocktail_height", fluid_height);
  
     shade.set("mixed_percent", mixed_percent);
   
  

  
}




void oscEvent(OscMessage m) {
  

  // message from wekinator to processing
  if (m.checkAddrPattern("/output_1")==true) {
    
ispouring=true;
isshaking=false;

  }
  else if (m.checkAddrPattern("/output_2")==true) {
    
ispouring=true;
isshaking=false;
  }
  else if (m.checkAddrPattern("/output_3")==true) {
    
ispouring=false;
isshaking=true;

  }
  else if (m.checkAddrPattern("/output_4")==true) {
    
ispouring=false;
isshaking=true;

  }
  else if (m.checkAddrPattern("/output_5")==true) {
    
ispouring=false;
isshaking=false;
  }
  else if (m.checkAddrPattern("/output_6")==true) {
    
ispouring=false;
isshaking=false;
  }
  

}
