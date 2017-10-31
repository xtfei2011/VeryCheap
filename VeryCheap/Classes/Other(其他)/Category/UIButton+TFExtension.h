//
//  UIButton+TFExtension.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/20.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *xtf_textWidth;
static NSString *xtf_textMinX;
static NSString *xtf_textMaxX;

@interface UIButton (TFExtension)
/*** textWidth ***/
@property (nonatomic ,assign) CGFloat textWidth;
/*** textMinX ***/
@property (nonatomic ,assign ,readonly) CGFloat textMinX;
/*** textMaxX ***/
@property (nonatomic ,assign ,readonly) CGFloat textMaxX;
@end
