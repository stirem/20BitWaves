#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

#include "Definitions.h"
#include "particles.h"
#include "touchObject.h"
#include "menu.h"
#include "recording.h"
#include "about.h"

#include "ofxMaxim.h" // Include Maximilian in project
#include "maximilian.h" // Inclde Maximilian in project






class ofApp : public ofxiOSApp {
	
public:
    void            setup();
    void            update();
    void            draw();
    void            exit();

    void            touchDown(ofTouchEventArgs & touch);
    void            touchMoved(ofTouchEventArgs & touch);
    void            touchUp(ofTouchEventArgs & touch);
    void            touchDoubleTap(ofTouchEventArgs & touch);
    void            touchCancelled(ofTouchEventArgs & touch);

    void            lostFocus();
    void            gotFocus();
    void            gotMemoryWarning();
    void            deviceOrientationChanged(int newOrientation);
    
    void            loadFileSamples();
    
    vector<Particles> particles;

    Touchobject     touchobject;

    menu            menu;

    Recording       recording[NUM_OF_REC_MODES];
    
    About           about;

    ofSoundStream   soundStream;


    float           touchPosX;
    float           touchPosY;
    bool            triggerFileSamplePlay;
    bool            triggerRecSamplePlay;
    //bool            triggerPlay;
    float           soundSpeed;
    bool            fingerIsLifted;
    bool            touchIsDown;
    float           addParticlesTimer;;

    vector<string> vectorOfStrings;
    int             howManySamples;

    
    
    ///< MAXIMILIAN
    // REMEMBER TO INCLUDE ACCELERATE FRAMEWORK !
    // Build phases -> Link Binary With Libraries -> + -> Accelerate Framework
    //void audioReceived( float * input, int bufferSize, int nChannels );
    
    //void AudioIn( float * input, int bufferSize, int nChannels );
	
    int             initialBufferSize;
	int             sampleRate;
	float           panning;
	float           volume;
	
	/** Called every time there is a request to calculate a new audio vector.
	 @param output			The audio vector
	 @param bufferSize		Audio vector size
	 @param nChannels		Number of audio channels
	 */
	void audioOut( float * output, int bufferSize, int nChannels );
    
    
    // Maximilian sample playback declaration
    ofxMaxiSample   fileSample[NUM_OF_HARDCODED_SOUNDS]; // + 1 because file names start on nr 1 and not 0.
    ofxMaxiSample   recSample[NUM_OF_REC_MODES];
    
    double          sample;
    
    // Declare FFT
    int             fftSize;
    int             nAverages;
    ofxMaxiFFT      myFFT;
    //ofxMaxiFFTOctaveAnalyzer myFFTOctAna;

    ofxMaxiFilter myFilter;
    
    
    
    
    


    

    
    
};


