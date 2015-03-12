
#include <stdio.h>
#include "ofMain.h"



#define BANDS 1024 // Number of bands in spectrum

class Touchobject
{
public:
    

    Touchobject(); // Constructor
    
    void Setup();
    void Update( float *val, float volume );
    void Draw();
    float ColorBrightness();
    float SpectrumVolume();
    float SoundBrightness();
    
    void Position( float touchX, float touchY );
    float StartRadius();
    
    float soundBrightness;
    float spectrumVolume;
    float startRadius;
    float distanceToButton;
    float colorBrightness;
    float alpha;
    float radius;



    
    ofPoint pos;
    ofColor color;
    
    
       
   
    float spectrum[BANDS];
    

    
    
   
    

    
    

};


