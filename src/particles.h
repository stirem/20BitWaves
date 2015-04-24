
#include <stdio.h>
#include "ofMain.h"

class Particles
{
public:
    
    Particles( float touchX, float touchY, float specVolume, float startRadius, float colorBrightness, float soundSpeed );

    void        Update( float soundSpeed, float volume, double sample );
    void        Draw();

    
    ofPoint     pos; // Position of soundwaves
    ofColor     color; // Color of soundwaves
    
    float       radius; // Radius of soundwaves
    float       circleColorBrightness; // Color brightness of particle circles
    float       alpha;
    float       myLineWidth;

    float       mySoundSpeed;
    
private:
    
    float       myScreenWidth;
    
};



