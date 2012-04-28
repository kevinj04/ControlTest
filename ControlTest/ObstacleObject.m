//
//  ObstacleObject.m
//  ControlTest
//
//  Created by Michael Highland on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObstacleObject.h"
#define PROXIMITY_ALERT 480.0

@implementation ObstacleObject

@synthesize xSpeed, speedFactor;

- (id) init{
    
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    
	if( (self=[super initWithRect:CGRectMake(0.0, 0.0, 0.0, 0.0)])) {
        [self randomReset];
    }
	return self;
    
}

- (void) setSpeed:(float)speed
{
    xSpeed = speed;
    
}

- (void) randomReset {
    
    //reset the position and size
    [super setupWithRect:CGRectMake(580.0 + arc4random() % 1000, 
                                    -100 + arc4random() % 420, 
                                    10 + arc4random() % 140, 
                                    10 +arc4random() % 90)];
    speedFactor = 0.5 + 2.0 * CCRANDOM_0_1();
    xSpeed = 0.0;
    //NSLog(@"Obstacle Reset");
    
}


- (void) update:(ccTime) dt{
    
    model.origin.x -= xSpeed * speedFactor * dt * 2.0;
    
    if(model.origin.x < -500.0)
        [self randomReset];
    
    //NSLog(@"Position: %f and Speed: %f",model.origin.x, xSpeed);
    [super update:dt];
    
}
- (void) draw{
    
    [self earlyWarning];
    [super draw];
    
}

- (void) earlyWarning{
    
    float proximity = model.origin.x - model.size.width/2.0 - PROXIMITY_ALERT;

    
    if(proximity > 0 && proximity < PROXIMITY_ALERT){
        // approches 1.0 as proximity goes to 0
        float proxFactor = (PROXIMITY_ALERT - proximity)/PROXIMITY_ALERT;
        
        glColor4f(proxFactor, 0.0, 0.0, 1.0);
        glLineWidth(2.0f);
        ccDrawLine(ccp(380.0 + proxFactor * 100.0, model.origin.y),
                   ccp(380.0 + proxFactor * 100.0, model.origin.y + model.size.height));	
    }
    
}

- (void) dealloc{
    
    [super dealloc];
}

@end
