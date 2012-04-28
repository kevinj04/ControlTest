//
//  MovableObject.m
//  ControlTest
//
//  Created by Michael Highland on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovableObject.h"

@implementation MovableObject

@synthesize model, red, green, blue, alpha;

- (id) init 
{
    if( (self=[super init])) {
        
        red = 1.0;
        green = 0.0;
        blue = 1.0;
        alpha = 1.0;
        
		[self setupWithRect:CGRectMake(0, 0, 10, 10)];
    }
	return self;
}


- (id) initWithRect:(CGRect) rect
{
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        red = 1.0;
        green = 0.0;
        blue = 1.0;
        alpha = 1.0;
		[self setupWithRect:rect];
    }
	return self;
}

- (void) setupWithRect:(CGRect) rect
{
    model = rect; 
}


- (void) setPosition:(CGPoint) point
{
    model.origin.x = point.x;
    model.origin.y = point.y;
}


- (void) update:(ccTime) dt
{
    //[self draw];
}

- (void) draw
{
    glColor4f(red, green, blue, alpha);
    glLineWidth(2.0f);
    //top
    ccDrawLine(ccp(model.origin.x - model.size.width/2, model.origin.y + model.size.height/2), 
               ccp(model.origin.x + model.size.width/2, model.origin.y + model.size.height/2));	
    //right
    ccDrawLine(ccp(model.origin.x + model.size.width/2, model.origin.y + model.size.height/2),
               ccp(model.origin.x + model.size.width/2, model.origin.y - model.size.height/2));	
    //bottom
    ccDrawLine(ccp(model.origin.x + model.size.width/2, model.origin.y - model.size.height/2),
               ccp(model.origin.x - model.size.width/2, model.origin.y - model.size.height/2));		
    //left
    ccDrawLine(ccp(model.origin.x - model.size.width/2, model.origin.y - model.size.height/2),
                ccp(model.origin.x - model.size.width/2, model.origin.y + model.size.height/2));	
}


- (void) dealloc{
    
    [super dealloc];

}

@end
