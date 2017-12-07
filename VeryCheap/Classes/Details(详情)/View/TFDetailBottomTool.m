//
//  TFDetailBottomTool.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/1.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFDetailBottomTool.h"
#import "TFDetailBottomBtn.h"

@interface TFDetailBottomTool ()
/*** 领劵价格 ***/
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/*** 不领劵价格 ***/
@property (weak, nonatomic) IBOutlet UILabel *invalidLabel;
@end

@implementation TFDetailBottomTool

- (void)setDetails:(TFDetails *)details
{
    _details = details;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@", details.jiage];
    self.invalidLabel.text = [NSString stringWithFormat:@"¥ %@", details.yuanjia];
}

- (IBAction)detailBottomBtnClick:(TFDetailBottomBtn *)sender
{
    NSInteger index = sender.tag - 1007;
    if (self.block) {
        self.block(index);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.xtf_y = TFMainScreen_Height - 55;
    self.xtf_width = TFMainScreen_Width;
}

@end
