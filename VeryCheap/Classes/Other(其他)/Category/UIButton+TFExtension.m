//
//  UIButton+TFExtension.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/20.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "UIButton+TFExtension.h"
#import <objc/runtime.h>

@implementation UIButton (TFExtension)
- (void)setTextWidth:(CGFloat)textWidth
{
    objc_setAssociatedObject(self, &xtf_textWidth, @(textWidth), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)textWidth
{
    id obj = objc_getAssociatedObject(self, &xtf_textWidth);
    
    if (obj != nil && [obj isKindOfClass:[NSNumber class]]) {
        
        return [(NSNumber *)obj floatValue];
    }
    return 0;
}

- (CGFloat)textMinX
{
    return (self.xtf_width - self.textWidth)/2 + self.xtf_x;
}

- (CGFloat)textMaxX
{
    return CGRectGetMaxX(self.frame) - (self.xtf_width - self.textWidth) * 0.5;
}
@end
