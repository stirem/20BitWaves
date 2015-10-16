#include "ofMain.h"
#include "ofApp.h"
#include "ofAppiOSWindow.h"

int main(){
    ///< Enable Retina
    
    /*ofAppiOSWindow * iOSWindow = new ofAppiOSWindow();
    //iOSWindow->enableAntiAliasing(4);
    iOSWindow->enableRetina();
    iOSWindow->disableHardwareOrientation();

    ofSetupOpenGL( iOSWindow, 1024,768, OF_FULLSCREEN );			// <-------- setup the GL context

	ofRunApp(new ofApp());*/
    
    ofiOSWindowSettings settings;
    settings.enableRetina = true; // enables retina resolution if the device supports it.
    settings.enableDepth = false; // enables depth buffer for 3d drawing.
    settings.enableAntiAliasing = false; // enables anti-aliasing which smooths out graphics on the screen.
    settings.numOfAntiAliasingSamples = 0; // number of samples used for anti-aliasing.
    settings.enableHardwareOrientation = true; // enables native view orientation.
    settings.enableHardwareOrientationAnimation = false; // enables native orientation changes to be animated.
    settings.glesVersion = OFXIOS_RENDERER_ES1; // type of renderer to use, ES1, ES2, ES3
    settings.windowMode = OF_FULLSCREEN;
    settings.setupOrientation = OF_ORIENTATION_90_LEFT;
    ofCreateWindow( settings );
    
    return ofRunApp( new ofApp );
    
}



///< Dirty hack to fix linker issue with ios simulator (Xcode 6 and ios SDK 8.0)
/*extern "C"{
    size_t fwrite$UNIX2003( const void *a, size_t b, size_t c, FILE *d )
    {
        return fwrite(a, b, c, d);
    }
    char* strerror$UNIX2003( int errnum )
    {
        return strerror(errnum);
    }
    time_t mktime$UNIX2003(struct tm * a)
    {
        return mktime(a);
    }
    double strtod$UNIX2003(const char * a, char ** b) {
        return strtod(a, b);
    }
}*/