//
//  KCButton.h
//  小试牛刀
//
//  Created by pgq on 15/9/22.
//  Copyright (c) 2015年 pgq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KCButton;
typedef void (^KCButtonClick)(KCButton *);


@protocol KCButtonDelegate <NSObject>

- (void ) showName:(NSString *)nameStr;

@end


@interface KCButton : NSObject

@property (nonatomic,copy) KCButtonClick onClick;

@property (nonatomic,weak) id<KCButtonDelegate> delegate;

-(void) click;

@end
