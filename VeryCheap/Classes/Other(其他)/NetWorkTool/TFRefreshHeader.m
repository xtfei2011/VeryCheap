//
//  TFRefreshHeader.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFRefreshHeader.h"

@implementation TFRefreshHeader

/*** 初始化 ***/
- (void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
    self.stateLabel.textColor = [UIColor grayColor];
    self.stateLabel.font = self.lastUpdatedTimeLabel.font = TFCommentTitleFont;
}

@end
