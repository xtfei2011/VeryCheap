//
//  NSString+TFExtension.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/4.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "NSString+TFExtension.h"

@implementation NSString (TFExtension)

- (unsigned long long)fileSize
{
    unsigned long long size = 0;
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (!exists) return size;
    
    if (isDirectory) {
        
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        for (NSString *subpath in enumerator) {
            
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
    } else {
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    
    return size;
}
@end
