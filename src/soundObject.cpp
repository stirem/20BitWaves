
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
    
}
// --------------------------------------------------------


// --------------------------------------------------------
void Soundobject::Update(float *v) {
    

    
    for (int i = 0; i<BANDS; i++) {
        
        spectrum[i] *= 0.97; // Slow decreasing
        spectrum[i] = max( spectrum[i], v[i]);
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
    
    mySoundBrightness = a / b;
    mySpecVolume = b;
    // --------------------



}
// --------------------------------------------------------




// --------------------------------------------------------
float Soundobject::SpectrumVolume() {
    return mySpecVolume;
    
}
// --------------------------------------------------------




// --------------------------------------------------------
float Soundobject::SoundBrightness() {
   return mySoundBrightness;
    
}
// --------------------------------------------------------





// --------------------------------------------------------
float Soundobject::StartRadius() {
    
    ///< Start radius for soundwaves based on the size of the largest soundobject ring.
    return mySpecVolume;
    
}
// --------------------------------------------------------



// --------------------------------------------------------
void Soundobject::Position(float x, float y) {
    pos.set(x, y);
}
// --------------------------------------------------------



// --------------------------------------------------------
void Soundobject::Draw() {
    //ofEnableAlphaBlending();
    //OF_BLENDMODE_SCREEN;

    color = ofColor(255, 255, 255, 255);
    color.setBrightness(mySpecVolume / 20);
    //color.setHue(mySoundBrightness * 20);
    ofSetColor(color);
    ofSetCircleResolution(100);
    ofFill();
    ofCircle(pos.x, pos.y, mySpecVolume / 40);

    
    
    ///< Spectrum
    ofSetColor(100, 100, 100);
    for (int i = 0; i < 1024; i++) {
        ofRect(10 + i * 2, ofGetHeight() - 30, 1, -spectrum[i] * 10);
    }
    
    
    
    
}
// --------------------------------------------------------





