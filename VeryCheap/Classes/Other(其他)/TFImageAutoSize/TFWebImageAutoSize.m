//
//  TFWebImageAutoSize.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFWebImageAutoSize.h"

static CGFloat const estimateDefaultHeight = 100;

@implementation TFWebImageAutoSize

+ (CGFloat)imageHeightForURL:(NSURL *)url layoutWidth:(CGFloat)layoutWidth estimateHeight:(CGFloat)estimateHeight
{
    CGFloat showHeight = estimateDefaultHeight;
    
    if (estimateHeight) showHeight = estimateHeight;
    
    if (!url || !layoutWidth) return showHeight;
    
    CGSize size = [self imageSizeFromCacheForURL:url];
    CGFloat imgWidth = size.width;
    CGFloat imgHeight = size.height;
    
    if (imgWidth > 0 && imgHeight > 0) {
        showHeight = layoutWidth / imgWidth*imgHeight;
    }
    return showHeight;
}

+ (void)storeImageSize:(UIImage *)image forURL:(NSURL *)url completed:(TFWebImageAutoSizeCacheCompletionBlock)completedBlock
{
    [[TFWebImageAutoSizeCache shardCache] storeImageSize:image forKey:[self cacheKeyForURL:url] completed:completedBlock];
}

+ (void)storeReloadState:(BOOL)state forURL:(NSURL *)url completed:(TFWebImageAutoSizeCacheCompletionBlock)completedBlock
{
    [[TFWebImageAutoSizeCache shardCache] storeReloadState:state forKey:[self cacheKeyForURL:url] completed:completedBlock];
}

+ (CGSize)imageSizeFromCacheForURL:(NSURL *)url
{
    return [[TFWebImageAutoSizeCache shardCache] imageSizeFromCacheForKey:[self cacheKeyForURL:url]];
}

+ (BOOL)reloadStateFromCacheForURL:(NSURL *)url
{
    return [[TFWebImageAutoSizeCache shardCache] reloadStateFromCacheForKey:[self cacheKeyForURL:url]];
}

#pragma mark - XHWebImageAutoSize (private)
+ (NSString *)cacheKeyForURL:(NSURL *)url
{
    return [url absoluteString];
}
@end
