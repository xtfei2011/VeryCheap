//
//  TFBasicInformationCell.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/20.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFBasicInformationCell.h"

@interface TFBasicInformationCell ()
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
/*** 购买渠道 ***/
@property (weak, nonatomic) IBOutlet UILabel *timeLimitLabel;

@end

@implementation TFBasicInformationCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelection:(TFSelection *)selection
{
    _selection = selection;
    
    self.titleLabel.text = selection.title;
    self.priceLabel.text = [NSString stringWithFormat:@"%@", selection.jiage];
    self.invalidLabel.text = [NSString stringWithFormat:@"¥ %@", selection.yuanjia];
    self.amountLabel.text = [NSString stringWithFormat:@"成交%@笔", selection.xiaoliang];
    self.awardLabel.text = [NSString stringWithFormat:@"%@", selection.quan];
    
    if ([selection.laiyuan isEqualToString:@"1"] ) {
        _ditchView.image = [UIImage imageNamed:@"ico_tao"];
    } else{
        _ditchView.image = [UIImage imageNamed:@"ico_tm"];
    }
    self.timeLimitLabel.text = [NSString stringWithFormat:@"使用期限：%@-%@", selection.starttime, selection.endtime];
}

- (IBAction)merchandiseBasicInfoAction:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;
    if (self.block) {
        self.block(index);
    }
}

@end
