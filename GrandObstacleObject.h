//
//  GrandObstactleObject.h
//  ControlTest
//
//  Created by Michael Highland on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObstacleObject.h"

typedef enum obstacleOrientation {
    top, side
} obstacleOrientation;

@interface GrandObstacleObject : ObstacleObject{
    
    float x;
    float y;
    float z;
    
    float width;
    float height;
    float depth;
    
    obstacleOrientation orientation;
    
}

@property float x;
@property float y;
@property float z;
@property float width;
@property float height;
@property float depth;


-(id) init;
-(void) setup;
+(id) object;
-(void) dealloc;
-(void) viewTop;
-(void) viewSide;

-(obstacleOrientation) orientation;
-(void) setOrientation:(obstacleOrientation) o;


@end
