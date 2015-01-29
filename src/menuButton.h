
#ifndef __Bit20iPadApp__menuButton__
#define __Bit20iPadApp__menuButton__

#include <stdio.h>
#include "ofMain.h"

class Button {
public:
    
    Button(); // Constructor
    
    void Setup();
    void Draw();
    void ChangeSample();
    void DistanceToButton(float touchX, float touchY);
    
    
    float posX;
    float posY;
    float distToObj;
    float radius;
    bool buttonIsPressed;
    unsigned int whatSample;
};




#endif /* defined(__Bit20iPadApp__menuButton__) */
