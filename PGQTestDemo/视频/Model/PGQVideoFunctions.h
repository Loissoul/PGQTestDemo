//
//  PGQVideoFunctions.h
//  PGQTestDemo
//
//  Created by Lois_pan on 16/2/29.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGQVideoFunctions : NSObject

+ (NSDictionary *)getUrlInfo;
+ (NSString *)getVideoUrl;
+ (NSString *)getVideoType;
+ (BOOL)getLoopMode;

@end
