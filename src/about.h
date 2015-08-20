
#include <stdio.h>
#include "ofMain.h"

#include "ofxXmlSettings.h"
#include "ofxiOSExtras.h"


class About
{
public:
    
    About(  );

    void                    setup();
    void                    update();
    void                    draw();
    
    void                    distanceToButton( float touchDownX, float touchDownY );
    
    bool                    _inputValue;
    
private:
    
    ofxXmlSettings          XML;
    float                   _distanceToButton;
    float                   _buttonRadius;
    float                   _buttonX;
    float                   _buttonY;
    bool                    _buttonValue;

    
    ofTrueTypeFont          _arial;
    


    
};



