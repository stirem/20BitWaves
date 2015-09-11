
#include <stdio.h>
#include "ofMain.h"

#include "ofxXmlSettings.h"
#include "ofxiOSExtras.h"

#define NUM_OF_BUTTONS 2
#define kButtonBluetooth 0
#define kButtonDelay 1



class About
{
public:
    
    About(  );

    void                    setup();
    void                    update();
    void                    draw();
    
    void                    distanceToButton( float touchDownX, float touchDownY );
    
    bool                    _audioInputValue;
    bool                    _isDelayActive;
    
private:
    
    ofxXmlSettings          XML;
    float                   _distanceToButton[NUM_OF_BUTTONS];
    float                   _buttonRadius[NUM_OF_BUTTONS];
    float                   _buttonX[NUM_OF_BUTTONS];
    float                   _buttonY[NUM_OF_BUTTONS];
    bool                    _buttonValue[NUM_OF_BUTTONS];

    
    ofTrueTypeFont          _arial;
    


    
};



