//
//  TFDetailsViewCell.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFDetailsViewCell.h"
#import "TFWebImageAutoSize.h"

@interface TFDetailsViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *detailsImageView;
@end

@implementation TFDetailsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    [_detailsImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [TFWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
            if (result) {
//                [ xtfei_reloadDataForURL:imageURL];
            }
        }];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.xtf_height = [TFWebImageAutoSize imageHeightForURL:[NSURL URLWithString:_imageUrl] layoutWidth:TFMainScreen_Width - 16 estimateHeight:TFMainScreen_Width];
}
@end
