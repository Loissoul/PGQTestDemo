//
//  ViewController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/11/10.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "ViewController.h"
#import "ViewAController.h"
#import "CalayerCAViewController.h"
#import "VCTransitionsController.h"

#import "ImageViewController.h"
#import "PGQViewController.h"

#import "Main1ViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

#import "MainViewController.h"

#import "showPGQContextMenuViewController.h"
#import "QQUItableViewAlert.h"
#import "CustomUIViewController.h"
#import "TranVC.h"
#import "SelectedPhotoViewController.h"
#import "VideoViewController.h"
#import "PullImageViewController.h"


@interface ViewController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];    
    
    PGQLog(@"heheda");
    
//    [AFNetUtils getInfoWithSubUrl:nil parameters:nil block:^(id result, NSError *error) {
//        if (error!=nil) {
//            NSLog(@"网络异常");
//        }
//    }];
    
//    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew  context:nil];
    
    _dataArr = @[@"0Core Animation Demo(CA)",@"1Core Graphic Demo(CG)",@"2Thread Demo(CoreData and so on )",@"3异步I/O(大文件读取)",@"4Custom UI",@"5ReactiveCocoa Demo",@"6自定义VC转场动画",@"7RunLoop应用(常驻线程)",@"8图片下拉",@"9Method Swizzling ",@"10传值",@"11tableView动态计算cell的高度",@"12将几张图片合成一张",@"13各种APP的标题模仿",@"14左视图",@"15有趣的Autolayout示例-Masonry实现",@"16右边按钮下拉",@"17选择相册",@"18视频"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void) viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:127 green:0 blue:127 alpha: 1];
//   self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:127 green:0 blue:127 alpha:1];

//    self.navigationController.navigationBar.alpha = 0;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//
//-(void)dealloc
//{
//    [self.tableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if (object == self.tableView && [keyPath isEqualToString:@"contentOffset"])
//    {
//        CGFloat offsetY = self.tableView.contentOffset.y;
//        CGFloat delta = offsetY / 64.f ;
////        delta = MAX(0, delta);
//        if (offsetY > 0) {
////            self.navigationController.navigationBar.alpha = 0;
////            CGFloat alpha = 1 - ((64 - offsetY) / 64);
//            CGFloat alpha = offsetY/64;
////            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:127 green:0 blue:127 alpha:alpha];
//            self.navigationController.navigationBar.alpha = alpha;
//        }
//        else{
////            self.navigationController.navigationBar.alpha = MIN(1, delta);
//            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:127 green:0 blue:127 alpha:0];
//            NSLog(@"%f",offsetY);
//        }
//    }
//    else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    
    NSLog(@"%ld",row);
    
    if(row == 0){
        CalayerCAViewController *calayer = [[CalayerCAViewController alloc] init];
        [self .navigationController pushViewController:calayer animated:YES];
    }
    else if (row == 4){
        CustomUIViewController * customUi = [[CustomUIViewController alloc] init];
        
        [self.navigationController pushViewController:customUi animated:YES];
    }
    else if (row == 6) {
//        VCTransitionsController *vctransition = [[VCTransitionsController alloc] init];
//        [self.navigationController pushViewController:vctransition animated:YES];
//
//        [self presentViewController:vctransition animated:YES completion:^{
//            
//            
//        }];
        
        [self.navigationController pushViewController:[[TranVC alloc] init] animated:YES];
    }
    else if(row == 8){
        [self.navigationController pushViewController:[[PullImageViewController alloc] init] animated:YES];
    }

    else if(row == 10){
        ViewAController *vcA  =  [[ViewAController alloc] init];
        [self.navigationController pushViewController:vcA animated:YES];
    }
    else if (row == 11) {
        QQUItableViewAlert * qqTableViewAlert = [[QQUItableViewAlert alloc] init];
        [self.navigationController pushViewController:qqTableViewAlert animated:YES];
    }
    else if (row == 12){
        ImageViewController *imageView = [[ImageViewController alloc] init];
        [self.navigationController pushViewController:imageView animated:YES];
    }
    else if (row == 13){
        PGQViewController *pgqView = [[PGQViewController alloc] init];
        [self.navigationController pushViewController:pgqView animated:YES];
    }
    else if (row == 14) {
        Main1ViewController *mainVc = [[Main1ViewController alloc] initWithLeft:[[LeftViewController alloc]init] right:[[RightViewController alloc] init] ];
        [self.navigationController pushViewController:mainVc animated:YES];
    }
    else if (row == 15){
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main1" bundle:nil];
        MainViewController *autolayoutView = [storyBoard instantiateViewControllerWithIdentifier:@"MainViewAuto"];
        [self.navigationController pushViewController:autolayoutView animated:YES];
    }
    else if(row == 16){
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        showPGQContextMenuViewController *autolayoutView = [storyBoard instantiateViewControllerWithIdentifier:@"showPGQ"];
        [self.navigationController pushViewController:autolayoutView animated:YES];
    }else if (row == 17){
    
        [self.navigationController pushViewController:[[SelectedPhotoViewController alloc] init] animated:YES];
    }else if (row == 18){
    
        [self.navigationController pushViewController:[[VideoViewController alloc] init] animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
