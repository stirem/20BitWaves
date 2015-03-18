
#include <stdio.h>
#include "ofMain.h"

class Particles
{
public:
    
    Particles(float touchX, float touchY, float specVolume, float startRadius, float colorBrightness);

    void Update(float soundSpeed, float volume);
    void Draw();

    
    ofPoint pos; // Position of soundwaves
    ofColor color; // Color of soundwaves
    
    float radius; // Radius of soundwaves
    float waveColorBrightness; // Color brightness of soundwaves
    float alpha;
    float myLineWidth;


};



