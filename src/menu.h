
#ifndef __Bit20iPadApp__menuButton__
#define __Bit20iPadApp__menuButton__

#include <stdio.h>
#include "ofMain.h"
#include "Definitions.h"


class Menu {
public:
    
    Menu(); // Constructor
    
    void Setup();
    int Update( float touchX, bool touchIsDown );
    void Draw();
    void DistanceToButton( float touchDownX, float touchDownY );

    float distanceToButton;
    float buttonRadius;
    bool buttonIsPressed;
    unsigned int whatSample;
    unsigned int whatMenuNum;
    unsigned int whatMode;
    float buttonPosX;
    float buttonHidePosY;
    float buttonActivePosY;
    float nearestButton;
    float pictogramsAndNumsPosY;
    float slideBallImageWidth;
    float slideBallImageHeight;
    int pictogramNumColor;
    int recMicPictogramColor;
    int bit20pictogramColor;
    int folderPictogramColor;
    
    bool recModeOn;
    bool aboutBit20On;
    bool fileBrowserOn;
    
    ofTrueTypeFont fontLarge;
    
    ofImage recMicPictogram;
    ofImage slideBallPictogram;
    ofImage pictogramNum[NUM_OF_SOUNDS + 1]; // + 1 because file names start on nr 1 and not 0.
    ofImage bit20pictogram;
    ofImage folderPictogram;
    
};




#endif /* defined(__Bit20iPadApp__menuButton__) */
