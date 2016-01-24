//
//  RightViewController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/11.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()
{
    
    NSDictionary *vectorDic;
    
}

@property(weak,nonatomic) UIView *navBarBackgroundView;
@property(weak,nonatomic) UILabel *newsTodayLb;

@end

@implementation RightViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //官方版高度没有64,所以加个高度56仿冒NavBar的View
    UIView *navBarBackgroundView = ({
        UIView *view =  [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 56.f)];
        view.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0.f];;
        [self.view addSubview:view];
        view;
    });
    _navBarBackgroundView = navBarBackgroundView;
    
    UILabel *lab = ({
        UILabel *label = [[UILabel alloc] init];
        label.attributedText = [[NSAttributedString alloc] initWithString:@"响应" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [label sizeToFit];
        [label setCenter:CGPointMake(self.view.center.x, 38)];
        [self.view addSubview:label];
        label;
        
    });
    _newsTodayLb = lab;
    
    //点击显示左视图
    UIButton *menuBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(16.f, 28.f, 22.f, 22.f)];
        [self.view addSubview:button];
        [button setImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    
    [menuBtn addTarget:self action:@selector(showLeftMenu:) forControlEvents:UIControlEventTouchUpInside];
    
//    [[menuBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
//     subscribeNext:^(id x) {
//         [self showLeftMenu:menuBtn];
//     }];
    
}
//显示左视图
- (void)showLeftMenu:(id)sender {
    
    NSLog(@"heheda");
    
    NSNotification *nitification = [NSNotification notificationWithName:@"showLeftMenu" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:nitification];
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showLeftMenu"  object:nil];
    
}

@end
