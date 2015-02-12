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
    
    button.Setup();

    
    triggerPlay             = false;
    soundSpeed              = 1.0;
    fingerIsLifted          = false;

    
    
    ///< M A X I M I L I A N
    sampleRate              = 44100;
    initialBufferSize       = 512;
    panning                 = 0.5;
    volume                  = 0.0;
    

    // Load samples
    for (int i = 0; i < NR_OF_SOUNDS; i++)
    {
        string fileNr = "Sound_Object_0" + ofToString( i ) + ".wav";
        fileSample[i].load( ofToDataPath( fileNr ) );
    }
    

    ///< openFrameworks sound stream
    ofSoundStreamSetup(2,0,this, sampleRate, initialBufferSize, 4);
    
    
    // Setup FFT
    fftSize = BANDS;
    myFFT.setup(fftSize, 1024, 256);
    //nAverages = 12;
    //myFFTOctAna.setup(sampleRate, fftSize/2, nAverages);


}

//--------------------------------------------------------------
void ofApp::update()
{

    
    ///< MAXIMILIAN
    float *val = myFFT.magnitudesDB;
    
    
    ///< Update spectrum analyze
    touchobject.Update(val, volume);
    
    
    ///< Increase radius of particles, and decrease alpha
    for( int i = 0; i < particles.size(); i++ )
    {
        particles[i].Update(soundSpeed, volume);
    }
    
    ///> Move Menu Button with finger
    button.Update( touchPosX );
    
    
    ///< Remove soundwave when alpha is 0
    ofRemove(particles, shouldRemove);
    
    
    ///< Add particles
    //if (volume > 0.0)
    if ( touchobject.spectrumVolume > 1200 && volume > 0.0 )
    {
        if (button.buttonIsPressed == false)// Do not add waves when pushing change-song-button.
        {
            particles.push_back( Particles(touchPosX, touchPosY, touchobject.SpectrumVolume(), touchobject.StartRadius(), touchobject.ColorBrightness() ) );
        }
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
    
    
    // Draw change-sound-sample-button
    button.Draw();
    
    
    /*
    ///< Debug text
    ofSetColor(100, 100, 100);
     ofDrawBitmapString("Touch X: " + ofToString(touchPosX), 10, 20);
     ofDrawBitmapString("Touch Y: " + ofToString(touchPosY), 10, 40);
     ofDrawBitmapString("What Sample: " + ofToString(button.whatSample), 10, 60);
     ofDrawBitmapString("Button is pressed: " + ofToString(button.buttonIsPressed), 10, 80);
    // ofDrawBitmapString("Button X: " + ofToString(button.posX), 10, 100);
    // ofDrawBitmapString("Button Y: " + ofToString(button.posY), 10, 120);
    // ofDrawBitmapString("Volume: " + ofToString(volume), 10, 140);
    // ofDrawBitmapString("Sound speed: " + ofToString(soundSpeed), 10, 160);
    // ofDrawBitmapString("Sound brightness: " + ofToString(touchobject.SoundBrightness()), 10, 180);
    // ofDrawBitmapString("Spectrum volume: " + ofToString(touchobject.SpectrumVolume()), 10, 200);
    ofDrawBitmapString("FPS: " + ofToString(ofGetFrameRate()), 10, 220);
    // ofDrawBitmapString("Start radius: " + ofToString(touchobject.startRadius), 10, 240);
    // ofDrawBitmapString("Delta time: " + ofToString(ofGetLastFrameTime()), 10, 260);
    // ofDrawBitmapString("Touchobject radius: " + ofToString(touchobject.radius), 10, 280);
    // ofDrawBitmapString("How many particless: " + ofToString(particles.size()), 10, 300);
    // ofDrawBitmapString("Finger is lifted: " + ofToString(fingerIsLifted), 10, 320);
    */
    
}

//--------------------------------------------------------------
void ofApp::exit(){

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
        if ( triggerPlay )
        {
           sample = fileSample[button.whatSample].playOnce( soundSpeed ); // No loop
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

    
    
    ///< Change sound speed
    if ( touchPosY > ofGetHeight() / 2 )
    {
        soundSpeed = ofMap(touchPosY, ofGetHeight() / 2, ofGetHeight(), 1.0, 0.1, true);
    }
    else if ( touchPosY < ofGetHeight() / 2 )
    {
        soundSpeed = ofMap(touchPosY, ofGetHeight() / 2, 0, 1.0, 1.5, true);
    }
    //soundSpeed = ofMap(touchPosY, ofGetHeight(), 0, 0.0, 1.0, true);
    
    
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



//--------------------------------------------------------------
void ofApp::touchDown( ofTouchEventArgs & touch )
{
    ///< Update position of particles when touch is pressed
    touchPosX = touch.x;
    touchPosY = touch.y;
    
    
    ///< Set position of samples to 0 when finger is pressed
    for (int i = 0; i < NR_OF_SOUNDS; i++)
    {
        fileSample[i].setPosition( 0. );
    }


    // Used to decrease volume when finger is lifted
    fingerIsLifted = false;
    
    
    // Used to check distance from finger to button. If finger is inside button: change sample.
    button.DistanceToButton(touch.x, touch.y);
    
    
    ///< Detect if finger is inside change-sample-button
    if (button.buttonIsPressed == true)
    {
        volume = 0.0;
    }
    else
    {
        triggerPlay = true;
        volume = 1.0;
        // Set position of touchobject when touch is moved
        touchobject.Position(touch.x, touch.y, button.posX, button.posY, button.radius);
    }
}

//--------------------------------------------------------------
void ofApp::touchMoved( ofTouchEventArgs & touch )
{
    ///< Set position of touchobject when touch is moved
    touchobject.Position(touch.x, touch.y, button.posX, button.posY, button.radius);
    
    
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
    button.buttonIsPressed = false;

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
