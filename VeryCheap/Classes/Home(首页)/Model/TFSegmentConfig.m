//
//  TFSegmentConfig.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/23.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSegmentConfig.h"

@implementation TFSegmentConfig

+ (instancetype)defaultConfig
{
    return [[TFSegmentConfig alloc] init];
}

/*** 用于标识选项卡的指示器颜色 ***/
- (UIColor *)indicatorColor
{
    if (!_indicatorColor) {
        _indicatorColor = TFColor(251, 44, 107);
    }
    return _indicatorColor;
}

- (CGFloat)indicatorHeight
{
    if (_indicatorHeight <= 0) {
        _indicatorHeight = 2;
    }
    return _indicatorHeight;
}

/*** 选项颜色(普通) ***/
-(UIColor *)segNormalColor
{
    if (!_segNormalColor) {
        _segNormalColor = [UIColor grayColor];
    }
    return _segNormalColor;
}

/*** 选项颜色(选中) ***/
-(UIColor *)segSelectedColor
{
    if (!_segSelectedColor) {
        _segSelectedColor = TFColor(251, 44, 107);
    }
    return _segSelectedColor;
}

/*** 选项字体(普通) ***/
- (UIFont *)segNormalFont
{
    if (!_segNormalFont) {
        _segNormalFont = TFCommentTitleFont;
    }
    return _segNormalFont;
}

/*** 选项字体(选中) ***/
- (UIFont *)segSelectedFont
{
    if (!_segSelectedFont) {
        _segSelectedFont = [UIFont systemFontOfSize:16];
    }
    return _segSelectedFont;
}

/*** 选项卡之间的最小间距 ***/
- (CGFloat)limitMargin
{
    if (_limitMargin <= 0) {
        _limitMargin = 25;
    }
    return _limitMargin;
}
@end
