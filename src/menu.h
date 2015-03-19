
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
    float buttonPosX;
    float buttonHidePosY;
    float buttonActivePosY;
    float nearestButton;
    
    bool recModeOn;
    bool aboutBit20On;
    bool fileBrowserOn;
    
    ofTrueTypeFont fontLarge;
    
};




#endif /* defined(__Bit20iPadApp__menuButton__) */
