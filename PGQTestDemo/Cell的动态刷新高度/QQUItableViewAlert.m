//
//  QQUItableViewAlert.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/25.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "QQUItableViewAlert.h"
@interface QQUItableViewAlert ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation QQUItableViewAlert
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    SXLog(@"heheda");
    
    _dataArr = @[@"强神",@"强神",@"强神",@"强神",@"强神",@"强神",@"强神",@"强神",@"强神",@"强神 "];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:127 green:0 blue:127 alpha: 1];
//    self.navigationController.navigationBar.alpha = 0;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

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

}




@end
