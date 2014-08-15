#include "ofApp.h"

float speed0;

float froskVolume = 0.75;
float hestVolume = 0.75;
float kattepusVolume = 0.75;
float flodhestVolume = 0.75;
float apekattVolume = 0.75;


//--------------------------------------------------------------
void ofApp::setup(){	
	ofBackground(0, 0, 0);
	ofSetCircleResolution(80);
    ofSetLogLevel(OF_LOG_VERBOSE);
	
	balls.assign(5, Ball());
	
	// initialize all of the Ball particles
	for(int i=0; i<balls.size(); i++){
		balls[i].init(i);
	}
    
    
    
    ///////////////// A U D I O /////////////////////
    
    // Load sounds
    
    //---------------------------------- frosk:
	frosk.loadSound("sounds/frosk.caf");
    frosk.setVolume(froskVolume);
    
    
    //---------------------------------- hest:
	hest.loadSound("sounds/hest.caf");
    hest.setVolume(hestVolume);
    
    
    //---------------------------------- kattepus:
    kattepus.loadSound("sounds/kattepus.caf");
    kattepus.setVolume(kattepusVolume);
    
    
    //---------------------------------- flodhest:
    flodhest.loadSound("sounds/flodhest.caf");
    flodhest.setVolume(flodhestVolume);
    
    
    //---------------------------------- apekatt:
    apekatt.loadSound("sounds/apekatt.caf");
    apekatt.setVolume(apekattVolume);
    
    
    
    
}


//--------------------------------------------------------------
void ofApp::update() {
	for(int i=0; i < balls.size(); i++){
		balls[i].update();
	}
  
}

//--------------------------------------------------------------
void ofApp::draw() {
	

    
	ofEnableAlphaBlending();
	//ofSetColor(255);
	ofPushMatrix();
		ofTranslate(ofGetWidth()/2, ofGetHeight()/2, 0);

	ofPopMatrix();

	ofPushStyle();
    //ofEnableBlendMode(OF_BLENDMODE_ADD);
    for(int i = 0; i< balls.size(); i++){
        balls[i].draw();
    }
	ofPopStyle();


    
    //ofDrawBitmapString(ofToString(speed0), 10, 10);
    
    
    
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    ofLog(OF_LOG_VERBOSE, "touch %d down at (%d,%d)", touch.id, touch.x, touch.y);
	balls[touch.id].moveTo(touch.x, touch.y);
	balls[touch.id].bDragged = true;
    

    
///// A U D I O /////
    
    if (touch.id == 0) {
        froskVolume = 0.75;
        frosk.setVolume(froskVolume);
        speed0 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan0 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        frosk.play();
        frosk.setLoop(true);
        frosk.setSpeed(speed0);
        frosk.setPan(pan0);
    }
    
    if (touch.id == 1) {
        hestVolume = 0.75;
        hest.setVolume(hestVolume);
        float speed1 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan1 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        hest.play();
        hest.setLoop(true);
        hest.setSpeed(speed1);
        hest.setPan(pan1);
    }
    
    if (touch.id == 2) {
        kattepusVolume = 0.75;
        kattepus.setVolume(kattepusVolume);
        float speed2 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan2 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        kattepus.play();
        kattepus.setLoop(true);
        kattepus.setSpeed(speed2);
        kattepus.setPan(pan2);
    }
    
    if (touch.id == 3) {
        flodhestVolume = 0.75;
        flodhest.setVolume(flodhestVolume);
        float speed3 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan3 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        flodhest.play();
        flodhest.setLoop(true);
        flodhest.setSpeed(speed3);
        flodhest.setPan(pan3);
    }
    
    if (touch.id == 4) {
        apekattVolume = 0.75;
        apekatt.setVolume(apekattVolume);
        float speed4 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan4 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        apekatt.play();
        apekatt.setLoop(true);
        apekatt.setSpeed(speed4);
        apekatt.setPan(pan4);
    }
    

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    ofLog(OF_LOG_VERBOSE, "touch %d moved at (%d,%d)", touch.id, touch.x, touch.y);
	balls[touch.id].moveTo(touch.x, touch.y);
	balls[touch.id].bDragged = true;
    
    
    
    
///// A U D I O /////
    if (touch.id == 0) {
        speed0 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan0 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        frosk.setSpeed(speed0);
        frosk.setPan(pan0);
    }
    
    if (touch.id == 1) {
        float speed1 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan1 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        hest.setSpeed(speed1);
        hest.setPan(pan1);
    }
    
    if (touch.id == 2) {
        float speed2 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan2 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        kattepus.setSpeed(speed2);
        kattepus.setPan(pan2);
    }
    
    if (touch.id == 3) {
        float speed3 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan3 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        flodhest.setSpeed(speed3);
        flodhest.setPan(pan3);
    }
    
    if (touch.id == 4) {
        float speed4 = ofMap(touch.y, ofGetHeight(), 0, 0.1, 2.0, true);
        float pan4 = ofMap(touch.x, 0, ofGetWidth(), -1.0, 1.0, true);
        apekatt.setSpeed(speed4);
        apekatt.setPan(pan4);
    }
    

    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    ofLog(OF_LOG_VERBOSE, "touch %d up at (%d,%d)", touch.id, touch.x, touch.y);
	balls[touch.id].bDragged = false;
    
    
///// A U D I O /////
    if (touch.id == 0) {
        froskVolume = 0;
        frosk.setVolume(froskVolume);
        frosk.setLoop(false);
    }
    if (touch.id == 1) {
        hestVolume = 0;
        hest.setVolume(hestVolume);
        hest.setLoop(false);
    }
    if (touch.id == 2) {
        kattepusVolume = 0;
        kattepus.setVolume(kattepusVolume);
        kattepus.setLoop(false);
    }
    if (touch.id == 3) {
        flodhestVolume = 0;
        flodhest.setVolume(flodhestVolume);
        flodhest.setLoop(false);
    }
    if (touch.id == 4) {
        apekattVolume = 0;
        apekatt.setVolume(apekattVolume);
        apekatt.setLoop(false);
    }

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    ofLog(OF_LOG_VERBOSE, "touch %d double tap at (%d,%d)", touch.id, touch.x, touch.y);
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

