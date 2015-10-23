
#include "recording.h"

Recording::Recording() {
    
}

void Recording::setup( int whatNrAmI, bool audioInputValue ) {
    
    initSizeValues();
    
    isRecording = false;
    
    _whatNrAmI = whatNrAmI;

    myRecString = ofxNSStringToString( initRecFile() ); // Init sound file
    
    recButtonColor                  = 100;
    muteAudioWhileRecording         = false;
    loadFileIsDone                  = false;

    mAveragePower                   = 0;
    mPeakPower                      = 0;
    meter                           = 0;
    addParticlesTimer               = 0;
    spectrumPosXinc                 = 0;
    
    _delButtonHasBeenPressed              = false;
    
    //eraseRecFileTimer               = 0.0;
    //eraseRectWidth                  = ofGetWidth() * 0.2;
    
    //silenceWhenDeleting             = false;
    
    if ( audioInputValue == 1 ) {
        _bluetoothActive = 0;
    } else {
        _bluetoothActive = 1;
    }
    _hasCheckedInputValue = false;
    
    trashcan.loadImage( "trashcan.png" );
    hold.loadImage( "hold.png" );
    _yesNo.loadImage( "yesNo.png" );
    
    _arial.loadFont( "Fonts/arial.ttf", 12 );
    _recordingIsDisabled.loadImage( "recordingIsDisabled.png" );
    
    
    // Enable bluetooth mic input
    /*UInt32 allowBluetoothInput = 1;
    
    AudioSessionSetProperty (
                             kAudioSessionProperty_OverrideCategoryEnableBluetoothInput,
                             sizeof (allowBluetoothInput),
                             &allowBluetoothInput
                             );*/
    
    
    
    
}

void Recording::initSizeValues() {
    
    recButtonPosX                   = ofGetWidth() * 0.5;
    recButtonPosY                   = ofGetHeight() * 0.5;
    recButtonRadius                 = ofGetWidth() * 0.15;
    _distanceToRecButton            = ofGetWidth(); // Avoid rec button getting pushed on start
    spectrumPosXincValue            = ofGetWidth() * 0.001;
    delButtonPosX                   = ofGetWidth() * 0.95;
    delButtonPosY                   = ofGetHeight() * 0.05;
    delButtonRadius                 = ofGetWidth() * 0.03;
    distanceToDelButton             = ofGetWidth();
    _distanceToDelYesButton         = ofGetWidth();
    _yesNoImageWidth                = ofGetWidth() * 0.2;
    _yesNoImageHeight               = ofGetWidth() * 0.055;
    _delYesPosX                     = ofGetWidth() * 0.5 - (_yesNoImageWidth * 0.4);
    _delYesPosY                     = ofGetHeight() * 0.2;
    _delYesRadius                   = ofGetWidth() * 0.04;
    _recordingIsDisabled_width      = ofGetWidth() * 0.5;
    _recordingIsDisabled_height     = ofGetWidth() * 0.045;

}


void Recording::isRecSampleZero( long recSampleLength ) {
    
    if ( recSampleLength == 0 )
    {
        readyToPlay = false;
        setupRecFile();
        willTakeRecording = true;
        showDeleteButton = false;
    }
    else
    {
        readyToPlay = true;
        willTakeRecording = false;
        showDeleteButton = true;
        loadFileIsDone = true;
    }
    
}

void Recording::Update( float touchX, float touchY, bool touchIsDown ) {
    
    if ( willTakeRecording ) {
        if ( recButtonRadius > _distanceToRecButton ) {
            if ( !_bluetoothActive ) {
                recButtonIsPressed = true;
            }
        }
        

        // Rec stoppes when touch is lifted or spectrum wave reaches end of screen
        if ( !touchIsDown || spectrumPosXinc > ofGetWidth() )
        {
            recButtonIsPressed = false;
            
            if ( isRecording ) {
                StopPressed();
            }
        }
        
        
        if ( recButtonIsPressed ) {
            RecordPressed();
        }
    }

    
    //// DELETE BUTTON ////
    /*if ( _delButtonHasBeenPressed )
    {
        eraseRecFileTimer += ofGetLastFrameTime();
        eraseRectWidth = ofMap( eraseRecFileTimer, 0.0, 0.5, ofGetWidth() * 0.2, 0.0 );
        silenceWhenDeleting = true;
        
        if ( eraseRecFileTimer >= 0.5 )
        {
            readyToPlay = false;
            setupRecFile();
            willTakeRecording = true;
            showDeleteButton = false;
            _delButtonHasBeenPressed = false;
        }
    }*/
    
    
    // Do not make sound or visuals when rec button is on
    if ( willTakeRecording )
    {
        readyToPlay = false;
    }

    
    
    /// LEVEL METERING ///
    
    [audioRecorder updateMeters];
    mAveragePower = [audioRecorder averagePowerForChannel:0];
    mPeakPower = [audioRecorder peakPowerForChannel:0];
    
    meter = ofMap( mAveragePower, -60, -30, 0, 100 );
    //meter = ofMap(mPeakPower, -60, -30, 0, 100);
    
    
    // Rec Spectrum
    if ( isRecording ) {
        addParticlesTimer += ofGetLastFrameTime();
        if ( addParticlesTimer >= 0.01 ) {
            spectrumPosXinc = spectrumPosXinc + spectrumPosXincValue;
            recSpectrum.push_back( RecSpectrum( meter, spectrumPosXinc ) );
            addParticlesTimer = 0;
        }
    } else {

        spectrumPosXinc = 0;
        
        for ( int i = 0; i < recSpectrum.size(); i++) {
            recSpectrum.erase( recSpectrum.begin() + i );
        }
    
    }
    
    
    // Bluetooth Input Value check
    /*if ( !_hasCheckedInputValue ) {
        if ( audioInputValue == 1 ) {
            _bluetoothActive = 0;
        } else {
            _bluetoothActive = 1;
        }
        _hasCheckedInputValue = true;
    }*/
    
}


void Recording::distanceToRecButton( float touchX, float touchY ) {
    
    // Checked in ofApp::touchDown function.
    _distanceToRecButton = sqrt(    (touchX - recButtonPosX) * (touchX - recButtonPosX) + (touchY - recButtonPosY) * (touchY - recButtonPosY)     ) ;
    
}


void Recording::distanceToDeleteButton( float touchX, float touchY ) {
    
    // Checked in ofApp::touchDown function.
    distanceToDelButton = sqrt(    (touchX - delButtonPosX) * (touchX - delButtonPosX) + (touchY - delButtonPosY) * (touchY - delButtonPosY)     ) ;
    
    if ( showDeleteButton ) {
        if ( delButtonRadius > distanceToDelButton ) {
            _delButtonHasBeenPressed = true;
            showDeleteButton = false;
            //eraseRecFileTimer = 0;
        }
    }
    

}

void Recording::distanceToDelYesButton( float touchX, float touchY ) {
    
    // Checked in ofApp::touchDown function.
    _distanceToDelYesButton = sqrt(    (touchX - _delYesPosX) * (touchX - _delYesPosX) + (touchY - _delYesPosY) * (touchY - _delYesPosY)     ) ;
    
    if ( _delYesRadius > _distanceToDelYesButton ) {
        readyToPlay = false;
        setupRecFile();
        willTakeRecording = true;
        showDeleteButton = false;
        _delButtonHasBeenPressed = false;
    } else if ( delButtonRadius < distanceToDelButton ) {
        _delButtonHasBeenPressed = false;
        showDeleteButton = true;
    }
}


void Recording::Draw() {
    
    initSizeValues();
    
    // Rec spectrum
    for (int i = 0; i < recSpectrum.size(); i++)
    {
        recSpectrum[i].Draw();
    }
    
    // Rec button
    if ( willTakeRecording )
    {
        if ( _bluetoothActive ) {
            ofSetColor( 100, 100, 100 );
        } else {
            ofSetColor( recButtonColor, 0, 0 );
        }
        ofFill();
        ofCircle( recButtonPosX, recButtonPosY, recButtonRadius );
        ofSetColor( 255, 255, 255, 20 );
        hold.setAnchorPercent( 0.5, 0.5 );
        hold.draw( recButtonPosX, recButtonPosY, recButtonRadius, recButtonRadius * 0.29 );
    }

    // Delete button
    if ( showDeleteButton )
    {
        ofSetColor( 255, 255, 255, 50 );
        trashcan.setAnchorPercent( 0.5, 0.5 );
        trashcan.draw( delButtonPosX, delButtonPosY, ofGetWidth() * 0.03, ofGetWidth() * 0.035 );
    }

    // Visual timer for delete file
    /*if ( _delButtonHasBeenPressed )
    {
        ofSetColor( 255, 255, 255 );
        ofFill();
        ofRect( ofGetWidth() * 0.4, ofGetHeight() * 0.25, eraseRectWidth, ofGetHeight() * 0.1 );
        ofNoFill();
        ofRect( ofGetWidth() * 0.4, ofGetHeight() * 0.25, ofGetWidth() * 0.2, ofGetHeight() * 0.1 );
        hold.setAnchorPercent( 0.5, 0.5 );
    }*/
    
    // Del Yes Button
    if ( _delButtonHasBeenPressed ) {
        ofSetColor( 255 );
        //ofNoFill();
        //ofCircle( _delYesPosX, _delYesPosY, _delYesRadius );
        _yesNo.setAnchorPercent( 0.5, 0.5 );
        _yesNo.draw( ofGetWidth() * 0.5, ofGetHeight() * 0.2, _yesNoImageWidth, _yesNoImageHeight );
    }

    
    // Bluetooth Text
    if ( willTakeRecording && _bluetoothActive ) {
        ofSetColor( 255 );
        //_arial.drawString( "Recording is disabled when Bluetooth is enabled for this app.\n\nTurn off Bluetooth for this app in iOS settings under 'BITWaves'", recButtonPosX - (recButtonRadius * 0.5), recButtonPosY + (recButtonRadius * 1.2) );
        _recordingIsDisabled.setAnchorPercent( 0.5, 0.5 );
        _recordingIsDisabled.draw( ofGetWidth() * 0.5, recButtonPosY + (recButtonRadius * 1.3), _recordingIsDisabled_width, _recordingIsDisabled_height );
    }
    
    
    // Meter
    /*if ( willTakeRecording ) {
        ofSetColor( 255, 0, 0 );
        ofRect( ofGetScreenWidth() * 0.25 , (ofGetScreenHeight() * 0.1), 10, -meter );
    }*/
    
}



void Recording::Exit() {
    
    [audioRecorder release];
    
}


void Recording::RecordPressed() {
    
    muteAudioWhileRecording = true;
    
    readyToPlay = false;
    
    loadFileIsDone = false;
    
    recButtonColor = 255;
    
    isRecording = true;
    
    [audioRecorder record];

    
}


void Recording::StopPressed() {
    
    if ( isRecording ) {
        
        [audioRecorder stop];
        
        readyToPlay = true;
        
        recButtonColor = 100;
        
        willTakeRecording = false;
        
        showDeleteButton = true;
        
        saveFileIsDone = true;
        
    }
    
    isRecording = false;
}


// Init sound file on startup
NSString* Recording::initRecFile() {
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *micRecPath = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:@"micRecordings"];
    NSString *fileName;
    

    fileName = [ NSString stringWithFormat:@"%@/micRecording%d.wav", micRecPath, _whatNrAmI ];
    
    
    return fileName;

}


// Check if micRecording.wav is in the Documents directory. Ended up checking for length of file instead, since the file is generated on startup.
/*bool Recording::isFileInDir() {
    
    NSFileManager *myManager = [NSFileManager defaultManager];
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [searchPaths objectAtIndex:0];
    
    if([myManager fileExistsAtPath:[documentsDirectory stringByAppendingPathComponent:@"/micRecording.wav"]]){
        return true;
    } else {
        return false;
    }
}*/


// Setup sound file for recording
void Recording::setupRecFile() {

    NSString *micRecPath;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    micRecPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"micRecordings"]; // Create directory
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:micRecPath])	//Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:micRecPath
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error])
        {
            NSLog(@"Create directory error: %@", error);
        }
    }
    
    NSString *soundFilePath;

    soundFilePath = [ NSString stringWithFormat:@"%@/micRecording%d.wav", micRecPath, _whatNrAmI ];
    
    
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
    
    error = nil;
    

    
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
    
    audioRecorder.meteringEnabled = YES;
    
    myRecString = ofxNSStringToString( soundFilePath );
    
    
 
    
}






