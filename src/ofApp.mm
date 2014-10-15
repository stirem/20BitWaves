#include "ofApp.h"


#define kNumOfObjects 5

int red[kNumOfObjects];
int green[kNumOfObjects];
int blue[kNumOfObjects];


//--------------------------------------------------------------
void ofApp::setup(){
    
    ///< Individual properties for objects
    red[0] = 100;
    green[0] = 22;
    blue[0] = 57;
    
    red[1] = 23;
    green[1] = 44;
    blue[1] = 79;
    
    red[2] = 119;
    green[2] = 86;
    blue[2] = 26;
    
    red[3] = 74;
    green[3] = 109;
    blue[3] = 24;
    
    red[4] = 176;
    green[4] = 144;
    blue[4] = 158;
    
    sndObj[0].sndPlay.loadSound("sounds/apekatt.aif");
    sndObj[1].sndPlay.loadSound("sounds/flodhest.aif");
    sndObj[2].sndPlay.loadSound("sounds/frosk.aif");
    sndObj[3].sndPlay.loadSound("sounds/hest.aif");
    sndObj[4].sndPlay.loadSound("sounds/kattepus.aif");
    
    
    
    
    for (int i = 0; i < kNumOfObjects; i++) {
        ///< Sending individual color for each object
        sndObj[i].Color(red[i], green[i], blue[i]);
        
        ///< Calling the start values (initialization) of the objects
        sndObj[i].Init();
        
        ///< Set start volume for all sounds
        sndObj[i].sndPlay.setVolume(0.75);
    }

    

    
    
}

//--------------------------------------------------------------
void ofApp::update(){
    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    ///< Draw the objects to screen
    for (int i = kNumOfObjects-1; i >= 0; i--) {
        sndObj[i].Draw();
    }
    
    
    /*
    ///< Debugging text on screen
    ofSetColor(255, 255, 255);
    ofDrawBitmapString(ofToString(sndObj[0].distToObj) +" Distance to object 0", 10, 70);
    ofDrawBitmapString(ofToString(sndObj[0].fingerIsInside) +" Is finger inside object 0?", 10, 130);
     */
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    

    
    for (int i = 0; i < kNumOfObjects; i++) {
        if (sndObj[i].IsFingerInside(touch.x, touch.y)) {
            
            sndObj[i].BindToFinger(touch.id);
            sndObj[i].SetPosition(touch.x, touch.y);
            sndObj[i].sndPlay.play();
            sndObj[i].sndPlay.setLoop(true);
            sndObj[i].sndPlay.setVolume(0.75);
            sndObj[i].PanTheSound(touch.x, ofGetWidth());
            sndObj[i].SpeedOfTheSound(touch.y, ofGetHeight());
            break; // Stops the "for" loop
        }
    }
    
    
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    
    for (int i = 0; i < kNumOfObjects; i++) {
        if (sndObj[i].IsFingerBoundToObject(touch.id)) {
            
            sndObj[i].SetPosition(touch.x, touch.y);
            sndObj[i].PanTheSound(touch.x, ofGetWidth());
            sndObj[i].SpeedOfTheSound(touch.y, ofGetHeight());
            break; // Stops the "for" loop
        }
    }
    
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
   for (int i = 0; i < kNumOfObjects; i++) {
       if (sndObj[i].IsFingerBoundToObject(touch.id)) {
           
           sndObj[i].ReleaseFinger();
           sndObj[i].sndPlay.setLoop(false);
           sndObj[i].sndPlay.setVolume(0.);
           break; // Stops the "for" loop
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

