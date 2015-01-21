
#include <stdio.h>
#include "ofMain.h"

#include "ofxMaxim.h" // Include Maximilian in project
#include "maximilian.h" // Inclde Maximilian in project

#define BANDS 1024 // Number of bands in spectrum

class Soundobject {
public:
    

    Soundobject(); // Constructor
    
    void Setup();
    void Update(float *v);
    void Draw();
    float SoundBrightness();
    float SpectrumVolume();
    
    void Position(float x, float y);
    float StartRadius();
    
    float mySoundBrightness;
    float mySpecVolume;


    
    ofPoint pos;
    ofColor color;
    
    
       
   
    float spectrum[BANDS];
    

    
    
   
    

    
    

};


