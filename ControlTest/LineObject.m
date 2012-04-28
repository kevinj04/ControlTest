//
//  LineObject.m
//  ControlTest
//
//  Created by Michael Highland on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LineObject.h"

@implementation LineObject
@synthesize xSpeed, paralaxFactor;

- (id) init{
    
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    
	if( (self=[super initWithRect:CGRectMake(0.0, 0.0, 0.0, 0.0)])) {
        [self randomReset];
    }
	return self;
    
}

- (void) draw{
    
    glColor4f(1.0, 1.0, 1.0, 1.0);
    glLineWidth(1.0f);
    
    ccDrawLine(ccp(model.origin.x, model.origin.y),
               ccp(model.origin.x + model.size.width, model.origin.y));	
    
}


- (void) setSpeed:(float)speed
{
    xSpeed = speed;
    
}

- (void) update:(ccTime) dt{
    
    model.origin.x -= xSpeed * dt * paralaxFactor;
    model.size.width = 1.0 + powf(xSpeed/500.0,6.0) * paralaxFactor;
    
    if(model.origin.x < -10.0)
        [self randomReset];
    
    //NSLog(@"Position: %f and Speed: %f",model.origin.x, xSpeed);
    [super update:dt];
    
}


- (void) randomReset {
    
    //reset the position and size
    [super setupWithRect:CGRectMake(480.0 + arc4random() % 480, arc4random() % 320, 1, 1)];
    //NSLog(@"Obstacle Reset");
    paralaxFactor = 0.01 + 0.99 * CCRANDOM_0_1();
    
}

@end
