
#include "menuButton.h"

Button::Button()
{
}


void Button::Setup()
{
    posX                 = ofGetWidth() * 0.98;
    posY                 = ofGetHeight() * 0.02;
    radius               = ofGetWidth() / 20;
    whatSample           = 1;
}


void Button::ChangeSample()
{
    
}

void Button::DistanceToButton(float touchX, float touchY)
{
    distToObj = sqrt(    (touchX - posX) * (touchX - posX) + (touchY - posY) * (touchY - posY)     ) ;

    if (radius > distToObj) {
        fingerIsInside = 1;
    }
    else
    {
        fingerIsInside = 0;
    }
    
    if (fingerIsInside) {
        if(whatSample < 6) {
            whatSample++;
        } else {
            whatSample = 1;
        }
    }
    
}

void Button::Draw()
{
    ///< Change sample button
    ofSetColor(50, 50, 50);
    ofNoFill();
    ofCircle(posX, posY, radius);
    ofDrawBitmapString(ofToString(whatSample), posX, posY);
}