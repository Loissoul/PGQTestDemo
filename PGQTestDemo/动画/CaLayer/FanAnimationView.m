//
//  FanAnimationView.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/2.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "FanAnimationView.h"

#import <QuartzCore/QuartzCore.h>
#import "math.h"
#include "stdlib.h"
#import "FanView.h"

#define ARC4RANDOM_MAX      0x100000000

static const NSInteger VIEWTAG = 100;     // 圆点tag

static const NSInteger pointCount = 4;     // 圆点个数

@implementation FanAnimationView
{
    UIImageView *_backImageView;          // 背景
    FanView *_pointerImageView;        // 指针
    int time;                             // 时间
    NSTimer *_timer;                      // 计时器
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    self.backgroundColor = [UIColor whiteColor];
    CGFloat length = 102;

    _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"job_radar.png"]];
    _backImageView.frame = CGRectMake((SCREEN_WIDTH-length)/2, (SCREEN_HEIGHT - 102)/2, length, length);

    _backImageView.backgroundColor = [UIColor clearColor];
    _backImageView.userInteractionEnabled = YES;
    [self addSubview:_backImageView];
    
    for (int i=0; i<pointCount; i++) {
        
        float pointLength = 4;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pointLength, pointLength)];
        [self setRandomLocationForView:view];
        view.tag = i+VIEWTAG;
        view.layer.cornerRadius = pointLength/2;
        [view setHidden:YES];
        view.backgroundColor = [UIColor whiteColor];
        [_backImageView addSubview:view];
    }
    _pointerImageView = [[FanView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
    _pointerImageView.backgroundColor = [UIColor clearColor];
    [_backImageView addSubview:_pointerImageView];
}

-(void)setRandomLocationForView:(UIView*)view
{
    [view sizeToFit];
    double angle = floor(((double)arc4random() /ARC4RANDOM_MAX)*(2*M_PI));
    double radius = floor(((double)arc4random()/ARC4RANDOM_MAX)*(_backImageView.frame.size.width/2))-view.frame.size.height/2;
    
    CGFloat x3 = _backImageView.frame.size.width/2+cos(angle)*radius;
    CGFloat y3 = _backImageView.frame.size.height/2+sin(angle)*radius;
    
    view.center = CGPointMake(x3, y3);
}


- (void)showRadarLoadingView
{
    [self startTimer];
    int maxcount = 999999;
    for (int i = 0; i<pointCount; i++) {
        UIView *view = (UIView*) [_backImageView viewWithTag:i+VIEWTAG];
        if (view) {
            [view setHidden:NO];
            CABasicAnimation *animation = [self opacityTimes_Animation:5 durTimes:0.5];
            [view.layer addAnimation:animation forKey:@"opacityAnimation"];
        }
    }
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = maxcount;
    [_pointerImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)hideRadarLoadingView
{
    if (time < 5) {
        [self performSelector:@selector(hideRadarLoadingView) withObject:nil afterDelay:5-time];
        return;
    }
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    for (int i = 0; i < pointCount; i ++) {
        UIView *view = (UIView *)[_backImageView viewWithTag:i+VIEWTAG];
        if (view) {
            [view setHidden:YES];
            [view.layer removeAnimationForKey:@"rotationAnimation"];
        }
    }
    
    [_pointerImageView.layer removeAnimationForKey:@"rotationAnimation"];
    
    if (_backImageView) {
        [_backImageView removeFromSuperview];
    }
    if (self) {
        [self removeFromSuperview];
    }
}

-(CABasicAnimation*)opacityTimes_Animation:(float)repeatTimes durTimes:(float)atime
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithBool:1.0];
    animation.repeatCount = repeatTimes;
    animation.toValue = [NSNumber numberWithBool:0.4];
    animation.duration = atime;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBackwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses = YES;
    
    return animation;
}


-(void)startTimer
{
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

-(void)timerAdvanced:(NSTimer*)timer
{
    if (timer == 0) {
        [timer invalidate];
        [self startTimer];
    }
    for (int i = 0; i< pointCount; i++) {
        UIView *view =(UIView*)[_backImageView viewWithTag:i+VIEWTAG];
        if (view&&view.hidden == NO) {
            [self setRandomLocationForView:view];
        }
    }
    time++;
}



@end
