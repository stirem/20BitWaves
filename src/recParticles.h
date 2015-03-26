
#include <stdio.h>
#include "ofMain.h"

class RecParticles
{
public:
    
    RecParticles( float meter );

    void Update( bool isRecording );
    void Draw();

    
    float posX;
    float posY;
    ofColor color; // Color of soundwaves
    
    float radius; // Radius of soundwaves
    float colorBrightness; // Color brightness of soundwaves
    float alpha;
    float myLineWidth;

    float mySoundSpeed;
};



