#include "ofApp.h"


///< Check if alpha is 0. Return true or false
bool shouldRemove(Soundwave &p){
    if(p.alpha <= 0 )return true;
    else return false;
}


//--------------------------------------------------------------
void ofApp::setup(){	
    ///< Setup framerate, background color and show mouse
    ofSetFrameRate(60);
    ofBackground(0, 0, 0);
    ofShowCursor();
    
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
    fileSample1.load(ofToDataPath("frosk.wav"));
    fileSample2.load(ofToDataPath("apekatt.wav"));
    fileSample3.load(ofToDataPath("flodhest.wav"));
    fileSample4.load(ofToDataPath("hest.wav"));
    fileSample5.load(ofToDataPath("kattepus.wav"));
    fileSample6.load(ofToDataPath("and.wav"));

    
    ///< openFrameworks sound stream
    ofSoundStreamSetup(2,0,this, sampleRate, initialBufferSize, 4); // OF Sound Stream
    
    
    // Setup FFT
    fftSize = BANDS;
    nAverages = 12;
    myFFT.setup(fftSize, 1024, 256);
    myFFTOctAna.setup(sampleRate, fftSize/2, nAverages);



    
}

//--------------------------------------------------------------
void ofApp::update(){

    
    ///< MAXIMILIAN
    float *val = myFFT.magnitudesDB;
    
    ///< Update sound engine, spectrum and average spectrum
    soundobject.Update(val, volume);
    
    
    
    ///< Increase radius of soundwaves, and decrease alpha
    for(int i = 0; i < soundwaves.size(); i++){
        soundwaves[i].Update(soundSpeed, volume);
    }
    
    
    ///< Remove soundwave when alpha is 0
    ofRemove(soundwaves, shouldRemove);
    
    
    
    ///< Add soundwaves
    if (volume > 0.0) {
        if (button.fingerIsInside == false) {
            if (ofGetElapsedTimef() > myTimer + 0.01) {
                soundwaves.push_back( Soundwave(touchPosX, touchPosY, soundobject.SpectrumVolume(), soundobject.StartRadius(), soundobject.ColorBrightness() ) );
                myTimer = ofGetElapsedTimef();
            }
        }
    }
    

    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    

    
    ///< Draw soundobject
    soundobject.Draw();
    
    
    
    ///< Draw soundwaves
    for(int i = 0; i < soundwaves.size(); i++){
        soundwaves[i].Draw();
    }
    
    
    button.Draw();
    
    
    
    ///< Debug text
    ofSetColor(100, 100, 100);
    ofDrawBitmapString("X: " + ofToString(touchPosX), 10, 20);
    ofDrawBitmapString("Y: " + ofToString(touchPosY), 10, 40);
    ofDrawBitmapString("What Sample: " + ofToString(button.whatSample), 10, 60);
    ofDrawBitmapString("Finger is inside button: " + ofToString(button.fingerIsInside), 10, 80);
    ofDrawBitmapString("Button X: " + ofToString(button.posX), 10, 100);
    ofDrawBitmapString("Button Y: " + ofToString(button.posY), 10, 120);
    ofDrawBitmapString("Volume: " + ofToString(volume), 10, 140);
    ofDrawBitmapString("Sound speed: " + ofToString(soundSpeed), 10, 160);
    ofDrawBitmapString("Sound brightness: " + ofToString(soundobject.SoundBrightness()), 10, 180);
    ofDrawBitmapString("Spectrum volume: " + ofToString(soundobject.SpectrumVolume()), 10, 200);
    
     
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------

///< M A X I M I L I A N
void ofApp::audioRequested(float * output, int bufferSize, int nChannels){
    
    
    if( initialBufferSize != bufferSize ){
        ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
        return;
    }
    
    
    
    
    if (triggerPlay) {
        // itererover alle samolene og regner ut samplene en etter en
        for (int i = 0; i < bufferSize; i++){
            switch (button.whatSample) {
                case 1:
                    sample = fileSample1.play(soundSpeed);
                    break;
                case 2:
                    sample = fileSample2.play(soundSpeed);
                    break;
                case 3:
                    sample = fileSample3.play(soundSpeed);
                    break;
                case 4:
                    sample = fileSample4.play(soundSpeed);
                    break;
                case 5:
                    sample = fileSample5.play(soundSpeed);
                    break;
                case 6:
                    sample = fileSample6.play(soundSpeed);
                    break;
                default:
                    break;
            }
            
            
            if (button.fingerIsInside == false) {
                channel1.stereo(sample, outputs1, panning);
            }
            
            // Process FFT Spectrum
            if (myFFT.process(sample)) {
                myFFT.magsToDB();
                myFFTOctAna.calculate(myFFT.magnitudes);
            }
            
            output[i*nChannels    ] = outputs1[0] * volume;
            output[i*nChannels + 1] = outputs1[1] * volume;
        }
    }

    
    ///< Change sound speed
    soundSpeed = ofMap(touchPosY, ofGetHeight(), 0, 0.1, 1.0, true);
    
    ///< Change sound panning
    panning = ofMap(touchPosX, 0, ofGetWidth(), 0.0, 1.0, true);
    
    
    ///< Fade out volume when finger is lifted
    if (fingerIsLifted) {
        if (volume >= 0.0) {
            volume = volume - 0.005;
        }
    }
    
    ///< Stop playback
    if (volume <= 0.0) {
        triggerPlay = false;
        fingerIsLifted = false;
    }
    
    
    
    
}



//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    ///< Update position of soundwaves when mouse is pressed
    touchPosX = touch.x;
    touchPosY = touch.y;
    
    ///< Set position of samples to 0 when finger is lifted
    fileSample1.setPosition(0.);
    fileSample2.setPosition(0.);
    fileSample3.setPosition(0.);
    fileSample4.setPosition(0.);
    fileSample5.setPosition(0.);
    fileSample6.setPosition(0.);


    
    fingerIsLifted = false;
    

    button.DistanceToButton(touch.x, touch.y);
    
    
    ///< Detect if finger is inside change-sample-button
    if (button.fingerIsInside == true)
    {
        volume = 0.0;
    }
    else
    {
        triggerPlay = true;
        volume = 1.0;
        soundobject.Position(touch.x, touch.y, button.posX, button.posY, button.radius);
    }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    ///< Set position of soundobject when mouse is moved
    soundobject.Position(touch.x, touch.y, button.posX, button.posY, button.radius);
    
    
    ///< Update position of soundwaves when touch moves
    touchPosX = touch.x;
    touchPosY = touch.y;
    
    
 
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    

    


    
    fingerIsLifted = true;
    
    button.fingerIsInside = false;
    
    
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
