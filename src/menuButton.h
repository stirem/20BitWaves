
#ifndef __Bit20iPadApp__menuButton__
#define __Bit20iPadApp__menuButton__

#include <stdio.h>
#include "ofMain.h"

class Button {
public:
    
    Button(); // Constructor
    
    void Setup();
    void ChangeSample();
    
    
    bool changeSampleFingerDown;
    float buttonX;
    float buttonY;
};




#endif /* defined(__Bit20iPadApp__menuButton__) */
