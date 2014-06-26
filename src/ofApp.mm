#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    ofBackground(255);
	ofSetOrientation(OF_ORIENTATION_90_RIGHT);
	
	frosk.loadSound("sounds/corrente1.caf"); // compressed mp3 format.
    frosk.setVolume(0.75);
    
	hest.loadSound("sounds/corrente2.caf"); // uncompressed caf format.
    hest.setVolume(0.75);
    
    pus.loadSound("sounds/corrente3.caf"); // uncompressed caf format.
    pus.setVolume(0.75);
    
    
    // in iOS, openFrameworks uses ofxiOSSoundPlayer to play sound.
    // ofxiOSSoundPlayer is a wrapper for AVSoundPlayer which uses AVFoundation to play sound.
    // you can use AVSoundPlayer directly using objective-c in the same way you use ofxiOSSoundPlayer,
    // and many of the function names are the same or similar.
    // the below code demonstrates how the AVSoundPlayer can be used inside your app.
    
    /*
    vocals = [[AVSoundPlayer alloc] init];
    [vocals loadWithFile:@"sounds/Violet.wav"]; // uncompressed wav format.
    [vocals volume:0.5];
    */
    
     
    font.loadFont("fonts/DIN.otf", 18);
}

//--------------------------------------------------------------
void ofApp::update(){
	//
}

//--------------------------------------------------------------
void ofApp::draw(){
    
	char tempStr[255];
	
	float sectionWidth = ofGetWidth() / 3.0f;

    // draw the background colors:
	ofSetHexColor(0xeeeeee);
	ofRect(0, 0, sectionWidth, ofGetHeight());
	ofSetHexColor(0xffffff);
	ofRect(sectionWidth, 0, sectionWidth, ofGetHeight());
	ofSetHexColor(0xdddddd);
	ofRect(sectionWidth * 2, 0, sectionWidth, ofGetHeight());
    
	//---------------------------------- frosk:
	if(frosk.getIsPlaying()) {
        ofSetHexColor(0xFF0000);
    } else {
        ofSetHexColor(0x000000);
    }
	font.drawString("Frosk", 10,50);
	
	ofSetColor(0);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", frosk.getPosition(),  frosk.getSpeed(), frosk.getPan());
	ofDrawBitmapString(tempStr, 10, ofGetHeight() - 50);
    
	//---------------------------------- hest:
	if (hest.getIsPlaying()) {
        ofSetHexColor(0xFF0000);
    } else {
        ofSetHexColor(0x000000);
    }
	font.drawString("Hest", sectionWidth + 10, 50);
    
	ofSetHexColor(0x000000);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", hest.getPosition(),  hest.getSpeed(), hest.getPan());
	ofDrawBitmapString(tempStr, sectionWidth + 10, ofGetHeight() - 50);
    
	//---------------------------------- pus:
    if (pus.getIsPlaying()) {
        ofSetHexColor(0xFF0000);
    } else {
        ofSetHexColor(0x000000);
    }
	font.drawString("Pus", sectionWidth * 2 + 10, 50);
    
	ofSetHexColor(0x000000);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", pus.getPosition(),  pus.getSpeed(), pus.getPan());
	ofDrawBitmapString(tempStr, sectionWidth * 2 + 10, ofGetHeight() - 50);
    
    
    
    
    
    
    /* AV Sound Player Example
    if ([vocals isPlaying]) {
        ofSetHexColor(0xFF0000);
    } else {
        ofSetHexColor(0x000000);
    }
	font.drawString("Pus", sectionWidth * 2 + 10, 50);
    
	ofSetHexColor(0x000000);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", [vocals position],  [vocals speed], [vocals pan]);
	ofDrawBitmapString(tempStr, sectionWidth * 2 + 10, ofGetHeight() - 50);
    */
}

//--------------------------------------------------------------
void ofApp::exit(){
    /* AV Sound Player Example
    [vocals release];
    vocals = nil;
    */
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
	if( touch.id != 0 ){
        return;
    }
		
    float sectionWidth = ofGetWidth() / 3.0f;
    float speed = ofMap(touch.y, ofGetHeight(), 0, 0.5, 2.0, true);
    float pan = 0;
    
    if (touch.x < sectionWidth){
        pan = ofMap(touch.x, 0, sectionWidth, -1.0, 1.0, true);
        
        frosk.play();
        frosk.setSpeed(speed);
        frosk.setPan(pan);
        frosk.setLoop(true);
        
    } else if(touch.x < sectionWidth * 2) {
        pan = ofMap(touch.x, sectionWidth, sectionWidth * 2, -1.0, 1.0, true);
        
        hest.play();
        hest.setSpeed(speed);
        hest.setPan(pan);
        hest.setLoop(true);
        
    } else if(touch.x < sectionWidth * 3) {
        pan = ofMap(touch.x, sectionWidth * 2, sectionWidth * 3, -1.0, 1.0, true);
        
        pus.play();
        pus.setSpeed(speed);
        pus.setPan(pan);
        pus.setLoop(true);
        
        
        /* AV Sound Player Example
        [vocals play];
        [vocals speed:speed];
        [vocals pan:pan];
        */
    }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
	if( touch.id != 0 ){
        return;
    }
    
    float sectionWidth = ofGetWidth() / 3.0f;
    float speed = ofMap(touch.y, ofGetHeight(), 0, 0.5, 2.0, true);
    float pan = 0;

    if (touch.x < sectionWidth){
        pan = ofMap(touch.x, 0, sectionWidth, -1.0, 1.0, true);
        
        frosk.setSpeed(speed);
        frosk.setPan(pan);

    } else if(touch.x < sectionWidth * 2) {
        pan = ofMap(touch.x, sectionWidth, sectionWidth * 2, -1.0, 1.0, true);
        
        hest.setSpeed(speed);
        hest.setPan(pan);

    } else if(touch.x < sectionWidth * 3) {
        pan = ofMap(touch.x, sectionWidth * 2, sectionWidth * 3, -1.0, 1.0, true);
        
        pus.setSpeed(speed);
        pus.setPan(pan);
        
        
        /* AV Sound Player Example
        [vocals speed:speed];
        [vocals pan:pan];
        */
    }
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
	if( touch.id != 0 ){
        return;
    }
    
    frosk.setLoop(false);
    hest.setLoop(false);
    pus.setLoop(false);


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
