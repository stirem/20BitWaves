
#include "soundObject.h"
#include "pennerRamp.h"

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




//--------------------------------------------------------------


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

//--------------------------------------------------------------


void SoundObject::Draw(int r, int g, int b) {
    ///< Set brightness on object to low if not touched, and high if touched
    if (fingerID != -99) {
        ///< Full brightness when object is touched
        myBrightness = 255;
    } else {
        ///< Pulsate object when not touched
        brightTime = ofGetElapsedTimef();
        brightValue = sin( (brightTime * M_TWO_PI) /2 );
        brightV = ofMap(brightValue, -1, 1, 50, 100); // Pulsate brightness between 50 and 100
        myBrightness = brightV;
        //brightness = 100;
    }
    
    myColor = ofColor(r, g, b);
    
    myColor.setBrightness(myBrightness);
    
    ///< Draw the color
    ofSetColor(myColor);
   
    ///< Draw the circle. Radius is bouncing with Elastic ease out function when object is touched.
    ofCircle(objectPosX, objectPosY, Elastic::easeOut  (time, beginning, change, duration));
}


//--------------------------------------------------------------



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


//--------------------------------------------------------------


void SoundObject::BindToFinger(int anFingerID) {
    fingerID = anFingerID;
}


//--------------------------------------------------------------



void SoundObject::ReleaseFinger() {
    fingerID = -99;
}


//--------------------------------------------------------------



bool SoundObject::IsFingerBoundToObject(int anFingerID) {
    return (fingerID == anFingerID);
}


//--------------------------------------------------------------



void SoundObject::SetPosition(float aX, float aY) {
    objectPosX = aX;
    objectPosY = aY;
}


//--------------------------------------------------------------



void SoundObject::rampInit(){
    time 		= 0;
    beginning	= 50;
    change 		= 50;
    duration 	= 50;
}



//------------------ S O U N D ----------------------------------

void SoundObject::PanTheSound(float x, int w) {
    float pan;
    pan = ofMap(x, 0, w, -1.0, 1.0, true);
    sndPlay.setPan(pan);
}


//--------------------------------------------------------------



void SoundObject::SpeedOfTheSound(float y, int h) {
    float speed = ofMap(y, h, 0, 0.5, 2.0, true);
    sndPlay.setSpeed(speed);
}

