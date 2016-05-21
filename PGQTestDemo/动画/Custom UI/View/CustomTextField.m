//
//  CustomTextField.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/15.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "CustomTextField.h"
#import <objc/runtime.h>


#define PGQplaceholderTextColor @"_placeholderLabel.textColor"
@implementation CustomTextField

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

+(void) initialize
{
    [self getIvars];
}

+ (void)getIvars
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        
        Ivar ivar = ivars[i];
        NSLog(@"%s---%s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
}

- (void)awakeFromNib {
    
    // 设置光标的颜色
    self.tintColor = self.textColor;
    self.tintColor = [UIColor redColor];

}

// 获取到焦点
- (BOOL)becomeFirstResponder {
    
    // 利用运行时获取key,设置占位文字的颜色
    [self setValue:self.textColor forKeyPath:PGQplaceholderTextColor];
    
    return [super becomeFirstResponder];
}

// 失去焦点
- (BOOL)resignFirstResponder {
    
    // 利用运行时获取key,设置占位文字的颜色
    [self setValue:[UIColor grayColor] forKeyPath:PGQplaceholderTextColor];
    
    return [super resignFirstResponder];
}

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+50, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

//其他的方法 画出颜色
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    
//    [[UIColor orangeColor] set];
//    
//    [self.placeholder drawInRect:rect withFont:[UIFont systemFontOfSize:20]];
//}








@end
