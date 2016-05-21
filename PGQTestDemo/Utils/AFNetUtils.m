//
//  AFNetUtils.m
//  PGQTestDemo
//
//  Created by Lois_Pan on 16/2/19.
//  Copyright © 2016年 潘国强. All rights reserved.
//


//这样重写的时候  每次只实例化一次（有很大的问题）

#import "AFNetUtils.h"

@implementation AFNetUtils

+(AFNetUtils *)shareManager
{
    static AFNetUtils * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        NSString * token = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //请求头
        //token
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
        //传本机语言
        NSString * lancode=[Statics langcode];
        if ([[Statics langcode] isEqualToString:@"zh-cn"]){
            lancode=@"zh-CN";
        }
        [manager.requestSerializer setValue:lancode forHTTPHeaderField:@"Accept"];
    });
    return manager;
}

/**
 *  Check NetWork status
 */
+ (void)checkNetWorkStatus{
    
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            
            NSLog(@"网络连接已断开，请检查您的网络！");
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"没有Wifi的人生怎么活" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            return ;
        }
    }];
}


#pragma mark -- get method

+ (void)getInfoWithSubUrl:(NSString *)subUrl
               parameters:(NSDictionary *)Parameters
                    block:(void (^)(id result, NSError *error))block
{
    [[self class] checkNetWorkStatus];
    
    [[[self class] shareManager] GET:subUrl parameters:Parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"NSProgress %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id  result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"resultDic = %@",result);
        if (block && result) {
            block(result,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }
    }];
}


#pragma mark -- post method

+ (void)postWithParameters:(NSDictionary *)Parameters
                    subUrl:(NSString *)suburl
                     block:(void (^)(NSDictionary *resultDic, NSError *error))block{
    
    [[self class] checkNetWorkStatus];
    
    [[[self class] shareManager]POST:suburl parameters:Parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"AFMultipartFormData: %@",formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"NSProgress:%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id  result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"resultDic = %@",result);
        if (block && result) {
            block(result,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"error = %@",error.description);
          if (block) {
           block(nil,error);
        }
    }];
}

#pragma mark patch method

+ (void)patchWithParameters:(NSDictionary *)Parameters
                    subUrl:(NSString *)suburl
                     block:(void (^)(NSDictionary *resultDic, NSError *error))block
{
    [[self class] checkNetWorkStatus];
    [[[self class] shareManager] PATCH:suburl parameters:Parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id  result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"resultDic = %@",result);
        if (block && result) {
            block(result,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }
    }];
}

#pragma mark put method

+ (void)putWithParameters:(NSDictionary *)Parameters
                     subUrl:(NSString *)suburl
                      block:(void (^)(NSDictionary *resultDic, NSError *error))block
{
    [[self class] checkNetWorkStatus];
    
    [[[self class] shareManager]PUT:suburl parameters:Parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id  result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"resultDic = %@",result);
        if (block && result) {
            block(result,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }
    }];
 }


#pragma mark 取消网络请求
+ (void)cancelRequest{
    
    NSLog(@"cancelRequest");
    [[[[self class] sharedManager] operationQueue] cancelAllOperations];
}

@end
