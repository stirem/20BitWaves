
#include "menuButton.h"

Menu::Menu()
{
}


void Menu::Setup()
{
    fontLarge.loadFont("Fonts/DIN.otf", 20 );
    
    posX                = ofGetScreenWidth() * 0.5;
    posY                = ofGetScreenHeight() * 0.95;
    buttonRadius        = ofGetScreenHeight() * 0.05;
    whatSample          = 1;
    buttonHidePosY      = ofGetScreenHeight();
    buttonActivePosY    = ofGetScreenHeight() * 0.95;

    
}

void Menu::Update( float touchX )
{

    // Get nearest button
    float buttonPos = ofGetWidth() * ( BUTTON_INDENT + 0.5 * BUTTON_WIDTH );
    float dist      = fabs( touchX - buttonPos );
    
    // Begynner med 0te button:
    float minDist   = dist;
    float nearestButton = 0;
    
    // Itererer over kommende buttons for å se om noen av de er nærmere
    for ( int i = 1; i < NUM_OF_MENU_POSITIONS; i++ ) {
        buttonPos += ofGetWidth() * ( BUTTON_WIDTH );
        dist      = fabs( touchX - buttonPos );
        if (dist < minDist) {
            minDist = dist;
            nearestButton = i;
        }
    }

    
    if ( buttonIsPressed )
    {
        posX = touchX;
        whatMenuNum = nearestButton;
        whatSample = whatMenuNum - 1;
    }
    

}

void Menu::DistanceToButton( float touchX, float touchY )
{
    // Calculate if finger is inside button when touch is down.
    distanceToButton = sqrt(    (touchX - posX) * (touchX - posX) + (touchY - posY) * (touchY - posY)     ) ;

    // If finger is inside button when touch is down, buttonIsPress to true.
    if ( buttonRadius > distanceToButton )
    {
        buttonIsPressed = 1;
    }
    else
    {
        buttonIsPressed = 0;
    }

}

void Menu::Draw()
{
    
    ///< What Sample numbers behind button
    if ( buttonIsPressed )
    {
        ofSetColor( 255, 255, 255, 255 );
    }
    else
    {
        ofSetColor( 0, 0, 0, 0 );
    }
    for (int i = 1; i < NUM_OF_SOUNDS + 1; i++)
    {
        fontLarge.drawString( ofToString( i ), ( (ofGetWidth() * SOUND_NUM_INDENT + 30) + ( (ofGetWidth() * BUTTON_WIDTH) * i) ), ( posY ) ); // +30 to compensate for Font origin X.
    }
    
    
    ///< What Menu Numbers
    if ( buttonIsPressed )
    {
        ofSetColor( 255, 255, 255, 255 );
    }
    else
    {
        ofSetColor( 0, 0, 0, 0 );
    }
    for (int i = 0; i < NUM_OF_MENU_POSITIONS; i++)
    {
        fontLarge.drawString( ofToString( i ), ( (ofGetWidth() * BUTTON_INDENT + 30) + ( (ofGetWidth() * BUTTON_WIDTH) * i) ), ( ofGetScreenHeight() * 0.5 ) );
    }
    
    
    ///< Button
    if ( buttonIsPressed )
    {
        ofSetColor( 255, 255, 255, 255 );
        ofFill();
        ofCircle( posX, buttonActivePosY, buttonRadius );
    }
    else
    {
        ofSetColor( 255, 255, 255, 20 );
        ofFill();
        ofCircle( posX, buttonHidePosY, buttonRadius );
    }
    //ofFill();
    //ofCircle( posX, posY - 15, radius );
    
    
    ///< Nr inside button
    if ( buttonIsPressed )
    {
        ofSetColor( 0, 0, 0, 255 );
        fontLarge.drawString( ofToString( whatSample ), posX - 13, buttonActivePosY ); // -13 to compensate for Font origin X
    }
    else
    {
        ofSetColor( 0, 0, 0, 100 );
        fontLarge.drawString( ofToString( whatSample ), posX - 13, buttonHidePosY ); // -13 to compensate for Font origin X
    }
    
    
    

}









