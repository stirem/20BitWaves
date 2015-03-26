
#include "recSpectrum.h"


// --------------------------------------------------------
RecSpectrum::RecSpectrum( float meter, int recSpectrumPosXinc )
{
    posX                    = ofGetWidth() * 0.001 + recSpectrumPosXinc;
    posY                    = ofGetHeight() * 0.25;
    width                   = ofGetWidth() * 0.001;
    height                  = meter * (ofGetHeight() * 0.001);

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

