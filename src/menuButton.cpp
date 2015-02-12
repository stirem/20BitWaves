
#include "menuButton.h"

/*
int getNearestSoundButton(float touchX)
{
    float buttonPos = ofGetWidth()*(SOUND_BUTTON_INDENT + 0.5*SOUND_BUTTON_WIDTH);
    float dist      = fabs(touchX - buttonPos);
    
    // Begynner med 0te button:
    float minDist   = dist;
    float nearestButton = 0;
    
    // Itererer over kommende buttons for å se om noen av de er nærmere
    for (int i=1; i<NR_OF_SOUNDS; i++) {
        buttonPos += ofGetWidth()*(SOUND_BUTTON_WIDTH);
        dist      = fabs(touchX - buttonPos);
        if (dist<minDist) {
            minDist = dist;
            nearestButton = i;
        }
    }
    return nearestButton;
}
 */



Button::Button()
{
}


void Button::Setup()
{
    fontLarge.loadFont("Fonts/DIN.otf", 36 );
    
    posX                 = ofGetScreenWidth() * 0.5;
    posY                 = ofGetScreenHeight() * 0.95;
    radius               = ofGetScreenHeight() * 0.05;
    whatSample           = 0;
}

void Button::Update( float touchX )
{

    // Get nearest button
    float buttonPos = ofGetWidth() * ( SOUND_BUTTON_INDENT + 0.5 * SOUND_BUTTON_WIDTH );
    float dist      = fabs( touchX - buttonPos );
    
    // Begynner med 0te button:
    float minDist   = dist;
    float nearestButton = 0;
    
    // Itererer over kommende buttons for å se om noen av de er nærmere
    for ( int i = 1; i < NR_OF_SOUNDS; i++ ) {
        buttonPos += ofGetWidth() * ( SOUND_BUTTON_WIDTH );
        dist      = fabs( touchX - buttonPos );
        if (dist < minDist) {
            minDist = dist;
            nearestButton = i;
        }
    }

    
    if ( buttonIsPressed )
    {
        posX = touchX;
        whatSample = nearestButton;
    }
    

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

}

void Button::Draw()
{
    ///< Numbers behind button
    if ( buttonIsPressed )
    {
        ofSetColor( 255, 255, 255, 255 );
    }
    else
    {
        ofSetColor( 0, 0, 0, 0 );
    }
    for (int i = 0; i < NR_OF_SOUNDS; i++)
    {
        fontLarge.drawString( ofToString( i ), ( (ofGetWidth() * SOUND_BUTTON_INDENT + 30) + ( (ofGetWidth() * SOUND_BUTTON_WIDTH) * i) ), ( posY ) ); // +30 to compensate for Font origin X.
    }
    
    
    ///< Button
    if ( buttonIsPressed )
    {
        ofSetColor( 255, 255, 255, 255 );
    }
    else
    {
        ofSetColor( 255, 255, 255, 20 );
    }
    ofFill();
    ofCircle( posX, posY - 15, radius );
    
    
    ///< Nr inside button
    if ( buttonIsPressed )
    {
        ofSetColor( 0, 0, 0, 255 );
    }
    else
    {
        ofSetColor( 0, 0, 0, 100 );
    }
    fontLarge.drawString( ofToString( whatSample ), posX - 13, posY ); // -13 to compensate for Font origin X
    
    

}









