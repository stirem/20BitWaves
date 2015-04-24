
#ifndef __Bit20iPadApp__recording__
#define __Bit20iPadApp__recording__

#include <stdio.h>
#include "ofMain.h"
#include "Definitions.h"

#include "ofxiOS.h"
#include "ofxiOSExtras.h"
//#include "ofxGui.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#include "recParticles.h"
#include "recSpectrum.h"



class Recording {
public:
    
    Recording();
    
    void setup( );
    void Update( float touchXDown, float touchYDown, bool touchIsDown, bool recModeOn );
    void Draw();
    void Exit();
    
    void RecordPressed();
    void StopPressed();
    
    void distanceToDeleteButton( float touchX, float touchY, bool recModeOn );
    
    void SetupAudioFile();
    
    NSString *getAudioFilePath();
    
    bool isFileInDir();
    
    void isRecSampleZero( long recSampleLength );
    
    
    // -----------------------------
    
    // Recording
    AVAudioRecorder         *audioRecorder; // Apples own audio recorder from AVFoundation
    bool                    isRecording;
    string                  myRecString;
    bool                    saveFileIsDone;
    float                   distanceToRecButton;
    float                   recButtonPosX;
    float                   recButtonPosY;
    float                   recButtonRadius;
    bool                    recButtonIsPressed;
    int                     recButtonColor;
    bool                    willTakeRecording;
    float                   waitForSaveFileTime;
    bool                    willWaitForSave;;
    bool                    readyToPlay;
    ofImage                 hold;
    bool                    muteAudioWhileRecording;
    bool                    loadFileIsDone; // is set in ofApp
    
    
    // Spectrum
    float                   mAveragePower;
    float                   mPeakPower;
    vector<RecSpectrum>     recSpectrum;
    float                   meter;
    vector<RecParticles>    recParticles;
    float                   addParticlesTimer;
    int                     spectrumPosXinc;

    
    // Delete button
    bool                    showDeleteButton;
    float                   distanceToDelButton;
    float                   delButtonPosX;
    float                   delButtonPosY;
    float                   delButtonRadius;
    bool                    delButtonIsPressed;
    float                   delButtonTime;
    bool                    willWaitForDelButton;
    ofImage                 trashcan;
    float                   eraseRecFileTimer;
    float                   eraseRectWidth;
    bool                    silenceWhenDeleting;
    
    
    float                   touchX;
    float                   touchY;
    

};


#endif /* defined(__Bit20iPadApp__recording__) */




