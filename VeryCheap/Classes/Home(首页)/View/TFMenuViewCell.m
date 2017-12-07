//
//  TFMenuViewCell.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/27.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFMenuViewCell.h"

@implementation TFMenuViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.menuLabel.textColor = TFColor(251, 44, 107);
    } else {
        self.menuLabel.textColor = [UIColor darkGrayColor];
    }
}
@end
