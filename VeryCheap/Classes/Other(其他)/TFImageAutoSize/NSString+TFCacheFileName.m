//
//  NSString+TFCacheFileName.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "NSString+TFCacheFileName.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TFCacheFileName)
- (NSString *)sizeKeyName
{
    NSString *keyName = [NSString stringWithFormat:@"sizeKeyName:%@",self];
    return keyName.md5String;
}

- (NSString *)reloadKeyName
{
    NSString *keyName = [NSString stringWithFormat:@"reloadKeyName:%@",self];
    return keyName.md5String;
}

- (NSString *)md5String
{
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}
@end
