#pragma once

#include "ofMain.h"



class SoundObject {

    
public:
    
    SoundObject();
    
    int radius; // Circle radius
    int red;
    int green;
    int blue;
    
    bool fingerIsInside; // True if finger is inside circle

    
    float distToObj; // Distance to object used by IsFingerInside
    
    float objectPosX; // Circle position
    float objectPosY; // Circle position

    int   fingerID;
  
    

    bool IsFingerInside(float x, float y); // Calculate distance between finger and circle

    void BindToFinger(int anFingerID);
    
    void ReleaseFinger();
    
    bool IsFingerBoundToObject(int anFingerID);
    
    void SetPosition(float aX, float aY);


    

    
    
private:
    
  

    
    /*
    float volume;
    float soundSpeed;
    float pan;
    */
};