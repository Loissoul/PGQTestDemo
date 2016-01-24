//
//  PGQContentMenuCell.h
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/18.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PGQContentMenuCell <NSObject>

- (UIView *)animatedIcon;
- (UIView *)animatedContent;

@end
