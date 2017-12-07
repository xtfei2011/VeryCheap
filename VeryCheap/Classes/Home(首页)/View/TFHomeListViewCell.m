//
//  TFHomeListViewCell.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFHomeListViewCell.h"

@interface TFHomeListViewCell ()
/*** 商品图片 ***/
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
/*** 商品名称 ***/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/*** 商品价格 ***/
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/*** 作废的价格 ***/
@property (weak, nonatomic) IBOutlet UILabel *invalidLabel;
/*** 购买人数 ***/
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
/*** 优惠金额 ***/
@property (weak, nonatomic) IBOutlet UILabel *awardLabel;
/*** 购买渠道 ***/
@property (weak, nonatomic) IBOutlet UIImageView *ditchView;
@end

@implementation TFHomeListViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.awardLabel.layer.borderWidth = 1;
    self.awardLabel.layer.borderColor = TFColor(251, 44, 107).CGColor;
}

- (void)setSelection:(TFSelection *)selection
{
    _selection = selection;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:selection.titlepic] placeholderImage:[UIImage imageNamed:@"Image_column_default"]];
    
    self.titleLabel.text = selection.title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@", selection.jiage];
    self.invalidLabel.text = [NSString stringWithFormat:@"¥ %@", selection.yuanjia];
    self.amountLabel.text = [NSString stringWithFormat:@"%@人已买", selection.xiaoliang];
    self.awardLabel.text = [NSString stringWithFormat:@" %@元 ", selection.quan];
    
    if ([selection.laiyuan isEqualToString:@"1"] ) {
        _ditchView.image = [UIImage imageNamed:@"ico_tao"];
    } else{
        _ditchView.image = [UIImage imageNamed:@"ico_tm"];
    }
}
@end
