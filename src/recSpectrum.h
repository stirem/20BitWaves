
#include <stdio.h>
#include "ofMain.h"

class RecSpectrum
{
public:
    
    RecSpectrum( float meter, float recSpectrumPosXinc );

    void Draw();
    
private:
    
    float posX;
    float posY;
    
    float height; // Radius of soundwaves
    float width;
    
    ofRectangle myRect;

};



