//
//  PGQVideoFunctions.m
//  PGQTestDemo
//
//  Created by Lois_pan on 16/2/29.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "PGQVideoFunctions.h"

@implementation PGQVideoFunctions

/**
 *  get plist file
 */
+ (NSDictionary *)getUrlInfo
{
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"Video" ofType:@"plist"];
    NSDictionary * dictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return dictionary;
}

+ (NSString *)getVideoUrl
{
    NSString * url = [[PGQVideoFunctions getUrlInfo] objectForKey:@"Url"];
    return url;
}

+ (NSString *)getVideoType
{
    NSString * type = [[PGQVideoFunctions getUrlInfo] objectForKey:@"Type"];

    return type;
}

+ (BOOL)getLoopMode
{
    BOOL  modeBool = [[[PGQVideoFunctions getUrlInfo] objectForKey:@"Mode Loop"] boolValue];
    return modeBool;
}
@end
