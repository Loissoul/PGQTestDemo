//
//  Tran1ViewBController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/15.
//  Copyright © 2016年 潘国强. All rights reserved.
//


#import "XWNaviTransition.h"
#import "Tran1ViewBController.h"
#import "Tran1ViewController.h"
#import "Tran1NaviTransition.h"
#import "PGQInteractiveTransition.h"

@interface Tran1ViewBController()
@property (nonatomic, strong) PGQInteractiveTransition * interactiveTransition;
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation Tran1ViewBController
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义转场";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
}

-(void) initView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pgq.png"]];
    self.getImageView = imageView;
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(self.view.center.x-100, self.view.center.y-200);
    imageView.bounds = CGRectMake(0, 0, 280, 280);

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+50, kScreenWidth, 40)];
    label.text = @"我就是我，一个不一样的我";
    label.textColor = [UIColor cyanColor];
    [self.view addSubview:label];
    
    self.interactiveTransition = [PGQInteractiveTransition transitionWithType:PGQNavTransitionTypePop Direction:PGQNavTransitionGestureDirectionRight];
    [_interactiveTransition addPanGestureForViewController:self];
}

 //区分 pop和push 两种不同的  转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    NSLog(@"%@", NSStringFromCGRect(self.getImageView.frame));
//    _operation = operation;
//    return [Tran1NaviTransition transitionWithType:operation == UINavigationControllerOperationPush?
//                          PGQNaviOneTransitionTypePush:PGQNaviOneTransitionTypePop];
    return [XWNaviTransition transitionWithType:operation == UINavigationControllerOperationPush?
                   XWNaviOneTransitionTypePush:XWNaviOneTransitionTypePop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return _interactiveTransition.interation?_interactiveTransition:nil;
}


@end
