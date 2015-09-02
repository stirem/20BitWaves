
#include "about.h"



About::About(  )
{
}

void About::setup() {

    // X M L  S E T T I N G S
    // We load our settings file that sets audio input to 1 or 0. If 1, mic is available, if 0, mic is disabled and bluetooth speakers are available.
    
    // initially we do this from the data/ folder
    // but when we save we are saving to the documents folder which is the only place we have write access to,
    // thats why we check if the file exists in the documents folder.
    if ( XML.loadFile(ofxiOSGetDocumentsDirectory() + "mySettings.xml" ) ){
        ofLog() << "mySettings.xml loaded from documents folder!";
    } else if ( XML.loadFile( "mySettings.xml" ) ){
        ofLog() << "mySettings.xml loaded from data folder!";
    } else {
        ofLog() << "unable to load mySettings.xml check data/ folder";
    }
    
    _inputValue         = XML.getValue( "INPUTVALUE", 1 );
    
    _distanceToButton   = ofGetWidth();
    _buttonRadius       = ofGetWidth() * 0.01;
    _buttonX            = ofGetWidth() * 0.15;
    _buttonY            = ofGetHeight() * 0.5;
    _buttonValue        = _inputValue;
    
    _arial.loadFont( "arial.ttf", 16 );
    
    
}


void About::update(  ) {
    

}


void About::draw() {

    // Button
    // Outer circle
    ofSetColor( 255, 255, 255 );
    ofNoFill();
    ofCircle( _buttonX, _buttonY, _buttonRadius );
    
    // Inner filled circle
    if ( !_buttonValue ) { // Audio input value 0 means no mic input and bluetooth on. Audio input value 1 means mic input is on, and bluetooth is off.
        ofFill();
        ofCircle( _buttonX, _buttonY, _buttonRadius * 0.8 ); // Smaller size than outer circle
    }
    
    // Text
    _arial.drawString( "Enable bluetooth speaker.\n (Setting will take effect the next time you start the app.\n When bluetooth is enabled, recording through microphone will be disabled.)", _buttonX + _buttonRadius * 2, _buttonY );

}


void About::distanceToButton( float touchDownX, float touchDownY ) {
    
    _distanceToButton = sqrt(    (touchDownX - _buttonX) * (touchDownX - _buttonX) + (touchDownY - _buttonY) * (touchDownY - _buttonY)     ) ;
    
    if ( (_buttonRadius + (ofGetWidth() * 0.01) ) > _distanceToButton ) // Bigger area than button to make it easier to hit.
    {
        if ( !_buttonValue ) {
            _buttonValue = true;
            XML.setValue( "INPUTVALUE", _buttonValue );
            XML.saveFile( ofxiOSGetDocumentsDirectory() + "mySettings.xml" );
            ofLog() << "mySettings.xml saved to app documents dolder ";
        } else {
            _buttonValue = false;
            XML.setValue( "INPUTVALUE", _buttonValue );
            XML.saveFile( ofxiOSGetDocumentsDirectory() + "mySettings.xml" );
            ofLog() << "mySettings.xml saved to app documents dolder ";
        }
    }
    
}

