
#include "menu.h"

menu::menu()
{
}


void menu::setup()
{
    //fontLarge.loadFont("Fonts/DIN.otf", 18 );
    
    buttonIsPressed             = false;
    buttonPressedTimer          = 0;
    whatSample                  = 1;
    whatMenuNum                 = 3;
    whatMode                    = 3;
    
    /*buttonRadius              = ofGetScreenHeight() * 0.05;
    buttonPosX                  = ofGetScreenWidth() * 0.5;
    buttonHidePosY              = ofGetScreenHeight() + ( buttonRadius * 0.5 );
    buttonActivePosY            = ofGetScreenHeight() * 0.95;
    pictogramsAndNumsPosY       = ofGetScreenHeight() * 0.8;
    slideBallImageWidth         = ofGetScreenWidth() * 0.12;
    slideBallImageHeight        = ofGetScreenHeight() * 0.1;*/
    
    buttonRadius                = ofGetHeight() * 0.05;
    
    buttonPosX                  = ofGetWidth() * 0.5;
    bounceTimeX                 = 0;
    bounceBeginningX            = 0;
    bounceChangeX               = 0;
    bounceDurationX             = 30;
    doBounceButtonX             = false;
    for ( int i = 0; i < NUM_OF_MENU_POSITIONS; i++) {
        menuXpositions[i] = ( ofGetWidth() * (BUTTON_WIDTH * 0.5) ) * 1.5 + ( (ofGetWidth() * BUTTON_WIDTH) * i );
    }

    buttonHidePosY              = ofGetHeight() + ( buttonRadius * 0.5 );
    buttonActivePosY            = ofGetHeight() * 0.95;
    buttonPosY                  = buttonHidePosY;
    bounceTimeY                 = 0;
    bounceBeginningY            = buttonHidePosY;
    bounceChangeY               = buttonActivePosY - buttonHidePosY;
    bounceDurationY             = 30;
    doBounceButtonY             = false;
    
    
    pictogramsAndNumsPosY       = ofGetHeight() * 0.8;
    slideBallImageWidth         = ofGetWidth() * 0.12;
    slideBallImageHeight        = ofGetWidth() * 0.076; // Obs! Using ofGetWidth() to get same proportions on iphone 4s and 5s (dirrerent screen width)
    
    pictogramNumColor           = 100;
    recMicPictogramColor        = 100;
    bit20pictogramColor         = 100;
    folderPictogramColor        = 100;
    recModeOn                   = false;
    aboutBit20On                = false;
    fileBrowserOn               = false;
    rectOverPictogramsOpacity   = 0;
    
    
    recMicPictogram.loadImage( "recMicPictogram.png" );
    slideBallPictogram.loadImage( "slideBallPictogram.png" );
    bit20pictogram.loadImage( "bit20pictogram.png" );
    folderPictogram.loadImage( "folderPictogram.png" );

    for (int i = 1; i < NUM_OF_SOUNDS + 1; i++)
    {
        string picFileNr = "pictogram_num_" + ofToString( i ) + ".png";
        pictogramNum[i].loadImage( ofToDataPath( picFileNr ) );
    }
    
}


int menu::update( float touchX, bool touchIsDown )
{

    // Get nearest button
    float buttonPos     = ofGetWidth() * ( BUTTON_INDENT + (BUTTON_WIDTH * 0.5) );
    float dist          = fabs( touchX - buttonPos );
    
    // Begynner med 0te button:
    float minDist       = dist;
    int nearestButton   = 0;
    
    // Itererer over kommende buttons for å se om noen av de er nærmere
    for ( int i = 1; i < NUM_OF_MENU_POSITIONS; i++ ) {
        buttonPos += ofGetWidth() * ( BUTTON_WIDTH );
        dist = fabs( touchX - buttonPos );
        if (dist < minDist) {
            minDist = dist;
            nearestButton = i;
        }
    }
    
    ofLog() << "nearestButton: " << nearestButton;
    ofLog() << "buttonPos: " << buttonPos;
    ofLog() << "buttonPosX: " << buttonPosX;
    
    if ( buttonIsPressed )
    {
        buttonPressedTimer += ofGetLastFrameTime();
        
        rectOverPictogramsOpacity = rectOverPictogramsOpacity - ( ofGetLastFrameTime() * 800 );
        
        if ( buttonPressedTimer > 0.3 )
        {
            buttonPosX = touchX;
            whatMenuNum = nearestButton;
        }
        
        bounceButtonY( bounceTimeY, bounceBeginningY, bounceChangeY, bounceDurationY );
    }
    else
    {
        buttonPosX = menuXpositions[whatMenuNum];
        
        doBounceButtonY = false;
        buttonPosY = buttonHidePosY;
        bounceTimeY = 0;
        
        rectOverPictogramsOpacity = 255;
        buttonPressedTimer = 0;
        pictogramNumColor = 0;
        whatMode = whatMenuNum;
        
        // Set what sound sample to play
        if ( whatMode >= 3 )
        {
            whatSample = whatMode - 2;
            recModeOn = 0;
            aboutBit20On = 0;
            fileBrowserOn = 0;
        }
        else if ( whatMode == 0 )
        {
            recModeOn = 0;
            aboutBit20On = 1;
            fileBrowserOn = 0;
            whatSample = 0; // Maybe another solution to quiet the samples when in rec mode?
        } else if ( whatMode == 1 )
        {
            recModeOn = 0;
            aboutBit20On = 0;
            fileBrowserOn = 1;
            whatSample = 0; // Maybe another solution to quiet the samples when in rec mode?
        }
        else if ( whatMode == 2 )
        {
            recModeOn = 1;
            aboutBit20On = 0;
            fileBrowserOn = 0;
            whatSample = 0; // Maybe another solution to quiet the samples when in rec mode?
        }
    }
    
    // Bounce Button Y
    if ( doBounceButtonY ) {
        if ( bounceTimeY < bounceDurationY ) bounceTimeY++;
    }
    
    // Retun what menu number to "recording mode" and "about Bit20". Show "recording mode" if 1 or show "about Bit20" if 0.
    return whatMenuNum;
}




void menu::distanceToButton( float touchDownX, float touchDownY )
{
    // Calculate if finger is inside button when touch is down. Using "buttonActive.." to make it easier to hit the button (since part of it is hidden below screen when in hide mode).
    _distanceToButton = sqrt(    (touchDownX - buttonPosX) * (touchDownX - buttonPosX) + (touchDownY - buttonActivePosY) * (touchDownY - buttonActivePosY)     ) ;

    // If finger is inside button when touch is down, buttonIsPress to true.
    if ( (buttonRadius + (ofGetScreenWidth() * 0.01) ) > _distanceToButton ) // Bigger area than button to make it easier to hit.
    {
        buttonIsPressed = true; // This is set to false in ofApp::touchUp
    }

}


void menu::draw()
{
    // Bit20 pictogram
    if ( buttonIsPressed ) {
        if ( whatMenuNum == 0 ) {
            bit20pictogramColor = 255;
        } else {
            bit20pictogramColor = 100;
        }
        ofSetColor( bit20pictogramColor );
        bit20pictogram.setAnchorPercent( 0.5, 0.5 );
        bit20pictogram.draw( ( ofGetWidth() * SOUND_NUM_INDENT ) - ( ofGetWidth() * BUTTON_WIDTH ) * 2, pictogramsAndNumsPosY, ofGetWidth() * 0.05, ofGetWidth() * 0.05 );
    }
    
    
    // Folder pictogram
    if ( buttonIsPressed ) {
        if ( whatMenuNum == 1 ) {
            folderPictogramColor = 255;
        } else {
            folderPictogramColor = 100;
        }
        ofSetColor( folderPictogramColor );
        folderPictogram.setAnchorPercent( 0.5, 0.5 );
        folderPictogram.draw( ( ofGetWidth() * SOUND_NUM_INDENT ) - ( ofGetWidth() * BUTTON_WIDTH ), pictogramsAndNumsPosY, ofGetWidth() * 0.05, ofGetWidth() * 0.05 );
    }
    
    
    // Rec mic pictogram
    if ( buttonIsPressed )
    {
        if ( whatMenuNum == 2 ) {
            recMicPictogramColor = 255;
        } else {
            recMicPictogramColor = 100;
        }
        ofSetColor( recMicPictogramColor );
        //recMicPictogram.setAnchorPoint( recMicPictogram.getWidth() * 0.5, recMicPictogram.getHeight() * 0.5 );
        recMicPictogram.setAnchorPercent( 0.5, 0.5 );
        recMicPictogram.draw( ( ofGetWidth() * SOUND_NUM_INDENT ), pictogramsAndNumsPosY, ofGetWidth() * 0.05, ofGetWidth() * 0.05 );
        //recMicPictogram.draw( (ofGetWidth() * BUTTON_INDENT) + ( (ofGetWidth() * BUTTON_WIDTH) * 2 ), pictogramsAndNumsPosY, ofGetWidth() * 0.05, ofGetWidth() * 0.05 );
        //recMicPictogram.draw( ofGetWidth() * SOUND_NUM_INDENT, pictogramsAndNumsPosY, ofGetWidth() * 0.05, ofGetWidth() * 0.05 );
        //recMicPictogram.draw( ofGetWidth() * SOUND_NUM_INDENT, pictogramsAndNumsPosY );
    }
    
    
    ///< What Sample numbers above button
    if ( buttonIsPressed )
    {
        for (int i = 1; i < NUM_OF_SOUNDS + 1; i++)
        {
            if ( whatMenuNum == i + 2 ) {
                pictogramNumColor = 255;
            } else {
                pictogramNumColor = 100;
            }
            ofSetColor( pictogramNumColor );
            pictogramNum[i].setAnchorPercent( 0.5, 0.5 );
            pictogramNum[i].draw( ( (ofGetWidth() * SOUND_NUM_INDENT ) + ( (ofGetWidth() * BUTTON_WIDTH) * i) ), ( pictogramsAndNumsPosY ), ofGetWidth() * 0.05, ofGetWidth() * 0.05 );
            //fontLarge.drawString( ofToString( i ), ( (ofGetWidth() * SOUND_NUM_INDENT + 30) + ( (ofGetWidth() * BUTTON_WIDTH) * i) ), ( pictogramsAndNumsPosY ) ); // +30 to compensate for Font origin X.
        }
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
    
    
    
    
    // Black rectangle over pictograms that fades out
    ofSetColor( 0, 0, 0, rectOverPictogramsOpacity );
    ofFill();
    ofRect( 0, ofGetHeight() / 2, ofGetWidth(), ofGetHeight() * 0.5 );
    
    
    
    ///< Button
    if ( buttonIsPressed )
    {
        if ( !recModeOn && !aboutBit20On && !fileBrowserOn ) {
            ofSetColor( 255, 255, 255, 255 );
        } else if ( recModeOn ) {
            ofSetColor( 255, 0, 0, 255 );
        }
        else if ( aboutBit20On ) {
            ofSetColor( 255, 255, 255, 255 );
        } else if ( fileBrowserOn ) {
            ofSetColor( 255, 255, 255, 255 );
        }
        
        
        //ofNoFill();
        //ofCircle( buttonPosX, buttonActivePosY, buttonRadius );
        slideBallPictogram.setAnchorPercent( 0.5, 0.5 );
        slideBallPictogram.draw( buttonPosX, buttonPosY, slideBallImageWidth, slideBallImageHeight );
    }
    else
    {
        if ( !recModeOn && !aboutBit20On && !fileBrowserOn ) {
            ofSetColor( 255, 255, 255, 60 );
        } else if ( recModeOn ) {
            ofSetColor( 255, 0, 0, 80 );
        }
        else if ( aboutBit20On ) {
            ofSetColor( 255, 255, 255, 60 );
        } else if ( fileBrowserOn ) {
            ofSetColor( 255, 255, 255, 60 );
        }
        
        //ofNoFill();
        //ofCircle( buttonPosX, buttonHidePosY, buttonRadius );
        slideBallPictogram.setAnchorPercent( 0.5, 0.5 );
        slideBallPictogram.draw( buttonPosX, buttonPosY, slideBallImageWidth, slideBallImageHeight );
    }
    
    
    
    
    
    // Menu X positions for debugging
    for ( int i = 0; i < NUM_OF_MENU_POSITIONS; i++) {
        ofSetColor( 255, 255, 255 );
        ofCircle( menuXpositions[i], ofGetHeight() * 0.9, 1 );
    }
    
    
}



void menu::bounceButtonY( float t, float b, float c, float d ) {
    
    doBounceButtonY = true;

    // Elastic out
    if ( t == 0 )
    {
        buttonPosY = b;
    }
    
    if (( t /= d ) == 1 )
    {
        buttonPosY = b + c;
    }
    
    float p = d * .3f;
    float a = c;
    float s = p / 4;
    
    buttonPosY = ( a * pow( 2, -10 * t) * sin( ( t * d - s) * ( 2 * PI ) / p ) + c + b );
    
    
    /*
     // Bounce out
    if ((t/=d) < (1/2.75f)) {
        buttonPosY = c*(7.5625f*t*t) + b;
    } else if (t < (2/2.75f)) {
        float postFix = t-=(1.5f/2.75f);
        buttonPosY = c*(7.5625f*(postFix)*t + .75f) + b;
    } else if (t < (2.5/2.75)) {
        float postFix = t-=(2.25f/2.75f);
        buttonPosY = c*(7.5625f*(postFix)*t + .9375f) + b;
    } else {
        float postFix = t-=(2.625f/2.75f);
        buttonPosY = c*(7.5625f*(postFix)*t + .984375f) + b;
    }
    */
}


void menu::bounceButtonX( float t, float b, float c, float d ) {
    
    doBounceButtonX = true;
    
    // Elastic out
    if ( t == 0 )
    {
        buttonPosX = b;
    }
    
    if (( t /= d ) == 1 )
    {
        buttonPosX = b + c;
    }
    
    float p = d * .3f;
    float a = c;
    float s = p / 4;
    
    buttonPosX = ( a * pow( 2, -10 * t) * sin( ( t * d - s) * ( 2 * PI ) / p ) + c + b );
    
}








