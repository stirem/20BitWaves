
#include "soundWave.h"


///< Get the position, color brightness and radius of soundwaves
// --------------------------------------------------------
Soundwave::Soundwave( float touchX, float touchY, float specVolume, float startRadius, float colorBrightness )
{
    pos.set(touchX, touchY);
    //colorBrightness = specVolume;
    waveColorBrightness = colorBrightness;
    radius = startRadius; // Radius from specVolume
    myLineWidth = 1;
    alpha = 255;
}
// --------------------------------------------------------



///< Increase radius of soundwaves, and decrease alpha
// --------------------------------------------------------
void Soundwave::Update(float soundSpeed, float volume) {
    
    //radius = radius + 40 * s;
    radius = radius + 1.2 * soundSpeed;
    
    if (volume == 1) {
        alpha = alpha - 1;
    } else {
        alpha = alpha - 1.5;
    }
}
// --------------------------------------------------------




///< Draw the soundwave circles
// --------------------------------------------------------
void Soundwave::Draw() {
    ofNoFill();
    color = ofColor(255, 255, 255, alpha);
    //color.setBrightness(colorBrightness / 25);
    color.setBrightness( waveColorBrightness );
    ofSetColor(color);
    ofEnableAntiAliasing();
    ofSetCircleResolution(100);
    ofSetLineWidth(myLineWidth);
    ofCircle(pos.x, pos.y, radius);
}
// --------------------------------------------------------

