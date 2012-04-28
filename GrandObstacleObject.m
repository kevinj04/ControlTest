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
@synthesize warpFactor, heightWarp, widthWarp, depthWarp;

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
    warpFactor = 1.0;
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
    CGRect newRect = CGRectMake(x, z, widthWarp, depthWarp);
    [self setupWithRect:newRect];
    red = 1.0;
    green = 1.0;
    blue = 0.0;
    
}

-(void) viewSide{
    //switch model    
    CGRect newRect = CGRectMake(x, y, widthWarp, heightWarp);
    [self setupWithRect:newRect];
    red = 0.0;
    green = 1.0;
    blue = 1.0;
}

- (void) randomReset {
    
    x = 580.0 + arc4random() % 2000;
    y = -100 + arc4random() % 420;
    z = -100 + arc4random() % 420;
    
    height = 10 +arc4random() % 90;
    width = 10 + arc4random() % 90;
    depth = 10 +arc4random() % 90;
    
    //reset the position and size
  
    speedFactor = 0.8 + 0.4 * CCRANDOM_0_1();
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
    
    warpFactor = 1.0 + xSpeed/200.0; 
    
    widthWarp = fmin(300.0, width * warpFactor);
    heightWarp = fmax(1.0, height / warpFactor);
    depthWarp = fmax(1.0, depth / warpFactor);
    
    [self setOrientation:orientation];
    
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
            1+1;
            CGPoint vertices1[] = { ccp(x,y),
                                    ccp(x, y + heightWarp), 
                                    ccp(x + widthWarp, y + heightWarp), 
                                    ccp(x + widthWarp, y) 
            };
            ccDrawPoly(vertices1, 4, YES);
            break;
        
        case side:
            1+1; // weird bug without this?
            CGPoint vertices2[] = {  ccp(x,z),
                                    ccp(x, z + depthWarp), 
                                    ccp(x + widthWarp, z + depthWarp), 
                                    ccp(x + widthWarp, z) 
            };
            ccDrawPoly(vertices2, 4, YES);
            break;
            
        default:
            break;
    }
    
    [super draw];
}


@end
