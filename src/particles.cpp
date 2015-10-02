
#include "particles.h"


///< Get the position, color brightness and radius of soundwaves
// --------------------------------------------------------
Particles::Particles( float touchX, float touchY, float specVolume, float startRadius, float colorBrightness, float soundSpeed )
{
    pos.set(touchX, touchY);
    circleColorBrightness   = colorBrightness;
    radius                  = startRadius; // Radius from specVolume
    myLineWidth             = 1;
    alpha                   = 255;
    mySoundSpeed            = soundSpeed;
    myScreenWidth           = ofGetScreenWidth();

}
// --------------------------------------------------------



///< Increase radius of soundwaves, and decrease alpha
// --------------------------------------------------------
void Particles::Update( float soundSpeed, double sample ) {
    

    radius = radius + ( 0.05 * myScreenWidth * mySoundSpeed * ofGetLastFrameTime() );
    
    if ( sample != 0.0 ) {
        alpha = alpha - ( 70 * ofGetLastFrameTime() );
    } else {
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
    color.setBrightness( circleColorBrightness );
    ofSetColor( color );
    //ofEnableAntiAliasing();
    ofSetCircleResolution( 50 );
    ofSetLineWidth( myLineWidth );
    ofCircle( pos.x, pos.y, radius );
}
// --------------------------------------------------------

