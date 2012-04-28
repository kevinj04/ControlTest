//
//  LineObject.h
//  ControlTest
//
//  Created by Michael Highland on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovableObject.h"

@interface LineObject : MovableObject{
    
    float xSpeed;
    float paralaxFactor;
}

@property float xSpeed;
@property float paralaxFactor;

- (void) randomReset;
- (void) setSpeed:(float)speed;

@end
