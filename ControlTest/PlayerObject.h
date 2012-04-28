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
    
}

@property float xSpeed;

- (id) init;
- (void) update:(ccTime) dt;
- (void) draw;
- (void) dealloc;
- (void) setX:(float) newX;
- (void) setY:(float) newY;
- (void) steerToPoint:(CGPoint) point;
- (void) speedBoost;

@end
