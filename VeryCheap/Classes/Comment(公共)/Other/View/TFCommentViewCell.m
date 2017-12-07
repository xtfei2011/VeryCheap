//
//  TFCommentViewCell.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/29.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentViewCell.h"

@interface TFCommentViewCell ()
/*** 商品图片 ***/
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
/*** 商品名称 ***/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/*** 商品价格 ***/
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/*** 购买人数 ***/
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
/*** 优惠金额 ***/
@property (weak, nonatomic) IBOutlet UILabel *awardLabel;
/*** 购买渠道 ***/
@property (weak, nonatomic) IBOutlet UIImageView *ditchView;
@end

@implementation TFCommentViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.awardLabel.layer.borderWidth = 1;
    self.awardLabel.layer.borderColor = TFColor(251, 44, 107).CGColor;
}

- (void)setComment:(TFComment *)comment
{
    _comment = comment;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:comment.titlepic] placeholderImage:[UIImage imageNamed:@"Image_column_default"]];
    
    self.titleLabel.text = comment.title;
    self.priceLabel.text = [NSString stringWithFormat:@"劵后¥ %@", comment.jiage];
    self.amountLabel.text = [NSString stringWithFormat:@"%@人已买", comment.xiaoliang];
    self.awardLabel.text = [NSString stringWithFormat:@" %@元 ", comment.quan];
    
    if ([comment.laiyuan isEqualToString:@"1"] ) {
        _ditchView.image = [UIImage imageNamed:@"ico_tao"];
    } else{
        _ditchView.image = [UIImage imageNamed:@"ico_tm"];
    }
}
@end
