
#ifndef __Bit20iPadApp__menuButton__
#define __Bit20iPadApp__menuButton__

#include <stdio.h>
#include "ofMain.h"
#include "Definitions.h"


class menu {
public:
    
    menu(); // Constructor
    
    void            setup();
    int             update( float touchX, bool touchIsDown );
    void            draw( int howManySamples );
    void            distanceToButton( float touchDownX, float touchDownY );
    void            bounceButtonY( float t, float b, float c, float d );
    void            bounceButtonX( float t, float b, float c, float d );

    float           _distanceToButton;
    float           buttonRadius;
    bool            buttonIsPressed;
    float           buttonPressedTimer;
    unsigned int    whatSample;
    unsigned int    whatRecSample;
    unsigned int    whatMenuNum;
    
    float           buttonPosX;
    float           bounceTimeX, bounceBeginningX, bounceChangeX, bounceDurationX;
    bool            doBounceButtonX;
    float           menuXpositions[NUM_OF_MENU_POSITIONS];
    
    float           buttonPosY;
    float           bounceTimeY, bounceBeginningY, bounceChangeY, bounceDurationY;
    bool            doBounceButtonY;
    float           buttonHidePosY;
    float           buttonActivePosY;
    
    float           nearestButton;
    float           pictogramsAndNumsPosY;
    float           slideBallImageWidth;
    float           slideBallImageHeight;
    int             pictogramNumColor;
    int             recMicPictogramColor[NUM_OF_REC_MODES];
    int             bit20pictogramColor;
    float           rectOverPictogramsOpacity;
    bool            recModeOn[NUM_OF_REC_MODES];
    bool            aboutBit20On;
    bool            fileSamplesModeOn;
    
    //ofTrueTypeFont fontLarge;
    
    ofImage         recMicPictogram[NUM_OF_REC_MODES];
    ofImage         slideBallPictogram;
    ofImage         pictogramNum[NUM_OF_HARDCODED_SOUNDS]; // + 1 because file names start on nr 1 and not 0.
    ofImage         bit20pictogram;
    
};




#endif /* defined(__Bit20iPadApp__menuButton__) */
