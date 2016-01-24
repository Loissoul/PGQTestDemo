//
//  Main1ViewController.h
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/11.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
#import "RightViewController.h"

@interface Main1ViewController : UIViewController
-(instancetype) initWithLeft:(LeftViewController *)leftView right:(RightViewController *)rightView;

@end
