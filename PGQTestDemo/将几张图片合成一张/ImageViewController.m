//
//  ImageViewController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/11/25.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "ImageViewController.h"
#import "PageView.h"
#import "PageViewController.h"

@interface ImageViewController ()
@property (nonatomic, strong) UIButton *buttonClick;
@property (nonatomic, strong) PageView * pageView;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.buttonClick];
    
    PageView *view1 = [[PageView alloc] initWithFrame:CGRectMake(100, 250, 200, 200)];
    [self.view addSubview:view1];
    
//    [self.view addSubview:self.pageView];
}

-(void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    UIImage *image = [self composeWithHeader:[UIImage imageNamed:@"1.png"] content:[UIImage imageNamed:@"2.png"] footer:[UIImage imageNamed:@"3.png"]];
    _imageView.image = image;
    
    [_buttonClick setTitle:@"下一页" forState:UIControlStateNormal];
    _buttonClick.backgroundColor = [UIColor lightGrayColor];
    [_buttonClick addTarget:self action:@selector(nextView) forControlEvents:UIControlEventTouchUpInside];
}

-(void)nextView
{
    NSLog(@"下一页");
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PageViewController *pageViewC = [storyBoard instantiateViewControllerWithIdentifier:@"PageView"];
    [self.navigationController pushViewController:pageViewC animated:YES];

}

#pragma mark 将图片合成一张的方法
- (UIImage *)composeWithHeader:(UIImage *)header content:(UIImage *)content footer:(UIImage *)footer{
    CGSize size = CGSizeMake(content.size.width, header.size.height +content.size.height +footer.size.height);
    UIGraphicsBeginImageContext(size);
    
    [header drawInRect:CGRectMake(0,
                                  0,
                                  header.size.width,
                                  header.size.height)];
    [content drawInRect:CGRectMake(0,
                                   header.size.height,
                                   content.size.width,
                                   content.size.height)];
    [footer drawInRect:CGRectMake(0,
                                  header.size.height+content.size.height,
                                  footer.size.width,
                                  footer.size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark  creat  some controls
-(UIImageView *)imageView
{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 100, 200)];
    }
    return _imageView;
}

-(UIButton*)buttonClick
{
    if (!_buttonClick) {
        _buttonClick = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 70, 40)];
    }
    return _buttonClick;
}

//-(PageView*)pageView
//{
//    if (!_pageView) {
//        _pageView = [[PageView alloc] initWithFrame:CGRectMake(100, 250, 200, 200)];
//    }
//    return _pageView;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
