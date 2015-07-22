
#include "recSpectrum.h"


// --------------------------------------------------------
RecSpectrum::RecSpectrum( float meter, int recSpectrumPosXinc )
{
    posX                    = ofGetScreenWidth() * 0.001 + recSpectrumPosXinc;
    posY                    = ofGetScreenHeight() * 0.15;
    width                   = ofGetScreenWidth() * 0.001;
    
    if ( meter > 0 ) {
        height = meter * ( ofGetScreenHeight() * 0.001 );
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
    
    myRect.x = posX;
    myRect.y = posY;
    myRect.width = width;
    myRect.height = height;
    myRect.setFromCenter( posX, posY, width, height );
    
    ofRect( myRect );
    
    
}
// --------------------------------------------------------

