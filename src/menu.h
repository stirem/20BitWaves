
#ifndef __Bit20iPadApp__menuButton__
#define __Bit20iPadApp__menuButton__

#include <stdio.h>
#include "ofMain.h"
#include "Definitions.h"
#include "Quad.h"


class menu {
public:
    
    menu();
    
    void            setup();
    void            update( );
    void            draw( int howManySamples );
    void            distanceToTinyButton( float touchX, float touchY );
    void            distanceToMenuButtons( float touchX, float touchY, int howManySamples );
    
    bool            _isInMenu;
    bool            _muteAudio;
    unsigned int    _whatRecSample;
    unsigned int    _whatFileSample;
    unsigned int    _whatMode;
    bool            _aboutIsOpen;

    
    
private:
    
    void            easeOpenX();
    void            easeOpenY();
    
    void            initSizeValues();
    
    float           _tinyButtonX;
    float           _tinyButtonY;
    float           _tinyButtonPictogramRadius;
    float           _tinyButtonOpacity;
    bool            _startTinyButtonFadeDown;
    float           _distanceToTinyButton;
    float           _distanceToMenuButtons[NUM_OF_MENU_PICTOGRAMS];
    
    ofImage         _pictogramRecMic[NUM_OF_REC_MODES];
    ofImage         _pictogramBit20;
    ofImage         _pictogramNum[NUM_OF_HARDCODED_SOUNDS];
    ofImage         _tinyButtonPictogram;
    float           _pictogramsClosedY;
    float           _pictogramsOpenY;
    float           _pictogramsClosedX;
    float           _pictogramsOpenX[NUM_OF_MENU_PICTOGRAMS];
    float           _pictogramsRadius;

    
    float           _outOfMenuTimer;
    bool            _startOutOfMenuTimer;
    
    float           _inToMenuTimer;
    bool            _startInToMenuTimer;
    
    // Ease
    float           _timeX, _beginningX, _changeX[NUM_OF_MENU_PICTOGRAMS], _durationX;
    float           _timeY, _beginningY, _changeY, _durationY;
    
    
       

};




#endif /* defined(__Bit20iPadApp__menuButton__) */
