//
//  Main1ViewController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/11.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "Main1ViewController.h"

//----------------------------------
#define DEBUG_PGQYES
//利用两个视图合在一起

#define  PGQScreenW  [UIScreen mainScreen].bounds.size.width


//打开抽屉动画参数初始值
#define AnimateDuration                         0.2
#define MainViewOriginXFromValue    0
#define MainViewOriginXEndValue      kScreenWidth*0.6
#define MainViewMoveXMaxValue     ABS(MainViewOriginXEndValue - MainViewOriginXFromValue)
#define MainViewScaleYFromValue    1
#define MainViewScaleYEndValue      1
#define MainViewScaleMaxValue        ABS(MainViewScaleYEndValue - MainViewScaleYFromValue)
#define LeftViewOriginXFromValue      -kScreenWidth*0.6
#define LeftViewOriginXEndValue        0
#define LeftViewMoveXMaxValue        ABS(LeftViewOriginXEndValue - LeftViewOriginXFromValue)
#define LeftViewScaleFromValue         1
#define LeftViewScaleEndValue           1
#define LeftViewScaleMaxValue           ABS(LeftViewScaleEndValue - LeftViewScaleFromValue)


@interface Main1ViewController ()
@property (nonatomic, strong) LeftViewController * leftVc;
@property (nonatomic, strong) RightViewController * rightVc;
@property (nonatomic, strong) UIView *leftView1;
@property (nonatomic, strong) UIView *rightView1;
@property (assign, nonatomic) CGFloat distance;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;


@end


@implementation Main1ViewController


#pragma mark init
/**
 *  Call this method Initialize lefView and RightView
 *
 *  @param leftView  <#leftView description#>
 *  @param rightView <#rightView description#>
 *
 *  @return <#return value description#>
 */
-(instancetype) initWithLeft:(LeftViewController *)leftView right:(RightViewController *)rightView
{
    self = [super init];
    
    if (self) {
        self.leftVc = leftView;
        self.rightVc = rightView;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rightViewShowLeftMenu) name:@"showLeftMenu" object:nil];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    _distance = MainViewOriginXFromValue;
    _leftView1 = _leftVc.view;
    _leftView1.frame = kScreenBounds;
    
    _leftView1.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, LeftViewScaleFromValue, LeftViewScaleFromValue), CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue, 0));
    
    [self.view addSubview:_leftView1];
    
    _rightView1 = [[UIView alloc] initWithFrame:kScreenBounds];
    [self.view addSubview:_rightView1];
    [_rightView1 addSubview:_rightVc.view];
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    //    [_rightView1 addGestureRecognizer:panGesture];
    //    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
}


#pragma mark  Hand signal
- (void)pan:(UIPanGestureRecognizer *)recongnizer
{
    CGFloat moveX = [recongnizer translationInView:self.view].x;
    CGFloat truedistance = _distance + moveX;
    CGFloat percent = truedistance/MainViewMoveXMaxValue;
    
    if (truedistance >= 0 && truedistance <= MainViewMoveXMaxValue) {
        _rightView1.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, 1, MainViewScaleYFromValue-MainViewScaleMaxValue*percent), CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXFromValue+truedistance, 0));
        _leftView1.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, LeftViewScaleFromValue+LeftViewScaleMaxValue*percent, LeftViewScaleFromValue+LeftViewScaleMaxValue*percent), CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue+LeftViewMoveXMaxValue*percent, 0));
    }
    if (recongnizer.state == UIGestureRecognizerStateEnded) {
        if (truedistance <= MainViewMoveXMaxValue/2) {
            [self showRightView];
        }else{
            [self showLeftView];
        }
    }
}

//- (void)tap:(UITapGestureRecognizer *)recongnizer
//{
//    [self showRightView];
//}

- (void)showRightView
{
    [UIView animateWithDuration:AnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _rightView1.transform = CGAffineTransformIdentity;
        _leftView1.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, LeftViewScaleFromValue, LeftViewScaleFromValue), CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue, 0));
    } completion:^(BOOL finished) {
        _distance = MainViewOriginXFromValue;
        //        [_rightView1 removeGestureRecognizer:_tap];
        [_rightView1 removeGestureRecognizer:_panGesture];
    }];
}

- (void)showLeftView
{
    [UIView animateWithDuration:AnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _rightView1.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, 1, MainViewScaleYEndValue), CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXEndValue, 0));
        _leftView1.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _distance = MainViewOriginXEndValue;
        //        [_rightView1 addGestureRecognizer:_tap];
        [_rightView1 addGestureRecognizer:_panGesture];
    }];
}


#pragma mark notification
/**
 *  Call this method to show homePage leftMenu
 */
- (void)rightViewShowLeftMenu
{
    [self showLeftView];
}


#pragma <#arguments#>
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
