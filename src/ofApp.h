#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

#include "soundWave.h"
#include "soundObject.h"



class ofApp : public ofxiOSApp {
	
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
    
    
    float myTimer; // Timer for how often soundwaves are spawned
    float touchPosX; // Declaration of soundwave pos X
    float touchPosY; // Declaration of soundwave pos Y
    
    
    vector<Soundwave> soundwaves; // Soundwave vector
    
    Soundobject soundobject; // Soundobject ??
    
    
    bool triggerPlay;
    float soundSpeed;
    int whatSample;
    bool changeSampleFingerDown;
    float buttonX;
    float buttonY;
    bool fingerIsLifted;
    bool triggerVolume;

    
    
    ///< MAXIMILIAN
    // REMEMBER TO INCLUDE ACCELERATE FRAMEWORK !!!!!!
    //void audioReceived( float * input, int bufferSize, int nChannels );
    void audioRequested( float * output, int bufferSize, int nChannels );
    int	initialBufferSize;
    int	sampleRate;
    float panning;
    float volume;

    
    // Maximilian sample playback declaration
    ofxMaxiSample sample1;
    ofxMaxiSample sample2;
    ofxMaxiSample sample3;
    ofxMaxiSample sample4;
    ofxMaxiSample sample5;
    ofxMaxiSample sample6;
    
    ofxMaxiMix channel1;
    double sample;
    double outputs1[2];
    
    // Declare FFT
    int fftSize;
    int nAverages;
    ofxMaxiFFT myFFT;
    ofxMaxiFFTOctaveAnalyzer myFFTOctAna;

    
};


