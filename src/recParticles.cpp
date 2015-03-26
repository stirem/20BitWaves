
#include "recParticles.h"


// --------------------------------------------------------
RecParticles::RecParticles( float meter )
{
    posX                    = ofGetWidth() * 0.5;
    posY                    = ofGetHeight() * 0.5;
    colorBrightness         = ofMap(meter, 0, 200, 20, 255);
    radius                  = ofGetScreenWidth() * 0.9;
    myLineWidth             = 1;
    alpha                   = 255;

}
// --------------------------------------------------------




// --------------------------------------------------------
void RecParticles::Update( bool isRecording ) {
    
    radius = radius - ( 0.3 * ofGetScreenWidth() * ofGetLastFrameTime() );
    
    if ( !isRecording ) {
        if (alpha > 0 ) {
            alpha = alpha - ( 200 * ofGetLastFrameTime() );
        }
    }


}
// --------------------------------------------------------




// --------------------------------------------------------
void RecParticles::Draw()
{
    ofNoFill();
    color = ofColor( 255, 0, 0, alpha );
    color.setBrightness( colorBrightness );
    ofSetColor( color );
    ofEnableAntiAliasing();
    ofSetCircleResolution( 100 );
    ofSetLineWidth( myLineWidth );
    ofCircle( posX, posY, radius );
}
// --------------------------------------------------------

