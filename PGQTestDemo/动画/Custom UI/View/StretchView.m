//
//  StretchView.m
//  PGQTestDemo
//
//  Created by Lois_pan on 16/3/2.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "StretchView.h"

#define SYS_DEVICE_WIDTH   ([[UIScreen mainScreen] bounds].size.width)
#define SYS_DEVICE_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)
#define MIN_HEIGHT          100                                                          // 图形最小高度

@interface StretchView()
@property (nonatomic, assign)     CGFloat mHeight;
@property (nonatomic, assign)     CGFloat curveX;               // r5点x坐标
@property (nonatomic, assign)     CGFloat curveY;               // r5点y坐标
@property (nonatomic, strong)     UIView *curveView;            // r5红点
@property (nonatomic, strong)     CAShapeLayer *shapeLayer;
@property (nonatomic, strong)     CADisplayLink *displayLink;
@property (nonatomic, assign)     BOOL isAnimating;

@end

static NSString *kX = @"curveX";
static NSString *kY = @"curveY";
@implementation StretchView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:kX options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:kY options:NSKeyValueObservingOptionNew context:nil];
        
        [self configuration];
        [self configShapelayer];
        [self congigCurveView];
    }
    return self;
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:kX];
    [self removeObserver:self forKeyPath:kY];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kX] || [keyPath isEqualToString:kY]) {
        [self updateShaperlayerPath];
    }
}

-(void)configuration
{
    _mHeight = 100;
    _isAnimating = NO;

       UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelAction:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:pan];

    //每秒 60次计算
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatepath)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES;
}
-(void)configShapelayer
{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor colorWithRed:60/255.0 green:80/255.0 blue:90/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:_shapeLayer];
}
-(void)congigCurveView
{
    self.curveX = SYS_DEVICE_WIDTH/2.0;
    self.curveY = MIN_HEIGHT;
    _curveView = [[UIView alloc] initWithFrame:CGRectMake(_curveX, _curveY, 3, 3)];
    _curveView.backgroundColor = [UIColor redColor];
    [self addSubview:_curveView];
}

-(void)handelAction:(UIPanGestureRecognizer*)pan
{
    if (!_isAnimating) {
        if (pan.state == UIGestureRecognizerStateChanged) {
            CGPoint point = [pan translationInView:self];
            _mHeight = point.y*0.7 + MIN_HEIGHT;
            self.curveX = SYS_DEVICE_WIDTH/2.0 + point.x;
            self.curveY = _mHeight > MIN_HEIGHT ? _mHeight : MIN_HEIGHT;
            _curveView.frame = CGRectMake(_curveX, _curveY, _curveView.frame.size.width, _curveView.frame.size.height);
        }
    }
    else if(pan.state == UIGestureRecognizerStateCancelled||
            pan.state == UIGestureRecognizerStateEnded||
            pan.state == UIGestureRecognizerStateFailed)
    {
        _isAnimating = YES;
        _displayLink.paused = NO;
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            _curveView.frame = CGRectMake(SYS_DEVICE_WIDTH/2.0, MIN_HEIGHT, 3, 3);
        } completion:^(BOOL finished) {
            if (finished) {
                _isAnimating = NO;
                _displayLink.paused = YES;
            }
        }];
    }
}

-(void)updateShaperlayerPath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(SYS_DEVICE_WIDTH, 0)];
    [path addLineToPoint:CGPointMake(SYS_DEVICE_WIDTH, MIN_HEIGHT)];
    [path addQuadCurveToPoint:CGPointMake(0, MIN_HEIGHT) controlPoint:CGPointMake(_curveX, _curveY)];
    [path closePath];
    _shapeLayer.path = path.CGPath;
}

-(void)calculatepath
{
    CALayer * layer = _curveView.layer.presentationLayer;
    self.curveX = layer.position.x;
    self.curveY = layer.position.y;
}

@end
