//
//  TestScene.m
//  ControlTest
//
//  Created by Kevin Jenkins on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScene.h"
#define NUM_OBSTACLES 20

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
    //[hero setIsBraking:YES];
    //[hero speedBoost];
}
- (void) handleBrakeButtonUp:(NSNotification *) notification {
    //[hero setIsBraking:NO];
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
    //[hero speedBoost];
    
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

@synthesize targetLayer, boostStreak, hero, speedLabel, distanceLabel, timeLabel, checkpointLabel, obstacles, stars, brake, powerUpButton, orientation, powerups;
@synthesize timeRemaining, totalDistance, distanceToCheckpoint;

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
    [speedLabel setPosition:CGPointMake(20.0, 300.0)];
    [speedLabel setString:@"Works"];
    speedLabel.anchorPoint = ccp(0,0);
    [self addChild:speedLabel z:1];
    
    distanceLabel = [CCLabelBMFont labelWithString:@"a" fntFile:@"debugFont.fnt"];
    [distanceLabel setPosition:CGPointMake(150.0, 300.0)];
    [distanceLabel setString:@"Works"];
    distanceLabel.anchorPoint = ccp(0,0);
    [self addChild:distanceLabel z:1];
    
    checkpointLabel = [CCLabelBMFont labelWithString:@"a" fntFile:@"debugFont.fnt"];
    [checkpointLabel setPosition:CGPointMake(20.0, 280.0)];
    [checkpointLabel setString:@"Works"];
    checkpointLabel.anchorPoint = ccp(0,0);
    [self addChild:checkpointLabel z:1];
    
    timeLabel = [CCLabelBMFont labelWithString:@"a" fntFile:@"debugFont.fnt"];
    [timeLabel setPosition:CGPointMake(20.0, 260.0)];
    [timeLabel setString:@"Works"];
    timeLabel.anchorPoint = ccp(0,0);
    [self addChild:timeLabel z:1];
    
    boostStreak = 0;
    orientation = side;
    
    timeRemaining = 30.0;
    distanceToCheckpoint = 5000.0;
    
    NSMutableArray *tmpObstacles = [[NSMutableArray alloc] init];
    for (int i = 0; i < NUM_OBSTACLES; i++) {
        GrandObstacleObject *anObstacle = [[GrandObstacleObject alloc] init];
        [anObstacle setOrientation:orientation];
        [tmpObstacles addObject:anObstacle];
        [self addChild:anObstacle z:2];
    }
  
    NSMutableArray *tmpPowerups = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1; i++) {
        PowerUp *aPU = [[PowerUp alloc] init];
        [tmpPowerups addObject:aPU];
        [self addChild:aPU z:1];
    }
    
    NSMutableArray *tmpStars = [[NSMutableArray alloc] init];
    for (int i = 0; i < 50; i++) {
        LineObject *aStar = [[LineObject alloc] init];
        [tmpStars addObject:aStar];
        [self addChild:aStar z:1];
    }
    
    obstacles = [[NSArray alloc] initWithArray:tmpObstacles];
    [tmpObstacles release];
  
    stars = [[NSArray alloc] initWithArray:tmpStars];
    [tmpStars release];
  
    powerups = [[NSArray alloc] initWithArray:tmpPowerups];
    [tmpPowerups release];
    
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
    [stars release];
    [powerups release];
    
    [super dealloc];
}

- (void) onEnterTransitionDidFinish {
    [self schedule:@selector(update:) interval:0.005];
    [super onEnterTransitionDidFinish];
}


- (void) update:(double) dt {
    
    timeRemaining -= dt;
    totalDistance += [hero xSpeed]*dt;
    distanceToCheckpoint -= [hero xSpeed]*dt;
    
    if(distanceToCheckpoint <= 0){
        //checkpoint
        float rank = floorf(totalDistance / 1000.0); // rounded float based on distance 1
        
        
        timeRemaining += 10.0 + powf(rank,0.5);
        distanceToCheckpoint = timeRemaining * (200.0 + powf(rank,0.5)*30.0);
    }
    else if(timeRemaining <= 0.0){
        // lost!
        NSLog(@"Made it %.0f before time ran out",totalDistance);
        totalDistance = 0.0;
        distanceToCheckpoint = 5000.0;
        timeRemaining = 30.0;
    }
    
    
    for (LineObject *o in stars) {
        [o setSpeed:[hero xSpeed]];
        [o update:dt];
    }
    
    for (ObstacleObject *o in obstacles) {
        [o setSpeed:[hero xSpeed]];
        [o update:dt];
        
        if(CGRectIntersectsRect([o model],[hero model])){
            [hero drag];
            boostStreak = 0;
            //[o randomReset];
        }
        
    }
    
    for (PowerUp *pu in powerups) {
        [pu setSpeed:[hero xSpeed]];
        [pu update:dt];
        
        if(CGRectIntersectsRect([pu model],[hero model])){
            [pu randomReset];
            boostStreak++;
            if(boostStreak == 5){
                [hero warp];
                boostStreak = 0;
            }
            else
                [hero speedBoostOf:100.0];
        }
        
    }
    
    [hero update:dt];
    [targetLayer update:dt];
    //NSLog(@"DT: %2.2f",dt);
    
}

- (void) draw {

     [speedLabel setString:[NSString stringWithFormat:@"Speed: %3.0f", [hero xSpeed]]];
    
     [distanceLabel setString:[NSString stringWithFormat:@"Distance: %.0f", totalDistance]];
    
     [checkpointLabel setString:[NSString stringWithFormat:@"To Checkpoint: %.0f", distanceToCheckpoint]];
    
     [timeLabel setString:[NSString stringWithFormat:@"Time: %2.1f - WarpX: %i", timeRemaining, 5-boostStreak]];
    
}




@end
