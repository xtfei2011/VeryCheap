//
//  TFSearchSectionHeader.m
//  haopianyi.com
//
//  Created by 谢腾飞 on 2016/11/15.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFSearchSectionHeader.h"

@implementation TFSearchSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.xtf_height - 21)/2, 20, 21)];
        
        self.titleLbael = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImage.frame) + 10, 0, self.xtf_width/3, self.xtf_height)];
        self.titleLbael.font = TFCommentTitleFont;
        self.titleLbael.textColor = [UIColor darkGrayColor];
        
        self.deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deletBtn.frame = CGRectMake(self.xtf_width - 50, 0, 40, 45);
        [self.deletBtn setImage:[UIImage imageNamed:@"Search_delete"] forState:UIControlStateNormal];
        
        [self addSubview:self.iconImage];
        [self addSubview:self.titleLbael];
        [self addSubview:self.deletBtn];
    }
    return self;
}
@end
