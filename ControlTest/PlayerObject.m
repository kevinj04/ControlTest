//
//  PlayerObject.m
//  ControlTest
//
//  Created by Michael Highland on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerObject.h"

#define MAX_TURN_SPEED 3.0

@implementation PlayerObject

- (id) init{
    
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    
	if( (self=[super initWithRect:CGRectMake(240.0, 160.0, 50.0, 15.0)])) {
        
    }
	return self;
    
}

- (void) setX:(float) newX {
    model.origin.x = newX;
}

- (void) setY:(float) newY{
    model.origin.y = newY;
}

- (void) steerToPoint:(CGPoint) point{
    
    float dy = (point.y - model.origin.y)/20; 
    if(dy>0)
        dy = fmin(dy, MAX_TURN_SPEED);
    else
        dy = fmax(dy, MAX_TURN_SPEED * -1.0);
    
    model.origin.y += dy;
}


- (void) update:(ccTime) dt{
    
    [super update:dt];
    
}
- (void) draw{
    
    [super draw];
    
}
- (void) dealloc{
    
    [super dealloc];
}

@end
