
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
    
    _audioInputValue                        = XML.getValue( "AUDIO_INPUT_VALUE", 1 );
    _isDelayActive                          = XML.getValue( "DELAY_ACTIVE", 0 );
    
    for ( int i = 0; i < NUM_OF_BUTTONS; i++ ) {
        _distanceToButton[i]                = ofGetWidth();
        _buttonRadius[i]                    = ofGetWidth() * 0.01;
        _buttonX[i]                         = ofGetWidth() * 0.15;
    }
    _buttonY[kButtonBluetooth]              = ofGetHeight() * 0.5;
    _buttonY[kButtonDelay]                  = ofGetHeight() * 0.2;
    _buttonValue[kButtonBluetooth]          = _audioInputValue;
    _buttonValue[kButtonDelay]              = _isDelayActive;
    
    _arial.loadFont( "Fonts/arial.ttf", 16 );
    

    
    
}


void About::update(  ) {
    

}


void About::draw() {


    ofSetColor( 255, 255, 255 );
    

    /// BLUETOOTH BUTTON ///
    // Button
    // Outer circle
    ofNoFill();
    ofCircle( _buttonX[kButtonBluetooth], _buttonY[kButtonBluetooth], _buttonRadius[kButtonBluetooth] );
    
    // Inner filled circle
    if ( !_buttonValue[kButtonBluetooth] ) { // WARNING! Audio input value 0 means no mic input and bluetooth on. Audio input value 1 means mic input is on, and bluetooth is off. So it is the other way around. Value 0 means button is filled, and value 1 means button is not filled.
        ofFill();
        ofCircle( _buttonX[kButtonBluetooth], _buttonY[kButtonBluetooth], _buttonRadius[kButtonBluetooth] * 0.8 ); // Smaller size than outer circle
    }
    // Text
    _arial.drawString( "Enable bluetooth speaker.\n (Setting will take effect the next time you start the app.\n When bluetooth is enabled, recording through microphone will be disabled.)", _buttonX[kButtonBluetooth] + _buttonRadius[kButtonBluetooth] * 2, _buttonY[kButtonBluetooth] );

    
    
    
    // DELAY BUTTON
    // Button
    // Outer circle
    ofNoFill();
    ofCircle( _buttonX[kButtonDelay], _buttonY[kButtonDelay], _buttonRadius[kButtonDelay] );
    
    // Inner filled circle
    if ( _buttonValue[kButtonDelay] ) {
        ofFill();
        ofCircle( _buttonX[kButtonDelay], _buttonY[kButtonDelay], _buttonRadius[kButtonDelay] * 0.8 ); // Smaller size than outer circle
    }
    // Text
    _arial.drawString( "Enable delay effect", _buttonX[kButtonDelay] + _buttonRadius[kButtonDelay] * 2, _buttonY[kButtonDelay] );


}


void About::distanceToButton( float touchDownX, float touchDownY ) {
    
    // This function is run in ofApp::update()
    
    
    
    /// BLUETOOTH BUTTON ///
    _distanceToButton[kButtonBluetooth] = sqrt(    (touchDownX - _buttonX[kButtonBluetooth]) * (touchDownX - _buttonX[kButtonBluetooth]) + (touchDownY - _buttonY[kButtonBluetooth]) * (touchDownY - _buttonY[kButtonBluetooth])     ) ;
    
    if ( (_buttonRadius[kButtonBluetooth] + (ofGetWidth() * 0.01) ) > _distanceToButton[kButtonBluetooth] ) // Bigger area than button to make it easier to hit.
    {
        if ( !_buttonValue[kButtonBluetooth] ) {
            _buttonValue[kButtonBluetooth] = true;
            XML.setValue( "AUDIO_INPUT_VALUE", _buttonValue[kButtonBluetooth] );
            XML.saveFile( ofxiOSGetDocumentsDirectory() + "mySettings.xml" );
            ofLog() << "mySettings.xml saved to app documents dolder ";
        } else {
            _buttonValue[kButtonBluetooth] = false;
            XML.setValue( "AUDIO_INPUT_VALUE", _buttonValue[kButtonBluetooth] );
            XML.saveFile( ofxiOSGetDocumentsDirectory() + "mySettings.xml" );
            ofLog() << "mySettings.xml saved to app documents dolder ";
        }
    }
    
    
    
    /// DELAY BUTTON ///
    _distanceToButton[kButtonDelay] = sqrt(    (touchDownX - _buttonX[kButtonDelay]) * (touchDownX - _buttonX[kButtonDelay]) + (touchDownY - _buttonY[kButtonDelay]) * (touchDownY - _buttonY[kButtonDelay])     ) ;
    
    if ( (_buttonRadius[kButtonDelay] + (ofGetWidth() * 0.01) ) > _distanceToButton[kButtonDelay] ) // Bigger area than button to make it easier to hit.
    {
        if ( !_buttonValue[kButtonDelay] ) {
            _buttonValue[kButtonDelay] = true;
            _isDelayActive = true;
            XML.setValue( "DELAY_ACTIVE", _buttonValue[kButtonDelay] );
            XML.saveFile( ofxiOSGetDocumentsDirectory() + "mySettings.xml" );
            ofLog() << "mySettings.xml saved to app documents dolder ";
        } else {
            _buttonValue[kButtonDelay] = false;
            _isDelayActive = false;
            XML.setValue( "DELAY_ACTIVE", _buttonValue[kButtonDelay] );
            XML.saveFile( ofxiOSGetDocumentsDirectory() + "mySettings.xml" );
            ofLog() << "mySettings.xml saved to app documents dolder ";
        }
    }
    
    
}

