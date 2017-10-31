//
//  TFBannerViewCell.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFBannerViewCell.h"

@interface TFBannerViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation TFBannerViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setBanner:(TFBanner *)banner
{
    _banner = banner;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:banner.pic]];
}
@end
