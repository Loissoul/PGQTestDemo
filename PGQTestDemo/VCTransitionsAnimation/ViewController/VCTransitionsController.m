//
//  VCTransitionsController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/11/16.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "VCTransitionsController.h"
#import "VCTran2Controller.h"
#import "VC3TranController.h"

@interface VCTransitionsController ()

@end

@implementation VCTransitionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专场动画";
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.nextBtn2];
    [self.view addSubview:self.view1];
    
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [_nextBtn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn2 addTarget:self action:@selector(tapClick2) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapClick2
{
    NSLog(@"翻页动画");
    VCTran2Controller *vcTran2 = [[VCTran2Controller alloc] init];
    [self addChildViewController:vcTran2];
    
    VC3TranController *vcTran3 = [[VC3TranController alloc] init];
    [self addChildViewController: vcTran3];
    
    [self.view1 addSubview:vcTran2.view];
    
    [vcTran2  didMoveToParentViewController:self];
    
    if ([self.view1 isKindOfClass:[vcTran3.view class] ]){

        NSLog(@"不需要专场1");
    }
    else{
    
        [self transitionFromViewController:vcTran2  toViewController:vcTran3 duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
        } completion:^(BOOL finished) {
            
            //        [self.view1 addSubview:vcTran3.view];
        }];

    }
}

- (void) tapClick
{
    NSLog(@"翻页动画");
    VCTran2Controller *vcTran2 = [[VCTran2Controller alloc] init];
    [self addChildViewController:vcTran2];
    
    VC3TranController *vcTran3 = [[VC3TranController alloc] init];
    [self addChildViewController: vcTran3];
    
    [self.view1 addSubview:vcTran3.view];
    [vcTran3  didMoveToParentViewController:self];
    
    if ([self.view1 isKindOfClass:[vcTran2.view class]]){
        NSLog(@"不需要转场");
        
    }else{
        [self transitionFromViewController:vcTran3  toViewController:vcTran2 duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
        } completion:^(BOOL finished) {
            
//            [self.view1 addSubview:vcTran2.view];

        }];
    }
   }


-(UIButton *)nextBtn
{
    if (!_nextBtn) {
        
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
        _nextBtn.backgroundColor = [UIColor blackColor];

    }
    return _nextBtn;
}


-(UIButton *)nextBtn2
{
    if (!_nextBtn2) {
        _nextBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 220, 100, 100)];
        
        _nextBtn2.backgroundColor = [UIColor redColor];
    }
    return _nextBtn2;
}

-(UIView *)view1
{
    if (!_view1) {
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(0,320 , 320, 200)];
        _view1.backgroundColor = [UIColor lightGrayColor];
    }
    return _view1;
}


@end
