
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



class Recording {
public:
    
    Recording();
    
    void Setup();
    void Update( float touchX, float touchY, bool touchIsDown );
    void Draw();
    void Exit();
    
    void RecordPressed();
    void PlayPresed();
    void StopPressed();
    
    void SetupAudioFile();
    AVAudioRecorder *audioRecorder; // Apples own audio recorder from AVFoundation
    bool isRecording;
    string myRecString;
    bool saveFileIsDone;
    
    NSString *getAudioFilePath();
    
    // -----------------------------
    
    float distanceToRecButton;
    float recButtonPosX;
    float recButtonPosY;
    float recButtonRadius;
    bool recButtonIsPressed;
    int recButtonColor;
    bool willTakeRecording;
    float waitForSaveFileTime;
    bool willWaitForSave;;
    bool readyToPlay;
    
    bool showDeleteButton;
    float distanceToDelButton;
    float delButtonPosX;
    float delButtonPosY;
    float delButtonRadius;
    bool delButtonIsPressed;
    float delButtonTime;
    bool willWaitForDelButton;
    
    float touchX;
    float touchY;
    bool touchIsDown;
    float myTimer;

};













#endif /* defined(__Bit20iPadApp__recording__) */
