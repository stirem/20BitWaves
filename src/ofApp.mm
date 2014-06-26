#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    ofBackground(0, 0, 0);
	ofSetOrientation(OF_ORIENTATION_90_RIGHT);
	
    
    ///< L O A D  S O U N D S ///
    
    //---------------------------------- frosk:
	frosk.loadSound("sounds/frosk.caf");
    frosk.setVolume(0.75);
    
    
    //---------------------------------- hest:
	hest.loadSound("sounds/hest.caf");
    hest.setVolume(0.75);


    //---------------------------------- kattepus:
    kattepus.loadSound("sounds/kattepus.caf");
    kattepus.setVolume(0.75);
    
    
    //---------------------------------- flodhest:
    flodhest.loadSound("sounds/flodhest.caf");
    flodhest.setVolume(0.75);
    

    ///< L O A D  F O N T ///
     
    font.loadFont("fonts/DIN.otf", 18);
}

//--------------------------------------------------------------
void ofApp::update(){
	//
}

//--------------------------------------------------------------
void ofApp::draw(){
    
	char tempStr[255];
	
	float sectionWidth = ofGetWidth() / 4.0f;

    ///< B U T T O N S  L O O K ///
    

    ofSetLineWidth(5);
    
    
    
    //---------------------------------- frosk:
    
    // Change color of fill when sound is playing

    if(frosk.getIsPlaying()) {
        ofSetColor(200, 200, 200);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(0, 0, sectionWidth, ofGetHeight());
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(0, 0, sectionWidth, ofGetHeight());
	
    // Change color of name of button when sound is playing
    if(frosk.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("Frosk", 10,50);
    
    // Show info text about sound
    ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", frosk.getPosition(),  frosk.getSpeed(), frosk.getPan());
	ofDrawBitmapString(tempStr, 10, ofGetHeight() - 50);
    
    
    //---------------------------------- hest:
    
    // Change color of fill when sound is playing
    
    if(hest.getIsPlaying()) {
        ofSetColor(200, 200, 200);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(sectionWidth, 0, sectionWidth, ofGetHeight());
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(sectionWidth, 0, sectionWidth, ofGetHeight());
    
    // Change color of name of button when sound is playing
    if (hest.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("Hest", sectionWidth + 10, 50);
    
    // Show info text about sound
    ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", hest.getPosition(),  hest.getSpeed(), hest.getPan());
	ofDrawBitmapString(tempStr, sectionWidth + 10, ofGetHeight() - 50);
    
    
    //---------------------------------- kattepus:
    
    // Change color of fill when sound is playing
    
    if(kattepus.getIsPlaying()) {
        ofSetColor(200, 200, 200);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(sectionWidth * 2, 0, sectionWidth, ofGetHeight());
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(sectionWidth * 2, 0, sectionWidth, ofGetHeight());
    
    // Change color of name of button when sound is playing
    if (kattepus.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("kattepus", sectionWidth * 2 + 10, 50);
    
    // Show info text about sound
	ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", kattepus.getPosition(),  kattepus.getSpeed(), kattepus.getPan());
	ofDrawBitmapString(tempStr, sectionWidth * 2 + 10, ofGetHeight() - 50);
    
    
    
    //---------------------------------- flodhest:
    
    // Change color of fill when sound is playing
    
    if(flodhest.getIsPlaying()) {
        ofSetColor(200, 200, 200);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(sectionWidth * 3, 0, sectionWidth, ofGetHeight());
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(sectionWidth * 3, 0, sectionWidth, ofGetHeight());
    
    // Change color of name of button when sound is playing
    if (flodhest.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("flodhest", sectionWidth * 3 + 10, 50);
    
    // Show info text about sound
	ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", flodhest.getPosition(),  flodhest.getSpeed(), flodhest.getPan());
	ofDrawBitmapString(tempStr, sectionWidth * 3 + 10, ofGetHeight() - 50);
    


	

    
    
    

}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
	if( touch.id != 0 ){
        return;
    }
		
    
    ///< B U T T O N S  T O U C H ///
    
    float sectionWidth = ofGetWidth() / 4.0f;
    float speed = ofMap(touch.y, ofGetHeight(), 0, 0.5, 2.0, true);
    float pan = 0;
    
    
    //---------------------------------- frosk:
    if (touch.x < sectionWidth){
        pan = ofMap(touch.x, 0, sectionWidth, -1.0, 1.0, true);
        
        frosk.play();
        frosk.setSpeed(speed);
        frosk.setPan(pan);
        frosk.setLoop(true);
        
        
    //---------------------------------- hest:
    } else if(touch.x < sectionWidth * 2) {
        pan = ofMap(touch.x, sectionWidth, sectionWidth * 2, -1.0, 1.0, true);
        
        hest.play();
        hest.setSpeed(speed);
        hest.setPan(pan);
        hest.setLoop(true);
        
        
    //---------------------------------- kattepus:
    } else if(touch.x < sectionWidth * 3) {
        pan = ofMap(touch.x, sectionWidth * 2, sectionWidth * 3, -1.0, 1.0, true);
        
        kattepus.play();
        kattepus.setSpeed(speed);
        kattepus.setPan(pan);
        kattepus.setLoop(true);
        
        
    //---------------------------------- flodhest:
    } else if(touch.x < sectionWidth * 4) {
        pan = ofMap(touch.x, sectionWidth * 3, sectionWidth * 4, -1.0, 1.0, true);
        
        flodhest.play();
        flodhest.setSpeed(speed);
        flodhest.setPan(pan);
        flodhest.setLoop(true);
    }
    
    
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
	if( touch.id != 0 ){
        return;
    }
    
    
    ///< B U T T O N S  T O U C H  M O V E D ///
    
    float sectionWidth = ofGetWidth() / 4.0f;
    float speed = ofMap(touch.y, ofGetHeight(), 0, 0.5, 2.0, true);
    float pan = 0;
    
    
    
    //---------------------------------- frosk:
    if (touch.x < sectionWidth){
        pan = ofMap(touch.x, 0, sectionWidth, -1.0, 1.0, true);
        
        frosk.setSpeed(speed);
        frosk.setPan(pan);
        
    
    //---------------------------------- hest:
    } else if(touch.x < sectionWidth * 2) {
        pan = ofMap(touch.x, sectionWidth, sectionWidth * 2, -1.0, 1.0, true);
        
        hest.setSpeed(speed);
        hest.setPan(pan);
        
    
    //---------------------------------- kattepus:
    } else if(touch.x < sectionWidth * 3) {
        pan = ofMap(touch.x, sectionWidth * 2, sectionWidth * 3, -1.0, 1.0, true);
        
        kattepus.setSpeed(speed);
        kattepus.setPan(pan);
    
    //---------------------------------- flodhest:
    } else if(touch.x < sectionWidth * 4) {
        pan = ofMap(touch.x, sectionWidth * 3, sectionWidth * 4, -1.0, 1.0, true);
        
        flodhest.setSpeed(speed);
        flodhest.setPan(pan);
    }
    
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
	if( touch.id != 0 ){
        return;
    }
    
    
    ///< T O U C H  L I F T E D  ///
    
    frosk.setLoop(false);
    hest.setLoop(false);
    kattepus.setLoop(false);
    flodhest.setLoop(false);


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
