String S = "F";
String Rule = "[+F]";


int numStars = 300;
Star[] stars = new Star[numStars];
int numConnections = 7;
int[][] connections2 = {{10, 11}, {11, 12}, {12, 13}, {13, 14}, {14, 20},{20,21},{21,22}};
int[][] connections = {{0, 1}, {1, 2}, {2, 3}, {3, 4}, {4, 0},{5,6},{6,90}};


PVector position;
PVector velocity;

PFont boldItalic;
PFont normalItalic;

int fadeValue = 255;
int fadeSpeed = 10;


void setup() {
  size(800, 600);

 
    normalItalic  = createFont("GillSans-Italic", 35);
    
 for (int i = 0; i < numStars; i++) {
    float x = random(width);
    float y = random(height);
    stars[i] = new Star(x, y);
 }
 

  position = new PVector(random(width), random(height * 0.3)); // Start position
  velocity = new PVector(5, +2); // Initial velocity (change this to control the speed)
  velocity.normalize(); // Normalize the velocity to control the direction
  velocity.mult(3); // Scale the velocity for speed
  noStroke();
  
}

void draw() {
 

 float branchLen = map(mouseX, 0, width, 0, 2);
  
  fill(fadeValue);
    if (fadeValue < 255) {
    fadeValue += fadeSpeed;
   
  }
   textSize(200);
  textFont(normalItalic);
  text("DRAW YOUR NIGHTSKY", 10,550);
 
  
  for (int i = 0; i < numStars; i++) {
    stars[i].display();
  }
  drawConnections(branchLen);
  
   fill(0, 10); // Create a fading trail effect
  rect(0, 0, width, height);

  // Update the position
  position.add(velocity);

  // Draw the star
  fill(255, 255, 255); // Yellow star
  pushMatrix();
   ellipse(position.x, position.y, 3, 3);
   translate(100,100);
    ellipse(position.x, position.y, 3, 3);
   // translate(0,100);
  //   rotate(PI/9);
   //  ellipse(position.x, position.y, 3, 3);
  popMatrix();

  // If the star goes off the screen, reset its position
  if (position.x > width || position.y < 0) {
    position.x = random(width);
    position.y = random(height * 0.3);
  }
  
  stroke(255);
    noFill();
  rect(20, 20, width-40, height-100);

  
 
}

void drawConnections(float branchLen) {
  stroke(255);
  for (int i = 0; i < numConnections; i++) {
    int star1 = connections[i][0];
    int star2 = connections[i][1];
    render(S,branchLen,star1,star2);

   
    star1 = connections2[i][0];
    star2 = connections2[i][1];
 
   render(S,branchLen,star1,star2);
   
  
    
  }
  
   
  
}

class Star {
  float x, y;

  Star(float startX, float startY) {
    x = startX;
    y = startY;
  }

  void display() {
     fill(255, random(150, 255));
     float starSize = random(0.1, 2);
    noStroke();
    ellipse(x, y, starSize, starSize);
  }
}

void render(String S, float branchLen, int star1,int star2) {
  int strLen = S.length();
  for (int i=0; i<strLen; i++) {
    switch( S.charAt(i) ) {
    case 'F': 
     line(stars[star1].x, stars[star1].y, stars[star2].x, stars[star2].y);
      break;
    case '+': 
      scale(branchLen);
      break;
    case '-': 
     scale(0.4);
      break;
    case '[': 
      pushMatrix();
      break;
    case ']': 
      popMatrix();
      break;
    }
  }
}

void keyPressed() {
  S = ApplyRule( S );
 
}

String ApplyRule( String s ) {
  String result = "";
  int strLen = s.length();
  for (int i=0; i<strLen; ++i) {
    char c = s.charAt(i);
    if (c == 'F') { 
      result += Rule;
    } else {
      result += c;
    }
  }
  return result;
}
