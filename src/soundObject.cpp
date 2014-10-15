
#include "soundObject.h"

//----------------VISUAL-------------------
/*
 SoundObject::SoundObject() {
 
 ///< Set radius of objects
 radius = 100;
 
 ///< Set color of objects
 color.r = ofRandom(0, 255);
 color.g = ofRandom(0, 255);
 color.b = ofRandom(0, 255);
 
 ///< Start position for objects
 objectPosX = ofRandomWidth();
 objectPosY = ofRandomHeight();
 
 ///< Start with a fingerID outside the finger range
 fingerID = -99;
 
 }
 */

void SoundObject::Color(int r, int g, int b) {
    ///< Set color of objects
    color = ofColor(r, g, b);
}

void SoundObject::Init() {
    ///< Set background color
    ofBackground(0, 0, 0);
    
    ///< Set radius of objects
    radius = 100;
    
    ///< Start position for objects
    objectPosX = ofRandomWidth();
    objectPosY = ofRandomHeight();
    
    ///< Start with a fingerID outside the finger range
    fingerID = -99;
}


void SoundObject::Draw() {
    ///< Set brightness on object to low if not touched, and high if touched
    int brightness;
    if (fingerID != -99)
        brightness = 255;
    else
        brightness = 100;
    color.setBrightness(brightness);
    
    ///< Draw the color
    ofSetColor(color);
   
    ///< Draw the circle
    ofCircle(objectPosX, objectPosY, radius);
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

void SoundObject::PanTheSound(float x, int w) {
    float pan;
    pan = ofMap(x, 0, w, -1.0, 1.0, true);
    sndPlay.setPan(pan);
}

void SoundObject::SpeedOfTheSound(float y, int h) {
    float speed = ofMap(y, h, 0, 0.5, 2.0, true);
    sndPlay.setSpeed(speed);
}

