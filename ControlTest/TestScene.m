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
    NSLog(@"Applying force: %@", NSStringFromCGPoint(forced));
    // add code here
}
@end

@implementation TestScene

@synthesize targetLayer;

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
    
    targetLayer = [[SetTargetLayer layerWithRect:CGRectMake(0, 0, 480, 320)] retain];
    [self addChild:targetLayer];
    
}
- (void) dealloc {
    if (targetLayer != nil) { [targetLayer release]; targetLayer = nil; }
    [super dealloc];
}

- (void) draw {
    
    ccDrawPoint(ccp(200,200));
    
}

@end
