
#ifndef __Bit20iPadApp__pennerRamp__
#define __Bit20iPadApp__pennerRamp__

#include <stdio.h>
#include <math.h> // Include to use math functions like sin, cos, pow etc.


#ifndef PI
#define PI  3.14159265
#endif


class Back {
    
public:
    
    static float easeIn(float t,float b , float c, float d);
    static float easeOut(float t,float b , float c, float d);
    static float easeInOut(float t,float b , float c, float d);
    
};

//--------------------------------------------------------------


class Bounce {
    
public:
    
    static float easeIn(float t,float b , float c, float d);
    static float easeOut(float t,float b , float c, float d);
    static float easeInOut(float t,float b , float c, float d);
};

//--------------------------------------------------------------


class Elastic {
    
public:
    
    static float easeIn(float t,float b , float c, float d);
    static float easeOut(float t,float b , float c, float d);
    static float easeInOut(float t,float b , float c, float d);
};


#endif

