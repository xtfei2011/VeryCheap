//
//  TFWebImageAutoSizeCache.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TFWebImageAutoSizeCacheCompletionBlock)(BOOL result);

@interface TFWebImageAutoSizeCache : NSObject
/**
 * Return global shared cache instance
 *
 * @return TFWebImageAutoSizeCache global instance
 */
+ (TFWebImageAutoSizeCache *)shardCache;

/**
 *  Store an imageSize into memory and disk cache at the given key.
 *
 *  @param image The image to store
 *  @param key   The unique imageSize cache key, usually it's image absolute URL
 *
 *  @return result
 */
- (BOOL)storeImageSize:(UIImage *)image forKey:(NSString *)key;

/**
 *  Store an imageSize into memory and disk cache at the given key.
 *
 *  @param image          The image to store
 *  @param key            The unique imageSize cache key, usually it's image absolute URL
 *  @param completedBlock An block that should be executed after the imageSize has been saved (optional)
 */
- (void)storeImageSize:(UIImage *)image forKey:(NSString *)key completed:(TFWebImageAutoSizeCacheCompletionBlock)completedBlock;

/**
 *  Query the disk cache synchronously after checking the memory cache
 *
 *  @param key  The unique key used to store the wanted imageSize
 *
 *  @return imageSize
 */
- (CGSize)imageSizeFromCacheForKey:(NSString *)key;

/**
 *  Store an reloadState into memory and disk cache at the given key.
 *
 *  @param state reloadState
 *  @param key   The unique reloadState cache key, usually it's image absolute URL
 *
 *  @return result
 */
- (BOOL)storeReloadState:(BOOL)state forKey:(NSString *)key;

/**
 *  Store an reloadState into memory and disk cache at the given key
 *
 *  @param state          reloadState
 *  @param key            The unique reloadState cache key, usually it's image absolute URL
 *  @param completedBlock An block that should be executed after the reloadState has been saved (optional)
 */
- (void)storeReloadState:(BOOL)state forKey:(NSString *)key completed:(TFWebImageAutoSizeCacheCompletionBlock)completedBlock;

/**
 *  Query the disk cache synchronously after checking the memory cache
 *
 *  @param key The unique key used to store the wanted reloadState
 *
 *  @return reloadState
 */
- (BOOL)reloadStateFromCacheForKey:(NSString *)key;
@end
