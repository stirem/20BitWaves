#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

#include "soundWave.h"
#include "soundObject.h"
#include "menuButton.h"



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
    
    Button button;
    
    
    bool triggerPlay;
    float soundSpeed;

    bool fingerIsLifted;


    
    
    ///< MAXIMILIAN
    // REMEMBER TO INCLUDE ACCELERATE FRAMEWORK !!!!!!
    //void audioReceived( float * input, int bufferSize, int nChannels );
    void audioRequested( float * output, int bufferSize, int nChannels );
    int	initialBufferSize;
    int	sampleRate;
    float panning;
    float volume;

    
    // Maximilian sample playback declaration
    ofxMaxiSample fileSample1;
    ofxMaxiSample fileSample2;
    ofxMaxiSample fileSample3;
    ofxMaxiSample fileSample4;
    ofxMaxiSample fileSample5;
    ofxMaxiSample fileSample6;
    
    ofxMaxiMix channel1;
    double sample;
    double outputs1[2];
    
    // Declare FFT
    int fftSize;
    int nAverages;
    ofxMaxiFFT myFFT;
    ofxMaxiFFTOctaveAnalyzer myFFTOctAna;

    
};


