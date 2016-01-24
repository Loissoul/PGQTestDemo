//
//  FanView.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/2.
//  Copyright © 2015年 潘国强. All rights reserved.
//
#import "FanView.h"

@implementation FanView

//--------------------------------------------------------------------------
#define DEBUG_PGQ YES  (FAN VIEW )
//--------------------------------------------------------------------------

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat startAngle = -M_PI*3/4;
    CGFloat endAngle = -M_PI*1/3;
    
    CGPoint centerPoint =  CGPointMake(0.5*width, 0.5*height);
    
    CGFloat radius = MIN(0.5*width, 0.5*height);
    
    CGFloat count = 100;
    
    CGFloat step = (endAngle -startAngle)/count;
    
    UIBezierPath *path = nil;
    for (int i = 0; i<count; i++) {
        path = [UIBezierPath bezierPath];
        path.lineWidth = 0.5;
        [path moveToPoint:centerPoint];
        
        CGFloat angle = startAngle + i*step;
        
        [path addLineToPoint:CGPointMake(centerPoint.x+radius*cos(angle), centerPoint.y+radius*sinf(angle))];
        
        [[[UIColor whiteColor] colorWithAlphaComponent:(float)i*0.4/count ] setStroke];
        [path stroke];
    }
    
}

@end
