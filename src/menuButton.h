
#ifndef __Bit20iPadApp__menuButton__
#define __Bit20iPadApp__menuButton__

#include <stdio.h>
#include "ofMain.h"

#define NR_OF_SOUNDS 9
#define SOUND_BUTTON_INDENT 0.25    ///< lkjhljhl
#define SOUND_BUTTON_WIDTH 0.08     ///< alisudfoausdhfajsdhflasdhflajsdhfaljs

class Button {
public:
    
    Button(); // Constructor
    
    void Setup();
    void Update( float touchX );
    void Draw();
    void DistanceToButton( float touchX, float touchY );
    
    
    float posX;
    float posY;
    float distToObj;
    float radius;
    bool buttonIsPressed;
    unsigned int whatSample;
    
    ofTrueTypeFont fontLarge;
    
};




#endif /* defined(__Bit20iPadApp__menuButton__) */
