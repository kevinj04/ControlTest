//
//  TestScene.m
//  ControlTest
//
//  Created by Kevin Jenkins on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestScene.h"

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
    
    [self turnWithForce:forced]; 
    
    //NSLog(@"Applying force: %@", NSStringFromCGPoint(forced));
    // add code here
}
@end

@implementation TestScene

@synthesize targetLayer, hero;

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
    
}
- (void) dealloc {
    if (targetLayer != nil) { [targetLayer release]; targetLayer = nil; }
    [hero release];
    
    [super dealloc];
}

- (void) onEnterTransitionDidFinish {
    [self schedule:@selector(update:) interval:0.005];
    [super onEnterTransitionDidFinish];
}


- (void) update:(double) dt {
    
    /*
    if ([self.children objectAtIndex:0] != nil) {
        CCNode *child = [self.children objectAtIndex:0];
        NSLog(@"Child: %@", child);
    }
     */
    [hero update:dt];
    [targetLayer update:dt];
    
}

- (void) draw {

    
}


- (void) turnWithForce:(CGPoint) force{
    
    [hero steerToPoint:force];
    
}

@end
