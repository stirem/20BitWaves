
#include "soundObject.h"





SoundObject::SoundObject() {
    
    ///< Radius of objects
    radius = 80;
    
    ///< Color of objects
    red = ofRandom(0, 255);
    green = ofRandom(0, 255);
    blue = ofRandom(0, 255);
    
    ///< Start position for objects
    objectPosX = ofRandom(700);
    objectPosY = ofRandom(700);
    
    fingerID = -99;
    
}





bool SoundObject::IsFingerInside(float x, float y) {
    

    
    ///< Calculate distance from finger to object
    distToObj = sqrt(    (x - objectPosX) * (x - objectPosX) + (y - objectPosY) * (y - objectPosY)     ) ;
    
    
    ///< Check if radius is greater than the distance to the object
    if (radius > distToObj) {
        fingerIsInside = 1;
    } else {
        fingerIsInside = 0;
    }

    return fingerIsInside;
    
}


void SoundObject::BindToFinger(int anFingerID) {
    fingerID = anFingerID;
}

void SoundObject::ReleaseFinger() {
    fingerID = -99;
}

bool SoundObject::IsFingerBoundToObject(int anFingerID) {
    return (fingerID == anFingerID);
}

void SoundObject::SetPosition(float aX, float aY) {
    objectPosX = aX;
    objectPosY = aY;
}


