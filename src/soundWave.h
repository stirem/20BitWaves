
#include <stdio.h>
#include "ofMain.h"

class Soundwave{
public:
    
    Soundwave(float x, float y, float s, float r, float h);

    void Update(float s, float v);
    void Draw();

    
    ofPoint pos; // Position of soundwaves
    ofColor color; // Color of soundwaves
    
    float radius; // Radius of soundwaves
    float colorBrightness; // Color brightness of soundwaves
    float alpha = 255;
    float myHue;
    float myLineWidth;
    


};



