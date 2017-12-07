//
//  TFDetails.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/2.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFDetails : NSObject
/*** 是否包邮 ***/
@property (nonatomic ,strong) NSString *baoyou;
/*** 详情内容 ***/
@property (nonatomic ,strong) NSString *detailurl;
/*** 结束时间 ***/
@property (nonatomic ,strong) NSString *endtime;
/*** 开始时间 ***/
@property (nonatomic ,strong) NSString *starttime;
/*** 商品ID ***/
@property (nonatomic ,strong) NSString *tbid;
/*** 商品标题 ***/
@property (nonatomic ,strong) NSString *title;
/*** 商品销量 ***/
@property (nonatomic ,strong) NSString *xiaoliang;
/*** 渠道 ***/
@property (nonatomic ,strong) NSString *laiyuan;
/*** 商品价格 ***/
@property (nonatomic ,strong) NSString *jiage;
/*** 商品原价 ***/
@property (nonatomic ,strong) NSString *yuanjia;
/*** 优惠券面值 ***/
@property (nonatomic ,strong) NSString *quan;
/*** 优惠券ID ***/
@property (nonatomic ,strong) NSString *activityid;
/*** 优惠券领取url ***/
@property (nonatomic ,strong) NSString *url;
/*** 淘宝详情页 ***/
@property (nonatomic ,strong) NSString *clickurl;
/*** 分享url ***/
@property (nonatomic ,strong) NSString *shareurl;
@end
