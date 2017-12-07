//
//  TFRightReusableView.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/2.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFRightReusableView.h"

@implementation TFRightReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = TFColor(252, 43, 106);
        self.headerTitile = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.xtf_width, self.xtf_height)];
        self.headerTitile.font = TFPromptTitleFont;
        self.headerTitile.textColor = [UIColor whiteColor];
        self.headerTitile.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.headerTitile];
    }
    return self;
}
@end
