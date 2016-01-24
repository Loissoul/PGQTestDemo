//
//  CalayerCAViewController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/11/25.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "CalayerCAViewController.h"

@interface CalayerCAViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTableView;


@end

@implementation CalayerCAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self tableViewZ:self.myTableView cellForRowAtIndexPath:indexPath];
    return cell;
}
- (UITableViewCell *)tableViewZ:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"offset---scroll:%f",self.myTableView.contentOffset.y);
    UIColor *color=[UIColor greenColor];
    CGFloat offset=scrollView.contentOffset.y;
    if (offset==-64) {
        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:1];
    }else {
        CGFloat alpha=((0-offset)/64);
        self.navigationController.navigationBar.backgroundColor=[color colorWithAlphaComponent:alpha];
    }
}

- (void)initTableView{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.view addSubview:self.myTableView];
}

- (void) draw1
{
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1/2000;
    
}

//- (CALayer *)greenHeadMaskLayer
//{
//    CALayer *mask = [CALayer layer];
//    mask.frame = self.greenHead.bounds;
//    
//    self.maskLayerUp = [CAShapeLayer layer];
//    self.maskLayerUp.bounds = CGRectMake(0, 0, 30.0f, 30.0f);
//    self.maskLayerUp.fillColor = [UIColor greenColor].CGColor; // Any color but clear will be OK
//    self.maskLayerUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15.0f, 15.0f)
//                                                           radius:15.0f
//                                                       startAngle:0
//                                                         endAngle:2*M_PI
//                                                        clockwise:YES].CGPath;
//    self.maskLayerUp.opacity = 0.8f;
//    self.maskLayerUp.position = CGPointMake(-5.0f, -5.0f);
//    [mask addSublayer:self.maskLayerUp];
//    
//    self.maskLayerDown = [CAShapeLayer layer];
//    self.maskLayerDown.bounds = CGRectMake(0, 0, 30.0f, 30.0f);
//    self.maskLayerDown.fillColor = [UIColor greenColor].CGColor; // Any color but clear will be OK
//    self.maskLayerDown.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15.0f, 15.0f)
//                                                             radius:15.0f
//                                                         startAngle:0
//                                                           endAngle:2*M_PI
//                                                          clockwise:YES].CGPath;
//    self.maskLayerDown.position = CGPointMake(35.0f, 35.0f);
//    [mask addSublayer:self.maskLayerDown];
//    return mask;
//}
//
//- (void)startGreenHeadAnimation
//{
//    CABasicAnimation *downAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//    downAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5.0f, -5.0f)];
//    downAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(10.0f, 10.0f)];
//    downAnimation.duration = duration;
//    [self.maskLayerUp addAnimation:downAnimation forKey:@"downAnimation"];
//    
//    CABasicAnimation *upAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//    upAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(35.0f, 35.0f)];
//    upAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(20.0f, 20.0f)];
//    upAnimation.duration = duration;
//    [self.maskLayerDown addAnimation:upAnimation forKey:@"upAnimation"];
//}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
