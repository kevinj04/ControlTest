//
//  PlayerObject.m
//  ControlTest
//
//  Created by Michael Highland on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerObject.h"

#define MAX_TURN_SPEED 5.0
#define MAX_SPEED 100.0

@implementation PlayerObject

@synthesize xSpeed;

- (id) init{
    
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    
	if( (self=[super initWithRect:CGRectMake(140.0, 160.0, 50.0, 15.0)])) {
        
    }
	return self;
    
}

- (void) setX:(float) newX {
    model.origin.x = newX;
}

- (void) setY:(float) newY{
    model.origin.y = newY;
}

- (void) speedBoost
{
    
    xSpeed += 100.0;
    
}

- (void) steerToPoint:(CGPoint) point{
    
    // apply steering force
    
    float dy = (point.y - model.origin.y)/20; 
    if(dy>0)
        dy = fmin(dy, MAX_TURN_SPEED);
    else
        dy = fmax(dy, MAX_TURN_SPEED * -1.0);
    
    if(xSpeed > 1.0)
        model.origin.y += dy * (0.10 + xSpeed/100.0*0.9);
    
    // decrement speed
    if(xSpeed>0)
        xSpeed -= fabsf(dy/MAX_TURN_SPEED) * xSpeed/MAX_SPEED * 1.0;
}


- (void) update:(ccTime) dt{
    
    [super update:dt];
    
    xSpeed += (MAX_SPEED - xSpeed)*(1.0/300.0);
    
}
- (void) draw{
    
    [super draw];
    
}
- (void) dealloc{
    
    [super dealloc];
}

@end
