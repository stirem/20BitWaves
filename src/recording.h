
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
//#import <AVFoundation/AVAudioSession.h>

#include "recSpectrum.h"



class Recording {
public:
    
    Recording();
    
    void                    setup( int whatNrAmI, bool audioInputValue );
    void                    Update( float touchXDown, float touchYDown, bool touchIsDown );
    void                    Draw();
    void                    Exit();
    void                    isRecSampleZero( long recSampleLength );
    void                    distanceToRecButton( float touchX, float touchY );
    void                    distanceToDeleteButton( float touchX, float touchY );
    
    string                  myRecString;
    bool                    readyToPlay;
    bool                    saveFileIsDone;
    bool                    loadFileIsDone; // is set in ofApp
    bool                    muteAudioWhileRecording;
    bool                    silenceWhenDeleting;
    bool                    delButtonIsPressed;
    
    
private:
    
    void                    initSizeValues();
    
    void                    RecordPressed();
    void                    StopPressed();
    
    void                    setupRecFile();
    
    NSString                *initRecFile();
    //void initRecFile( unsigned int whatRecSample );
    
    bool                    isFileInDir();
    
    
    
    
    // -----------------------------
    
    // Recording
    AVAudioRecorder         *audioRecorder; // Apples own audio recorder from AVFoundation
    bool                    isRecording;
    float                   _distanceToRecButton;
    float                   recButtonPosX;
    float                   recButtonPosY;
    float                   recButtonRadius;
    bool                    recButtonIsPressed;
    int                     recButtonColor;
    bool                    willTakeRecording;
    float                   waitForSaveFileTime;
    bool                    willWaitForSave;

    ofImage                 hold;
    
    
    
    // Spectrum
    float                   mAveragePower;
    float                   mPeakPower;
    vector<RecSpectrum>     recSpectrum;
    float                   meter;
    float                   addParticlesTimer;
    float                   spectrumPosXinc;
    float                   spectrumPosXincValue;
    
    
    // Delete button
    bool                    showDeleteButton;
    float                   distanceToDelButton;
    float                   delButtonPosX;
    float                   delButtonPosY;
    float                   delButtonRadius;
    float                   delButtonTime;
    bool                    willWaitForDelButton;
    ofImage                 trashcan;
    float                   eraseRecFileTimer;
    float                   eraseRectWidth;
    
    
    float                   touchX;
    float                   touchY;
    
    int                     _whatNrAmI;
    
    bool                    _bluetoothActive;

    ofTrueTypeFont          _arial;

};


#endif /* defined(__Bit20iPadApp__recording__) */




