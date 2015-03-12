
#ifndef __Bit20iPadApp__menuButton__
#define __Bit20iPadApp__menuButton__

#include <stdio.h>
#include "ofMain.h"
#include "Definitions.h"


class Menu {
public:
    
    Menu(); // Constructor
    
    void Setup();
    void Update( float touchX );
    void Draw();
    void DistanceToButton( float touchX, float touchY );
    
    
    float posX;
    float posY;
    float distanceToButton;
    float buttonRadius;
    bool buttonIsPressed;
    unsigned int whatSample;
    unsigned int whatMenuNum;
    float buttonHidePosX;
    float buttonHidePosY;
    float buttonActivePosX;
    float buttonActivePosY;

    
    ofTrueTypeFont fontLarge;
    
};




#endif /* defined(__Bit20iPadApp__menuButton__) */
