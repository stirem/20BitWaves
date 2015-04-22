
#include "recSpectrum.h"


// --------------------------------------------------------
RecSpectrum::RecSpectrum( float meter, int recSpectrumPosXinc )
{
    posX                    = ofGetWidth() * 0.001 + recSpectrumPosXinc;
    posY                    = ofGetHeight() * 0.25;
    width                   = ofGetWidth() * 0.001;
    
    if ( meter > 0 ) {
        height = meter * (ofGetHeight() * 0.001);
    } else {
        height = 2;
    }

}
// --------------------------------------------------------



// --------------------------------------------------------
void RecSpectrum::Draw()
{
    ofFill();
    ofSetColor( 255, 0, 0 );
    ofRect( posX, posY, width, -height );
    
}
// --------------------------------------------------------

