
#include "particles.h"


///< Get the position, color brightness and radius of soundwaves
// --------------------------------------------------------
Particles::Particles( float touchX, float touchY, float specVolume, float startRadius, float colorBrightness, float soundSpeed )
{
    pos.set(touchX, touchY);
    //colorBrightness = specVolume;
    waveColorBrightness     = colorBrightness;
    radius                  = startRadius; // Radius from specVolume
    myLineWidth             = 1;
    alpha                   = 255;
    mySoundSpeed            = soundSpeed;
}
// --------------------------------------------------------



///< Increase radius of soundwaves, and decrease alpha
// --------------------------------------------------------
void Particles::Update( float soundSpeed, float volume ) {
    
    //radius = radius + 40 * s;
    //radius = radius + 1 * soundSpeed;
    //radius = radius + 1 * soundSpeed * ofGetLastFrameTime() * 100;
    
    //radius = radius + ( 0.05 * ofGetScreenWidth() * soundSpeed * ofGetLastFrameTime() );
    radius = radius + ( 0.05 * ofGetScreenWidth() * mySoundSpeed * ofGetLastFrameTime() );
    
    
    if ( volume == 1 ) {
        //alpha = alpha - 1;
        alpha = alpha - ( 50 * ofGetLastFrameTime() );
    } else {
        //alpha = alpha - 1.5;
        alpha = alpha - ( 150 * ofGetLastFrameTime() );
    }
}
// --------------------------------------------------------




///< Draw the soundwave circles
// --------------------------------------------------------
void Particles::Draw()
{
    ofNoFill();
    color = ofColor( 255, 255, 255, alpha );
    //color.setBrightness(colorBrightness / 25);
    color.setBrightness( waveColorBrightness );
    ofSetColor( color );
    ofEnableAntiAliasing();
    ofSetCircleResolution( 100 );
    ofSetLineWidth( myLineWidth );
    ofCircle( pos.x, pos.y, radius );
}
// --------------------------------------------------------

