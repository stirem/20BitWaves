
#include <stdio.h>
#include "ofMain.h"

class RecSpectrum
{
public:
    
    RecSpectrum( float meter, int recSpectrumPosXinc );

    void Draw();

    
    float posX;
    float posY;
    
    float height; // Radius of soundwaves
    float width;

};



