
#include <stdio.h>
#include "ofMain.h"

class Particles
{
public:
    
    Particles( float touchX, float touchY, float startRadius, float colorBrightness, float soundSpeed );

    void        Update( float soundSpeed, double sample );
    void        Draw();

    float       alpha;
    
private:
    
    ofPoint     pos; // Position of soundwaves
    ofColor     color; // Color of soundwaves
    
    float       radius; // Radius of soundwaves
    float       circleColorBrightness; // Color brightness of particle circles
    float       myLineWidth;
    float       mySoundSpeed;
    float       myScreenWidth;
    
};



