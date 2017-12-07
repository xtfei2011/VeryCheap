//
//  TFNetworkTools.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFNetworkTools : NSObject
#pragma mark -------  GET 请求数据
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getResultWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark -------  POST 请求数据
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postResultWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/*** 左右联动分类数据 ***/
+ (void)getSortWithDataRequestBlock:(void(^)(id content))complation;

/*** 详情页面轮播图 ***/
+ (void)getResultBannerWithUrl:(NSString *)url success:(void (^)(id content))success;

/*** 搜索页面 ***/
+ (void)getSearchWithUrl:(NSString *)url success:(void (^)(id content))success;
@end
