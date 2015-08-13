#include "ofApp.h"


///< Remove soundwave vectors if alpha is 0 or less.
bool shouldRemove(Particles &p)
{
    if(p.alpha <= 0 )return true;
    else return false;
}


//--------------------------------------------------------------
void ofApp::setup()
{
    ///< Setup framerate, background color and show mouse
    ofSetFrameRate( 60 );
    ofBackground( 0, 0, 0 );
    //ofSetVerticalSync( true );

    
    touchobject.Setup();
    
    menu.setup();

    touchPosX               = 0;
    touchPosY               = 0;
    triggerFileSamplePlay   = false;
    triggerRecSamplePlay    = false;
    //triggerPlay             = false;
    soundSpeed              = 1.0;
    fingerIsLifted          = false;
    touchIsDown             = false;
    addParticlesTimer       = 0;

    
    
    ///< M A X I M I L I A N
    sampleRate              = 44100;
    initialBufferSize       = 512;
    panning                 = 0.5;
    volume                  = 0.0;
    sample                  = 0.0;
    


    ///< openFrameworks sound stream
    //ofSoundStreamSetup( 2, 0, this, sampleRate, initialBufferSize, 4 );
    soundStream.setup( this, 2, 1, sampleRate, initialBufferSize, 4 );
    
    
    // Setup FFT
    fftSize = BANDS;
    myFFT.setup(fftSize, 1024, 256);
    //nAverages = 12;
    //myFFTOctAna.setup(sampleRate, fftSize/2, nAverages);


    ///// R E C O R D I N G /////
    // Order here is important to check if rec file has content. If no content, rec button will be shown.
    for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
        recording[i].setup( i );
        recSample[i].load( recording[i].myRecString );
        recording[i].isRecSampleZero( recSample[i].length );
    }

    
    
    // Load samples
    loadFileSamples();


    
   /* for (int i = 1; i < NUM_OF_HARDCODED_SOUNDS + 1; i++)
    {
        string fileNr = "Sound_Object_0" + ofToString( i ) + ".wav";
        fileSample[i].load( ofToDataPath( fileNr ) );
    }*/
    
    
    
    

    ofSetOrientation( OF_ORIENTATION_90_LEFT ); // Set this after recording.Setup() and menu.Setup() because of issue with ofGetWidth() vs ofGetScreenWidth().

    
    
    
    
}

//--------------------------------------------------------------
void ofApp::loadFileSamples() {
    
    // Are there any wav sound files in dir?
    bool filesExist = false;

    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *documentsPath = [searchPaths objectAtIndex:0];
    NSString *extension = @"wav";
    NSFileManager *fileManager = [ NSFileManager defaultManager ];
    NSArray *contents = [ fileManager contentsOfDirectoryAtPath: documentsPath error: NULL ];
    NSEnumerator *e = [ contents objectEnumerator ];
    NSString *fileName;
    
    int fileCounter = 0; // Prevent from loading more than 7 sounds
    
    while ( ( fileName = [ e nextObject ] ) ) {
        if ( [ [ fileName pathExtension ] isEqualToString: extension ] ) {
            NSLog( @"FileName: %@", fileName );
            NSString *soundFilePath = [ documentsPath stringByAppendingPathComponent: fileName ];
            string myFileString = ofxNSStringToString( soundFilePath );
            fileCounter++;
            if ( fileCounter <= 7 ) {
                vectorOfStrings.push_back( myFileString ); // Fill my own vector with strings
            }

            filesExist = true;
        }
    }
    
    ofLog() << "fileCounter: " << fileCounter;
    
    

    ofLog() << "filesExist: " << filesExist;
    
    if ( filesExist ) {
        
        ofLog() << "vectorOfStrings.size(): " << vectorOfStrings.size();
        howManySamples = vectorOfStrings.size();
        
        // Load the user installed (from iTunes to Document dir) file samples
        // Load file sample strings into ofxMaxiSample fileSample.
        for ( int i = 0; i < vectorOfStrings.size(); i++ ) {
            fileSample[i].load( ofToDataPath( vectorOfStrings.at( i ) ) );
        }
        
        // Empty vector from memory
        for ( int i = 0; i < vectorOfStrings.size(); i++ ) {
            vectorOfStrings.erase( vectorOfStrings.begin() + i );
        }
            
    }
    else
    {
        howManySamples = NUM_OF_HARDCODED_SOUNDS;
        
        // Otherwise load the hard coded file samples
        for (int i = 0; i < NUM_OF_HARDCODED_SOUNDS; i++)
        {
            string fileNr = "Sound_Object_0" + ofToString( i ) + ".wav";
            fileSample[i].load( ofToDataPath( fileNr ) );
        }
    }
        
    


}

//--------------------------------------------------------------
void ofApp::update()
{
    
    ///< MAXIMILIAN
    float *val = myFFT.magnitudesDB;

    
    ///< Update spectrum analyze
    touchobject.Update( val, volume );

    
    ///< Increase radius of particles, and decrease alpha

    for( int i = 0; i < particles.size(); i++ ) {
        particles[i].Update( soundSpeed, volume, sample );
    }

    
    
    ///> Move Menu Button with finger
    menu.update( touchPosX, touchIsDown );
    
    
    ///< Remove soundwave when alpha is 0
    ofRemove( particles, shouldRemove );
    
    
    ///< Add particles
    if ( !menu.buttonIsPressed && recording[ menu.whatRecSample ].readyToPlay ) {// Do not add waves when pushing change-song-button.
        
        if ( touchobject.spectrumVolume > 1200 && volume > 0.0 ) {
            
            addParticlesTimer += ofGetLastFrameTime();
            if ( addParticlesTimer >= 0.01 ) {
                particles.push_back( Particles(touchPosX, touchPosY, touchobject.SpectrumVolume(), touchobject.StartRadius(), touchobject.ColorBrightness(), soundSpeed ) );
                addParticlesTimer = 0;
            }
        }
    }



    ///// R E C O R D I N G /////

    if ( menu.recModeOn[ menu.whatRecSample ] )
    {
        recording[ menu.whatRecSample ].Update( touchPosX, touchPosY, touchIsDown, menu.recModeOn );
    }
    
    // Load rec sample after recording (loadFileIsDone flag to prevent rec sample from being played before it is loaded)
    if ( recording[ menu.whatRecSample ].saveFileIsDone )
    {
        recSample[ menu.whatRecSample ].load( recording[ menu.whatRecSample ].myRecString );
        recording[ menu.whatRecSample ].loadFileIsDone = true;
        recording[ menu.whatRecSample ].saveFileIsDone = false;
    }
    
    // Prevent rec sample from playing instantly after finger is lifted from rec button.
    if ( recording[ menu.whatRecSample ].loadFileIsDone && touchIsDown ) {
        recording[ menu.whatRecSample ].muteAudioWhileRecording = false;
    }
    
    // Set ready to play if not in rec mode
    if ( !menu.recModeOn[ menu.whatRecSample ] )
    {
        recording[ menu.whatRecSample ].readyToPlay = true;
    }

    
    

    
}

//--------------------------------------------------------------
void ofApp::draw()
{
    
    // Draw menu-button
    menu.draw( howManySamples );
    
    ///< Draw touchobject
    touchobject.Draw();
    
    ///< Draw particles
    for( int i = 0; i < particles.size(); i++ )
    {
        particles[i].Draw();
    }

    ///// R E C O R D I N G /////

    if ( menu.recModeOn[ menu.whatRecSample ] ) {
        recording[ menu.whatRecSample ].Draw();
    }

    
    /*ofSetColor( 255, 255, 255 );
    ofDrawBitmapString( "fps: "+ ofToString( ofGetFrameRate() ), 10, 20 );
    ofDrawBitmapString( "what sample: "+ ofToString( menu.whatSample ), 10, 40 ) ;
    ofDrawBitmapString( "what menu num: "+ ofToString( menu.whatMenuNum ), 10, 60 );
    ofDrawBitmapString( "what REC sample: "+ ofToString( menu.whatRecSample ), 10, 80 );*/
}

//--------------------------------------------------------------
void ofApp::exit(){

    ///// R E C O R D I N G /////
    //recording.Exit();
    
}

//--------------------------------------------------------------


///< ----------- M A X I M I L I A N -------------
void ofApp::audioRequested(float * output, int bufferSize, int nChannels)
{
	
	ofxMaxiMix channel1;
	//double sample;
	double stereomix[2];
	
    if( initialBufferSize != bufferSize )
    {
        ofLog( OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize );
        return;
    }
    
    // Calculate audio vector by iterating over samples
    
    for ( int i = 0; i < bufferSize; i++ )
    {
        

        if ( menu.recModeOn[ menu.whatRecSample ] )
        {
            if ( recording[ menu.whatRecSample ].readyToPlay ) {
                if ( recording[ menu.whatRecSample ].loadFileIsDone ) {
                    if ( !recording[ menu.whatRecSample ].silenceWhenDeleting && !recording[ menu.whatRecSample ].muteAudioWhileRecording ) {
                        if ( triggerRecSamplePlay ) {
                            sample = recSample[ menu.whatRecSample ].playOnce( soundSpeed );
                        } else {
                            sample = 0.;
                        }
                    }
                }
            }
        }
        else if ( menu.fileSamplesModeOn )
        {
            if ( triggerFileSamplePlay ) {
                sample = fileSample[ menu.whatSample ].playOnce( soundSpeed );
            } else {
                sample = 0.;
            }
        }
        
        
        
            
        // Stereo panning
        channel1.stereo( sample, stereomix, panning );
        
        
        // Process FFT Spectrum
        if ( myFFT.process( sample ) )
        {
            myFFT.magsToDB();
            //myFFTOctAna.calculate( myFFT.magnitudes );
        }
        
        
        output[i*nChannels    ] = stereomix[0] * volume;
        output[i*nChannels + 1] = stereomix[1] * volume;
        
    }
    
    /*for ( int i = 0; i < bufferSize; i++ )
    {
        if ( recording.readyToPlay )
        {

            if ( menu.recModeOn[0] )
            {
                if ( !recording.silenceWhenDeleting )
                {
                    if ( !recording.muteAudioWhileRecording )
                    {
                        if ( recording.loadFileIsDone )
                        {
                            if ( triggerRecSamplePlay ) {
                                sample = recSample.playOnce( soundSpeed );
                            }
                        }
                    }
                    else
                    {
                        sample = 0.;
                    }
                }
            }
            
            else
            {
                if ( triggerFileSamplePlay ) {
                    sample = fileSample[menu.whatSample].playOnce( soundSpeed );
                }
            }
            
            // Stereo panning
            channel1.stereo( sample, stereomix, panning );
            
            
            // Process FFT Spectrum
            if ( myFFT.process( sample ) )
            {
                myFFT.magsToDB();
                //myFFTOctAna.calculate( myFFT.magnitudes );
            }
            
            
            output[i*nChannels    ] = stereomix[0] * volume;
            output[i*nChannels + 1] = stereomix[1] * volume;
        }
    }*/
    
    
    
    
    ///< Change sound speed
    if ( !menu.buttonIsPressed )
    {
        
        if ( touchPosY > ofGetHeight() / 2 )
        {
            soundSpeed = ofMap(touchPosY, ofGetHeight() / 2, ofGetHeight(), 1.0, 0.1, true);
        }
        else if ( touchPosY < ofGetHeight() / 2 )
        {
            soundSpeed = ofMap(touchPosY, ofGetHeight() / 2, 0, 1.0, 1.5, true);
        }
    }
    
    
    ///< Change sound panning
    panning = ofMap(touchPosX, 0, ofGetWidth(), 0.0, 1.0, true);
    
    
    ///< Fade out volume when finger is lifted
    if ( fingerIsLifted )
    {
        if ( volume >= 0.0 )
        {
            volume = volume - 0.005;
        }
    }
    
    
    ///< Stop playback when volume is 0 or less.
    if ( volume <= 0.0 )
    {
        triggerFileSamplePlay = false;
        triggerRecSamplePlay = false;
        //triggerPlay = false;
        fingerIsLifted = false;
    }
}



/*void ofApp::audioReceived(float *input, int bufferSize, int nChannels) {

}*/


//--------------------------------------------------------------
void ofApp::touchDown( ofTouchEventArgs & touch )
{
    ///< Update position of particles when touch is pressed
    touchPosX = touch.x;
    touchPosY = touch.y;
    
    
    ///< Set position of samples to 0 when finger is pressed
 
    fileSample[ menu.whatSample ].setPosition( 0. );
    recSample[ menu.whatRecSample ].setPosition( 0. );
    
    

    // Used to decrease volume when finger is lifted
    fingerIsLifted = false;
    
    
    // Used to check distance from finger to button. If finger is inside button: change sample.
    menu.distanceToButton( touch.x, touch.y );
    
    // Check if delete button is pressed
    recording[ menu.whatRecSample ].distanceToDeleteButton( touch.x, touch.y, menu.recModeOn );
    
    
    ///< Detect if finger is inside menu-button or del button
    if ( menu.buttonIsPressed )
    {
        volume = 0.0;
    }
    else if ( menu.recModeOn[ menu.whatRecSample ] && recording[ menu.whatRecSample ].delButtonIsPressed )
    {
        volume = 0.0;
    }
    else
    {
        triggerFileSamplePlay = true;
        triggerRecSamplePlay = true;
        //triggerPlay = true;
        volume = 1.0;
        // Set position of touchobject when touch is moved
        touchobject.Position( touch.x, touch.y );
    }
    
    touchIsDown = true;
}

//--------------------------------------------------------------
void ofApp::touchMoved( ofTouchEventArgs & touch )
{
    ///< Set position of touchobject when touch is moved
    if ( !menu.buttonIsPressed )
    {
        touchobject.Position( touch.x, touch.y );
    }
    
    ///< Update position of particles when touch moves
    touchPosX = touch.x;
    touchPosY = touch.y;
    
}

//--------------------------------------------------------------
void ofApp::touchUp( ofTouchEventArgs & touch )
{
    // Used to decrease volume when finger is lifted
    fingerIsLifted = true;
    
    // Used to change sound sample
    menu.buttonIsPressed = false;
    
    recording[ menu.whatRecSample ].delButtonIsPressed = false;
    
    recording[ menu.whatRecSample ].silenceWhenDeleting = false;

    touchIsDown = false;

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
