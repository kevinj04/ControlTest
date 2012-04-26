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
@end

@implementation TestScene (hidden)
- (void) registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSetTarget:) name:nSetTarget object:nil];
}
- (void) handleSetTarget:(NSNotification *) notification {
    CGPoint forced = CGPointFromString([[notification userInfo] objectForKey:forceApplied]);
    
    [hero steerToPoint:forced];
    
    //NSLog(@"Applying force: %@", NSStringFromCGPoint(forced));
    // add code here
}
@end

@implementation TestScene

@synthesize targetLayer, hero, speedLabel, obstacles;

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
    
    SetTargetLayer *test = [SetTargetLayer layerWithRect:CGRectMake(0, 0, 480, 320)];
    targetLayer = [test retain];
    
    //targetLayer = [[SetTargetLayer layerWithRect:CGRectMake(0, 0, 480, 320)] retain];
    [self addChild:targetLayer z:10];
    
    hero = [[PlayerObject alloc] init];
    [self addChild:hero z:1];
    
    speedLabel = [CCLabelBMFont labelWithString:@"a" fntFile:@"debugFont.fnt"];
    [speedLabel setPosition:CGPointMake(100.0, 300.0)];
    [speedLabel setString:@"Works"];
    [self addChild:speedLabel z:1];
    
    NSMutableArray *tmpObstacles = [[NSMutableArray alloc] init];
    for (int i = 0; i < NUM_OBSTACLES; i++) {
        ObstacleObject *anObstacle = [[ObstacleObject alloc] init];
        [tmpObstacles addObject:anObstacle];
        [self addChild:anObstacle z:1];
    }
    
    obstacles = [[NSArray alloc] initWithArray:tmpObstacles];
    [tmpObstacles release];
   
    
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
