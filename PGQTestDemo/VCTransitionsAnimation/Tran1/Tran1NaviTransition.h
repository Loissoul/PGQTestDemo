//
//  Tran1NaviTransition.h
//  PGQTestDemo
//
//  Created by 魏帅 on 16/1/15.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, PGQNaviOneTransitionType)
{
    PGQNaviOneTransitionTypePush = 0,
    PGQNaviOneTransitionTypePop
};

@interface Tran1NaviTransition : NSObject<UIViewControllerAnimatedTransitioning>
+(instancetype) transitionWithType:(PGQNaviOneTransitionType)type;
-(instancetype) initWithTransitionType:(PGQNaviOneTransitionType)type;
@end
