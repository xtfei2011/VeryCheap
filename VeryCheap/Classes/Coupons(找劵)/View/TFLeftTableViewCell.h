//
//  TFLeftTableViewCell.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/12/2.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFCoupons.h"

@interface TFLeftTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic ,strong) UIView *baseView;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) TFLeftCategory *leftCategory;
@end
