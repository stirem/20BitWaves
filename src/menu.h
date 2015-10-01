
#ifndef __Bit20iPadApp__menuButton__
#define __Bit20iPadApp__menuButton__

#include <stdio.h>
#include "ofMain.h"
#include "Definitions.h"


class menu {
public:
    
    menu();
    
    void            setup();
    void            update( );
    void            draw( );
    void            distanceToTinyButton( float touchX, float touchY );
    void            distanceToMenuButtons( float touchX, float touchY );
    
    bool            _isInMenu;
    bool            _muteAudio;
    unsigned int    _whatRecSample;
    unsigned int    _whatFileSample;
    unsigned int    _whatMode;

    
    
private:
    
    float           _tinyButtonX;
    float           _tinyButtonY;
    float           _tinyButtonPictogramRadius;
    float           _distanceToTinyButton;
    float           _distanceToMenuButtons[NUM_OF_MENU_PICTOGRAMS];
    
    ofImage         _pictogramRecMic[NUM_OF_REC_MODES];
    ofImage         _pictogramBit20;
    ofImage         _pictogramNum[NUM_OF_HARDCODED_SOUNDS];
    ofImage         _tinyButton;
    ofImage         _tinyButtonPictogram;
    float           _pictogramsPosY;
    float           _pictogramsPosX[NUM_OF_MENU_PICTOGRAMS];
    float           _pictogramsRadius;

    
    float           _outOfMenuTimer;
    bool            _startOutOfMenuTimer;
    
    float           _inToMenuTimer;
    bool            _startInToMenuTimer;
    
    
    
       

};




#endif /* defined(__Bit20iPadApp__menuButton__) */
