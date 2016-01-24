//
//  Tran1NaviTransition.m
//  PGQTestDemo
//
//  Created by Lois_soul on 16/1/15.
//  Copyright © 2016年 Lois_soul. All rights reserved.
//

#import "Tran1NaviTransition.h"
#import "Tran1ViewBController.h"
#import "Tran1ViewController.h"
#import "XWMagicMoveController.h"
#import "XWMagicMovePushController.h"
#import "XWMagicMoveCell.h"
@interface Tran1NaviTransition ()
/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) PGQNaviOneTransitionType type;

@end

@implementation Tran1NaviTransition

+(instancetype) transitionWithType:(PGQNaviOneTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

-(instancetype) initWithTransitionType:(PGQNaviOneTransitionType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

//设置动画时长
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.75;
}

//设置动画开始动作
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case PGQNaviOneTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
            
        case PGQNaviOneTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
}

/**
 *  push 动画
 *
 *  @param transitionContext transitionContext description
 */
-(void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    Tran1ViewController * VCA = [[Tran1ViewController alloc] init];
    Tran1ViewBController * VCB = [[Tran1ViewBController alloc] init];
    VCA = (Tran1ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    VCB = (Tran1ViewBController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
   UIView *containerView = [transitionContext containerView];
//取到当前的image
    UIView *tempView = [VCA.tapImageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [VCA.tapImageView convertRect:VCA.tapImageView.bounds toView: containerView];
    
    VCA.tapImageView.hidden = YES;
    NSLog(@"debug1");
    VCB.view.alpha = 0;
    VCB.getImageView.hidden = YES;

    NSLog(@"debug2");

    //tempView 要在后面 添加
    [containerView addSubview:VCB.view];
    [containerView addSubview:tempView];
    
    // 开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [VCB.getImageView convertRect:VCB.getImageView.bounds toView:containerView];
        VCB.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
//        VCB.getImageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
}
/**
 *  pop动画
 *
 *  @param transitionContext <#transitionContext description#>
 */
-(void) doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    Tran1ViewController * VCA = [[Tran1ViewController alloc] init];
    Tran1ViewBController * VCB = [[Tran1ViewBController alloc] init];
    VCA = (Tran1ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    VCB = (Tran1ViewBController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    //取到当前的image
    UIImageView * imageViewA = (UIImageView*)VCA.tapImageView;
    UIImageView * imageViewB = (UIImageView*)VCB.getImageView;
    UIView *tempView = containerView.subviews.lastObject;
    imageViewA.hidden = YES;
    imageViewB.hidden = YES;
    tempView.hidden = YES;

    [containerView insertSubview:VCA.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [imageViewA convertRect:imageViewA.bounds toView:containerView];
        VCB.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
            imageViewB.hidden = NO;
        }else{//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            imageViewA.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

@end
