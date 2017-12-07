//
//  TFSelection.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/29.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFSelection : NSObject
/*** 商品ID ***/
@property (nonatomic ,strong) NSString *tbid;
/*** 商品标题 ***/
@property (nonatomic ,strong) NSString *title;
/*** 商品销量 ***/
@property (nonatomic ,strong) NSString *xiaoliang;
/*** 渠道 ***/
@property (nonatomic ,strong) NSString *laiyuan;
/*** 商品图片 ***/
@property (nonatomic ,strong) NSString *titlepic;
/*** 商品价格 ***/
@property (nonatomic ,strong) NSString *jiage;
/*** 商品原价 ***/
@property (nonatomic ,strong) NSString *yuanjia;
/*** 优惠券面值 ***/
@property (nonatomic ,strong) NSString *quan;
/*** 优惠券ID ***/
@property (nonatomic ,strong) NSString *activityid;
/*** 是否包邮 ***/
@property (nonatomic ,strong) NSString *baoyou;
/*** 结束时间 ***/
@property (nonatomic ,strong) NSString *endtime;
/*** 开始时间 ***/
@property (nonatomic ,strong) NSString *starttime;
@end
