//
//  TFSelectionViewController.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFBanner.h"

@interface TFSelectionViewController : UITableViewController
@property (nonatomic ,copy) NSString *loadKey;
@property (nonatomic ,strong) NSMutableArray<TFBanner *> *banner;
@end
