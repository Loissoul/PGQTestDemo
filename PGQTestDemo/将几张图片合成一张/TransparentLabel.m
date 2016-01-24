//
//  TransparentLabel.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/19.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "TransparentLabel.h"

@implementation TransparentLabel

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect viewBounds = self.bounds;
    CGContextTranslateCTM(ctx, 0, viewBounds.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 0.0);
    CGContextSetLineWidth(ctx, 2.0);

//    CGContextSelectFont(ctx, "Helvetica", 17.0, kCGEncodingMacRoman);
    CGContextSetCharacterSpacing(ctx, 1.7);
//    CGContextShowTextAtPoint(ctx, 0, 50, "Lois_soul", 9);
    
}

@end
