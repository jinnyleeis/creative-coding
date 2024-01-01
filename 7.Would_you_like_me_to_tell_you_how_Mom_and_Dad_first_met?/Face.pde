import oscP5.*;

// a single tracked face from FaceOSC
class Face {
  
  // num faces found
 float found;
  
  // pose
  float poseScale;
  PVector posePosition = new PVector();
  PVector poseOrientation = new PVector();
  
  // gesture
  float mouthHeight, mouthWidth;
  float eyeLeft, eyeRight;
  float eyebrowLeft, eyebrowRight;
  float jaw;
  float nostrils;
  PVector[] vertices=new PVector[66];
   float[] FaceOSCData=new float[15];
  PVector vertice = new PVector();
  //  int[] vertices=new int[66];
  
  Face() {}

  // parse an OSC message from FaceOSC
  // returns true if a message was handled
  boolean parseOSC(OscMessage m) {
    
    if(m.checkAddrPattern("/found")) {
        found = (float)m.get(0).intValue();
         FaceOSCData[0]=found;
        return true;
       
    }     
    
    
   
    
    
    
      if(m.checkAddrPattern("/raw")) {
        
   for(int i=0; 2*i<132; i++){
   vertice.x=m.get(2*i).floatValue();
   vertice.y=m.get(2*i+1).floatValue();
   vertices[i]=vertice;
   print(vertices[i]);
  
}


        
        
    //  vertices[0]=m.get(0).floatValue();
        return true;
    }      
          
    // pose
    else if(m.checkAddrPattern("/pose/scale")) {
        poseScale = m.get(0).floatValue();
         FaceOSCData[1]=poseScale;
        return true;
    }
    else if(m.checkAddrPattern("/pose/position")) {
        posePosition.x = m.get(0).floatValue();
        posePosition.y = m.get(1).floatValue();
         FaceOSCData[2]=posePosition.x;
         FaceOSCData[3]=posePosition.y;
        return true;
    }
    else if(m.checkAddrPattern("/pose/orientation")) {
        poseOrientation.x = m.get(0).floatValue();
        poseOrientation.y = m.get(1).floatValue();
        poseOrientation.z = m.get(2).floatValue();
        
         FaceOSCData[4]= poseOrientation.x;
         FaceOSCData[5]= poseOrientation.y;
         FaceOSCData[6]= poseOrientation.z;
        
        return true;
    }
    
    // gesture
    else if(m.checkAddrPattern("/gesture/mouth/width")) {
        mouthWidth = m.get(0).floatValue();
         FaceOSCData[7]=mouthWidth;
       
        return true;
    }
    else if(m.checkAddrPattern("/gesture/mouth/height")) {
        mouthHeight = m.get(0).floatValue();
         FaceOSCData[8]=mouthHeight;
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eye/left")) {
        eyeLeft = m.get(0).floatValue();
         FaceOSCData[9]=eyeLeft;
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eye/right")) {
        eyeRight = m.get(0).floatValue();
         FaceOSCData[10]=eyeRight;
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eyebrow/left")) {
        eyebrowLeft = m.get(0).floatValue();
         FaceOSCData[11]=eyebrowLeft;
        return true;
    }
    else if(m.checkAddrPattern("/gesture/eyebrow/right")) {
        eyebrowRight = m.get(0).floatValue();
         FaceOSCData[12]=eyebrowRight;
        return true;
    }
    else if(m.checkAddrPattern("/gesture/jaw")) {
        jaw = m.get(0).floatValue();
         FaceOSCData[13]=jaw;
        return true;
    }
    else if(m.checkAddrPattern("/gesture/nostrils")) {
        nostrils = m.get(0).floatValue();
         FaceOSCData[14]=nostrils;
        return true;
    }
    
    return false;
  }
  
  // get the current face values as a string (includes end lines)
  String toString() {
    return "found: " + found + "\n"
           + "pose" + "\n"
           + " scale: " + poseScale + "\n"
           + " position: " + posePosition.toString() + "\n"
           + " orientation: " + poseOrientation.toString() + "\n"
           + "gesture" + "\n"
           + " mouth: " + mouthWidth + " " + mouthHeight + "\n"
           + " eye: " + eyeLeft + " " + eyeRight + "\n"
           + " eyebrow: " + eyebrowLeft + " " + eyebrowRight + "\n"
           + " jaw: " + jaw + "\n"
           + " nostrils: " + nostrils + "\n";
  }
  
};
