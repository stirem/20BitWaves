
#include "touchObject.h"

// --------------------------------------------------------
///< Constructor for Touchobject
Touchobject::Touchobject()
{

}
// --------------------------------------------------------


// --------------------------------------------------------
void Touchobject::Setup()
{
    // Set spectrum values to 0
    for (int i = 0; i<BANDS; i++) {
        spectrum[i] = 0.0f;
    }
    
    soundBrightness     = 0;
    alpha               = 255;
    spectrumVolume      = 0;
    colorBrightness     = 0;
    radius              = 0;
    
}
// --------------------------------------------------------


// --------------------------------------------------------
void Touchobject::Update( float *val, double sample )
{
    // Sound spectrum
    for (int i = 0; i < BANDS; i++)
    {
        spectrum[i] *= 0.97; // Slow decreasing
        spectrum[i] = max( spectrum[i], val[i]);
    }
    // --------------------
    
    
    // --------------------
    ///< Get average value from sound spectrum
    float a = 0;
    float b = 0;
    
    for ( int i = 0; i < BANDS/2; i++ )
    {
        a += ( i + 1 ) * spectrum[i];
        b += spectrum[i];
    }
    
    // Avoid division by 0 for silence
    if ( a == 0 ) {
        b = 1;
    }
    
    soundBrightness = a / b;
    spectrumVolume = b;
    // --------------------

    
    // Fade down soundobject when not playing
    /*if ( spectrumVolume < 500 )
    {
        if ( colorBrightness > 0 )
        {
            colorBrightness = colorBrightness - 5;
        }
        if( alpha > 0 ) alpha = alpha - 5;
        
        if ( radius >= 0 ) {
            radius = radius - 1;
        }
        
    } else {
        alpha = 255;
    }*/
    
    if ( sample == 0 ) {
        if ( alpha > 0 ) {
            alpha -= 15;
        }
    } else {
        alpha = 255;
    }
    
}
// --------------------------------------------------------


// --------------------------------------------------------
float Touchobject::SpectrumVolume()
{
    return spectrumVolume;
}
// --------------------------------------------------------


// --------------------------------------------------------
float Touchobject::SoundBrightness()
{
    return soundBrightness;
}
// --------------------------------------------------------


// --------------------------------------------------------
float Touchobject::ColorBrightness()
{
    
    
    colorBrightness = ofMap( soundBrightness, 10, 50, 20, 255 );
    
    return colorBrightness;
    
}
// --------------------------------------------------------


// --------------------------------------------------------
float Touchobject::StartRadius()
{
    
    float spectrumValue = 0;
    float startRadius = 0;
    
    spectrumValue = ofClamp( spectrumVolume, 1, 2000 );
    
    startRadius = ofMap( spectrumValue, 1, 1600, 0, ofGetWidth() * 0.04 );
    
    radius = startRadius;
    
    return startRadius;
    
}
// --------------------------------------------------------


// --------------------------------------------------------
void Touchobject::Position( float touchX, float touchY )
{
    pos.set(touchX, touchY);
}
// --------------------------------------------------------


// --------------------------------------------------------
void Touchobject::Draw()
{
    // DEBUGGING TEXT
    ofSetColor( 255 );
    for ( int i = 3; i < 20; i++ ) {
        ofDrawBitmapString( "spectrum volume: " + ofToString( spectrumVolume ), 10, 130 );
        ofDrawBitmapString( "sound brightness: " + ofToString( soundBrightness ), 10, 150 );
        ofDrawBitmapString( "radius: " + ofToString( StartRadius() ), 10, 170 );
        //ofDrawBitmapString( "spectrum: " + ofToString( i ) + ": " + ofToString( spectrum[i] ), 10, 150 + (i * 10));
    
    }
    // DEBUGGING SPECTRUM
    ofSetColor(255);
    ofSetRectMode(OF_RECTMODE_CORNER);
    ofFill();
    for (int i = 0; i < BANDS; i++) {
        ofRect(10 + i * 2, ofGetHeight(), 1, -spectrum[i] * 10);
    }
    

    
    //ofEnableAlphaBlending();
    //OF_BLENDMODE_SCREEN;

    color = ofColor( 255, 255, 255, alpha );
    color.setBrightness( colorBrightness );
    ofSetColor( color );
    ofSetCircleResolution( 100 );
    ofFill();
    ofCircle( pos.x, pos.y, radius );


    
    ///< Spectrum
    /*ofSetColor(100, 100, 100);
    for (int i = 0; i < BANDS; i++) {
        ofRect(5 + i * 2, ofGetHeight(), 1, -spectrum[i] * 10);
    }*/

    
}
// --------------------------------------------------------





