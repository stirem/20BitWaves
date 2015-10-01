
#include "menu.h"

menu::menu()
{
}


void menu::setup()
{
    _tinyButtonX                = ofGetWidth() * 0.01;
    _tinyButtonY                = ofGetWidth() * 0.01;
    _distanceToTinyButton       = ofGetWidth();
    _isInMenu                   = false;
    _muteAudio                  = false;
    _whatRecSample              = 0;
    _whatFileSample             = 0;
    _whatMode                   = kModeFileSample;
    _pictogramsPosY             = ofGetHeight() * 0.8;
    _pictogramsRadius           = ofGetWidth() * 0.05;
    _outOfMenuTimer             = 0;
    _startOutOfMenuTimer        = false;
    _inToMenuTimer              = 0;
    _startInToMenuTimer         = false;
    _tinyButtonPictogramRadius  = ofGetWidth() * 0.03;


    
    for ( int i = 0; i < NUM_OF_MENU_PICTOGRAMS; i++ ) {
        _pictogramsPosX[i] = (ofGetWidth() * BUTTON_INDENT) * 2 + (ofGetWidth() * BUTTON_WIDTH) * i;
        _distanceToMenuButtons[i] = ofGetWidth();
    }
    
    
    _pictogramBit20.loadImage( "bit20pictogram.png" );
    
    for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
        _pictogramRecMic[i].loadImage( "recMicPictogram" + ofToString( i ) + ".png" );
    }
    
    for (int i = 0; i < NUM_OF_HARDCODED_SOUNDS; i++)
    {
        string picFileNr = "pictogram_num_" + ofToString( i ) + ".png";
        _pictogramNum[i].loadImage( ofToDataPath( picFileNr ) );
    }
    
    
}


void menu::update(  )
{
    if ( _startOutOfMenuTimer) {
        _outOfMenuTimer += ofGetLastFrameTime();
        if ( _outOfMenuTimer > 0.1 ) {
            _isInMenu = false;
            _muteAudio = false;
            _outOfMenuTimer = 0;
            _startOutOfMenuTimer = false;
        }
    }
    
    if ( _startInToMenuTimer ) {
        _inToMenuTimer += ofGetLastFrameTime();
        if ( _inToMenuTimer > 0.1 ) {
            _isInMenu = true;
            _inToMenuTimer = 0;
            _startInToMenuTimer = false;
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

void menu::distanceToMenuButtons( float touchX, float touchY ) {
    
    for ( int i = 0; i < NUM_OF_MENU_PICTOGRAMS; i++ ) {
        _distanceToMenuButtons[i] = sqrt( (touchX - _pictogramsPosX[i]) * (touchX - _pictogramsPosX[i]) + (touchY - _pictogramsPosY) * (touchY - _pictogramsPosY) ) ;
    
        if ( _pictogramsRadius > _distanceToMenuButtons[i] ) {
            if ( i == 0 ) {
                _whatMode = kModeAbout;
                _startOutOfMenuTimer = true;
            } else if ( i == 1 || i == 2 || i == 3 ) {
                _whatMode = kModeRec;
                _whatRecSample = i - 1;
                _startOutOfMenuTimer = true;
            } else {
                _whatMode = kModeFileSample;
                _whatFileSample = i - 4;
                _startOutOfMenuTimer = true;
            }
        } else if ( _isInMenu ) {
            _startOutOfMenuTimer = true;
        }
    }
}



void menu::draw(  )
{
    // Tiny button
    if ( !_isInMenu ) {
        ofSetColor( 70 );
        if ( _whatMode == kModeAbout ) {
            _tinyButtonPictogram.clone( _pictogramBit20 );
        } else if ( _whatMode == kModeRec ) {
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
        _tinyButtonPictogram.draw( _tinyButtonX, _tinyButtonY, _tinyButtonPictogramRadius, _tinyButtonPictogramRadius );
    }
    
    
    if ( _isInMenu ) {
        
        // Bit20 pictogram
        if ( _whatMode == kModeAbout ) {
            ofSetColor( 255 );
        } else {
            ofSetColor( 70 );
        }
        _pictogramBit20.draw( _pictogramsPosX[0], _pictogramsPosY, _pictogramsRadius, _pictogramsRadius );
        
        // Rec mic pictogram
        for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
            if ( _whatMode == kModeRec && _whatRecSample == i ) {
                ofSetColor( 255 );
            } else {
                ofSetColor( 70 );
            }
            _pictogramRecMic[i].draw( _pictogramsPosX[i + 1], _pictogramsPosY, _pictogramsRadius, _pictogramsRadius );
        }
        
        // Num pictogram
        for ( int i = 0; i < NUM_OF_HARDCODED_SOUNDS; i++ ) {
            if ( _whatMode == kModeFileSample && _whatFileSample == i ) {
                ofSetColor( 255 );
            } else {
                ofSetColor( 70 );
            }
            _pictogramNum[i].draw( _pictogramsPosX[i + 4], _pictogramsPosY, _pictogramsRadius, _pictogramsRadius );
        }
    }
    
    
}


