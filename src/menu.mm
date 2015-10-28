
#include "menu.h"

menu::menu()
{
}


void menu::setup()
{
    if ( _XML.loadFile(ofxiOSGetDocumentsDirectory() + "mySettings.xml" ) ){
        ofLog() << "mySettings.xml loaded from documents folder!";
    } else if ( _XML.loadFile( "mySettings.xml" ) ){
        ofLog() << "mySettings.xml loaded from data folder!";
    } else {
        ofLog() << "unable to load mySettings.xml check data/ folder";
    }
    _whatMode                   = _XML.getValue( "WHAT_MODE", 2 );
    _whatRecSample              = _XML.getValue( "WHAT_REC_SAMPLE", 0 );
    _whatFileSample             = _XML.getValue( "WHAT_FILE_SAMPLE", 0 );
    

    
    _tinyButtonOpacity          = 30;
    _startTinyButtonFadeDown    = false;
    _isInMenu                   = false;
    _muteAudio                  = false;
    _outOfMenuTimer             = 0;
    _startOutOfMenuTimer        = false;
    _inToMenuTimer              = 0;
    _startInToMenuTimer         = false;
    _aboutIsOpen                = false;
    
    initSizeValues();
    
    easeOpenX();
    easeOpenY();


    _pictogramBit20.loadImage( "bit20pictogram.png" );
    
    for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
        _pictogramRecMic[i].loadImage( "recMicPictogram" + ofToString( i ) + ".png" );
    }
    
    for (int i = 0; i < NUM_OF_HARDCODED_SOUNDS; i++)
    {
        // WARNING!! The number in the image is one higher than what the filename says.
        string picFileNr = "pictogram_num_" + ofToString( i ) + ".png";
        _pictogramNum[i].loadImage( ofToDataPath( picFileNr ) );
    }
    
    // Init image with something random
    _tinyButtonPictogram.loadImage( "pictogram_num_0.png" );
    
    
}

void menu::initSizeValues() {
    
    _tinyButtonX                = ofGetWidth() * 0.04;
    _tinyButtonY                = ofGetWidth() * 0.04;
    _distanceToTinyButton       = ofGetWidth();
    _pictogramsOpenY            = ofGetHeight() * 0.9;
    _pictogramsClosedY          = _tinyButtonX;
    _pictogramsClosedX          = _tinyButtonY;
    _pictogramsRadius           = ofGetWidth() * 0.05;
    _tinyButtonPictogramRadius  = _pictogramsRadius;
    for ( int i = 0; i < NUM_OF_MENU_PICTOGRAMS; i++ ) {
        _pictogramsOpenX[i] = (ofGetWidth() * BUTTON_INDENT) * 3 + (ofGetWidth() * BUTTON_WIDTH) * i;
        _distanceToMenuButtons[i] = ofGetWidth();
    }
}

void menu::easeOpenX() {
    
    for ( int i = 0; i < NUM_OF_MENU_PICTOGRAMS; i++ ) {
        _timeX          = 0;
        _beginningX     = _pictogramsClosedX;
        _changeX[i]     = _pictogramsOpenX[i] - _pictogramsClosedX;
        _durationX      = 20;
    }
    
}

void menu::easeOpenY() {
    
    _timeY      = 0;
    _beginningY = _pictogramsClosedY;
    _changeY    = _pictogramsOpenY - _pictogramsClosedY;
    _durationY  = 20;
}



void menu::update(  )
{
    // Easing animation timer
    if ( _isInMenu ) {
        if ( _timeX < _durationX ) _timeX++;
        if ( _timeY < _durationY ) _timeY++;
    }
    
    // Animate menu in
    if ( _startInToMenuTimer ) {
        _inToMenuTimer += ofGetLastFrameTime();
        if ( _inToMenuTimer > 0.1 ) {
            _isInMenu = true;
            easeOpenX();
            easeOpenY();
            _inToMenuTimer = 0;
            _startInToMenuTimer = false;
        }
    }
    
    // Out of menu
    if ( _startOutOfMenuTimer) {
        _outOfMenuTimer += ofGetLastFrameTime();
        _tinyButtonOpacity = 255;
        _startTinyButtonFadeDown = true;
        if ( _outOfMenuTimer > 0.1 ) {
            _isInMenu = false;
            _muteAudio = false;
            _outOfMenuTimer = 0;
            _startOutOfMenuTimer = false;
        }
    }
    
    // Fade down tiny button
    if ( _startTinyButtonFadeDown ) {
        if ( _whatMode == kModeFileSample ) {
            if ( _tinyButtonOpacity > 30 ) {
                _tinyButtonOpacity -= 5;
            } else {
                _startTinyButtonFadeDown = false;
            }
        } else if ( _whatMode == kModeRec ) {
            if ( _tinyButtonOpacity > 50 ) {
                _tinyButtonOpacity -= 5;
            } else {
                _startTinyButtonFadeDown = false;
            }
        }
    }
    
}

void menu::distanceToTinyButton( float touchX, float touchY ) {
    
    _distanceToTinyButton = sqrt( (touchX - _tinyButtonX) * (touchX - _tinyButtonX) + (touchY - _tinyButtonY) * (touchY - _tinyButtonY) ) ;
    
    if ( _tinyButtonPictogramRadius > _distanceToTinyButton ) {
        if ( !_isInMenu ) {
            _muteAudio = true;
            _startInToMenuTimer = true;
        }
    }
}

void menu::distanceToMenuButtons( float touchX, float touchY, int howManySamples ) {
    

    for ( int i = 0; i < 1 + NUM_OF_REC_MODES + howManySamples; i++ ) { // 1 = about
        _distanceToMenuButtons[i] = sqrt( (touchX - _pictogramsOpenX[i]) * (touchX - _pictogramsOpenX[i]) + (touchY - _pictogramsOpenY) * (touchY - _pictogramsOpenY) ) ;
    
        if ( _pictogramsRadius > _distanceToMenuButtons[i] ) {
            if ( i == 0 ) {
                _aboutIsOpen = true;
                _startOutOfMenuTimer = true;
            } else if ( i == 1 || i == 2 || i == 3 ) {
                _whatMode = kModeRec;
                _XML.setValue( "WHAT_MODE", kModeRec );
                _whatRecSample = i - 1;
                _XML.setValue( "WHAT_REC_SAMPLE", i - 1 );
                _XML.saveFile( ofxiOSGetDocumentsDirectory() + "mySettings.xml" );
                ofLog() << "mySettings.xml saved to app documents dolder ";
                _startOutOfMenuTimer = true;
            } else {
                _whatMode = kModeFileSample;
                _XML.setValue( "WHAT_MODE", kModeFileSample );
                _whatFileSample = i - 4;
                _XML.setValue( "WHAT_FILE_SAMPLE", i - 4 );
                _XML.saveFile( ofxiOSGetDocumentsDirectory() + "mySettings.xml" );
                ofLog() << "mySettings.xml saved to app documents dolder ";
                _startOutOfMenuTimer = true;
            }
        } else if ( _isInMenu ) {
            _startOutOfMenuTimer = true;
        }
    }

}



void menu::draw( int howManySamples )
{
   initSizeValues();
    
    // Tiny button
    if ( !_isInMenu ) {
        if ( !_aboutIsOpen ) {
            ofSetColor( _tinyButtonOpacity );
            if ( _whatMode == kModeRec ) {
                for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
                    if ( _whatRecSample == i ) {
                        _tinyButtonPictogram.clone( _pictogramRecMic[i] );
                    }
                }
            } else if ( _whatMode == kModeFileSample ) {
                for ( int i = 0; i < NUM_OF_HARDCODED_SOUNDS; i++ ) {
                    if ( _whatFileSample == i ) {
                        _tinyButtonPictogram.clone( _pictogramNum[i] );
                    }
                }
            }
            _tinyButtonPictogram.setAnchorPercent( 0.5, 0.5 );
            _tinyButtonPictogram.draw( _tinyButtonX, _tinyButtonY, _tinyButtonPictogramRadius, _tinyButtonPictogramRadius );
        }
    }
    
    
    
    if ( _isInMenu ) {
        
        // Bit20 pictogram
        if ( _aboutIsOpen ) {
            ofSetColor( 255 );
        } else {
            ofSetColor( 70 );
        }
        _pictogramBit20.setAnchorPercent( 0.5, 0.5 );
        _pictogramBit20.draw( Quad::easeOut( _timeX, _beginningX, _changeX[0], _durationX ),  Quad::easeOut( _timeY, _beginningY, _changeY, _durationY ), _pictogramsRadius, _pictogramsRadius );
        
        // Rec mic pictogram
        for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
            if ( _whatMode == kModeRec && _whatRecSample == i ) {
                ofSetColor( 255 );
            } else {
                ofSetColor( 70 );
            }
            _pictogramRecMic[i].setAnchorPercent( 0.5, 0.5 );
            _pictogramRecMic[i].draw( Quad::easeOut( _timeX, _beginningX, _changeX[i + 1], _durationX ),  Quad::easeOut( _timeY, _beginningY, _changeY, _durationY ), _pictogramsRadius, _pictogramsRadius );
        }
        
        // Num pictogram
        for ( int i = 0; i < howManySamples; i++ ) {
            if ( _whatMode == kModeFileSample && _whatFileSample == i ) {
                ofSetColor( 255 );
            } else {
                ofSetColor( 70 );
            }
            _pictogramNum[i].setAnchorPercent( 0.5, 0.5 );
            _pictogramNum[i].draw( Quad::easeOut( _timeX, _beginningX, _changeX[i + 4], _durationX ),  Quad::easeOut( _timeY, _beginningY, _changeY, _durationY ), _pictogramsRadius, _pictogramsRadius );
        }
    }
    
    
   /* if ( _isInMenu ) {
        
        // Bit20 pictogram
        if ( _whatMode == kModeAbout ) {
            ofSetColor( 255 );
        } else {
            ofSetColor( 70 );
        }
        _pictogramBit20.draw( _pictogramsOpenX[0], _pictogramsOpenY, _pictogramsRadius, _pictogramsRadius );
        
        // Rec mic pictogram
        for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
            if ( _whatMode == kModeRec && _whatRecSample == i ) {
                ofSetColor( 255 );
            } else {
                ofSetColor( 70 );
            }
            _pictogramRecMic[i].draw( _pictogramsOpenX[i + 1], _pictogramsOpenY, _pictogramsRadius, _pictogramsRadius );
        }
        
        // Num pictogram
        for ( int i = 0; i < NUM_OF_HARDCODED_SOUNDS; i++ ) {
            if ( _whatMode == kModeFileSample && _whatFileSample == i ) {
                ofSetColor( 255 );
            } else {
                ofSetColor( 70 );
            }
            _pictogramNum[i].draw( _pictogramsOpenX[i + 4], _pictogramsOpenY, _pictogramsRadius, _pictogramsRadius );
        }
    }*/
    
    
}


