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

@interface TestScene : CCScene {

    SetTargetLayer *targetLayer;
    
}

@property (nonatomic, retain) SetTargetLayer *targetLayer;

- (id) init;
+ (id) scene;
- (void) setup;
- (void) dealloc;

@end
