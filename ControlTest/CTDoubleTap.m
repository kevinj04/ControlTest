//
//  CTDoubleTap.m
//  ControlTest
//
//  Created by Michael Highland on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CTDoubleTap.h"

@implementation CTDoubleTap


-(id)initWithRect:(CGRect)rect {
    
    if (( self = [super initWithRect:rect] )) {
        return self;
    } else {
        return nil;
    }
    
}

- (void) onEnterTransitionDidFinish
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:10 swallowsTouches:NO];
}

@end
