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
    ofSetOrientation( OF_ORIENTATION_90_LEFT );
    
    touchobject.Setup();
    
    menu.Setup();

    
    triggerPlay             = false;
    soundSpeed              = 1.0;
    fingerIsLifted          = false;
    addParticlesTimer       = 0;

    
    
    ///< M A X I M I L I A N
    sampleRate              = 44100;
    initialBufferSize       = 512;
    panning                 = 0.5;
    volume                  = 0.0;
    


    ///< openFrameworks sound stream
    //ofSoundStreamSetup( 2, 0, this, sampleRate, initialBufferSize, 4 );
    soundStream.setup( this, 2, 1, sampleRate, initialBufferSize, 4 );
    
    
    // Setup FFT
    fftSize = BANDS;
    myFFT.setup(fftSize, 1024, 256);
    //nAverages = 12;
    //myFFTOctAna.setup(sampleRate, fftSize/2, nAverages);


    ///// R E C O R D I N G /////
    recording.Setup();
    

    recSample.load( recording.myRecString );
    
    
    // Load samples
    for (int i = 1; i < NUM_OF_SOUNDS + 1; i++)
    {
        string fileNr = "Sound_Object_0" + ofToString( i ) + ".wav";
        fileSample[i].load( ofToDataPath( fileNr ) );
    }
    
    
}

//--------------------------------------------------------------
void ofApp::update()
{

    
    
    ///< MAXIMILIAN
    float *val = myFFT.magnitudesDB;
    
    
    ///< Update spectrum analyze
    touchobject.Update(val, volume);

    
    ///< Increase radius of particles, and decrease alpha

    for( int i = 0; i < particles.size(); i++ ) {
        particles[i].Update(soundSpeed, volume);
    }

    
    
    ///> Move Menu Button with finger
    menu.Update( touchPosX );
    
    
    ///< Remove soundwave when alpha is 0
    ofRemove(particles, shouldRemove);
    
    
    ///< Add particles
    //if (volume > 0.0)

    if ( !menu.buttonIsPressed && recording.readyToPlay ) {// Do not add waves when pushing change-song-button.
        
        if ( touchobject.spectrumVolume > 1200 && volume > 0.0 ) {
            
            addParticlesTimer += ofGetLastFrameTime();
            if ( addParticlesTimer >= 0.01 ) {
                particles.push_back( Particles(touchPosX, touchPosY, touchobject.SpectrumVolume(), touchobject.StartRadius(), touchobject.ColorBrightness() ) );
                addParticlesTimer = 0;
            }
        }
    }
    

    ///// R E C O R D I N G /////
    if ( menu.recModeOn ) {
        recording.Update( touchPosX, touchPosY, touchIsDown );
    }
    
    if ( recording.saveFileIsDone ) {
        recSample.load( recording.myRecString );
        recording.saveFileIsDone = 0;
    }
    
    
    
}

//--------------------------------------------------------------
void ofApp::draw()
{
    ///< Draw touchobject
    touchobject.Draw();
    
    
    ///< Draw particles
    for( int i = 0; i < particles.size(); i++ )
    {
        particles[i].Draw();
    }
    
    
    // Draw menu-button
    menu.Draw();
    
    
    
    ///< Debug text
    ofSetColor(100, 100, 100);

    //ofDrawBitmapString("What Sample: " + ofToString(menu.whatSample), 10, 60);
    //ofDrawBitmapString("What Menu Postition Number: " + ofToString(menu.whatMenuNum), 10, 120);
    //ofDrawBitmapString("Rec mode is on: " + ofToString(menu.recModeOn), 10, 140);
    //ofDrawBitmapString("About Bit20 is on: " + ofToString(menu.aboutBit20On), 10, 160);
    //ofDrawBitmapString("File browser is on: " + ofToString(menu.fileBrowserOn), 10, 180);
    //ofDrawBitmapString("File path: " + ofToString(recording.myRecString), 10, 200);
    //ofDrawBitmapString("Del button is pressed: " + ofToString(recording.delButtonIsPressed), 10, 220);
    //ofDrawBitmapString("myTimer: " + ofToString(recording.myTimer), 10, 240);
    //ofDrawBitmapString("del button time: " + ofToString(recording.delButtonTime), 10, 260);
    //ofDrawBitmapString("Ready to play: " + ofToString(recording.readyToPlay), 10, 280);
    //ofDrawBitmapString("Wait for save time " + ofToString(recording.waitForSaveFileTime), 10, 300);
    //ofDrawBitmapString("Wait for save bool " + ofToString(recording.willWaitForSave), 10, 320);
    
    
    ///// R E C O R D I N G /////
    if ( menu.recModeOn ) {
        recording.Draw();
    }
}

//--------------------------------------------------------------
void ofApp::exit(){

    ///// R E C O R D I N G /////
    recording.Exit();
    
}

//--------------------------------------------------------------






///< ----------- M A X I M I L I A N -------------
void ofApp::audioRequested(float * output, int bufferSize, int nChannels)
{
	
	ofxMaxiMix channel1;
	double sample;
	double stereomix[2];
	
    if( initialBufferSize != bufferSize )
    {
        ofLog( OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize );
        return;
    }
    
    
    // Calculate audio vector by iterating over samples
    for ( int i = 0; i < bufferSize; i++ )
    {
        if ( recording.readyToPlay ) {
            
        
            if ( triggerPlay )
            {
                
                if ( menu.recModeOn ) {
                    sample = recSample.playOnce( soundSpeed );
                } else {
                    sample = fileSample[menu.whatSample].playOnce( soundSpeed ); // No loop
                }
            }
            else
                sample = 0.;
            
            
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
    }

    
    
    ///< Change sound speed
    if ( !menu.buttonIsPressed ) {
        
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
        triggerPlay = false;
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
    for (int i = 0; i < NUM_OF_SOUNDS; i++) {
        fileSample[i].setPosition( 0. );
        recSample.setPosition( 0. );
    }
    

    // Used to decrease volume when finger is lifted
    fingerIsLifted = false;
    
    
    // Used to check distance from finger to button. If finger is inside button: change sample.
    menu.DistanceToButton(touch.x, touch.y);
    
    
    ///< Detect if finger is inside menu-button
    if (menu.buttonIsPressed == true) {
        volume = 0.0;
    } else {
        triggerPlay = true;
        volume = 1.0;
        // Set position of touchobject when touch is moved
        touchobject.Position( touch.x, touch.y );
    }
    
    touchIsDown = 1;
}

//--------------------------------------------------------------
void ofApp::touchMoved( ofTouchEventArgs & touch )
{
    ///< Set position of touchobject when touch is moved
    if ( !menu.buttonIsPressed ) {
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

    
    touchIsDown = 0;
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
