//
//  TFDetailBottomTool.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFDetails.h"

typedef void(^TFDetailBottomToolBlock)(NSInteger index);
@interface TFDetailBottomTool : UIView
@property (nonatomic ,strong) TFDetails *details;
@property (nonatomic ,copy) TFDetailBottomToolBlock block;
@end
