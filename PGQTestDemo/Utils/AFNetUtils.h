//
//  AFNetUtils.h
//  PGQTestDemo
//
//  Created by Lois_Pan on 16/2/19.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFNetUtils : AFHTTPSessionManager
/**
 *  Construct the singleton
 *
 *  @return singleton
 */
+(AFNetUtils*)shareManager;


/**
 *  get method
 *
 *  @param subUrl     url
 *  @param Parameters 参数
 *  @param block      block返回数据
 */
+ (void)getInfoWithSubUrl:(NSString *)subUrl
               parameters:(NSDictionary *)Parameters
                    block:(void (^)(id result, NSError *error))block;


/**
 *  post method
 *
 *  @param Parameters 参数
 *  @param suburl     url
 *  @param block      block 返回数据
 */
+ (void)postWithParameters:(NSDictionary *)Parameters
                    subUrl:(NSString *)suburl
                     block:(void (^)(NSDictionary *resultDic, NSError *error))block;


/**
 *  patch method
 *
 *  @param Parameters 参数
 *  @param suburl     url
 *  @param block      block 返回数据
 */
+ (void)patchWithParameters:(NSDictionary *)Parameters
                     subUrl:(NSString *)suburl
                      block:(void (^)(NSDictionary *resultDic, NSError *error))block;


/**
 *  put menthod
 *
 *  @param Parameters 参数
 *  @param suburl     url
 *  @param block      block 返回数据
 */
+ (void)putWithParameters:(NSDictionary *)Parameters
                   subUrl:(NSString *)suburl
                    block:(void (^)(NSDictionary *resultDic, NSError *error))block;

/**
 *  取消网络请求
 */

+ (void)cancelRequest;

@end
