//
//  NSString+TFCacheFileName.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TFCacheFileName)
@property (nonatomic ,copy ,readonly) NSString *sizeKeyName;
@property (nonatomic ,copy ,readonly) NSString *reloadKeyName;
@property (nonatomic ,copy ,readonly) NSString *md5String;
@end
