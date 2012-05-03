//
//  PlayerObject.h
//  ControlTest
//
//  Created by Michael Highland on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovableObject.h"
#import "cocos2d.h"

@interface PlayerObject : MovableObject {

    float xSpeed;
    float width;
    float height;
    bool isBraking;
    float speedLimit;
    float juice;
}

@property float xSpeed;
@property float speedLimit;
@property float width;
@property float height;
@property bool isBraking;
@property float juice;

- (id) init;
- (void) setup;
- (void) update:(ccTime) dt;
- (void) draw;
- (void) warp;
- (void) drag;
- (void) dealloc;
- (void) setX:(float) newX;
- (void) setY:(float) newY;
- (void) steerToPoint:(CGPoint) point;
- (void) speedBoostOf:(float) boost;
- (void) killBoost;

@end
