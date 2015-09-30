
#include "menu.h"

menu::menu()
{
}


void menu::setup()
{
    _tinyButtonX            = ofGetWidth() * 0.01;
    _tinyButtonY            = ofGetWidth() * 0.01;
    _tinyButtonRadius       = ofGetWidth() * 0.01;
    _distanceToTinyButton   = ofGetWidth();
    _isInMenu               = false;
    _whatRecSample          = 0;
    _whatFileSample         = 1;
    _whatMode               = kModeFileSample;
    _pictogramsPosY         = ofGetHeight() * 0.2;
    _pictogramsRadius       = ofGetWidth() * 0.05;
    _outOfMenuTimer         = 0;
    _startOutOfMenuTimer    = false;


    
    for ( int i = 0; i < NUM_OF_MENU_PICTOGRAMS; i++ ) {
        _pictogramsPosX[i] = (ofGetWidth() * BUTTON_INDENT) + (ofGetWidth() * BUTTON_WIDTH) * i;
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
            _outOfMenuTimer = 0;
            _startOutOfMenuTimer = false;
        }
    }
    
}

void menu::distanceToTinyButton( float touchX, float touchY ) {
    
    _distanceToTinyButton = sqrt( (touchX - _tinyButtonX) * (touchX - _tinyButtonX) + (touchY - _tinyButtonY) * (touchY - _tinyButtonY) ) ;
    
    if ( _tinyButtonRadius * 4 > _distanceToTinyButton ) {
        if ( !_isInMenu ) {
            _isInMenu = true;
        } else {
            _isInMenu = false;
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
                ofLog() << "what mode: " << _whatMode;
            } else if ( i == 1 || i == 2 || i == 3 ) {
                _whatMode = kModeRec;
                _whatRecSample = i - 1;
                _startOutOfMenuTimer = true;
                ofLog() << "what mode: " << _whatMode;
                ofLog() << "what rec sample: " << _whatRecSample;
            } else {
                _whatMode = kModeFileSample;
                _whatFileSample = i - 4;
                _startOutOfMenuTimer = true;
                ofLog() << "what mode: " << _whatMode;
                ofLog() << "what file sample: " << _whatFileSample;
            }
        }
    }
}



void menu::draw(  )
{
    // Tiny button
    ofSetColor( 255, 255, 255 );
    ofFill();
    ofCircle( _tinyButtonX, _tinyButtonY, _tinyButtonRadius );
    
    
    if ( _isInMenu ) {
        // Bit20 pictogram
        _pictogramBit20.draw( _pictogramsPosX[0], _pictogramsPosY, _pictogramsRadius, _pictogramsRadius );
        
        // Rec mic pictogram
        for ( int i = 0; i < NUM_OF_REC_MODES; i++ ) {
            _pictogramRecMic[i].draw( _pictogramsPosX[i + 1], _pictogramsPosY, _pictogramsRadius, _pictogramsRadius );
        }
        
        // Num pictogram
        for ( int i = 0; i < NUM_OF_HARDCODED_SOUNDS; i++ ) {
            _pictogramNum[i].draw( _pictogramsPosX[i + 4], _pictogramsPosY, _pictogramsRadius, _pictogramsRadius );
        }
    }
    
    
}


