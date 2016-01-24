//
//  showPGQContextMenuViewController.m
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/24.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import "showPGQContextMenuViewController.h"
#import "ContextMenuCell.h"
#import "PGQContentMenuTableView.h"
#import "YALNavigationBar.h"
#import "DynamicAnimationViewController.h"

static NSString *const menuCellIdentifier = @"rotationCell";

@interface showPGQContextMenuViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
PGQContentMenuTableViewDelegate
>

@property (nonatomic, strong) PGQContentMenuTableView* contextMenuTableView;

@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;

@end

@implementation showPGQContextMenuViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initiateMenuOptions];
    
    // set custom navigationBar with a bigger height
//    [self.navigationController setValue:[[YALNavigationBar alloc]init] forKeyPath:@"navigationBar"];
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"BtnAdd.png"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addFriendClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    //should be called after rotation animation completed
    [self.contextMenuTableView reloadData];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.contextMenuTableView updateAlongsideRotation];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //should be called after rotation animation completed
        [self.contextMenuTableView reloadData];
    }];
    [self.contextMenuTableView updateAlongsideRotation];
    
}

#pragma mark - IBAction

- (void)addFriendClick{
    // init YALContextMenuTableView tableView
    if (!self.contextMenuTableView) {
        self.contextMenuTableView = [[PGQContentMenuTableView alloc]initWithTableViewDelegateDataSource:self];
        self.contextMenuTableView.animationDuration = 0.15;
        //optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView.pgqDelegate = self;
        
        //register nib
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
    }
    
    // it is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
}

#pragma mark - Local methods

- (void)initiateMenuOptions {
    self.menuTitles = @[@"",
                        @"Send message",
                        @"Like profile",
                        @"Add to friends",
                        @"Add to favourites",
                        @"Block user"];
    
    self.menuIcons = @[[UIImage imageNamed:@"Icnclose"],
                       [UIImage imageNamed:@"SendMessageIcn"],
                       [UIImage imageNamed:@"LikeIcn"],
                       [UIImage imageNamed:@"AddToFriendsIcn"],
                       [UIImage imageNamed:@"AddToFavouritesIcn"],
                       [UIImage imageNamed:@"BlockUserIcn"]];
    
    NSLog(@"%@",self.menuIcons);
}

#pragma mark - YALContextMenuTableViewDelegate

- (void)contextMenuTableView:(PGQContentMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Menu dismissed with indexpath = %@", indexPath);
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(PGQContentMenuTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView dismisWithIndexPath:indexPath];
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DynamicAnimationViewController * dynamicAnimation = [main instantiateViewControllerWithIdentifier:@"DynamicAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:dynamicAnimation animated:YES];
        
    });
    
    if (indexPath.row == 4) {
        
        NSLog(@"呵呵哒");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(PGQContentMenuTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
        cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
    }
    
    return cell;
}

@end

