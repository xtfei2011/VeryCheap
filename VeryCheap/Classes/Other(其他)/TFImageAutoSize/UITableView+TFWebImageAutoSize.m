//
//  UITableView+TFWebImageAutoSize.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "UITableView+TFWebImageAutoSize.h"
#import "TFWebImageAutoSize.h"

@implementation UITableView (TFWebImageAutoSize)

- (void)xtfei_reloadDataForURL:(NSURL *)url
{
    BOOL reloadState = [TFWebImageAutoSize reloadStateFromCacheForURL:url];
    
    if (!reloadState) {
        
        [self reloadData];
        [TFWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}
@end
