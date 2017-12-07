//
//  TFDetailBottomBtn.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFDetailBottomBtn.h"

@interface TFDetailBottomBtn ()
@property (nonatomic ,assign) CGFloat radio;
@end

@implementation TFDetailBottomBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (CGFloat)radio
{
    return 0.7;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * self.radio, contentRect.size.width, contentRect.size.height * (1 - self.radio));
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * self.radio);
}
@end
