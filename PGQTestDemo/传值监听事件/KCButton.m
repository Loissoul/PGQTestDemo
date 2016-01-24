//
//  KCButton.m
//  小试牛刀
//
//  Created by pgq on 15/9/22.
//  Copyright (c) 2015年 pgq. All rights reserved.
//

#import "KCButton.h"

@implementation KCButton

-(void) click
{
    NSLog(@"Invoke KCButton's click method");
    if (_onClick)
    {
        _onClick(self);
    }
}


@end
