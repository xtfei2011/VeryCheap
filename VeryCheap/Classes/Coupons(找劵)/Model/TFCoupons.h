//
//  TFCoupons.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/2.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFCoupons : NSObject

@end

/*** 左边分类 ***/
@interface TFLeftCategory : NSObject
@property (nonatomic ,copy) NSString *c_id;
@property (nonatomic ,copy) NSString *c_name;
@property (nonatomic ,copy) NSArray *fenlei;

@end

/*** 右边分类 ***/
@interface TFRightCategory : NSObject
@property (nonatomic ,copy) NSString *c_id;
@property (nonatomic ,copy) NSString *c_name;
@end
