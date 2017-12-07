//
//  TFRefreshFooter.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/30.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFRefreshFooter.h"

@implementation TFRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor grayColor];
    self.stateLabel.font = TFCommentTitleFont;
    
    [self setTitle:@"--- 没有更多啦 ---" forState:MJRefreshStateNoMoreData];
}

@end
