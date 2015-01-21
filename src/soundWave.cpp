
#include "soundWave.h"
//#include "ofApp.h"
//#include "ofApp.mm"


///< Get the position, color brightness and radius of soundwaves
// --------------------------------------------------------
Soundwave::Soundwave(float x, float y, float s, float r, float b) { // x = touchX, y = touchY, s = spectrumVolume, r = startRadius, b = soundBrighness
    pos.set(x, y);
    colorBrightness = s;
    radius = r; // Radius from specVolume
    myHue = b;
    myLineWidth = 1;
}
// --------------------------------------------------------



///< Increase radius of soundwaves, and decrease alpha
// --------------------------------------------------------
void Soundwave::Update(float s, float v) { // s = soundSpeed, v = volume
    radius = radius + 40 * s;
    
    if (v == 1) {
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
    color.setBrightness(colorBrightness / 25);
    //color.setHue(myHue * 20);
    ofSetColor(color);
    ofEnableAntiAliasing();
    ofSetCircleResolution(100);
    ofSetLineWidth(myLineWidth);
    ofCircle(pos.x, pos.y, radius / 40);
}
// --------------------------------------------------------

