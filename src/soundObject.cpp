
#include "soundObject.h"




// --------------------------------------------------------
///< Constructor for Soundobject
Soundobject::Soundobject() {

}
// --------------------------------------------------------


// --------------------------------------------------------
void Soundobject::Setup() {

    
    // Set spectrum values to 0
    for (int i = 0; i<BANDS; i++) {
        spectrum[i] = 0.0f;
    }
    
    alpha = 255;
    
}
// --------------------------------------------------------


// --------------------------------------------------------
void Soundobject::Update(float *val, float volume) {
    

    
    for (int i = 0; i<BANDS; i++) {
        
        spectrum[i] *= 0.97; // Slow decreasing
        spectrum[i] = max( spectrum[i], val[i]);
    }
    // --------------------
    
    // --------------------
    ///< Get average value from sound spectrum
    float a = 0;
    float b = 0;
    
    for (int i = 0; i<BANDS; i++) {
        a += (i + 1) * spectrum[i];
        b += spectrum[i];
    }
    
    // Avoid division by 0 for silence
    if (a == 0)
        b = 1;
    
    soundBrightness = a / b;
    spectrumVolume = b;
    // --------------------


    



    
}
// --------------------------------------------------------




// --------------------------------------------------------
float Soundobject::SpectrumVolume() {
    return spectrumVolume;
    
}
// --------------------------------------------------------

float Soundobject::SoundBrightness()
{
    return soundBrightness;
}


// --------------------------------------------------------
float Soundobject::ColorBrightness() {
   
    colorBrightness = ofMap( soundBrightness, 500, 750, 255, 10 );
    
    return colorBrightness;
    
}
// --------------------------------------------------------





// --------------------------------------------------------
float Soundobject::StartRadius() {
    
    ///< Start radius for soundwaves based on the size of the largest soundobject ring.
    //startRadius = spectrumVolume / 30;
    startRadius = ofMap( spectrumVolume, 1300, 1600, 10, 50 );
    return startRadius;
    
}
// --------------------------------------------------------



// --------------------------------------------------------
void Soundobject::Position(float touchX, float touchY, float buttonX, float buttonY, float buttonRadius) {


    distanceToButton = sqrt( (touchX - buttonX) * (touchX - buttonX) + (touchY - buttonY) * (touchY - buttonY) ) ;
    
    if (distanceToButton > buttonRadius) {
        
    }
    
    pos.set(touchX, touchY);
}
// --------------------------------------------------------



// --------------------------------------------------------
void Soundobject::Draw() {
    //ofEnableAlphaBlending();
    //OF_BLENDMODE_SCREEN;

    color = ofColor(255, 255, 255, alpha);
    //color.setBrightness(mySpecVolume / 20);
    color.setBrightness( colorBrightness );
    ofSetColor(color);
    ofSetCircleResolution(100);
    ofFill();
    ofCircle(pos.x, pos.y, startRadius);


    
    ///< Spectrum
    ofSetColor(100, 100, 100);
    for (int i = 0; i < 1024; i++) {
        ofRect(5 + i * 2, ofGetHeight(), 1, -spectrum[i] * 10);
    }
    
    
    
    
}
// --------------------------------------------------------





