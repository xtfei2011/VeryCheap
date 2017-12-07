//
//  TFNetworkTools.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFNetworkTools.h"
#import <AFNetworking.h>

@implementation TFNetworkTools

#pragma mark -------  GET 请求数据
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getResultWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [manger GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -------  POST 请求数据
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postResultWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSMutableSet *setM = [manger.responseSerializer.acceptableContentTypes mutableCopy];
    [setM addObject:@"text/plain"];
    [setM addObject:@"text/html"];
    manger.responseSerializer.acceptableContentTypes = [setM copy];
    
    [manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    [manger POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/*** 左右联动分类数据 ***/
+ (void)getSortWithDataRequestBlock:(void(^)(id content))complation
{
    [self postResultWithUrl:@"http://www.haopianyi.com/app/class.php" params:nil success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        complation(responseObject);
    } failure:^(NSError *error) {
        TFLog(@"请求失败 - %@", error);
    }];
}

/*** 详情页面轮播图 ***/
+ (void)getResultBannerWithUrl:(NSString *)url success:(void (^)(id content))success
{
    [self getResultWithUrl:url params:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        TFLog(@"请求失败 - %@", error);
    }];
}

/*** 搜索页面 ***/
+ (void)getSearchWithUrl:(NSString *)url success:(void (^)(id content))success
{
    [self getResultWithUrl:url params:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        TFLog(@"请求失败 - %@", error);
    }];
}
@end
