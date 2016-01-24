//
//  LeftImageTextField.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/13.
//  Copyright © 2016年 潘国强. All rights reserved.
//


//在storyboard中调用  直接就有放图片的属性
#import "LeftImageTextField.h"

@implementation LeftImageTextField
/**
 *  set leftImage
 *
 *  @param leftViewImage image
 */
- (void) setLeftViewImage:(UIImage *)leftViewImage
{
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:leftViewImage];
    self.frame = CGRectMake(0, 0, 25, 25);
    self.leftView = leftImage;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x +=10;
    return textRect;
}
@end
