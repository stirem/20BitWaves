
#include <stdio.h>
#include "ofMain.h"

#include "ofxMaxim.h" // Include Maximilian in project
#include "maximilian.h" // Inclde Maximilian in project

#define BANDS 1024 // Number of bands in spectrum

class Soundobject
{
public:
    

    Soundobject(); // Constructor
    
    void Setup();
    void Update(float *val, float volume);
    void Draw();
    float ColorBrightness();
    float SpectrumVolume();
    float SoundBrightness();
    
    void Position(float touchX, float touchY, float buttonX, float buttonY, float buttonRadius);
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


