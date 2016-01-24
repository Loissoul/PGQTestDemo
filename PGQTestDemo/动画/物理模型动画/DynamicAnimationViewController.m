//
//  DynamicAnimationViewController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/24.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "DynamicAnimationViewController.h"

@interface DynamicAnimationViewController ()

@property (strong, nonatomic) UIDynamicAnimator  * animator;
@property (strong, nonatomic) UIImageView * imageview;
@property (strong, nonatomic)NSTimer * timer;
@property (strong, nonatomic)UILabel * alertLabel;
@property (weak, nonatomic) IBOutlet UIButton *snapButton;

@end

@implementation DynamicAnimationViewController

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImageView * showImageview = ({
    
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.image = [UIImage imageNamed:@"pgq.png"];
        
        imageView.frame = CGRectMake(10, 0, 100, 100);
        
        [self.view addSubview:imageView];

//        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.
//            
//        }];
        
        imageView;
    });
    
    self.imageview = showImageview;
}

- (void)reset
{
    [self.animator removeAllBehaviors];

    self.imageview.center = CGPointMake(55, 100);
}


- (IBAction)snap:(id)sender {
    NSLog(@"snap");
    [self reset];
    UISnapBehavior * snapBehavior = [[UISnapBehavior alloc] initWithItem:self.imageview snapToPoint:self.view.center];
    
    snapBehavior.damping = 1.5;
    
    [self.animator addBehavior:snapBehavior];
}


- (IBAction)collision:(id)sender {
    NSLog(@"collision");
    [self reset];
    UIGravityBehavior * gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:self.imageview];
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] init];

    itemBehavior.resistance = 1;
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]init];
    [collisionBehavior addItem:self.imageview];
     collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [collisionBehavior addBoundaryWithIdentifier:@"Button" forPath:[UIBezierPath bezierPathWithRect:self.snapButton.frame]];
    
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:itemBehavior];
    [self.animator addBehavior:gravityBehavior];
}

- (IBAction)gravity:(id)sender {
    NSLog(@"gravity");
    [self reset];
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    gravityBehavior.gravityDirection = CGVectorMake(0, 1);
    gravityBehavior.magnitude = 0.5;
    [gravityBehavior addItem:self.imageview];
    [self.animator addBehavior:gravityBehavior];
    
    [_timer invalidate];
    _alertLabel= [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, self.view.frame.size.height + 20, 100, 20)];
    
    _alertLabel.text = @"呵呵哒";
    
    [self.view addSubview:_alertLabel];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect  frame1 = CGRectMake(kScreenWidth/2-50, self.view.frame.size.height-40, 100, 20);
        _alertLabel.frame = frame1;
    } completion:^(BOOL finished) {

    }];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(dismisLabel) userInfo:nil repeats:YES];
}


- (void) dismisLabel
{
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        _alertLabel.transform = CGAffineTransformIdentity;
        CGRectMake(kScreenWidth/2-50, self.view.frame.size.height + 20, 100, 20);
        
    } completion:^(BOOL finished) {
        
        [_alertLabel removeFromSuperview];
        
    }];
}


- (IBAction)Attach:(id)sender {
    NSLog(@"attach");
    [self reset];
    UIAttachmentBehavior * attachBeahavior = [[UIAttachmentBehavior alloc] initWithItem:self.imageview attachedToAnchor:CGPointMake(CGRectGetMidX(self.view.frame), 114)];
    UIGravityBehavior * gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[self.imageview]];
    [self.animator addBehavior:attachBeahavior];
    [self.animator addBehavior:gravityBehavior];
    
}


- (IBAction)push:(id)sender {
    NSLog(@"push");
    [self reset];
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.imageview] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(45, 0);
    push.magnitude = 1.0;
    
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.imageview]];
    itemBehavior.resistance = 0.8;
    
    [self.animator addBehavior:itemBehavior];
    [self.animator addBehavior:push];
    
}























@end
