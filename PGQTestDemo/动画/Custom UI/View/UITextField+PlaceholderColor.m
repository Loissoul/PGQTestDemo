//
//  UITextField+PlaceholderColor.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/15.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "UITextField+PlaceholderColor.h"

static NSString * const PlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (PlaceholderColor)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    BOOL change = NO;
    if (self.placeholder == nil) {
        self.placeholder = @" ";
        change = YES;
    }
    [self setValue:placeholderColor forKeyPath:PlaceholderColorKey];
    if (change) {
        self.placeholder = nil;
    }
}

-(UIColor *)placeholderColor
{
    return [self valueForKeyPath:PlaceholderColorKey];
}

@end
