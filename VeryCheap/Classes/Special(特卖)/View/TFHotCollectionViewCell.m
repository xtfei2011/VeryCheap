//
//  TFHotCollectionViewCell.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/15.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFHotCollectionViewCell.h"

@interface TFHotCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@end
@implementation TFHotCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backView.layer.cornerRadius = 3.0f;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.borderColor = TFrayColor(236).CGColor;
    self.backView.layer.borderWidth = 0.5f;
}

@end
