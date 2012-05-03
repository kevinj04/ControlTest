//
//  PowerUp.m
//  ControlTest
//
//  Created by Michael Highland on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PowerUp.h"
#define PROXIMITY_ALERT 500


@implementation PowerUp



- (void) randomReset {
    
    //reset the position and size
    [super setupWithRect:CGRectMake(580.0 + arc4random() % 1000, 
                                    10 + arc4random() % 300, 
                                    15, 
                                    15) 
    ];
    speedFactor = 0.5;
    xSpeed = 0.0;
    //NSLog(@"Obstacle Reset");
    red = 0.0;
    green = 1.0;
    blue = 0.0;
    
}


- (void) draw{
    
    [self earlyWarning];
    [super draw];
    
}

- (void) earlyWarning{
    
    float proximity = model.origin.x - model.size.width/2.0 - PROXIMITY_ALERT;
    
    
    if(proximity > 0 && proximity < PROXIMITY_ALERT){
        // approches 1.0 as proximity goes to 0
        float proxFactor = (PROXIMITY_ALERT - proximity)/PROXIMITY_ALERT;
        glColor4f(0.0, 1.0, 0.0, 1.0);
        glLineWidth(2.0f);
        ccDrawLine(ccp(380.0 + proxFactor * 100.0, model.origin.y),
                   ccp(380.0 + proxFactor * 100.0, model.origin.y + model.size.height));	
    }
    
}

- (void) dealloc{
    
    [super dealloc];
}

@end
