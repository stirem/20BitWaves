
#include "menuButton.h"

Button::Button()
{
}


void Button::Setup()
{
    posX                 = 0;
    posY                 = 0;
    radius               = 100;
    whatSample           = 0;
}


void Button::ChangeSample()
{
    
}

void Button::DistanceToButton(float touchX, float touchY)
{
    // Calculate if finger is inside button when touch is down.
    distToObj = sqrt(    (touchX - posX) * (touchX - posX) + (touchY - posY) * (touchY - posY)     ) ;

    // If finger is inside button when touch is down, buttonIsPress to true.
    if (radius > distToObj)
    {
        buttonIsPressed = 1;
    }
    else
    {
        buttonIsPressed = 0;
    }
    
    // If buttonIsPress is true, change sample.
    if (buttonIsPressed)
    {
        if(whatSample < 8)
        {
            whatSample++;
        }
        else
        {
            whatSample = 0;
        }
    }
    
}

void Button::Draw()
{
    ///< Change sample button
    ofSetColor( 50, 50, 50 );
    ofNoFill();
    ofCircle( posX, posY, radius );
    ofDrawBitmapString( ofToString( whatSample ), posX - 5, posY + 5 );
}