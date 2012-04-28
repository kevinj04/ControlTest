//
//  TestScene.m
//  ControlTest
//
//  Created by Kevin Jenkins on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScene.h"
#define NUM_OBSTACLES 10

NSString *const nSetTarget = @"targetLayerUpdate";

@interface TestScene (hidden)
- (void) registerNotifications;
- (void) handleSetTarget:(NSNotification *) notification;
- (void) handleBrakeButtonDown:(NSNotification *) notification;
- (void) handleBrakeButtonUp:(NSNotification *) notification;
- (void) handlePowerUpButtonDown:(NSNotification *) notification;
- (void) handlePowerUpButtonUp:(NSNotification *) notification;
- (void) handlerPowerButtonDoubleTap:(NSNotification *)notification;
@end

@implementation TestScene (hidden)
- (void) registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSetTarget:) name:nSetTarget object:nil];
    
    // button code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleBrakeButtonDown:) name:@"brakeButtonDown" object:brake];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleBrakeButtonUp:) name:@"brakeButtonUp" object:brake];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePowerUpButtonDown:) name:@"brakeButtonDown" object:powerUpButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePowerUpButtonUp:) name:@"brakeButtonUp" object:powerUpButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerPowerButtonDoubleTap:) name:doubleTap object:powerUpButton];
    
}
- (void) handleSetTarget:(NSNotification *) notification {
    CGPoint forced = CGPointFromString([[notification userInfo] objectForKey:forceApplied]);
    
    [hero steerToPoint:forced];
    
    //NSLog(@"Applying force: %@", NSStringFromCGPoint(forced));
    // add code here
}

- (void) handleBrakeButtonDown:(NSNotification *) notification {
    NSLog(@"Brake Down");
}
- (void) handleBrakeButtonUp:(NSNotification *) notification {
    NSLog(@"Brake Up");
}
- (void) handlePowerUpButtonDown:(NSNotification *) notification {
    NSLog(@"Power Up Down");
}
- (void) handlePowerUpButtonUp:(NSNotification *) notification {
    NSLog(@"Power Up Up");
}
- (void) handlerPowerButtonDoubleTap:(NSNotification *)notification {
    //NSLog(@"Power Up Double Tap");
    [hero speedBoost];
    
    switch (orientation) {
        case top:
            orientation = side;
            break;
        case side:
            orientation = top;
            break;    
        default:
            orientation = side;
            break;
    }
    
    for (GrandObstacleObject *o in obstacles) {
        [o setOrientation: orientation];
    }
    
    
}
@end

@implementation TestScene

@synthesize targetLayer, hero, speedLabel, obstacles, brake, powerUpButton, orientation;

- (id) init {
    
    if (( self = [super init] )) {
        
        [self setup];
        [self registerNotifications];
        return self;
        
    } else {
        return nil;
    }
    
}
+ (id) scene {
    
    return [[[TestScene alloc] init] autorelease];
    
}
- (void) setup {
    
    hero = [[PlayerObject alloc] init];
    [self addChild:hero z:1];
    
    speedLabel = [CCLabelBMFont labelWithString:@"a" fntFile:@"debugFont.fnt"];
    [speedLabel setPosition:CGPointMake(100.0, 300.0)];
    [speedLabel setString:@"Works"];
    [self addChild:speedLabel z:1];
    
    orientation = side;
    
    NSMutableArray *tmpObstacles = [[NSMutableArray alloc] init];
    for (int i = 0; i < NUM_OBSTACLES; i++) {
        GrandObstacleObject *anObstacle = [[GrandObstacleObject alloc] init];
        [anObstacle setOrientation:orientation];
        [tmpObstacles addObject:anObstacle];
        [self addChild:anObstacle z:1];
    }
    
    obstacles = [[NSArray alloc] initWithArray:tmpObstacles];
    [tmpObstacles release];
   
    targetLayer = [SetTargetLayer layerWithRect:CGRectMake(240, 0, 240, 320)];
    [self addChild:targetLayer z:12];
    
    // Button code
    
    brake = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 240, 320)];
    brake.boundingBox = CGRectMake(0, 0, 240, 320);
    [brake setButtonName:@"brakeButton"];
    [brake setIsHoldable:YES];
    [self addChild:brake z:11];
    [brake release];
    
    powerUpButton = [[CTDoubleTap alloc] initWithRect:CGRectMake(240, 0, 240, 320)];
    powerUpButton.boundingBox = CGRectMake(240, 0, 240, 320);
    [powerUpButton setButtonName:@"powerUpButton"];
    [self addChild:powerUpButton z:11];
    [powerUpButton release];
    //
}
- (void) dealloc {
    if (targetLayer != nil) { [targetLayer release]; targetLayer = nil; }
    [hero release];
    [speedLabel release];
    [obstacles release];
    
    [super dealloc];
}

- (void) onEnterTransitionDidFinish {
    [self schedule:@selector(update:) interval:0.005];
    [super onEnterTransitionDidFinish];
}


- (void) update:(double) dt {
    
    for (ObstacleObject *o in obstacles) {
        [o setSpeed:[hero xSpeed]];
        [o update:dt];
    }
    
    [hero update:dt];
    [targetLayer update:dt];
    //NSLog(@"DT: %2.2f",dt);
    
}

- (void) draw {

    [speedLabel setString:[NSString stringWithFormat:@"Speed %3.0f", [hero xSpeed]]];
    
}




@end
