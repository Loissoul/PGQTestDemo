//
//  YYAnimationIndicator.h
//  AnimationIndicator
//
//  AdvertisingColumn.h
//  Stampapa
//
//  Created by 韩刚 on 15/8/13.
//  Copyright (c) 2015年 韩刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGAnimationIndicator : UIView

{
    UIImageView *imageView;
    UILabel *Infolabel;
}

@property (nonatomic, assign) NSString *loadtext;
@property (nonatomic, readonly) BOOL isAnimating;


//use this to init
- (id)initWithFrame:(CGRect)frame;
-(void)setLoadText:(NSString *)text;

- (void)startAnimation;
- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;


@end
