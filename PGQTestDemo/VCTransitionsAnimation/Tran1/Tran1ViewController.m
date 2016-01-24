//
//  Tran1ViewController.m
//  PGQTestDemo
//
//  Created by Lois_soul on 16/1/15.
//  Copyright © 2016年 Lois_soul. All rights reserved.
//

#import "Tran1ViewController.h"
#import "Tran1ViewBController.h"

@implementation Tran1ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
  
}

-(void) initView
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.tapImageView addGestureRecognizer:tap];
    [self.view addSubview:self.tapImageView];
    
//    _tapImageView = ({
//        UIImageView * imageView = [UIImageView new];
//        imageView.userInteractionEnabled = YES;
//        [imageView addGestureRecognizer:tap];
//        [self.view addSubview:imageView];
//        imageView.frame = CGRectMake(self.view.center.x-100, self.view.center.y-200, 200, 329);
//        imageView.image = [UIImage imageNamed:@"pgq.png"];
//        imageView;
//    });
}


-(void)tapClick:(UITapGestureRecognizer*)tap
{
    NSLog(@"hehe");
    Tran1ViewBController *vc = [[Tran1ViewBController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}


-(UIImageView *)tapImageView
{
    if (!_tapImageView) {
        
        _tapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x-100, self.view.center.y-200, 200, 329)];
        _tapImageView.userInteractionEnabled = YES;
        _tapImageView.image = [UIImage imageNamed:@"pgq.png"];
    }
    return _tapImageView;
}

@end
