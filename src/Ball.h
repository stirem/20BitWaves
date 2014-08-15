#pragma once




class Ball{

    public:
        ofPoint pos;
        ofColor col;
        ofColor touchCol;
        bool bDragged;
	
        //----------------------------------------------------------------	
        void init(int id) {
            
            // Random initialise position
            pos.set(ofRandomWidth(), ofRandomHeight(), 0);
		
            // Touch Up color
            if ( id  == 0  ){
                col.r = 255;
                col.g = 0;
                col.b = 0;
                col.a = 100;
            } else if (  id == 1){
                col.r = 0;
                col.g = 255;
                col.b = 0;
                col.a = 100;
            } else if (id == 2){
                col.r = 0;
                col.g = 0;
                col.b = 255;
                col.a = 100;
            } else if (id == 3){
                col.r = 255;
                col.g = 255;
                col.b = 0;
                col.a = 100;
            } else if (id == 4){
                col.r = 0;
                col.g = 255;
                col.b = 255;
                col.a = 100;
            } else if (id == 5){
                col.r = 255;
                col.g = 0;
                col.b = 255;
                col.a = 100;
            } else if (id == 6){
                col.r = 50;
                col.g = 100;
                col.b = 100;
                col.a = 100;
            }
            
            // Touch color
            if ( id  == 0  ){
                touchCol.r = 255;
                touchCol.g = 0;
                touchCol.b = 0;
            } else if (  id == 1){
                touchCol.r = 0;
                touchCol.g = 255;
                touchCol.b = 0;
            } else if (id == 2){
                touchCol.r = 0;
                touchCol.g = 0;
                touchCol.b = 255;
            } else if (id == 3){
                touchCol.r = 255;
                touchCol.g = 255;
                touchCol.b = 0;
            } else if (id == 4){
                touchCol.r = 0;
                touchCol.g = 255;
                touchCol.b = 255;
            } else if (id == 5){
                touchCol.r = 255;
                touchCol.g = 0;
                touchCol.b = 255;
            } else if (id == 6){
                touchCol.r = 50;
                touchCol.g = 100;
                touchCol.b = 100;
            }
		
            bDragged = false;
        }
	
        //----------------------------------------------------------------	
        void update() {
		


            
 }

 
        //----------------------------------------------------------------
        void draw() {
            
            // Change color
            if( bDragged ){
                ofSetColor(touchCol);
                ofCircle(pos.x, pos.y, 80);
            }else{
                ofSetColor(col);		
                ofCircle(pos.x, pos.y, 80);
            }
        }
	
        //----------------------------------------------------------------	
        void moveTo(int x, int y) {
            
            // Move to position
            pos.set(x, y, 0);

        }
};
