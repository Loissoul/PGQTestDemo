//
//  ViewBController.h
//  小试牛刀
//
//  Created by pgq on 15/9/23.
//  Copyright (c) 2015年 pgq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^block1)(NSString *blockstring);

typedef void(^ablock)(NSString *blockString);

typedef void(^abloc1)(NSString *blao) ;

@protocol classdelegate <NSObject>

- (void)newGirlFriend;

@end

@interface ViewBController : UIViewController

@property (nonatomic, strong) UITextView *writeView;
@property (nonatomic, strong) UIButton *clickButton;
@property (nonatomic, copy)   ablock bock;
@property (nonatomic, copy)   abloc1 blox;

@property (nonatomic, weak) id<classdelegate>  delegate;


@end