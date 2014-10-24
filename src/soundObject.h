#ifndef _OF_SOUNDOBJECT // If this class hasn't been defined, the program can define it.
#define _OF_SOUNDOBJECT // By using this if statement you prevent the class to be called more
                        // than once which would confuse the compiler.


#include "ofMain.h"



class SoundObject {

    
public:
    
    //SoundObject(); // Not doing it like this because when starting the app the ofRandom and ofRandomWidth() must be in the ofApp.mm under void ofApp::setup() to work. See Init() function.
    
    ///< VISUAL
    float           radius; // Circle radius
    bool            fingerIsInside; // True if finger is inside circle
    float           distToObj; // Distance to object used by IsFingerInside
    float           objectPosX; // Circle position X
    float           objectPosY; // Circle position Y
    int             fingerID; // What finger is touching the screen
    
    
    bool            IsFingerInside(float x, float y); // Calculate distance between finger and circle
    void            BindToFinger(int anFingerID); // Bind fingerID to touch.id
    void            ReleaseFinger(); // Set fingerID to out of range value (-99) when not touching object
    bool            IsFingerBoundToObject(int anFingerID); // Check if finger is already bound to an object
    void            SetPosition(float aX, float aY); // Make the object follow the finger
    void            Draw(); // Draw the objects on screen
    void            Init(); // Function to set start values. Must be called in the setup()
                            // function in ofApp.cpp to work. Otherwise the values will be
                            // called at the wrong time.
    void            Color(int r, int g, int b); // Send individual color values to each object
    ofColor         color; // Get access to the OF ofColor funciton

    
    void rampInit(); // Penner Ramp values function
    float time, beginning, change, duration; // Penner Ramp values

    
    ///< SOUND
    ofSoundPlayer   sndPlay; // The OF class for playing sounds
    void            PanTheSound(float x, int w); // Function for paning the sounds left and right
    void            SpeedOfTheSound(float y, int h); // Function for setting the speed of the sound


    
private:
    
  

    
    /*
    float volume;
    float soundSpeed;
    float pan;
    */
};



#endif