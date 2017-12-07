//
//  TFMenueBarShowController.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/23.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+TFSegmentProtocol.h"

@interface TFMenueBarShowController : UICollectionViewController

@property (nonatomic ,assign) CGFloat expectedHeight;
@property (nonatomic ,strong) NSArray <id<TFSegmentProtocol>>*protocol;
@end
