//
//  CustomUItextField.m
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/15.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "CustomUItextField.h"
#import "HGAnimationIndicator.h"
#import "ProgressView.h"
@interface CustomUItextField ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField * phoneTextField;
@end


@implementation CustomUItextField

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ProgressView * progressView = [[ProgressView alloc] initWithFrame:CGRectMake(100, 70, 100, 8) Num:0.65];
    
    [self.view addSubview:progressView];
    [Statics reputationButtonWidthAnimation:progressView.progressBtn withProgress:0.65];
    
    [self initView];
    [self indicatorAnimation];
}

- (void)initView
{
    _phoneTextField = ({
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 35)];
        [self.view addSubview:textField];
        textField.delegate = self;
        textField.backgroundColor = [UIColor whiteColor];
        textField;
    });
    //创建一个富文本对象
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    //设置富文本对象的颜色
    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attributes];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    //设置富文本对象的颜色
    attributes[NSForegroundColorAttributeName] = [UIColor redColor];
    _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attributes];
}

- (void)indicatorAnimation
{
    [[Statics shardManager] showIndicator];  //加载页面的动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[Statics shardManager] stopIndicatorWithText:@"失败" withType:NO];
    });
}



@end
