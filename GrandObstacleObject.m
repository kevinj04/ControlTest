//
//  GrandObstactleObject.m
//  ControlTest
//
//  Created by Michael Highland on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GrandObstacleObject.h"


@implementation GrandObstacleObject

@synthesize x, y, z, height, width, depth;

-(id) init
{
    if((self = [super init])){
        
        [self setup];
        return self;
    }
    
    return nil;
    
    
}

-(void) setup{
    orientation = side;
    [self viewSide];
}

+(id) object{
    return [[[GrandObstacleObject alloc] init] autorelease];
}

-(void) dealloc{
    [super dealloc];
}

-(void) viewTop{
    //switch model    
    CGRect newRect = CGRectMake(x, z, width, depth);
    [self setupWithRect:newRect];
    red = 1.0;
    green = 1.0;
    blue = 0.0;
    
}

-(void) viewSide{
    //switch model    
    CGRect newRect = CGRectMake(x, y, width, height);
    [self setupWithRect:newRect];
    red = 0.0;
    green = 1.0;
    blue = 1.0;
}

- (void) randomReset {
    
    x = 580.0 + arc4random() % 1000;
    y = -100 + arc4random() % 420;
    z = -100 + arc4random() % 420;
    
    height = 10 +arc4random() % 90;
    width = 10 + arc4random() % 140;
    depth = 10 +arc4random() % 90;
    
    //reset the position and size
  
    speedFactor = 0.5 + 2.0 * CCRANDOM_0_1();
    xSpeed = 0.0;
    //NSLog(@"Obstacle Reset");
 
    [self setOrientation:orientation];
    
}

-(obstacleOrientation) orientation{
    return orientation;
    
}
-(void) setOrientation:(obstacleOrientation) o{
    
    orientation = o;
    switch (orientation) {
        case top:
            [self viewTop];
            break;
        case side:
            [self viewSide];
            break;
        default:
            [self viewSide];
            break;
    }
    
}

- (void) update:(ccTime)dt {
    
    x = [self model].origin.x;
    [super update:dt];
}

- (void) draw {
    
    float r, g, b;
    
    switch (orientation) {
        case top:
            r = 0.0;
            g = 1.0;
            b = 1.0;
            break;
        case side:
            r = 1.0;
            g = 1.0;
            b = 0.0;
            break;    
        default:
            break;
    }
    
    glColor4f(r/4.0, g/4.0, b/4.0, 0.0);
    glLineWidth(2.0f);
    
    switch (orientation) {
        case top:
            //top
            ccDrawLine(ccp(x - width/2, y + height/2), 
                       ccp(x + width/2, y + height/2));	
            //right
            ccDrawLine(ccp(x + width/2, y + height/2),
                       ccp(x + width/2, y - height/2));	
            //bottom
            ccDrawLine(ccp(x + width/2, y - height/2),
                       ccp(x - width/2, y - height/2));		
            //left
            ccDrawLine(ccp(x - width/2, y - height/2),
                       ccp(x - width/2, y + height/2));
            break;
        
        case side:
            //top
            ccDrawLine(ccp(x - width/2, z + depth/2), 
                       ccp(x + width/2, z + depth/2));	
            //right
            ccDrawLine(ccp(x + width/2, z + depth/2),
                       ccp(x + width/2, z - depth/2));	
            //bottom
            ccDrawLine(ccp(x + width/2, z - depth/2),
                       ccp(x - width/2, z - depth/2));		
            //left
            ccDrawLine(ccp(x - width/2, z - depth/2),
                       ccp(x - width/2, z + depth/2));
            break;
            
        default:
            break;
    }
    
    [super draw];
}


@end
