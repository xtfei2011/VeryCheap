//
//  TFRightCollectionViewCell.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/2.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFRightCollectionViewCell.h"
#import "TFCoupons.h"

@interface TFRightCollectionViewCell ()

@end

@implementation TFRightCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TFGlobalBg;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (TFMainScreen_Width - kLeftWidth - 8)/3, 35)];
        self.titleLabel.font = TFCommodityTitleFont;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setRightCategory:(TFRightCategory *)rightCategory
{
    _rightCategory = rightCategory;
    
    self.titleLabel.text = rightCategory.c_name;
}
@end
