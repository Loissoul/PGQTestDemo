//
//  ProgressView.h
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/19.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

-(instancetype)initWithFrame:(CGRect)frame Num:(float)progressNum;
@property (nonatomic, strong) UIButton * progressBtn;

@end
