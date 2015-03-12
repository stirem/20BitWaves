
#include "menu.h"

Menu::Menu()
{
}


void Menu::Setup()
{
    fontLarge.loadFont("Fonts/DIN.otf", 18 );
    
    
    buttonRadius        = ofGetScreenHeight() * 0.05;
    whatSample          = 1;
    buttonHidePosY      = ofGetScreenHeight() + ( buttonRadius * 0.5 );
    buttonActivePosY    = ofGetScreenHeight() * 0.95;
    buttonPosX          = ofGetScreenWidth() * 0.5;

    
}


int Menu::Update( float touchX )
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
        buttonPosX = touchX;
        
        // Set what menu number
        whatMenuNum = nearestButton;
        
        // Set what sound sample to play
        if ( whatMenuNum >= 3 ) {
            whatSample = whatMenuNum - 2;
            recModeOn = 0;
            aboutBit20On = 0;
            fileBrowserOn = 0;
        }
        else if ( whatMenuNum == 0 ) {
            recModeOn = 0;
            aboutBit20On = 1;
            fileBrowserOn = 0;
            whatSample = 0; // Maybe another solution to quiet the samples when in rec mode?
        } else if ( whatMenuNum == 1 ) {
            recModeOn = 0;
            aboutBit20On = 0;
            fileBrowserOn = 1;
            whatSample = 0; // Maybe another solution to quiet the samples when in rec mode?
        }
        else if ( whatMenuNum == 2 ) {
            recModeOn = 1;
            aboutBit20On = 0;
            fileBrowserOn = 0;
            whatSample = 0; // Maybe another solution to quiet the samples when in rec mode?
        }
    }

    
    // Retun what menu number to "recording mode" and "about Bit20". Show "recording mode" if 1 or show "about Bit20" if 0.
    return whatMenuNum;
}




void Menu::DistanceToButton( float touchDownX, float touchDownY )
{
    // Calculate if finger is inside button when touch is down. Using "buttonActive.." to make it easier to hit the button (since part of it is hidden below screen when in hide mode).
    distanceToButton = sqrt(    (touchDownX - buttonPosX) * (touchDownX - buttonPosX) + (touchDownY - buttonActivePosY) * (touchDownY - buttonActivePosY)     ) ;

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
        fontLarge.drawString( ofToString( i ), ( (ofGetWidth() * SOUND_NUM_INDENT + 30) + ( (ofGetWidth() * BUTTON_WIDTH) * i) ), ( buttonActivePosY ) ); // +30 to compensate for Font origin X.
    }
    
    
    ///< What Menu Numbers (FOR DEBUGGING)
    /*if ( buttonIsPressed )
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
    }*/
    
    
    ///< Button
    if ( buttonIsPressed )
    {
        if ( !recModeOn && !aboutBit20On && !fileBrowserOn ) {
            ofSetColor( 255, 255, 255, 255 );
        } else if ( recModeOn ) {
            ofSetColor( 255, 0, 0 );
        } else if ( aboutBit20On ) {
            ofSetColor( 0, 0, 255 );
        } else if ( fileBrowserOn ) {
            ofSetColor( 0, 255, 0 );
        }

        
        ofFill();
        ofCircle( buttonPosX, buttonActivePosY, buttonRadius );
        
    }
    else
    {
        if ( !recModeOn && !aboutBit20On && !fileBrowserOn ) {
            ofSetColor( 255, 255, 255, 40 );
        } else if ( recModeOn ) {
            ofSetColor( 255, 0, 0, 80 );
        } else if ( aboutBit20On ) {
            ofSetColor( 0, 0, 255, 80 );
        } else if ( fileBrowserOn ) {
            ofSetColor( 0, 255, 0, 80 );
        }
        
        ofFill();
        ofCircle( buttonPosX, buttonHidePosY, buttonRadius );
    }

    
    
    ///< Nr inside button
    if ( buttonIsPressed )
    {
        if ( !recModeOn && !aboutBit20On && !fileBrowserOn ) {
            ofSetColor( 0, 0, 0, 255 );
            fontLarge.drawString( ofToString( whatSample ), buttonPosX - 9, buttonActivePosY ); // -13 to compensate for Font origin X
        }
    }
    else
    {
        if ( !recModeOn && !aboutBit20On && !fileBrowserOn ) {
            ofSetColor( 0, 0, 0, 100 );
            fontLarge.drawString( ofToString( whatSample ), buttonPosX - 9, buttonHidePosY - 15 ); // -13 to compensate for Font origin X
        }
    }
    
    
    
    

}









