//
//  TestScene.h
//  ControlTest
//
//  Created by Kevin Jenkins on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SetTargetLayer.h"
#import "MovableObject.h"
#import "PlayerObject.h"
#import "GrandObstacleObject.h"
#import "SneakyButton.h"
#import "CTDoubleTap.h"
#import "LineObject.h"
#import "PowerUp.h"


@interface TestScene : CCScene {

    SetTargetLayer *targetLayer;
    PlayerObject *hero;
    CCLabelBMFont *speedLabel;
    CCLabelBMFont *timeLabel;
    CCLabelBMFont *distanceLabel;
    CCLabelBMFont *checkpointLabel;
    NSArray *obstacles;
    NSArray *stars;
    NSArray *powerups;
    obstacleOrientation orientation; 
    
    SneakyButton *brake;
    CTDoubleTap *powerUpButton;
    
    int boostStreak;
    double timeRemaining;
    float totalDistance;
    float distanceToCheckpoint;
}

@property (nonatomic, retain) SetTargetLayer *targetLayer;
@property (nonatomic, retain) MovableObject *hero;
@property (nonatomic, retain) CCLabelBMFont *speedLabel;
@property (nonatomic, retain) CCLabelBMFont *timeLabel;
@property (nonatomic, retain) CCLabelBMFont *distanceLabel;
@property (nonatomic, retain) CCLabelBMFont *checkpointLabel;
@property (nonatomic, retain) NSArray *obstacles;
@property (nonatomic, retain) NSArray *stars;
@property (nonatomic, retain) NSArray *powerups;

@property (nonatomic, retain) SneakyButton *brake;
@property (nonatomic, retain) CTDoubleTap *powerUpButton;
@property obstacleOrientation orientation;

@property int boostStreak;
@property double timeRemaining;
@property float totalDistance;
@property float distanceToCheckpoint;

- (id) init;
+ (id) scene;
- (void) setup;
- (void) dealloc;

@end
