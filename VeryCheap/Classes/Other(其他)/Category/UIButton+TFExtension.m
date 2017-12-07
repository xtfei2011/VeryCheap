//
//  UIButton+TFExtension.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/20.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "UIButton+TFExtension.h"

@implementation UIButton (TFExtension)

- (void)setButtonImageTitleStyle:(TFButtonImageTitleStyle)style padding:(CGFloat)padding
{
    if (self.imageView.image != nil && self.titleLabel.text != nil) {
        
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        
        CGRect imageRect = self.imageView.frame;
        CGRect titleRect = self.titleLabel.frame;
        
        switch (style) {
             //图片在左，文字在右
            case TFButtonImageTitleStyleLeft:
                
                if (padding) {
                    self.titleEdgeInsets = UIEdgeInsetsMake(0, padding/2, 0, -padding/2);
                    self.imageEdgeInsets = UIEdgeInsetsMake(0, -padding/2, 0, padding/2);
                }
                break;
                
            case TFButtonImageTitleStyleRight:
            {
                //图片在右，文字在左
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageRect.size.width + padding/2), 0, (imageRect.size.width + padding/2));
                
                self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleRect.size.width+ padding/2), 0, -(titleRect.size.width+ padding/2));
            }
                break;
    
            default:
                break;
        }
        
    } else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
@end
