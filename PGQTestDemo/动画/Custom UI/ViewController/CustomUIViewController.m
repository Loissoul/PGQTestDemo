//
//  CustomUIViewController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/10.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "CustomUIViewController.h"

#import "HGAnimationIndicator.h"

#import "CustomUItextField.h"

#import "CustomAnimationViewController.h"

@implementation CustomUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"Custom UI";
    [self initButton];
}

- (void) initButton
{
    for (int i = 0 ; i < 5; i++) {
        UIButton * button = [UIButton new];
        button.frame = CGRectMake(20, 100+i*60, 80, 50);
        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        button.tag = i+11;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:button];
    }
}

-(void)buttonClick:(UIButton *)sender
{
    NSInteger  tag = sender.tag-10;
    if (tag == 1) {
        CustomUItextField *cutomView = [[CustomUItextField alloc] init];
        
        [self.navigationController pushViewController:cutomView animated:YES];
    }
    if (tag == 2) {
        
    }
}





@end
