//
//  ObstacleObject.h
//  ControlTest
//
//  Created by Michael Highland on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovableObject.h"
#import "cocos2d.h"

@interface ObstacleObject : MovableObject {
    
    float xSpeed;
    float speedFactor;
    
}

@property float xSpeed;
@property float speedFactor;

- (id) init;
- (void) update:(ccTime) dt;
- (void) draw;
- (void) earlyWarning;
- (void) dealloc;
- (void) setSpeed:(float) speed;
- (void) randomReset;


@end
