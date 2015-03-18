
#include "recording.h"

Recording::Recording() {
    
}



void Recording::Setup() {
    
    myTimer = 0;
    
    isRecording = false;
    
    //SetupAudioFile();
    
    myRecString = ofxNSStringToString( getAudioFilePath() ); // Init sound file
    
    recButtonPosX = ofGetScreenWidth() * 0.5;
    recButtonPosY = ofGetScreenHeight() * 0.5;
    recButtonRadius = ofGetScreenWidth() * 0.15;
    distanceToRecButton = ofGetScreenWidth();
    recButtonColor = 100;
    willTakeRecording = 0;
    waitForSaveFileTime = 0;
    willWaitForSave = 0;
    readyToPlay = 1;
    
    showDeleteButton = 1;
    delButtonIsPressed = 0;
    delButtonPosX = ofGetScreenWidth() * 0.95;
    delButtonPosY = ofGetScreenWidth() * 0.05;
    delButtonRadius = ofGetScreenWidth() * 0.02;
    distanceToDelButton = ofGetScreenWidth();
    delButtonTime = 0;
    willWaitForDelButton = 0;
}


void Recording::Update( float touchX, float touchY, bool touchIsDown ) {
    
    myTimer += ofGetLastFrameTime();
    
    
    //// REC BUTTON ////
    distanceToRecButton = sqrt(    (touchX - recButtonPosX) * (touchX - recButtonPosX) + (touchY - recButtonPosY) * (touchY - recButtonPosY)     ) ;
    
    if ( willTakeRecording ) {
        if ( recButtonRadius > distanceToRecButton )
        {
            recButtonIsPressed = 1;
        }
        
        // Touch Up
        if ( !touchIsDown ) {
            recButtonIsPressed = 0;
            
            if ( isRecording ) {
                StopPressed();
            }
        }
        
        if ( recButtonIsPressed ) {
            RecordPressed();
        }
    }
    
    if ( willWaitForSave ) {
        if ( myTimer > waitForSaveFileTime + 0.5 ) {
            saveFileIsDone = 1;
            readyToPlay = 1;
            willWaitForSave = 0;
        }
    }
    
    
    //// DELETE BUTTON ////
    distanceToDelButton = sqrt(    (touchX - delButtonPosX) * (touchX - delButtonPosX) + (touchY - delButtonPosY) * (touchY - delButtonPosY)     ) ;
    
    if ( showDeleteButton ) {
        if ( delButtonRadius > distanceToDelButton )
        {
            delButtonIsPressed = 1;
        }

        
        // Touch Up
        if ( !touchIsDown ) {
            delButtonIsPressed = 0;
        }

    }
    
    if ( delButtonIsPressed ) {
        readyToPlay = 0;
        delButtonTime = myTimer;
        willWaitForDelButton = 1;
    }
    

    if ( willWaitForDelButton ) {
        if ( myTimer > delButtonTime + 0.1 ) {
            SetupAudioFile();
            willTakeRecording = 1;
            showDeleteButton = 0;
            willWaitForDelButton = 0;
        }
    }


}


void Recording::Draw() {
    
    // Rec button
    if ( willTakeRecording ) {
        ofSetColor( recButtonColor, 0, 0 );
        ofCircle( recButtonPosX, recButtonPosY, recButtonRadius );
    }

    if ( showDeleteButton ) {
        ofSetColor( 50, 50, 50 );
        ofCircle( delButtonPosX, delButtonPosY, delButtonRadius );
    }
    
    
    // Spectrum
    /*if ( recButtonIsPressed ) {
        ofSetColor( 255, 0, 0 );
        for (int i = 0; i < myDrawInput.size(); i++) {

            ofRect( 5 + i * 2, (ofGetWidth() * 0.25), 1, -myDrawInput[i] * 10);
        }
    }*/
    
    /*if ( recButtonIsPressed ) {
        
        //Graph of the sound buffer
        int w = ofGetWidth() * 0.5;	// Width of the sound visualization picture
        ofSetColor( 255, 0, 0 );
        for (int x = 0; x < w; x++) {
            int i = float(x) * 44100.0 / w;   // Convert x to buffer's position
            ofLine( (ofGetWidth() * 0.25) + x, 100, (ofGetWidth() * 0.25) + x, 100 - myBuffInt[i] * 10 );
        }
    }*/
    
    // Rec square visual timer
    /*if ( recButtonIsPressed ) {
        recTimerWidth += ofGetLastFrameTime() * 10;
        ofLog() << "recTimerWidth:" << recTimerWidth;
        
        ofSetColor( 255, 0, 0 );
        ofRect(ofGetWidth() * 0.25, ofGetHeight() * 0.1, recTimerWidth, ofGetHeight() * 0.1 );
    }*/
}



void Recording::Exit() {
    
    //[soundFileURL release];
    
}


void Recording::RecordPressed(){
    
    readyToPlay = 0;
    
    recButtonColor = 255;
    
    //StopPressed();
    
    isRecording = true;
    
    [audioRecorder record];

    
}

//!recording.recButtonIsPressed && !recording.delButtonIsPressed && !recording.willTakeRecording

void Recording::StopPressed(){
    
    if (isRecording) {
        
        [audioRecorder stop];
        
        waitForSaveFileTime = myTimer;
        willWaitForSave = 1;
        
        recButtonColor = 100;
        
        willTakeRecording = 0;
        
        showDeleteButton = 1;
    }
    

    
    isRecording = false;
}


// Init sound file on startup
NSString* Recording::getAudioFilePath(){
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [searchPaths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/micRecording.wav", documentsPath];
    return fileName;
}


// Setup sound file for recording
void Recording::SetupAudioFile() {

    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"micRecording.wav"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 1],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    audioRecorder = [[AVAudioRecorder alloc]
                      initWithURL:soundFileURL
                      settings:recordSettings
                      error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [audioRecorder prepareToRecord];
    }
    
    myRecString = ofxNSStringToString( soundFilePath );
   
}







