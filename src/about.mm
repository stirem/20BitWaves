
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
    /*if ( XML.loadFile(ofxiOSGetDocumentsDirectory() + "mySettings.xml" ) ){
        ofLog() << "mySettings.xml loaded from documents folder!";
    } else if ( XML.loadFile( "mySettings.xml" ) ){
        ofLog() << "mySettings.xml loaded from data folder!";
    } else {
        ofLog() << "unable to load mySettings.xml check data/ folder";
    }
    _audioInputValue                        = XML.getValue( "AUDIO_INPUT_VALUE", 1 );*/
    
    //_isDelayActive                          = XML.getValue( "DELAY_ACTIVE", 0 );
    
    _closeAbout                             = false;

    
    //_buttonValue[kButtonBluetooth]          = _audioInputValue;
    //_buttonValue[kButtonDelay]              = _isDelayActive;

    initSizeValues();
    
    _arial.loadFont( "Fonts/arial.ttf", 12 );
    
    _aboutTextAndLogos.loadImage( "aboutTextAndLogos.png" );
    _closeButton.loadImage( "closeButton.png" );
    
    
    
}

void About::initSizeValues() {
    
    for ( int i = 0; i < NUM_OF_BUTTONS; i++ ) {
        _distanceToButton[i]                = ofGetWidth();
    }
    _buttonY[kButtonBluetooth]              = ofGetHeight() * 0.95;
    _buttonY[kButtonDelay]                  = ofGetHeight() * 0.9;
    _aboutTextAndLogos_width                = ofGetWidth() * 0.85;
    _aboutTextAndLogos_height               = ofGetWidth() * 0.47;
    _aboutTextAndLogos_X                    = ofGetWidth() * 0.5;
    _aboutTextAndLogos_Y                    = ofGetHeight() * 0.5;
    _buttonRadius[kButtonUrlBek]            = ofGetWidth() * 0.02;
    _buttonRadius[kButtonUrlStian]          = ofGetWidth() * 0.04;
    _buttonRadius[kButtonUrlBit20]          = ofGetWidth() * 0.025;
    _buttonX[kButtonUrlBek]                 = _aboutTextAndLogos_X - ( _aboutTextAndLogos_width * 0.115 );
    _buttonY[kButtonUrlBek]                 = _aboutTextAndLogos_Y + ( _aboutTextAndLogos_height * 0.1 );
    _buttonX[kButtonUrlStian]               = _aboutTextAndLogos_X - ( _aboutTextAndLogos_width * 0.02 );
    _buttonY[kButtonUrlStian]               = _aboutTextAndLogos_Y + ( _aboutTextAndLogos_height * 0.1 );
    _buttonX[kButtonUrlBit20]               = _aboutTextAndLogos_X + ( _aboutTextAndLogos_width * 0.158 );
    _buttonY[kButtonUrlBit20]               = _aboutTextAndLogos_Y - ( _aboutTextAndLogos_height * 0.14 );

    _distanceToCloseButton                  = ofGetWidth();
    _closeButtonX                           = _aboutTextAndLogos_X + ( _aboutTextAndLogos_width * 0.495 );
    _closeButtonY                           = _aboutTextAndLogos_Y - ( _aboutTextAndLogos_height * 0.495 );
    _closeButtonRadius                      = ofGetWidth() * 0.04;
    
}


void About::update(  ) {
    

}


void About::draw() {

    initSizeValues();
    
    // About Text and Logoes
    ofSetColor( 255 );
    _aboutTextAndLogos.setAnchorPercent( 0.5, 0.5 );
    _aboutTextAndLogos.draw( _aboutTextAndLogos_X, _aboutTextAndLogos_Y, _aboutTextAndLogos_width, _aboutTextAndLogos_height );

    
    // CLOSE BUTTON
    _closeButton.setAnchorPercent( 0.5, 0.5 );
    _closeButton.draw( _closeButtonX, _closeButtonY, _closeButtonRadius, _closeButtonRadius );
    // Close Button circle for DEBUGGING
    /*ofNoFill();
    ofCircle( _closeButtonX, _closeButtonY, _closeButtonRadius );*/
    
    
    // WEB LINKS CIRCLES FOR DEBUGGING
    /*ofNoFill();
    ofCircle( _buttonX[kButtonUrlBek], _buttonY[kButtonUrlBek], _buttonRadius[kButtonUrlBek] );
    ofCircle( _buttonX[kButtonUrlStian], _buttonY[kButtonUrlStian], _buttonRadius[kButtonUrlStian] );
    ofCircle( _buttonX[kButtonUrlBit20], _buttonY[kButtonUrlBit20], _buttonRadius[kButtonUrlBit20] );*/
    

    /// BLUETOOTH BUTTON ///
    // Button
    // Outer circle
    /*ofSetColor( 255 );
    ofNoFill();
    ofCircle( _buttonX[kButtonBluetooth], _buttonY[kButtonBluetooth], _buttonRadius[kButtonBluetooth] );
    // Inner filled circle
    if ( !_buttonValue[kButtonBluetooth] ) { // WARNING! Audio input value 0 means no mic input and bluetooth on. Audio input value 1 means mic input is on, and bluetooth is off. So it is the other way around. Value 0 means button is filled, and value 1 means button is not filled.
        ofFill();
        ofCircle( _buttonX[kButtonBluetooth], _buttonY[kButtonBluetooth], _buttonRadius[kButtonBluetooth] * 0.8 ); // Smaller size than outer circle
    }
    // Text
    _arial.drawString( "Enable bluetooth speaker. (Setting will take effect the next time you start the app.\nWhen bluetooth is enabled, recording through microphone will be disabled.)", _buttonX[kButtonBluetooth] + _buttonRadius[kButtonBluetooth] * 2, _buttonY[kButtonBluetooth] );*/
    

    // DELAY BUTTON
    // Button
    // Outer circle
    /*ofNoFill();
    ofCircle( _buttonX[kButtonDelay], _buttonY[kButtonDelay], _buttonRadius[kButtonDelay] );
    
    // Inner filled circle
    if ( _buttonValue[kButtonDelay] ) {
        ofFill();
        ofCircle( _buttonX[kButtonDelay], _buttonY[kButtonDelay], _buttonRadius[kButtonDelay] * 0.8 ); // Smaller size than outer circle
    }
    // Text
    _arial.drawString( "Enable delay effect", _buttonX[kButtonDelay] + _buttonRadius[kButtonDelay] * 2, _buttonY[kButtonDelay] );*/


}


void About::distanceToButton( float touchDownX, float touchDownY ) {
    
    // This function is run in ofApp::touchDown()
    
    
    // Bek Url
    _distanceToButton[kButtonUrlBek] = sqrt(    (touchDownX - _buttonX[kButtonUrlBek]) * (touchDownX - _buttonX[kButtonUrlBek]) + (touchDownY - _buttonY[kButtonUrlBek]) * (touchDownY - _buttonY[kButtonUrlBek])     ) ;
    if ( _buttonRadius[kButtonUrlBek] > _distanceToButton[kButtonUrlBek] ) {
        NSURL *urlPath = [NSURL URLWithString:@"http://www.bek.no"];
        [[UIApplication sharedApplication] openURL:urlPath];
    }
    // Stian Url
    _distanceToButton[kButtonUrlStian] = sqrt(    (touchDownX - _buttonX[kButtonUrlStian]) * (touchDownX - _buttonX[kButtonUrlStian]) + (touchDownY - _buttonY[kButtonUrlStian]) * (touchDownY - _buttonY[kButtonUrlStian])     ) ;
    if ( _buttonRadius[kButtonUrlStian] > _distanceToButton[kButtonUrlStian] ) {
        NSURL *urlPath = [NSURL URLWithString:@"http://www.stianremvik.com"];
        [[UIApplication sharedApplication] openURL:urlPath];
    }
    // Bit20 Url
    _distanceToButton[kButtonUrlBit20] = sqrt(    (touchDownX - _buttonX[kButtonUrlBit20]) * (touchDownX - _buttonX[kButtonUrlBit20]) + (touchDownY - _buttonY[kButtonUrlBit20]) * (touchDownY - _buttonY[kButtonUrlBit20])     ) ;
    if ( _buttonRadius[kButtonUrlBit20] > _distanceToButton[kButtonUrlBit20] ) {
        NSURL *urlPath = [NSURL URLWithString:@"http://www.bit20.no"];
        [[UIApplication sharedApplication] openURL:urlPath];
    }
    
    /// BLUETOOTH BUTTON ///
    /*_distanceToButton[kButtonBluetooth] = sqrt(    (touchDownX - _buttonX[kButtonBluetooth]) * (touchDownX - _buttonX[kButtonBluetooth]) + (touchDownY - _buttonY[kButtonBluetooth]) * (touchDownY - _buttonY[kButtonBluetooth])     ) ;
    
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
    }*/
    
    
    
    /// DELAY BUTTON ///
    /*_distanceToButton[kButtonDelay] = sqrt(    (touchDownX - _buttonX[kButtonDelay]) * (touchDownX - _buttonX[kButtonDelay]) + (touchDownY - _buttonY[kButtonDelay]) * (touchDownY - _buttonY[kButtonDelay])     ) ;
    
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
    }*/
    
    
}


void About::distanceToCloseButton( float touchX, float touchY ) {
    
     _distanceToCloseButton = sqrt( (touchX - _closeButtonX) * (touchX - _closeButtonX) + (touchY - _closeButtonY) * (touchY - _closeButtonY) ) ;
    
    if ( _closeButtonRadius > _distanceToCloseButton ) {
        _closeAbout = true;
    }
    
}











