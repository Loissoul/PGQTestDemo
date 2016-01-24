//
//  PGQInteractiveTransition.h
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/15.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GestureConifg)();

//手势的方向
typedef NS_ENUM(NSInteger, PGQNavTransitionGestureDirection)
{
    PGQNavTransitionGestureDirectionLeft = 0,
    PGQNavTransitionGestureDirectionRight,
    PGQNavTransitionGestureDirectionUp,
    PGQNavTransitionGestureDirectionDown
};


//转场方式
typedef NS_ENUM(NSInteger, PGQNavTransitionType)
{
    PGQNavTransitionTypePresent = 0,
    PGQNavTransitionTypeDismiss,
    PGQNavTransitionTypePush,
    PGQNavTransitionTypePop
};



@interface PGQInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interation;//判断是那种手势

/**促发手势presen/push的时候的config(配置)，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg presentConfig;
@property (nonatomic, copy) GestureConifg pushConfig;

+(instancetype)transitionWithType:(PGQNavTransitionType) type Direction:(PGQNavTransitionGestureDirection)direction;
-(instancetype) initWithTransitionType:(PGQNavTransitionType)type gestureDirection:(PGQNavTransitionGestureDirection)direction;
- (void)addPanGestureForViewController:(UIViewController *)viewController;
@end
