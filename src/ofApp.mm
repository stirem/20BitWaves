#include "ofApp.h"


///< Remove soundwave vectors if alpha is 0 or less.
bool shouldRemove(Soundwave &p)
{
    if(p.alpha <= 0 )return true;
    else return false;
}


//--------------------------------------------------------------
void ofApp::setup()
{
    ///< Setup framerate, background color and show mouse
    ofSetFrameRate(60);
    ofBackground(0, 0, 0);
    
    soundobject.Setup();
    
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
    fileSample1.load(ofToDataPath("Sound_Object_01.wav"));
    fileSample2.load(ofToDataPath("Sound_Object_02.wav"));
    fileSample3.load(ofToDataPath("Sound_Object_03.wav"));
    fileSample4.load(ofToDataPath("Sound_Object_04.wav"));
    fileSample5.load(ofToDataPath("Sound_Object_05.wav"));
    fileSample6.load(ofToDataPath("Sound_Object_06.wav"));
    fileSample7.load(ofToDataPath("Sound_Object_07.wav"));
    fileSample8.load(ofToDataPath("Sound_Object_08.wav"));
    fileSample9.load(ofToDataPath("Sound_Object_09.wav"));

    
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
    soundobject.Update(val, volume);
    
    
    
    ///< Increase radius of soundwaves, and decrease alpha
    for( int i = 0; i < soundwaves.size(); i++ )
    {
        soundwaves[i].Update(soundSpeed, volume);
    }
    
    
    ///< Remove soundwave when alpha is 0
    ofRemove(soundwaves, shouldRemove);
    
    
    
    ///< Add soundwaves
    //if (volume > 0.0)
    if ( soundobject.spectrumVolume > 1200 && volume > 0.0 )
    {
        if (button.buttonIsPressed == false)// Do not add waves when pushing change-song-button.
        {
            soundwaves.push_back( Soundwave(touchPosX, touchPosY, soundobject.SpectrumVolume(), soundobject.StartRadius(), soundobject.ColorBrightness() ) );
        }
    }
    

    
    
}

//--------------------------------------------------------------
void ofApp::draw()
{
    

    
    ///< Draw soundobject
    soundobject.Draw();
    
    
    
    ///< Draw soundwaves
    for( int i = 0; i < soundwaves.size(); i++ )
    {
        soundwaves[i].Draw();
    }
    
    
    // Draw change-sound-sample-button
    button.Draw();
    
    
    
    ///< Debug text
    ofSetColor(100, 100, 100);
    ofDrawBitmapString("Touch X: " + ofToString(touchPosX), 10, 20);
    ofDrawBitmapString("Touch Y: " + ofToString(touchPosY), 10, 40);
    ofDrawBitmapString("What Sample: " + ofToString(button.whatSample), 10, 60);
    ofDrawBitmapString("Button is pressed: " + ofToString(button.buttonIsPressed), 10, 80);
    ofDrawBitmapString("Button X: " + ofToString(button.posX), 10, 100);
    ofDrawBitmapString("Button Y: " + ofToString(button.posY), 10, 120);
    ofDrawBitmapString("Volume: " + ofToString(volume), 10, 140);
    ofDrawBitmapString("Sound speed: " + ofToString(soundSpeed), 10, 160);
    ofDrawBitmapString("Sound brightness: " + ofToString(soundobject.SoundBrightness()), 10, 180);
    ofDrawBitmapString("Spectrum volume: " + ofToString(soundobject.SpectrumVolume()), 10, 200);
    ofDrawBitmapString("FPS: " + ofToString(ofGetFrameRate()), 10, 220);
    ofDrawBitmapString("Start radius: " + ofToString(soundobject.startRadius), 10, 240);
    ofDrawBitmapString("Delta time: " + ofToString(ofGetLastFrameTime()), 10, 260);
    ofDrawBitmapString("Soundobject radius: " + ofToString(soundobject.radius), 10, 280);
    ofDrawBitmapString("How many soundwaves: " + ofToString(soundwaves.size()), 10, 300);
     
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------




///< ----------- M A X I M I L I A N -------------
void ofApp::audioRequested(float * output, int bufferSize, int nChannels)
{
    
    
    if( initialBufferSize != bufferSize )
    {
        ofLog( OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize );
        return;
    }
    
    
    
    
    if ( triggerPlay )
    {
        // itererover alle samolene og regner ut samplene en etter en
        for ( int i = 0; i < bufferSize; i++ )
        {
            switch ( button.whatSample )
            {
                case 1:
                    sample = fileSample1.play( soundSpeed );
                    break;
                case 2:
                    sample = fileSample2.play( soundSpeed );
                    break;
                case 3:
                    sample = fileSample3.play( soundSpeed );
                    break;
                case 4:
                    sample = fileSample4.play( soundSpeed );
                    break;
                case 5:
                    sample = fileSample5.play( soundSpeed );
                    break;
                case 6:
                    sample = fileSample6.play( soundSpeed );
                    break;
                case 7:
                    sample = fileSample7.play( soundSpeed );
                    break;
                case 8:
                    sample = fileSample8.play( soundSpeed );
                    break;
                case 9:
                    sample = fileSample9.play( soundSpeed );
                    break;
                default:
                    break;
            }
            
            
            // Play sample when finger is not inside change-sound-button.
            if ( button.buttonIsPressed == false )
            {
                channel1.stereo( sample, outputs1, panning );
            }
            
            // Process FFT Spectrum
            if ( myFFT.process( sample ) )
            {
                myFFT.magsToDB();
                //myFFTOctAna.calculate( myFFT.magnitudes );
            }
            
            output[i*nChannels    ] = outputs1[0] * volume;
            output[i*nChannels + 1] = outputs1[1] * volume;
        }
    }

    
    ///< Change sound speed
    soundSpeed = ofMap(touchPosY, ofGetHeight(), 0, 0.0, 1.0, true);
    
    
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
    ///< Update position of soundwaves when touch is pressed
    touchPosX = touch.x;
    touchPosY = touch.y;
    
    ///< Set position of samples to 0 when finger is pressed
    fileSample1.setPosition(0.);
    fileSample2.setPosition(0.);
    fileSample3.setPosition(0.);
    fileSample4.setPosition(0.);
    fileSample5.setPosition(0.);
    fileSample6.setPosition(0.);
    fileSample7.setPosition(0.);
    fileSample8.setPosition(0.);
    fileSample9.setPosition(0.);


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
        // Set position of soundobject when touch is moved
        soundobject.Position(touch.x, touch.y, button.posX, button.posY, button.radius);
    }
}

//--------------------------------------------------------------
void ofApp::touchMoved( ofTouchEventArgs & touch )
{
    ///< Set position of soundobject when touch is moved
    soundobject.Position(touch.x, touch.y, button.posX, button.posY, button.radius);
    
    
    ///< Update position of soundwaves when touch moves
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
