
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
    whatRecSample               = 0;
    whatMenuNum                 = 3;
    
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
    
    bit20pictogramColor         = 100;
    for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
        recModeOn[i] = false;
        recMicPictogramColor[i] = 100;
    }
    aboutBit20On                = false;
    fileSamplesModeOn           = true;
    rectOverPictogramsOpacity   = 0;
    
    
    for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
        recMicPictogram[i].loadImage( "recMicPictogram" + ofToString( i ) + ".png" );
    }
    slideBallPictogram.loadImage( "slideBallPictogram.png" );
    bit20pictogram.loadImage( "bit20pictogram.png" );

    for (int i = 0; i < NUM_OF_HARDCODED_SOUNDS; i++)
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
        buttonPosX = menuXpositions[ whatMenuNum ];
        
        doBounceButtonY = false;
        buttonPosY = buttonHidePosY;
        bounceTimeY = 0;
        
        rectOverPictogramsOpacity = 255;
        buttonPressedTimer = 0;
        pictogramNumColor = 0;
        
        // Set what sound sample to play
        if ( whatMenuNum >= 4 )
        {
            whatSample = whatMenuNum - NUM_OF_POS_TO_THE_LEFT_FOR_FILESAMPLES;
            for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
                recModeOn[i] = false;
            }
            aboutBit20On = false;
            fileSamplesModeOn = true;
        }
        else if ( whatMenuNum == 0 )
        {
            for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
                recModeOn[i] = false;
            }
            aboutBit20On = true;
            fileSamplesModeOn = false;
        } else if ( whatMenuNum == 1 )
        {
            for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
                recModeOn[0] = true;
                recModeOn[1] = false;
                recModeOn[2] = false;
            }
            whatRecSample = 0;
            aboutBit20On = false;
            fileSamplesModeOn = false;
        }
        else if ( whatMenuNum == 2 )
        {
            for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
                recModeOn[0] = false;
                recModeOn[1] = true;
                recModeOn[2] = false;
            }
            whatRecSample = 1;
            aboutBit20On = false;
            fileSamplesModeOn = false;
        }
        else if ( whatMenuNum == 3 )
        {
            for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
                recModeOn[0] = false;
                recModeOn[1] = false;
                recModeOn[2] = true;
            }
            whatRecSample = 2;
            aboutBit20On = false;
            fileSamplesModeOn = false;
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


void menu::draw( int howManySamples )
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
    
    
    // Rec mic pictogram
    if ( buttonIsPressed )
    {

        for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
            
            if ( whatMenuNum == 1 ) {
                recMicPictogramColor[0] = 255;
                recMicPictogramColor[1] = 100;
                recMicPictogramColor[2] = 100;
            } else if ( whatMenuNum == 2 ) {
                recMicPictogramColor[0] = 100;
                recMicPictogramColor[1] = 255;
                recMicPictogramColor[2] = 100;
            } else if ( whatMenuNum == 3 ) {
                recMicPictogramColor[0] = 100;
                recMicPictogramColor[1] = 100;
                recMicPictogramColor[2] = 255;
            } else {
                recMicPictogramColor[i] = 100;
            }
            ofSetColor( recMicPictogramColor[i] );
            
            recMicPictogram[i].setAnchorPercent( 0.5, 0.5 );
            recMicPictogram[i].draw( ( ofGetWidth() * SOUND_NUM_INDENT ) - ( ofGetWidth() * BUTTON_WIDTH ) + ( ( ofGetWidth() * BUTTON_WIDTH ) * i ), pictogramsAndNumsPosY, ofGetWidth() * 0.05, ofGetWidth() * 0.05 );
        }
    
    }
    
    
    ///< What Sample number pictograms
    if ( buttonIsPressed )
    {
        for (int i = 0; i < howManySamples; i++)
        {
            if ( whatMenuNum == i + NUM_OF_POS_TO_THE_LEFT_FOR_FILESAMPLES ) {
                pictogramNumColor = 255;
            } else {
                pictogramNumColor = 100;
            }
            ofSetColor( pictogramNumColor );
            pictogramNum[i].setAnchorPercent( 0.5, 0.5 );
            pictogramNum[i].draw( ( (ofGetWidth() * SOUND_NUM_INDENT ) + ( ( ofGetWidth() * BUTTON_WIDTH ) ) * 2 + ( ( ofGetWidth() * BUTTON_WIDTH ) * i ) ), ( pictogramsAndNumsPosY ), ofGetWidth() * 0.05, ofGetWidth() * 0.05 );
            //fontLarge.drawString( ofToString( i ), ( (ofGetWidth() * SOUND_NUM_INDENT + 30) + ( (ofGetWidth() * BUTTON_WIDTH) * i) ), ( pictogramsAndNumsPosY ) ); // +30 to compensate for Font origin X.
        }
    }


    
    // Black rectangle over pictograms that fades out
    ofSetColor( 0, 0, 0, rectOverPictogramsOpacity );
    ofFill();
    ofRect( 0, ofGetHeight() / 2, ofGetWidth(), ofGetHeight() * 0.5 );
    
    
    
    ///< Button
    if ( buttonIsPressed )
    {
    
        ofSetColor( 255, 255, 255, 255 );
       
        
        
        //ofNoFill();
        //ofCircle( buttonPosX, buttonActivePosY, buttonRadius );
        slideBallPictogram.setAnchorPercent( 0.5, 0.5 );
        slideBallPictogram.draw( buttonPosX, buttonPosY, slideBallImageWidth, slideBallImageHeight );
    }
    else
    {
      
        ofSetColor( 255, 255, 255, 60 );

        
        //ofNoFill();
        //ofCircle( buttonPosX, buttonHidePosY, buttonRadius );
        slideBallPictogram.setAnchorPercent( 0.5, 0.5 );
        slideBallPictogram.draw( buttonPosX, buttonPosY, slideBallImageWidth, slideBallImageHeight );
    }
    
    
    
    
    ///< What Menu Numbers (FOR DEBUGGING)
    /*if ( buttonIsPressed )
     {
     ofSetColor( 255, 255, 255, 255 );
     }
     else
     {
     ofSetColor( 0, 0, 0, 0 );
     }*/
    ofSetColor( 255, 255, 255, 255 );
    for (int i = 0; i < NUM_OF_MENU_POSITIONS; i++)
    {
        ofDrawBitmapString( ofToString( i ), menuXpositions[i], ofGetScreenHeight() * 0.5 );
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








