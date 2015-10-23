
#include <stdio.h>
#include "ofMain.h"

#include "ofxXmlSettings.h"
#include "ofxiOSExtras.h"
#include "ofxiOS.h"

#define NUM_OF_BUTTONS 5
#define kButtonBluetooth 0
#define kButtonDelay 1
#define kButtonUrlBek 2
#define kButtonUrlStian 3
#define kButtonUrlBit20 4



class About
{
public:
    
    About(  );

    void                    setup();
    void                    update();
    void                    draw();
    
    void                    distanceToButton( float touchDownX, float touchDownY );
    void                    distanceToCloseButton( float touchX, float touchY );
    
    bool                    _audioInputValue;
    bool                    _isDelayActive;
    bool                    _closeAbout;
    
private:
    
    void                    initSizeValues();
    
    ofxXmlSettings          XML;
    float                   _distanceToButton[NUM_OF_BUTTONS];
    float                   _buttonRadius[NUM_OF_BUTTONS];
    float                   _buttonX[NUM_OF_BUTTONS];
    float                   _buttonY[NUM_OF_BUTTONS];
    bool                    _buttonValue[NUM_OF_BUTTONS];
    
    float                   _distanceToCloseButton;
    float                   _closeButtonX;
    float                   _closeButtonY;
    float                   _closeButtonRadius;
    float                   _aboutTextAndLogos_width;
    float                   _aboutTextAndLogos_height;
    float                   _aboutTextAndLogos_X;
    float                   _aboutTextAndLogos_Y;

    
    ofTrueTypeFont          _arial;
    
    ofImage                 _aboutTextAndLogos;
    ofImage                 _closeButton;
    


    
};



