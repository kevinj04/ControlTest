//
//  MovableObject.h
//  ControlTest
//
//  Created by Michael Highland on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MovableObject : CCNode {
    
    CGRect model;
    float red;
    float green;
    float blue;
    float alpha;
    
}

@property CGRect model;
@property float red;
@property float green;
@property float blue;
@property float alpha;

- (id) init;
- (id) initWithRect:(CGRect) rect;
- (void) setupWithRect:(CGRect) rect;
- (void) update:(ccTime) dt;
- (void) draw;
- (void) dealloc;


@end
