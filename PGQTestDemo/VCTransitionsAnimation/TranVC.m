//
//  TranVC.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/15.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "TranVC.h"


@interface TranVC()
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *viewControllers;

@end

@implementation TranVC
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initView];
}

- (NSArray *)data{
    if (!_data) {
        _data = [@[@"神奇移动",@"弹性pop",@"翻页效果",@"小圆点扩散"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [@[@"Tran1ViewController", @"Tran2ViewController", @"Tran3ViewController", @"Tran4ViewController"] copy];
    }
    return _viewControllers;
}
-(void) initView
{
    for (int i = 0; i<4; i++) {
        UIButton * button = [UIButton new];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(200, 100+i*50, 100, 40);
        [button setTitle:_data[i] forState:UIControlStateNormal];
        button.tag = i+11;
        [button setTitle:[NSString stringWithFormat:@"View%d",i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview: button];
    }
}
-(void)buttonClick:(UIButton*)sender
{
    NSInteger tag = sender.tag-11;
    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[tag]) alloc] init] animated:YES];
    

//    [self.navigationController pushViewController:[[NSClassFromString(@"XWMagicMoveController") alloc] init] animated:YES];

}
@end
