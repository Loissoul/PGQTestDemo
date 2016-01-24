//
//  ProgressView.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/19.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame Num:(float)progressNum
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViewWithNum:progressNum];
    }
    return self;
}

-(void)initViewWithNum:(float)progressNum
{
    CGFloat labelX = 50;
    UILabel *label1 = ({
    
        UILabel * label = [UILabel new];
        [self addSubview:label];
        label.frame = CGRectMake(0, 0, 8, 8);
        CALayer *layer=[label layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [layer setCornerRadius: 4.0];
        label.layer.borderWidth = 1;
        label.backgroundColor = [UIColor redColor];
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label;
    });
    UILabel *label2 = ({
        
        UILabel * label = [UILabel new];
        [self addSubview:label];
        label.frame = CGRectMake(labelX, 0, 8, 8);
        CALayer *layer=[label layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [layer setCornerRadius: 4.0];
        
        label.layer.borderWidth = 1;
        label.backgroundColor = [UIColor redColor];
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label;
    });
    UILabel *label3 = ({
        
        UILabel * label = [UILabel new];
        [self addSubview:label];
        label.frame = CGRectMake(2*labelX, 0, 8, 8);
        CALayer *layer=[label layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [layer setCornerRadius: 4.0];
        label.layer.borderWidth = 1;
        label.backgroundColor = [UIColor redColor];
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label;
    });
    UILabel *label4 = ({
        
        UILabel * label = [UILabel new];
        [self addSubview:label];
        label.frame = CGRectMake(3*labelX, 0, 8, 8);
        CALayer *layer=[label layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [layer setCornerRadius: 4.0];
        label.layer.borderWidth = 1;
        label.backgroundColor = [UIColor redColor];
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label;
    });
    UILabel *label5 = ({
        UILabel * label = [UILabel new];
        [self addSubview:label];
        label.frame = CGRectMake(4*labelX, 0, 8, 8);
        CALayer *layer=[label layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [layer setCornerRadius: 4.0];
        label.layer.borderWidth = 1;
        label.backgroundColor = [UIColor redColor];
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label;
    });
    
    //0.224    0.036
        if (progressNum < 0.224) {
            label1.backgroundColor = [UIColor cyanColor];
        }
        if(progressNum >= 0.224 && progressNum<0.4){
            label1.backgroundColor = [UIColor cyanColor];
            label2.backgroundColor = [UIColor cyanColor];
        }
        if(progressNum >= 0.4 && progressNum<0.6){
            label1.backgroundColor = [UIColor cyanColor];
            label2.backgroundColor = [UIColor cyanColor];
            label3.backgroundColor = [UIColor cyanColor];
        }
        if(progressNum >= 0.6 && progressNum<0.8){
            label1.backgroundColor = [UIColor cyanColor];
            label2.backgroundColor = [UIColor cyanColor];
            label3.backgroundColor = [UIColor cyanColor];
            label4.backgroundColor = [UIColor cyanColor];
        }
        if(progressNum >= 0.8 && progressNum<=1.0){
            label1.backgroundColor = [UIColor cyanColor];
            label2.backgroundColor = [UIColor cyanColor];
            label3.backgroundColor = [UIColor cyanColor];
            label4.backgroundColor = [UIColor cyanColor];
            label5.backgroundColor = [UIColor cyanColor];
        }
    
    UIButton * button = [[UIButton alloc] init];
    button.frame = CGRectMake(5, 2, labelX*4-3, 3);
    button.backgroundColor = [UIColor redColor];
    [self addSubview:button];
    self.progressBtn = [[UIButton alloc] init];
    self.progressBtn.frame = CGRectMake(5, 2, labelX*4-3, 3);
    self.progressBtn.backgroundColor = [UIColor cyanColor];
    button.layer.borderColor = [UIColor blackColor].CGColor;
//    [Statics reputationButtonWidthAnimation:self.progressBtn withProgress:progressNum];
    [self addSubview:self.progressBtn];
}


@end
