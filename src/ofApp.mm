#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    
///////////////// A P P  S E T T I N G S /////////////////////
    
    
    // Background of app
    ofBackground(0, 0, 0);
	
    // Orientation of app
    ofSetOrientation(OF_ORIENTATION_90_RIGHT);
	
    
    
    
///////////////// L O A D  S O U N D S /////////////////////
    
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
    
    
    //---------------------------------- apekatt:
    apekatt.loadSound("sounds/apekatt.caf");
    apekatt.setVolume(0.75);
    
    
    //---------------------------------- mus:
    mus.loadSound("sounds/mus.caf");
    mus.setVolume(0.75);
    
    
    //---------------------------------- mus:
    hund.loadSound("sounds/hund.caf");
    hund.setVolume(0.75);
    
    
    //---------------------------------- sebra:
    sebra.loadSound("sounds/sebra.caf");
    sebra.setVolume(0.75);
    
    
    

///////////////// L O A D  F O N T S /////////////////////
     
    font.loadFont("fonts/DIN.otf", 18);
}

//--------------------------------------------------------------
void ofApp::update(){
	//
}

//--------------------------------------------------------------
void ofApp::draw(){
    
	char tempStr[255];
	
    // Divide screen-width in four rectangles
	float sectionWidth = ofGetWidth() / 4.0f;
    float sectionHeight = ofGetHeight() / 2.0f;

    
    
    
///////////////// B U T T O N S  L O O K /////////////////////
    
    ofSetLineWidth(5);
    

//------------------ T O P  R O W ---------------------//
    
    
    //---------------------------------- frosk:
    
    // Change color of fill when sound is playing

    if(frosk.getIsPlaying()) {
        ofSetColor(100, 100, 100);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(0, 0, sectionWidth, sectionHeight);
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(0, 0, sectionWidth, sectionHeight);
	
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
	ofDrawBitmapString(tempStr, 10, sectionHeight - 50);
    
    
    //---------------------------------- hest:
    
    // Change color of fill when sound is playing
    
    if(hest.getIsPlaying()) {
        ofSetColor(100, 100, 100);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(sectionWidth, 0, sectionWidth, sectionHeight);
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(sectionWidth, 0, sectionWidth, sectionHeight);
    
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
	ofDrawBitmapString(tempStr, sectionWidth + 10, sectionHeight - 50);
    
    
    //---------------------------------- kattepus:
    
    // Change color of fill when sound is playing
    
    if(kattepus.getIsPlaying()) {
        ofSetColor(100, 100, 100);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(sectionWidth * 2, 0, sectionWidth, sectionHeight);
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(sectionWidth * 2, 0, sectionWidth, sectionHeight);
    
    // Change color of name of button when sound is playing
    if (kattepus.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("Kattepus", sectionWidth * 2 + 10, 50);
    
    // Show info text about sound
	ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", kattepus.getPosition(),  kattepus.getSpeed(), kattepus.getPan());
	ofDrawBitmapString(tempStr, sectionWidth * 2 + 10, sectionHeight - 50);
    
    
    
    //---------------------------------- flodhest:
    
    // Change color of fill when sound is playing
    
    if(flodhest.getIsPlaying()) {
        ofSetColor(100, 100, 100);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(sectionWidth * 3, 0, sectionWidth, sectionHeight);
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(sectionWidth * 3, 0, sectionWidth, sectionHeight);
    
    // Change color of name of button when sound is playing
    if (flodhest.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("Flodhest", sectionWidth * 3 + 10, 50);
    
    // Show info text about sound
	ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", flodhest.getPosition(),  flodhest.getSpeed(), flodhest.getPan());
	ofDrawBitmapString(tempStr, sectionWidth * 3 + 10, sectionHeight - 50);
    

    
//---------------- B O T T O M  R O W --------------------//
    

    
    //---------------------------------- apekatt:
    
    // Change color of fill when sound is playing
    
    if(apekatt.getIsPlaying()) {
        ofSetColor(100, 100, 100);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(0, sectionHeight, sectionWidth, sectionHeight);
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(0, sectionHeight, sectionWidth, sectionHeight);
	
    // Change color of name of button when sound is playing
    if(apekatt.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("Apekatt", 10, sectionHeight + 50);
    
    // Show info text about sound
    ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", apekatt.getPosition(),  apekatt.getSpeed(), apekatt.getPan());
	ofDrawBitmapString(tempStr, 10, ofGetHeight() - 50);
    
    
    
    //---------------------------------- mus:
    
    // Change color of fill when sound is playing
    
    if(mus.getIsPlaying()) {
        ofSetColor(100, 100, 100);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(sectionWidth, sectionHeight, sectionWidth, sectionHeight);
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(sectionWidth, sectionHeight, sectionWidth, sectionHeight);
	
    // Change color of name of button when sound is playing
    if(mus.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("Mus", sectionWidth + 10, sectionHeight + 50);
    
    // Show info text about sound
    ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", mus.getPosition(),  mus.getSpeed(), mus.getPan());
	ofDrawBitmapString(tempStr, sectionWidth + 10, ofGetHeight() - 50);


    
    //---------------------------------- hund:
    
    // Change color of fill when sound is playing
    
    if(hund.getIsPlaying()) {
        ofSetColor(100, 100, 100);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(sectionWidth * 2, sectionHeight, sectionWidth, sectionHeight);
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(sectionWidth * 2, sectionHeight, sectionWidth, sectionHeight);
	
    // Change color of name of button when sound is playing
    if(hund.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("Hund", (sectionWidth * 2) + 10, sectionHeight + 50);
    
    // Show info text about sound
    ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", hund.getPosition(),  hund.getSpeed(), hund.getPan());
	ofDrawBitmapString(tempStr, (sectionWidth * 2) + 10, ofGetHeight() - 50);
    
    
    
    //---------------------------------- sebra:
    
    // Change color of fill when sound is playing
    
    if(sebra.getIsPlaying()) {
        ofSetColor(100, 100, 100);
    } else {
        ofSetColor(0, 0, 0);
    }
    ofFill();
    ofRect(sectionWidth * 3, sectionHeight, sectionWidth, sectionHeight);
    
    // Rectangle stroke color
    ofNoFill();
    ofSetColor(255, 255, 255);
    ofRect(sectionWidth * 3, sectionHeight, sectionWidth, sectionHeight);
	
    // Change color of name of button when sound is playing
    if(sebra.getIsPlaying()) {
        ofSetColor(0, 0, 0);
    } else {
        ofSetColor(50, 50, 50);
    }
	font.drawString("Sebra", (sectionWidth * 3) + 10, sectionHeight + 50);
    
    // Show info text about sound
    ofSetColor(50, 50, 50);
	sprintf(tempStr, "click to play\nposition: %f\nspeed: %f\npan: %f", sebra.getPosition(),  sebra.getSpeed(), sebra.getPan());
	ofDrawBitmapString(tempStr, (sectionWidth * 3) + 10, ofGetHeight() - 50);
    

}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
	if( touch.id != 0 ){
        return;
    }
		
    
///////////////// B U T T O N S  T O U C H /////////////////////
    
    
    float sectionWidth = ofGetWidth() / 4.0f;
    float sectionHeight = ofGetHeight() / 2.0f;
    float speedTop = ofMap(touch.y, sectionHeight, 0, 0.5, 2.0, true);
    float speedBottom = ofMap(touch.y, sectionHeight, sectionHeight * 2, 2.0, 0.5);
    float pan = 0;
    

//------------------ T O P  R O W ---------------------//
    
    
    //---------------------------------- frosk:
    if (touch.x < sectionWidth && touch.y < sectionHeight){
        pan = ofMap(touch.x, 0, sectionWidth, -1.0, 1.0, true);
        
        frosk.play();
        frosk.setSpeed(speedTop);
        frosk.setPan(pan);
        frosk.setLoop(true);
        
        
    //---------------------------------- hest:
    } else if(touch.x < sectionWidth * 2 && touch.y < sectionHeight) {
        pan = ofMap(touch.x, sectionWidth, sectionWidth * 2, -1.0, 1.0, true);
        
        hest.play();
        hest.setSpeed(speedTop);
        hest.setPan(pan);
        hest.setLoop(true);
        
        
    //---------------------------------- kattepus:
    } else if(touch.x < sectionWidth * 3 && touch.y < sectionHeight) {
        pan = ofMap(touch.x, sectionWidth * 2, sectionWidth * 3, -1.0, 1.0, true);
        
        kattepus.play();
        kattepus.setSpeed(speedTop);
        kattepus.setPan(pan);
        kattepus.setLoop(true);
        
        
    //---------------------------------- flodhest:
    } else if(touch.x < sectionWidth * 4 && touch.y < sectionHeight) {
        pan = ofMap(touch.x, sectionWidth * 3, sectionWidth * 4, -1.0, 1.0, true);
        
        flodhest.play();
        flodhest.setSpeed(speedTop);
        flodhest.setPan(pan);
        flodhest.setLoop(true);
    

        
//---------------- B O T T O M  R O W --------------------//
        
        
        
    //---------------------------------- apekatt:
    } else if (touch.x < sectionWidth && touch.y > sectionHeight) {
        pan = ofMap(touch.x, 0, sectionWidth, -1.0, 1.0, true);
        
        apekatt.play();
        apekatt.setSpeed(speedBottom);
        apekatt.setPan(pan);
        apekatt.setLoop(true);
    
    
    //---------------------------------- mus:
    } else if (touch.x < sectionWidth * 2 && touch.y > sectionHeight) {
        pan = ofMap(touch.x, 0, sectionWidth * 2, -1.0, 1.0, true);
        
        mus.play();
        mus.setSpeed(speedBottom);
        mus.setPan(pan);
        mus.setLoop(true);
    
        
    //---------------------------------- hund:
    } else if (touch.x < sectionWidth * 3 && touch.y > sectionHeight) {
        pan = ofMap(touch.x, 0, sectionWidth * 3, -1.0, 1.0, true);
        
        hund.play();
        hund.setSpeed(speedBottom);
        hund.setPan(pan);
        hund.setLoop(true);
    
        
    //---------------------------------- sebra:
    } else if (touch.x < sectionWidth * 4 && touch.y > sectionHeight) {
        pan = ofMap(touch.x, 0, sectionWidth * 4, -1.0, 1.0, true);
        
        sebra.play();
        sebra.setSpeed(speedBottom);
        sebra.setPan(pan);
        sebra.setLoop(true);
    }
    
    
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
	if( touch.id != 0 ){
        return;
    }
    
    
///////////////// B U T T O N S  T O U C H  M O V E D /////////////////////
    
    float sectionWidth = ofGetWidth() / 4.0f;
    float sectionHeight = ofGetHeight() / 2.0f;
    float speedTop = ofMap(touch.y, sectionHeight, 0, 0.5, 2.0, true);
    float speedBottom = ofMap(touch.y, sectionHeight, sectionHeight * 2, 2.0, 0.5);
    float pan = 0;

    
//-------------------T O P  R O W----------------------//

    
    //---------------------------------- frosk:
    if (touch.x < sectionWidth && touch.y < sectionHeight){
        pan = ofMap(touch.x, 0, sectionWidth, -1.0, 1.0, true);
        
        frosk.setSpeed(speedTop);
        frosk.setPan(pan);
        
    
    //---------------------------------- hest:
    } else if(touch.x < sectionWidth * 2 && touch.y < sectionHeight) {
        pan = ofMap(touch.x, sectionWidth, sectionWidth * 2, -1.0, 1.0, true);
        
        hest.setSpeed(speedTop);
        hest.setPan(pan);
        
    
    //---------------------------------- kattepus:
    } else if(touch.x < sectionWidth * 3 && touch.y < sectionHeight) {
        pan = ofMap(touch.x, sectionWidth * 2, sectionWidth * 3, -1.0, 1.0, true);
        
        kattepus.setSpeed(speedTop);
        kattepus.setPan(pan);
    
    //---------------------------------- flodhest:
    } else if(touch.x < sectionWidth * 4 && touch.y < sectionHeight) {
        pan = ofMap(touch.x, sectionWidth * 3, sectionWidth * 4, -1.0, 1.0, true);
        
        flodhest.setSpeed(speedTop);
        flodhest.setPan(pan);

        
//-----------------B O T T O M  R O W---------------------//
        
        
    //---------------------------------- apekatt:
    } else if(touch.x < sectionWidth && touch.y > sectionHeight) {
        pan = ofMap(touch.x, 0, sectionWidth, -1.0, 1.0, true);
        
        apekatt.setSpeed(speedBottom);
        apekatt.setPan(pan);
    
        
    //---------------------------------- mus:
    } else if(touch.x < sectionWidth * 2 && touch.y > sectionHeight) {
        pan = ofMap(touch.x, sectionWidth, sectionWidth * 2, -1.0, 1.0, true);
        
        mus.setSpeed(speedBottom);
        mus.setPan(pan);
    
        
    //---------------------------------- hund:
    } else if(touch.x < sectionWidth * 3 && touch.y > sectionHeight) {
        pan = ofMap(touch.x, sectionWidth * 2, sectionWidth * 3, -1.0, 1.0, true);
        
        hund.setSpeed(speedBottom);
        hund.setPan(pan);
    
        
    //---------------------------------- sebra:
    } else if(touch.x < sectionWidth * 4 && touch.y > sectionHeight) {
        pan = ofMap(touch.x, sectionWidth * 3, sectionWidth * 4, -1.0, 1.0, true);
        
        sebra.setSpeed(speedBottom);
        sebra.setPan(pan);
    }
    
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
	if( touch.id != 0 ){
        return;
    }
    
    
///////////////// T O U C H  L I F T E D /////////////////////
    
    
    frosk.setLoop(false);
    hest.setLoop(false);
    kattepus.setLoop(false);
    flodhest.setLoop(false);
    apekatt.setLoop(false);
    mus.setLoop(false);
    hund.setLoop(false);
    sebra.setLoop(false);


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
