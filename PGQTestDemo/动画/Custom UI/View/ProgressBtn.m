//
//  ProgressBtn.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/19.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "ProgressBtn.h"

@implementation ProgressBtn
-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self inirView];
    }
    return self;
}


-(void)inirView
{
    
    for (int i = 0; i < 5; i++) {
        UILabel * label = [[UILabel alloc] init];
        
        label.frame = CGRectMake(0, 0, 8, 8);
        
    
        
    }
    
    
    
    UILabel * label = ({
    
        UILabel * label = [UILabel new];
        [self addSubview:label];
        
        
        label;
    });
}

@end
