//
//  Statics.m
//  Wordoor
//
//  Created by BernieWang on 14-5-6.
//  Copyright (c) 2014年 Bernie. All rights reserved.
//

#import "Statics.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetWorking.h"
#import "HGAnimationIndicator.h"
@interface Statics ()

@property (nonatomic, strong) HGAnimationIndicator * hganimation;
@property (nonatomic, strong) UIView * backWindowView;
@property (nonatomic, strong) UILabel * label;
@end

@implementation Statics

static Statics * statics = nil;

+(id)shardManager
{
    if (!statics) {
        statics = [[Statics alloc]init];
    }
    return statics;
}


+ (void)reputationButtonWidthAnimation:(UIButton *)button withProgress:(CGFloat)progress
{
    static CAShapeLayer *layer = nil;
    if (!button.layer.mask)
    {
        layer = [CAShapeLayer layer];
        layer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(button.bounds) * progress, CGRectGetHeight(button.bounds))].CGPath;
        layer.fillColor = [UIColor whiteColor].CGColor;
        button.layer.mask = layer;
    }
    else
    {
        CGPathRef path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(button.bounds) * progress, CGRectGetHeight(button.bounds))].CGPath;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.duration = 0.25;
        animation.fromValue = (id)layer.path;
        animation.toValue = (__bridge id)path;
        animation.removedOnCompletion = YES;
        [layer addAnimation:animation forKey:@"shapeLayerPath"];
        layer.path = path;
    }
}



- (void)showIndicator
{
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        _backWindowView = ({
            UIView *view = [UIView new];
            [window addSubview:view];
            view.frame = kScreenBounds;
            view.alpha = 0;
            view.backgroundColor = [UIColor blackColor];
    
            view;
        });
    _hganimation = [[HGAnimationIndicator alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _hganimation.center = _backWindowView.center;
    [window addSubview:_hganimation];

    [_hganimation startAnimation];
}

- (void)stopIndicatorWithText:(NSString*)title withType:(BOOL)type
{
    [_hganimation stopAnimationWithLoadText:title withType:type];
    
    [UIView animateWithDuration:0.3 animations:^{

    } completion:^(BOOL finished) {

        [_backWindowView removeFromSuperview];
        [_hganimation removeFromSuperview];
    }];
}

#pragma mark - 网络状态监听

+(void)netWorkStatusandSuccessBlock:(void (^)(NSInteger netWorkStatus))successBlock
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSInteger netWorkStatus;

        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                netWorkStatus = -1;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                netWorkStatus = 0;

                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                netWorkStatus = 1;

                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                netWorkStatus = 2;

                break;
            default:
                break;
 
        }
        
        if (successBlock) {
            successBlock(netWorkStatus);
        }
    }];
    
    //开始监听
    [manager startMonitoring];
}

#pragma mark get language
+(NSString *)langcode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLang = [languages objectAtIndex:0];
    
    NSString * lang;
    if([currentLang rangeOfString:@"zh-Hans"].location != NSNotFound|| [currentLang rangeOfString:@"zh-Hant"].location != NSNotFound)
    {
        lang = @"zh-CN";
        
    }else
    {
        lang=@"en";
    }
    return lang;
}

#pragma mark PGQ 登陆的时候 存入myid
+(NSString *)myid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"myidData"];
}

+(NSString *)getCurrentTime{
    
    NSDate *nowUTC = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [dateFormatter stringFromDate:nowUTC];
}

+ (NSString*) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString*) md5:(NSString*) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

+(NSString*) uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

+(NSString *)roundUp:(float)number afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

//
//+(NSString*)DateFormatterForSMS:(NSDate*)smsDate
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[Utils langcode]];
//    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
//    NSString *dateSMS = [dateFormatter stringFromDate:smsDate];
//    NSDate *now = [NSDate date];
//    NSString *dateNow = [dateFormatter stringFromDate:now];
//    if ([dateSMS isEqualToString:dateNow]) {
//        [dateFormatter setDateFormat:@"HH:mm"];
//    }
//    else {
//        [dateFormatter setDateFormat:@"MM/dd HH:mm"];
//    }
//    dateSMS = [dateFormatter stringFromDate:smsDate];
//    return dateSMS;
//}

+(BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+ (NSArray*)getAllSystemFonts;
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray* familys = [UIFont familyNames];
    
    for (id obj in familys) {
        NSArray* fonts = [UIFont fontNamesForFamilyName:obj];
        for (id font in fonts)
        {
            [array addObject:font];
        }
    }
    return array;
}

+ (UIFont*)getCurrentFont
{
    //判断系统字体的size，返回使用的字体。
    UIFont *font = [UIFont systemFontOfSize:14];
    return font;
}


+(NSString *)UnicodeToUTF8:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

+(NSString *)UTF8ToUnicode:(NSString *)utf8Str
{
    NSUInteger length = [utf8Str length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++)
    {
        unichar _char = [utf8Str characterAtIndex:i];
        
        switch (_char) {
            case '\t':
                [s appendFormat:@"\%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
                break;
            case '\n':
                [s appendFormat:@"\%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
                break;
            case '\r':
                [s appendFormat:@"\%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
                break;
            case '\f':
                [s appendFormat:@"\%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
                break;
            case '=': // Fall through
            case ':': // Fall through
            case '#': // Fall through
            case '!':
            case ' ':
                [s appendFormat:@"\\%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
                break;
            default:
                if ((_char < 0x0020) || (_char > 0x007e))
                {
                    [s appendFormat:@"\\u%x",[utf8Str characterAtIndex:i]];
                }
                else
                {
                    [s appendFormat:@"%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
                }
                break;
        }
        /*
        //判断是否为英文和数字
        if (_char <= '9' && _char >='0')
        {
            [s appendFormat:@"%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
        }
        else if(_char >='a' && _char <= 'z')
        {
            [s appendFormat:@"%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
        }
        else if(_char >='A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
        }
        else if(_char =='[' || _char == ']')
        {
            [s appendFormat:@"%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
        }
        else if(_char ==' ')
        {
            [s appendFormat:@"\\%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
        }
        else if ((_char < 0x0020) || (_char > 0x007e))
        {
            [s appendFormat:@"\\u%x",[utf8Str characterAtIndex:i]];
        }
        else
        {
            [s appendFormat:@"%@",[utf8Str substringWithRange:NSMakeRange(i,1)]];
        }
         */
    }
    return s;
}

+(NSString *)filterHTML:(NSString *)html
{
    NSRange range;
    while ((range = [html rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        html=[html stringByReplacingCharactersInRange:range withString:@""];
    }
    /*
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
     */
    return html;
}

- (void)pgq_RACSignal
{

    RACSignal * signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"a"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"b"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    RACSignal * signalC = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"b"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    RACSignal * signalD = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"b"];
            [subscriber sendCompleted];
        });
        return nil;
    }];

//    [[signalA combineLatestWith:signalB] sub]
    
    //一个完成之后 另一个完成
    [[signalA concat:signalB]subscribeNext:^(id x) {

    }];
    //两个完成过后
    [[signalA zipWith:signalB] subscribeNext:^(id x) {
        
    }];
    //所有完成过后
    [[RACSignal combineLatest:@[signalA, signalB]] subscribeNext:^(id x) {

    }];
}

- (void)Timer_RAC
{
    RAC(_label, text) = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] map:^NSString*(NSData * date) {
        return date.description;
        
    }];
}

- (void)Rac_Macro
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    RAC(button, backgroundColor) = [RACObserve(button, selected)map:^UIColor* (NSNumber * selected) {
        return [selected boolValue]?[UIColor redColor]:[UIColor greenColor];
    }];
}

- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
    }
    return _label;
}

@end
