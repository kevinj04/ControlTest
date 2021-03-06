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
#import "ObstacleObject.h"
#import "SneakyButton.h"
#import "DoubleTapButton.h"

@interface TestScene : CCScene {

    SetTargetLayer *targetLayer;
    PlayerObject *hero;
    CCLabelBMFont *speedLabel;
    NSArray *obstacles;
    
    SneakyButton *brake;
    DoubleTapButton *powerUpButton;
}

@property (nonatomic, retain) SetTargetLayer *targetLayer;
@property (nonatomic, retain) MovableObject *hero;
@property (nonatomic, retain) CCLabelBMFont *speedLabel;
@property (nonatomic, retain) NSArray *obstacles;

@property (nonatomic, retain) SneakyButton *brake;
@property (nonatomic, retain) DoubleTapButton *powerUpButton;

- (id) init;
+ (id) scene;
- (void) setup;
- (void) dealloc;

@end
