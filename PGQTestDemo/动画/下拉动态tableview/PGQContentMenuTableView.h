//
//  PGQContentMenuTableView.h
//  PGQTestDemo
//
//  Created by 魏帅 on 15/12/18.
//  Copyright © 2015年 潘国强. All rights reserved.
//

#import <UIKit/UIKit.h>

//----------------------------------------
#define  DE_BUG BY PGQ-YES
//----------------------------------------

@class PGQContentMenuTableView;

@protocol PGQContentMenuTableViewDelegate <NSObject>

@optional

/**
 *   This method called when menu dismissed
 *
 *  @param contentMenuTableView <#contentMenuTableView description#>
 *  @param indexPath            <#indexPath description#>
 */
- (void)contentMenuTableView:(PGQContentMenuTableView*)contentMenuTableView
      didDismissWithIndePath:(NSIndexPath*)indexPath;

@end

@interface PGQContentMenuTableView : UITableView

@property (nonatomic, weak) id<PGQContentMenuTableViewDelegate>pgqDelegate;

@property (nonatomic) CGFloat animationDuration;


/**
 *   Call this method for initilization of the table view with datasource and delegate assigned.
 *
 *  @param delegateDataSource: Add our class for delegate and dataSource methods here
 *
 *  @return PGQTableView object or nil
 */
- (instancetype) initWithTableViewDelegateDataSource:(id<UITableViewDelegate,UITableViewDataSource>)delegateDataSource;


/**
 *  Use this method for correct presenration as [superview addSubview:MyPGQTableView] will not present side menu properly
 *
 *  @param superView Superview to present your menu. If you are using a navigation controller it is better to use myViewController.navigationController.view as a superview.
 *  @param edgInsets <#edgInsets description#>
 *  @param animated  yes or no wather you want appearance animated or not
 */
- (void)showInView:(UIView *)superView withEdgeInsets:(UIEdgeInsets)edgInsets animated:(BOOL)animated;


/**
 *  Call this method to dismiss your menuAnimated
 *
 *  @param indexPath indexPath of the cell selected
 */
- (void)dismisWithIndexPath:(NSIndexPath *)indexPath;


/**
 *  call this menthod before or building the device totation animation
 */
- (void)updateAlongsideRotation;





@end
