
#include <stdio.h>
#include "ofMain.h"



#define BANDS 1024 // Number of bands in spectrum

class Touchobject
{
public:
    

    Touchobject(); // Constructor
    
    void        Setup();
    void        Update( float *val );
    void        Draw();
    float       ColorBrightness();
    float       SpectrumVolume();
    
    
    void        Position( float touchX, float touchY );
    float       StartRadius();
    
    float       spectrumVolume;
    



    
private:
    
    float       SoundBrightness();
    
    float       maxRadius;
    float       soundBrightness;
    float       startRadius;
    float       colorBrightness;
    float       alpha;
    float       radius;
    float       spectrum[BANDS];

    ofPoint     pos;
    ofColor     color;
    
    
   
    

    
    

};


