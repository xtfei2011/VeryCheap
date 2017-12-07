//
//  TFCategoryViewCell.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/29.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFCategoryViewCell;
@protocol TFCategoryBtnDelegate <NSObject>
- (void)sortButtonClick:(UIButton *)sender;
@end

@interface TFCategoryViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,weak) id<TFCategoryBtnDelegate>delegate;
@end
