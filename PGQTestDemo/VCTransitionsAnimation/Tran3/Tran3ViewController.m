//
//  XWPageCoverController.m
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import "Tran3ViewController.h"
#import "XWPageCoverPushController.h"
#import "PGQInteractiveTransition.h"
#import "Masonry.h"

@interface Tran3ViewController ()<XWPageCoverPushControllerDelegate>
@property (nonatomic, strong) PGQInteractiveTransition *interactiveTransitionPush;
@end

@implementation Tran3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"翻页效果";
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic2.png"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向左滑动push" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(74);
    }];
    _interactiveTransitionPush = [PGQInteractiveTransition transitionWithType:PGQNavTransitionTypePush Direction:PGQNavTransitionGestureDirectionLeft];
    typeof(self)weakSelf = self;
    _interactiveTransitionPush.pushConfig = ^(){
        [weakSelf push];
    };
    //此处传入self.navigationController， 不传入self，因为self.view要形变，否则手势百分比算不准确；
    [_interactiveTransitionPush addPanGestureForViewController:self];
}

- (void)push{
    XWPageCoverPushController *pushVC = [XWPageCoverPushController new];
    self.navigationController.delegate = pushVC;
    pushVC.delegate = self;
    [self.navigationController pushViewController:pushVC animated:YES];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush{
    return _interactiveTransitionPush;
}

@end
