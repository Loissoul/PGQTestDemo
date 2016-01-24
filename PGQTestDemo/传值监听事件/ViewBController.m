//
//  ViewBController.m
//  小试牛刀
//
//  Created by pgq on 15/9/23.
//  Copyright (c) 2015年 pgq. All rights reserved.
//

#import "ViewBController.h"
#import "ViewAController.h"

@interface personMy : NSObject
{
    NSString *_name;
    int             _age;
    int             _height;
    int             _weight;
}

@end



@interface ViewBController ()

@property (nonatomic, retain) personMy *testPerson;

-(IBAction)onBtnTest:(id)sender;

@end

@implementation ViewBController



//-(void)dealloc
//{
//    [_testPerson removeObserver:self forKeyPath:@"height" context:nil];
//}
//
//-(void) testKVO
//{
//    _testPerson = [[personMy alloc] init];
//    
//    [_testPerson addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:nil];
//}


//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath  isEqualToString:@"height"]) {
//        
//        NSLog(@"Height is change ! new = %@",[change valueForKey:NSKeyValueChangeNewKey]);
//    }
//    else
//    {
//        [super observeValueForKeyPath: keyPath ofObject:object change:change context:context];
//    }
//}


- (IBAction)onBtnTest:(id)sender
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.clickButton];
    [self.view addSubview:self.writeView];
}


- (void)viewDidLayoutSubviews
{
    self.clickButton.frame = CGRectMake(0, 0, 100, 100);
    self.clickButton.backgroundColor = [UIColor blackColor];
    [self.clickButton setTitle:@"返回上一页面" forState:UIControlStateNormal];
    [self.clickButton addTarget:self action:@selector(clickButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.writeView.frame = CGRectMake(100, 200, 100, 50);
    self.writeView.backgroundColor = [UIColor lightGrayColor];
}



- (void)clickButtonClick
{
    NSLog(@"点一下");
    
    //1.block 传值
    if (self.bock)
    {
        self.bock(self.writeView.text);
        [self dismissViewControllerAnimated:YES completion:^{
            //返回传值
            
        }];
    }
    
//    2.协议传值
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//        [self.delegate newGirlFriend];
//    }];
    
    
//        3.通知传值
    
//    NSString *str = @"heheheda";
    
    NSDictionary *dict =[ [NSDictionary alloc] initWithObjectsAndKeys:self.writeView.text,@"textOne", nil];
    
    NSNotification *nitification = [NSNotification notificationWithName:@"tongzh" object:nil userInfo:dict];
    
    [[NSNotificationCenter defaultCenter] postNotification:nitification];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (UITextView *)writeView
{
    if (!_writeView) {
        
        _writeView = [[UITextView alloc] init];
        
    }
    return _writeView;
}

- (UIButton *)clickButton
{
    if (!_clickButton) {
        
        _clickButton = [[UIButton alloc] init];
        
    }
    return _clickButton;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.writeView resignFirstResponder];
}


@end
