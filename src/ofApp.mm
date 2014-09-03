#include "ofApp.h"


float soundSpeed0;

float froskVolume = 0.75;
float hestVolume = 0.75;

float froskPosX;
float froskPosY;
float hestPosX;
float hestPosY;

int froskInside;
int hestInside;

float froskDistance = 0;
float hestDistance = 0;


int ballRadius = 80;


float myTouchX;
float myTouchY;



//--------------------------------------------------------------
void ofApp::setup(){	
	ofBackground(0, 0, 0);

	
    // Set start position
    
    ///< F R O S K - START ///
    froskPosX = ofRandomWidth();
    froskPosY = ofRandomHeight();
    ///< F R O S K - END ///
    
    
    ///< H E S T - START ///
    hestPosX = ofRandomWidth();
    hestPosY = ofRandomHeight();
    ///< H E S T - END ///
  
    
    
    
    

    
    
    // Load sounds
    
    ///< F R O S K - START ///
	frosk.loadSound("sounds/frosk.aif");
    frosk.setVolume(froskVolume);
    ///< F R O S K - END ///
    
    
    ///< H E S T - START ///
	hest.loadSound("sounds/hest.aif");
    hest.setVolume(hestVolume);
    ///< H E S T - END ///
    
    

    
    
    
}


//--------------------------------------------------------------
void ofApp::update() {

    
  
    
  
}

//--------------------------------------------------------------
void ofApp::draw() {
	

    
	ofEnableAlphaBlending();
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2, 0);
    ofPopMatrix();
    ofPushStyle();
    //ofEnableBlendMode(OF_BLENDMODE_ADD);
    
    
    ///< F R O S K - START ///
        if (froskInside == 1) {
            ofSetColor(255, 255, 0, 255);
        } else {
            ofSetColor(255, 255, 0, 100);
        }
        ofCircle(froskPosX, froskPosY, ballRadius);
    ///< F R O S K - END ///
    
    
    
    ///< H E S T - START ///
        if (hestInside == 1) {
            ofSetColor(255, 0, 255, 255);
        } else {
            ofSetColor(255, 0, 255, 100);
        }
        ofCircle(hestPosX, hestPosY, ballRadius);
    ///< H E S T - END ///
    
    
    
    ofPopStyle();

    
    
    
    

    
    ofDrawBitmapString(ofToString(froskInside) +" froskInside", 10, 10);
    ofDrawBitmapString(ofToString(myTouchX) +" touch.x", 10, 30);
    ofDrawBitmapString(ofToString(myTouchY) +" touch.y", 10, 50);
    ofDrawBitmapString(ofToString(froskDistance) +" my touch inside", 10, 70);
    ofDrawBitmapString(ofToString(froskPosX) +" froskPosX", 10, 90);
    ofDrawBitmapString(ofToString(froskPosY) +" froskPosY", 10, 120);
    
    
    
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
   
    
    myTouchX = touch.x;
    myTouchY = touch.y;
    //soundSpeed0 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
    //float pan0 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
    //frosk.setPan(pan0);
    //frosk.setSpeed(soundSpeed0);
    
    
    
    ///< F R O S K - START ///
    froskDistance =  sqrt(    (touch.x - froskPosX) * (touch.x - froskPosX) +  (touch.y - froskPosY) * (touch.y - froskPosY)     ) ;
        
    if (ballRadius > froskDistance) {
        froskInside = 1;
    } else {
        froskInside = 0;
    }
    
    // Audio
    if (froskInside == 1) {
        froskVolume = 0.75;
        frosk.setVolume(froskVolume);
        frosk.play();
        frosk.setLoop(true);
    }
    ///< F R O S K - START ///
    

    
    
    ///< H E S T - START ///
    hestDistance =  sqrt(    (touch.x - hestPosX) * (touch.x - hestPosX) +  (touch.y - hestPosY) * (touch.y - hestPosY)     ) ;
    
    if (ballRadius > hestDistance) {
        hestInside = 1;
    } else {
        hestInside = 0;
    }
    
    // Audio
    if (hestInside == 1) {
        hestVolume = 0.75;
        hest.setVolume(hestVolume);
        hest.play();
        hest.setLoop(true);
    }
    ///< H E S T - END ///
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

    
    
    ///< F R O S K - START ///
    myTouchX = touch.x;
    myTouchY = touch.y;
    
    froskDistance =  sqrt(    (touch.x - froskPosX) * (touch.x - froskPosX) +  (touch.y - froskPosY) * (touch.y - froskPosY)     ) ;
    
    if (ballRadius > froskDistance) {
        froskInside = 1;
    } else {
        froskInside = 0;
    }
    
    if (froskInside == 1) {
        froskPosX = touch.x;
        froskPosY = touch.y;
    }
    
    
    // Audio
    if (froskInside == 1) {
        froskVolume = 0.75;
        frosk.setVolume(froskVolume);
        frosk.setLoop(true);
    } else {
        froskVolume = 0;
        frosk.setVolume(froskVolume);
        frosk.setLoop(false);
    }
    ///< F R O S K - END ///
    
    
    
    
    
    ///< H E S T - START ///
    hestDistance =  sqrt(    (touch.x - hestPosX) * (touch.x - hestPosX) +  (touch.y - hestPosY) * (touch.y - hestPosY)     ) ;
    
    if (ballRadius > hestDistance) {
        hestInside = 1;
    } else {
        hestInside = 0;
    }
    
    
    if (hestInside == 1) {
        hestPosX = touch.x;
        hestPosY = touch.y;
    }
    
    
    
    // Audio
    if (hestInside == 1) {
        hestVolume = 0.75;
        hest.setVolume(hestVolume);
        hest.setLoop(true);
    } else {
        hestVolume = 0;
        hest.setVolume(hestVolume);
        hest.setLoop(false);
    }
    ///< H E S T - END ///
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){


    
    
    ///< F R O S K - START ///
    froskInside = 0;

    // Audio
    froskVolume = 0;
    frosk.setVolume(froskVolume);
    frosk.setLoop(false);
    ///< F R O S K - END ///
  
    
    
    
    ///< H E S T - START ///
    hestInside = 0;
    
    // Audio
    hestVolume = 0;
    hest.setVolume(hestVolume);
    hest.setLoop(false);
    ///< H E S T - END ///



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

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){
	
}

