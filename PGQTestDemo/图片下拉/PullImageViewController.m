//
//  PullImageViewController.m
//  PGQTestDemo
//
//  Created by Lois_pan on 16/3/19.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "PullImageViewController.h"

#import "UIImage+Image.h"

static CGFloat ParallaxHeaderHeight = 235;

@interface PullImageViewController ()
@property (nonatomic, strong) UIScrollView   * scrollView; //滚动视图
@property (nonatomic, strong) UIView         * backView;   //约束
@property (strong, nonatomic) UIImageView    * parallaxHeaderView;
@property (strong, nonatomic) MASConstraint  * parallaxHeaderHeightConstraint;


@end

@implementation PullImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
}

- (void) initImageView
{
    _parallaxHeaderView = [UIImageView new];
    
    [self.view insertSubview:_parallaxHeaderView belowSubview:_backView];
    _parallaxHeaderView.contentMode = UIViewContentModeScaleAspectFill;
    _parallaxHeaderView.image = [UIImage imageNamed:@"parallax_header_back.png"];
    
    [_parallaxHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        _parallaxHeaderHeightConstraint = make.height.equalTo(@(ParallaxHeaderHeight));
    }];
    
    // Add KVO
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

}


// 方法2：利用KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = ((NSValue *)change[NSKeyValueChangeNewKey]).CGPointValue;
        if (contentOffset.y < 0) {
            _parallaxHeaderHeightConstraint.equalTo(@(ParallaxHeaderHeight - contentOffset.y));
        } else {
            _parallaxHeaderHeightConstraint.equalTo(@(ParallaxHeaderHeight - contentOffset.y));
        }
    }
}

- (void) initView
{
    //滚动视图
    _scrollView = ({
        UIScrollView *view = [UIScrollView new];
        view.showsVerticalScrollIndicator = NO;
        view.bounces = YES;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        view.backgroundColor = [UIColor redColor];
        view;
    });
    
    _backView = ({
        UIView *view = [UIView new];
        [_scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView);
        }];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(80);
    }];
}




@end
