//Project #1 leejiin
//projct title:-- i feel dizzy  --//


//Description:
//This process is inspired by Casey Reas' work and aims to represent the feeling of dizziness and mental complexity. It combines a fractal tree visualization with the text "I FEEL DIZZY" to illustrate the idea that excessive thinking can lead to mental overload.

//Forms:
//- F1: Line

//Behaviors:
//- B1: Rotate left
//- B2: Rotate right

//Elements:
//- E1: F1 + B1
//- E2: F1 + B2

//Implementation:
//1. Initialize angle1, angle2, branchRatio, and maxLevels.
//2. Set up the canvas size to 800x600.
//3. Load bold italic and normal italic fonts for text rendering.
//4. In the draw function:
//   - Gradually fade in the text "I FEEL DIZZY" and a thought-provoking message.
//   - Translate the coordinate system to the center bottom of the canvas.
//   - Draw the custom fractal tree using recursive calls to drawBranch.
//5. The drawBranch function:
//   - Draw a line from the current position upwards.
//   - Move upwards by the specified length.
//   - If the recursion level is not zero:
//     - Create two branches with rotations using behaviors B1 and B2.


float angle1; 
float angle2; 
float branchRatio = 0.8;//ratio of the branch length
float maxLevels = 1; //  maximum recursion depth for branching.

//----------------//

PFont boldItalic;
PFont normalItalic;
int fadeValue = 0;
int fadeSpeed = 10;



void setup() {
  size(800, 600);
 
  
  angle1 = radians(30); // 첫 번째 각도 설정 (30도)
  angle2 = radians(25); // 두 번째 각도 설정 (25도)
  
 
    boldItalic    = createFont("GillSans-BoldItalic",60);
    normalItalic  = createFont("GillSans-Italic", 15);
   

}

void draw() {
  
  
 background(255);
  if(maxLevels<17)
    {maxLevels+=0.07;}
  
   if (fadeValue < 255) {
    fadeValue += fadeSpeed;
   
  }
  
  fill(0, fadeValue);
   textSize(80);
  textFont(boldItalic);
  text("I FEEL DIZZY", 10,70);
   textSize(15);
   fill(40, fadeValue);
    textFont(normalItalic);
   text("If you keep overthinking,", 10, 100);
   text("it can get really complicated.", 10, 120);
   text("Do you ever worry that, ", 10, 140);
    text("if you think too much, ", 10, 160);
     text("your head might explode like a fractal?", 10,180);
  
   
 
  translate(width / 2, height); // move the start position to the center of the bottom(중앙아)
  drawBranch(120, maxLevels); // draw first branch at the bottom
  
 
}

void drawBranch(float len, float levels) {
  line(0, 0, 0, -len); // draw the line at the current position to upwards
  translate(0, -len); //move upwards for len만

  if (levels > 0) { // if its maximum recursion levels, stop the process.
 
    rotate(angle1); // roate by the first angle
    drawBranch(len * branchRatio, levels - 1); // draw the shorter branch
   

   
    rotate(-angle2); // roate by the second angle
    drawBranch(len * branchRatio, levels - 1); //  draw the shorter branch
   
  }
}
