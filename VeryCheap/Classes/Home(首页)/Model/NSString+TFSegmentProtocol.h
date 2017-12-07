//
//  NSString+TFSegmentProtocol.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/23.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFSegmentProtocol.h"

@interface NSString (TFSegmentProtocol)<TFSegmentProtocol>
/*** 选项卡ID ***/
- (NSString *)classid;

/*** 选项卡内容 ***/
- (NSString *)classname;

/*** 选项卡图片 ***/
- (NSString *)icon;
@end
