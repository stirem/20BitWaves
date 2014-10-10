#include "ofApp.h"


#define OBJECTS 5

int textFingerID;


//--------------------------------------------------------------
void ofApp::setup(){
    
    ///< Set the background color
    ofBackground(0, 0, 0);
    

}

//--------------------------------------------------------------
void ofApp::update(){
    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    

    for (int i = OBJECTS-1; i >= 0; i--) {
        
        ///< Draw the cricle
        ofCircle(sndObj[i].objectPosX, sndObj[i].objectPosY, sndObj[i].radius);
        
        ///< Change color of object depending on if finger is inside
        if (sndObj[i].fingerIsInside) {
            ofSetColor(sndObj[i].red, sndObj[i].green, sndObj[i].blue, 255);
        } else {
            ofSetColor(sndObj[i].red, sndObj[i].green, sndObj[i].blue, 100);
        }
        
        
       

        ///< Debugging text on screen
        ofDrawBitmapString(ofToString(sndObj[0].distToObj) +" Distance to object 0", 10, 70);
        ofDrawBitmapString(ofToString(sndObj[0].fingerIsInside) +" Is finger inside object 0?", 10, 130);
        ofDrawBitmapString(ofToString(textFingerID) +" Touch ID", 10, 150);

    }
    
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    
    textFingerID = touch.id;
    
    
    for (int i = 0; i < OBJECTS; i++) {
        ///< Send finger position values to DistanceToObject function.
        if (sndObj[i].IsFingerInside(touch.x, touch.y)) {
            sndObj[i].BindToFinger(touch.id);
            sndObj[i].SetPosition(touch.x, touch.y);
            break;
        }
    }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    
    for (int i = 0; i < OBJECTS; i++) {
    
        if (sndObj[i].IsFingerBoundToObject(touch.id)) {
            sndObj[i].SetPosition(touch.x, touch.y);
            break;
        }
        
    }
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
   for (int i = 0; i < OBJECTS; i++) {
       if (sndObj[i].IsFingerBoundToObject(touch.id)) {
           sndObj[i].ReleaseFinger();
           break; // Stop for loop
       }
       
   }
    
   
    
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}

