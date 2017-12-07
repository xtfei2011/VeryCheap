//
//  UIButton+TFExtension.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/20.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

/*** UIButton中图片和文字的关系 ***/
typedef NS_ENUM(NSInteger, TFButtonImageTitleStyle ) {
    TFButtonImageTitleStyleLeft      = 0,     //图片在左，文字在右，整体居中。
    TFButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
};

@interface UIButton (TFExtension)

/**
 *  调整按钮的文本图片布局
 *
 *  @param style            按钮样式
 *  @param padding          间距
 */
- (void)setButtonImageTitleStyle:(TFButtonImageTitleStyle)style padding:(CGFloat)padding;
@end
