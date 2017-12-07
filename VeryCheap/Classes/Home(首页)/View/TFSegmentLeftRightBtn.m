//
//  TFSegmentLeftRightBtn.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/23.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSegmentLeftRightBtn.h"

@interface TFSegmentLeftRightBtn ()
@property (nonatomic ,assign) CGFloat radio;
@end

@implementation TFSegmentLeftRightBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (CGFloat)radio
{
    return 0.7;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width *self.radio, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * self.radio, 0, contentRect.size.width * ( 1 - self.radio - 0.2), contentRect.size.height);
}
@end
