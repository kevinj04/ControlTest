//
//  PlayerObject.m
//  ControlTest
//
//  Created by Michael Highland on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerObject.h"

#define MAX_TURN_SPEED 5.0
#define MAX_SPEED 200.0

@implementation PlayerObject

@synthesize xSpeed, width, height, isBraking, speedLimit, juice, warpStreak;

- (id) init{
    
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    
	if( (self=[super initWithRect:CGRectMake(140.0, 160.0, 1, 1)])) {
        [self setup];
    }
	return self;
    
}

- (void) setup
{
    height = 33;
    width = 33;
    isBraking = NO;
    speedLimit = MAX_SPEED;
    juice = 0;
    warpStreak = 0;
    
}

- (void) setX:(float) newX {
    model.origin.x = newX;
}

- (void) setY:(float) newY{
    model.origin.y = newY;
}

- (void) warp
{
    warpStreak++;
    juice += warpStreak * 25.0;
    if(warpStreak % 5 == 0){
        speedLimit = warpStreak * 200.0;
        juice += warpStreak * 75.0;
        [self performSelector:@selector(killSuperWarp) withObject:nil afterDelay:2.0];
    }
}

-(void) killSuperWarp{
    speedLimit = MAX_SPEED;
}

- (void) speedBoostOf:(float) boost
{
    juice += boost;
}


- (void) warpKill
{
    warpStreak = 0;
    juice = 0;
}


- (void) drag
{
 
    xSpeed *= 0.666;
    
}



- (void) steerToPoint:(CGPoint) point{
    
    // apply steering force
    
    point.y -= model.size.height/2;
    
    float dy = (point.y - model.origin.y)/20; 
    if(dy>0)
        dy = fmin(dy, MAX_TURN_SPEED);
    else
        dy = fmax(dy, MAX_TURN_SPEED * -1.0);
    
    if(xSpeed > 1.0)
        model.origin.y += dy * fmin(2.0,(0.10 + xSpeed/200.0*0.9));
    
    // decrement speed
    if(xSpeed>0)
        xSpeed -= fabsf(dy/MAX_TURN_SPEED) * xSpeed/MAX_SPEED * 2.0;
}


- (void) update:(ccTime) dt{
    
    [super update:dt];
    model.size.width = fmin(100.0, width * (1.0 + xSpeed/200.0));
    model.size.height = fmax(1.0, height / (1.0 + xSpeed/200.0));
    
    if(isBraking){
        xSpeed += (0.0 - xSpeed)*(1.0/500.0);
        xSpeed = fmax(0.0, xSpeed - 1.0);
    }
    else{
        xSpeed += fmax(0.0,((speedLimit + 100 * warpStreak) - xSpeed)*(1.0/500.0));
        if(juice>0){
            float dj = (0.0-juice)/500.0;
            xSpeed += fabsf(dj);
            juice += dj;
        }
         
    }
}
- (void) draw{
    
    [super draw];
    
}
- (void) dealloc{
    
    [super dealloc];
}

@end
