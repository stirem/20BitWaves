#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        ofSoundPlayer frosk;
        ofSoundPlayer hest;
        ofSoundPlayer kattepus;
        ofSoundPlayer flodhest;
    
        ofSoundPlayer apekatt;
        ofSoundPlayer mus;
        ofSoundPlayer hund;


        ofTrueTypeFont font;
    
    

    
    
///////////////// R E C O R D I N G /////////////////////
    
    //Function for receiving audio
	void audioReceived( float *input, int bufferSize, int nChannels );
    
	//Function for generating audio
	void audioOut( float *output, int bufferSize, int nChannels );
    
	//Object for sound output and input setup
	ofSoundStream soundStream;
    
    
};


