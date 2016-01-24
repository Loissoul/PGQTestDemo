//
//  PGQInteractiveTransition.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/15.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "PGQInteractiveTransition.h"

@interface PGQInteractiveTransition()
@property (nonatomic, weak) UIViewController * vc;

@property (nonatomic, assign) PGQNavTransitionGestureDirection direction;//手势方向

@property (nonatomic, assign) PGQNavTransitionType type;//转场的方式

@end


@implementation PGQInteractiveTransition


+(instancetype)transitionWithType:(PGQNavTransitionType) type Direction:(PGQNavTransitionGestureDirection)direction
{
    return [[self alloc] initWithTransitionType:type gestureDirection:direction];
}


-(instancetype) initWithTransitionType:(PGQNavTransitionType)type gestureDirection:(PGQNavTransitionGestureDirection)direction
{
    self = [super init];

    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}


/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case PGQNavTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case PGQNavTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case PGQNavTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case PGQNavTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

- (void)startGesture{
    switch (_type) {
        case PGQNavTransitionTypePresent:{
            if (_presentConfig) {
                _presentConfig();
            }
        }
            break;
            
        case PGQNavTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case PGQNavTransitionTypePush:{
            if (_pushConfig) {
                _pushConfig();
            }
        }
            break;
        case PGQNavTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}




@end
