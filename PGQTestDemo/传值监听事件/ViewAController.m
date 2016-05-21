//
//  ViewController.m
//  小试牛刀
//
//  Created by pgq on 15/9/21.
//  Copyright (c) 2015年 pgq. All rights reserved.
//

//   KVO  by 潘



#import "ViewAController.h"
#import "KCButton.h"
#import "ViewBController.h"

@interface StockData : NSObject
//{
//    NSString * stockName;
//    float price;
//}
@property (nonatomic, strong) NSString *stockName;
@property (nonatomic, strong) NSString  *price;

@end

@implementation StockData

@end


@interface ViewAController ()
@property (nonatomic, retain) StockData* stockForKVO;
@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UIButton *changePriceBtn;

@end

@implementation ViewAController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzh" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    UINavigationItem  *navItem = [[UINavigationItem alloc] initWithTitle:@"小试牛刀"];
    [navBar pushNavigationItem:navItem animated:YES];
    [self.view addSubview:navBar];
    
    [self.view addSubview:self.confirmButton];
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.label1];
    
    _stockForKVO = [[StockData alloc] init];
    [_stockForKVO setValue:@"searph" forKeyPath:@"stockName"];
    [_stockForKVO setValue:@"10.0" forKeyPath:@"price"];
    
    [_stockForKVO addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    [self.view addSubview:self.myLabel];
    [self.view addSubview:self.changePriceBtn];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //在这边实现页面上的改动
    self.confirmButton.frame = CGRectMake(0, 64, 100, 100);
    self.confirmButton.backgroundColor = [UIColor redColor];
    self.bgView.frame = CGRectMake(100, 300, 100, 100);
    [self.confirmButton setTitle:@"进入下一页" forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(clickCom) forControlEvents:UIControlEventTouchUpInside];
    self.label1.frame = CGRectMake(200, 100, 100, 100);
    self.label1.textColor = [UIColor blackColor];
    
    _myLabel.frame = CGRectMake(0, 220, 80, 40);
    _myLabel.backgroundColor = [UIColor lightGrayColor];
    _myLabel.text = [_stockForKVO valueForKeyPath:@"price"];
    
    _changePriceBtn.frame = CGRectMake(0, 170, 80, 40);
    _changePriceBtn.backgroundColor = [UIColor yellowColor];
    [_changePriceBtn setTitle:@"改变价格" forState:UIControlStateNormal];
    [_changePriceBtn addTarget:self action:@selector(changePriceClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void) changePriceClick
{
    [_stockForKVO setValue:@"20.0" forKeyPath:@"price"];
}


//实现回调方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"price"])
    {
        _myLabel.text = [_stockForKVO valueForKeyPath:@"price"];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [_stockForKVO removeObserver:self forKeyPath:@"price"];
}


-(void)tongzhi:(NSNotification *)text
{
    self.label1.text = text.userInfo[@"textOne"];
}

-(void)clickCom
{
    NSLog(@"进入下一个页面");
    
    ViewBController *viewB = [[ViewBController alloc] init];
//    
    [self presentViewController:viewB animated:YES completion:^{
//        viewB.bock = ^(NSString *str){
//            self.label1.text = str;
//        };
    }];
//    [self.navigationController  pushViewController:viewB animated:YES];
//    viewB.bock = ^(NSString *str){
//        self.label1.text = str;
//    };
}

- (void) tapClick
{
    NSLog(@"手势有用");
}


-(UILabel*)label1
{
    if (!_label1) {
        
        _label1 = [[UILabel alloc] init];
        
    }
    return _label1;
}


-(UIButton*)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
    }
    return  _confirmButton;
}


-(UIView *)bgView
{
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        
        _bgView.backgroundColor = [UIColor lightGrayColor];
        
        _bgView.frame = CGRectMake(100, 200, 100, 100);
        
        _bgView.alpha = 0.02;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

-(UILabel *)myLabel
{
    if (!_myLabel) {
        _myLabel = [[UILabel alloc] init];
    }
    return _myLabel;
}

-(UIButton *)changePriceBtn
{
    if (!_changePriceBtn) {
        _changePriceBtn = [[UIButton alloc] init];
    }
    return _changePriceBtn;
}

@end
