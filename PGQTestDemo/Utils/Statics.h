//
//  Statics.h
//  Wordoor
//
//  Created by BernieWang on 14-5-6.
//  Copyright (c) 2014年 Bernie. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *USEREMAIL = @"useremail";
static NSString *USERPASS= @"userpass";

@interface Statics : NSObject


+ (void)reputationButtonWidthAnimation:(UIButton *)button withProgress:(CGFloat)progress;

+(id)shardManager;

//加载动画 开始
- (void)showIndicator;
//加载动画结束
- (void)stopIndicatorWithText:(NSString*)title withType:(BOOL)type;


+(void)netWorkStatusandSuccessBlock:(void (^)(NSInteger netWorkStatus))successBlock;
+(NSString *)langcode;
+(NSString *)myid;
+ (NSString *)getCurrentTime;
+ (NSString *)sha1:(NSString*)input;
+ (NSString *)md5:(NSString*)input;
+ (NSString *)uuid;
+ (NSString *)roundUp:(float)number afterPoint:(int)position;

+ (BOOL)       validateEmail: (NSString *) candidate;
+ (NSArray*) getAllSystemFonts;
+ (UIFont*)     getCurrentFont;
+ (NSString *)UTF8ToUnicode:(NSString *)utf8Str;
+ (NSString *)UnicodeToUTF8:(NSString *)unicodeStr;
+ (NSString *)filterHTML:(NSString *)html;
@end
